<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<jsp:include page="../include/menu_admin.jsp">
	<jsp:param name="pageInMenu" value="내정보"  />
	<jsp:param name="pageCategory" value=""  />
	<jsp:param name="pageTitle" value=""  /> 
</jsp:include>
<div class="page mypageUpdatePage">
	<div class="page-wrapper">
		<div class="pageTitle"><h2>내 정보</h2></div>
		<sec:authorize access="hasAnyRole('ROLE_ADMIN')">
		<div id="layerWindow_p" class="layerWindow">
			<span class="modalWindow"></span>
		
			<div id="loginLayer" class="loginLayer loginTypeA">
				<div class="layerPopContent">
					<p><span class="re_question">경성테크놀러지로 문의 바랍니다.</span></p>
					<p><span class="re_question">연락처 : 051-853-3736</span></p>
					<p><span class="re_question">이메일 : sghong@topkst.co.kr</span></p> 
					<input type="button" class="btn_confirming_text" onclick="closeLayer2(1)" >
<!-- 					<input type="button" class="btn_close_text" onclick="closeLayer2(0)" > -->
				</div>
			</div>
		</div>
		</sec:authorize>
		
		<div class="pageContent MypageUpdatePage">
		<c:set value="${staffInfo}" var="dto_c"/>
			<form action="SaveMypageForm" id="SaveMypageForm" class="SaveMypageForm" method="post" onkeydown="if(event.keyCode==13){event.returnValue=false;}"
	 enctype="multipart/form-data">
	 	<div class="mypageUpdate_Content">
	 		<div class="mypageUpdate_Content_L">
<!-- 	 			<div class="mypageTeachImg" id="holder"></div> -->
<!-- 	 			<input type="file" id="staff_phot_url" onchange="filePlus(this)" name="staff_phot_url" class="big_input"> -->
				<div class="mypageTeachImg thumbnail-wrapper" >
	 				<div class="thumbnail">
	    				<div class="centered" id="holder">
	    				</div>
	    			</div>
	 			</div>
	 			<div class="file_input_div">
					<img src="images/button/button_photo_correct_180x50.png" class="file_input_img_btn">
					<input type="file" id="staff_phot_url" onchange="filePlus(this)" name="staff_phot_url" class="big_input file_input_hidden">
				</div>
	 		</div>
	 		<div class="mypageUpdate_Content_R">
	 			<table>
					<tr>
						<th>아이디</th>
						<td>${dto_c[0].staff_id}<input type="hidden" id="staff_id" name="staff_id" value="${dto_c[0].staff_id}" class="big_Input" re></td>
					</tr>
<!-- 					<tr> -->
<!-- 						<th>비밀번호</th> -->
<!-- 						<td><input type="password" id="staff_pw" name="staff_pw" value="" class="big_Input"></td> -->
<!-- 					</tr> -->
					<tr>
						<th>이름</th>
						<td><input type="text" id="staff_name" name="staff_name" value="${dto_c[0].staff_name}" class="big_Input" maxlength="5" placeholder="ex)홍길동"></td>
					</tr>
					<tr>
						<th>연락처</th>
						<td><input type="tel" id="staff_phone" name="staff_phone" value="${dto_c[0].staff_phone}" class="big_Input" maxlength="11" placeholder="ex)01012345678"></td>
					</tr>
					<tr>
						<th>이메일</th>
						<td><input type="text" id="staff_email" name="staff_email" value="${dto_c[0].staff_email}" class="big_Input"placeholder="ex)hong@kst.com"></td>
					</tr>
					<tr>
						<th>직책</th>
						<td>${dto_c[0].staff_position}<input type="hidden" id="staff_position" name="staff_position" value="${dto_c[0].staff_position}" class="big_Input" readonly="readonly"></td>
					</tr>
					<tr>
						<th>가입일</th>
						<td>${dto_c[0].createtime}<input type="hidden" id="registrant" name="registrant" value="${dto_c[0].createtime}" class="big_Input" readonly="readonly"></td>
					</tr>
				</table>
	 		</div>
	 	</div>
				
				<input type="hidden" name="${_csrf.parameterName}" id="csrf" value="${_csrf.token}" />
				<div class="pageBtn contentBottomBtn mypageBlock">						
					<div class="btnLeftBox">
						<input type="button" class="btn_back" value="" onclick="history.back();" id="bottomBtn-Input">
					</div>
					<div class="btnCnterBox">
						<input type="submit" value="" class="btn_update" id="cusInputBtn2" />
					</div>
					<div class="btnRightBox">	
					<sec:authorize access="hasAnyRole('ROLE_ADMIN')">		
						<input type="button" value="" id="cusInputBtn3" class="btn_leave_text" onclick='signOut()'/>	  				
					</sec:authorize>
			  		</div> 
				</div>
			</form>
		</div>
	</div>
</div>
<jsp:include page="../include/footer.jsp"/>
<script type="text/javascript">
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
$(document).ready(function(){	
	var staff_name = $("#staff_name").val();
	var nameSplit = staff_name.split('(');
	for ( var i in nameSplit ) {
		nameSplit[i] = nameSplit[i].substr(0,2);
        console.log(i+"staff_name:"+nameSplit[i]);
    }
	if(nameSplit[1]=="탈퇴"){
		$("#staff_name").attr("readonly",true);
		$("#staff_name").css("background-color","#e6e6e6");
		$("#cusInputBtn2").css("display","none");
		$("#cusInputBtn3").css("display","none");
		$("input[type=text]").css("background-color","#e6e6e6");
		$("input[type=text]").attr("readonly",true);
	}
});
function signOut(){
	$('#layerWindow_p').css('display','block');
}

function closeLayer2(obj){
	
	var staff_id = '${dto_c[0].staff_id}';
	var staff_name = '${dto_c[0].staff_name}';
	console.log(staff_id);
// 	$('#layerWindow').css('display','none');
// 	if(obj==1){
// 		$.ajax({
// 			type : "POST",
// 			url : "signOut",
// 			data : { "staff_id" : staff_id, "staff_name" : staff_name},
// 			beforeSend: function(xhr) {
// 	              xhr.setRequestHeader(header, token);
// 	           },
// 			success : function(data) {
// 				console.log("test"+data.check);
				
// 				var check = data.check;
				
// 				if(check==1){
					
// 					var form = document.createElement("form");     
// 					document.body.appendChild(form);

// 					form.setAttribute("method","post");                    
// 					form.setAttribute("action","j_spring_security_logout");        
								 
// 					//input
// 					var input_id = document.createElement("input");  
// 					input_id.setAttribute("type", "hidden");                 
// 					input_id.setAttribute("name", "${_csrf.parameterName}");                        
// 					input_id.setAttribute("value", "${_csrf.token}");                          

// 					form.appendChild(input_id);
					
// 				    form.submit();
// 				}
// //					setInterval('autoRefresh_div()', 3000);
// //					$('#msgBox').addClass("msgBox_Success");	
// //		    		$('#msgBox').html("<span>상태가 변경 되었습니다.</span>");
// //		    		document.getElementById('msgBox').style.display="block";
// //		    		location.href="MypageUpdate";
// //	 			$('#changePassword').load('changePassWord');
// 			},
// 			error : function(xhr, txtStatus, errorThrown) {
// 				alert("error" + errorThrown);
// 			}
// 		});
// 	}
	
	
	document.getElementById('layerWindow_p').style.display='none';
}

</script>

<script>
$(function() {			
	 $.validator.addMethod("regex", function(value, element, regexpr) {          
	     return regexpr.test(value);
	   });			 
	 
	$("#SaveMypageForm").validate({
		errorClass: "validFail",
		validClass: "validSuccess",
		
	    rules: {
	    	staff_name: {
	    		required: true,
	    		regex: /^[ㄱ-ㅎ가-힣]{2,5}$/
	    	},
	    	staff_phone: {
	    		required: true,
	    		regex: /[0-9]{10,11}/ 
	    	},
	    	staff_email:	{
	    		required: true,
	    		regex : /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/
	    	}
	    },	    
	    messages: {
	        staff_name: {
	        	 required: "이름을 입력 해 주세요.",		            
		         regex : "2자 이상 입력 해 주세요."	
	        },
	        staff_phone: {
	        	required: "연락처를 입력 해 주세요.",		            
	            regex : "숫자만 입력 해 주세요."
	        },
	        staff_email: {
	        	required: "이메일을 입력 해 주세요.",		            
	        	regex : "이메일 형식이 아닙니다."
	        }
	    },
	    submitHandler: function (frm){	
	    	var dataString = $(this.currentForm).serialize();
              frm.submit();   //유효성 검사를 통과시 전송
          },
	    success: function(label) {
//                  label.addClass("validSuccess").text("사용가능합니다.");
	    },
	    invalidHandler: function(form, validator){ //입력값이 잘못된 상태에서 submit 할때 호출
			var errors = validator.numberOfInvalids();
			if (errors) {						
				validator.errorList[0].element.focus();
			} 
		}
	});	
});
</script>
<script type="text/javascript">
function binaryStringToArrayBuffer(binary) {
    var length = binary.length;
    var buf = new ArrayBuffer(length);
    var arr = new Uint8Array(buf);
    for(var i=0;i<length;i++) {
        arr[i] = binary.charCodeAt(i);
    }
    return buf;
}

function base64StringToBlob(base64) {
    var type = base64.match(/data:([^;]+)/)[1];
    base64 = base64.replace(/^[^,]+,/g, '');
    var options = {};
    if (type) {
        options.type = type;
    }
    var binaryArrayBuffer = [ binaryStringToArrayBuffer(window.atob(base64)) ];
    return new Blob(binaryArrayBuffer, options);
}

var check_file = true;
function filePlus(this_obj){
   holder.innerHTML = '';
   
   var file_kind = this_obj.value.lastIndexOf('.');
   var file_name = this_obj.value.substring(file_kind+1,this_obj.length);
   var file_type = file_name.toLowerCase();
   
//    var upload = document.getElementById('Home_communicationForm_imgfile'),
    holder = document.getElementById('holder'),
    state = document.getElementById('status');

   
   var check_file_type = new Array();
   check_file_type = ['jpg','gif','png','jpeg','bmp'];   

   
    var files = event.target.files;
    
    for(var i = 0; i< files.length; i++)
     {             
       var file = this_obj.files[i];      

       if(check_file_type.indexOf(file.type.substring((file.type.lastIndexOf('/'))+1,file.type.length))==-1){   
          
//           var parent_Obj=this_obj.parentNode
//           var node=parent_Obj.replaceChild(this_obj.cloneNode(true),this_obj);            
          check_file = false;
         }         
     }   
   
    if(!check_file){
      alert("이미지만 넣어주세요!!");
       $("#holder").empty();
       event.target.value = null;
       check_file = true;
      
        return false;
    }
    else{

       for(var i = 0; i< files.length; i++)
        {   
          var file = this_obj.files[i];      
          
          var reader = new FileReader();   
          
          reader.addEventListener("load", function () {   
               var image = new Image();
               var base64 = this.result;

                 image.width = 260;
                 image.height = 200; 
                 image.title = file_name;
                 image.src = window.URL.createObjectURL(base64StringToBlob(base64));
                 image.className = "file_image";
                 holder.appendChild( image );
                
               }, false);                
            reader.readAsDataURL(file);
        }
    }
    

   if (typeof window.FileReader == 'undefined') {
//      state.className = 'fail';
//      state.innerHTML = 'fail';
   }   
   else {
//      state.className = 'success';
//      state.innerHTML = 'success';
   }
    
}
</script>
<script>
$(function() {			
	 $.validator.addMethod("regex", function(value, element, regexpr) {          
	     return regexpr.test(value);
	   });			 
	 
	$("#SaveMypageForm").validate({
		errorClass: "validFail",
		validClass: "validSuccess",
		
	    rules: {
	    	staff_name: {
	    		required: true,
	    		regex: /^[ㄱ-ㅎ가-힣]{2,5}$/
	    	},
	    	staff_phone: {
	    		required: true,
	    		regex: /[0-9]{10,11}/ 
	    	},
	    	staff_email:	{
	    		required: true,
	    		regex : /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/
	    	},
	    },	    
	    messages: {
	        staff_name: {
	        	 required: "이름을 입력 해 주세요.",		            
		         regex : "2자 이상 입력 해 주세요."	
	        },
	        staff_phone: {
	        	required: "연락처를 입력 해 주세요.",		            
	            regex : "숫자만 입력 해 주세요."
	        },
	        staff_email: {
	        	required: "이메일을 입력 해 주세요.",		            
	        	regex : "이메일 형식이 아닙니다."
	        }
	    },
	    submitHandler: function (frm){	
	    	var dataString = $(this.currentForm).serialize();
            SaveMypageForm.submit();   //유효성 검사를 통과시 전송
           },
	    success: function(label) {
//                   label.addClass("validSuccess").text("사용가능합니다.");
	    },
	    invalidHandler: function(form, validator){ //입력값이 잘못된 상태에서 submit 할때 호출
			var errors = validator.numberOfInvalids();
			if (errors) {						
				validator.errorList[0].element.focus();
			} 
		}
	});	
});
</script>	
