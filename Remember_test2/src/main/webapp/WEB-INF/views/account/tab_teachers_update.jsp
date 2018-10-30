<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="" id="category">
<c:set value="${staffAccount}" var="dto"/>	

	<form name="account_teacher" action="UpdateStaffAccount" id="account_teacher" method="POST" onkeydown="if(event.keyCode==13){event.returnValue=false;}"
	 enctype="multipart/form-data">
	 	<div class="mypageUpdate_Content">
	 		<div class="mypageUpdate_Content_L">
 			<div class="mypageTeachImg thumbnail-wrapper" >
 				<div class="thumbnail">
    				<div class="centered" id="holder">
    				</div>
    			</div>
 			</div>
 			<div class="file_input_div">
				<img src="images/button/button_photo_correct_180x50.png" class="file_input_img_btn">
				<input type="file" id="staff_photo_url" onchange="filePlus(this)" name="staff_photo_url" class="big_input file_input_hidden">
			</div>
 		</div>
 		<div class="mypageUpdate_Content_R">
 			<table>
				<tr>
					<th width="80">아이디</th>
					<td width="200">${dto[0].staff_id }<input type="hidden" id="staff_id" name="staff_id" value="${dto[0].staff_id }" class="big_Input" maxlength="13"></td>
					<td width="50"><label id="staff_id-error" class="validFail" for="staff_id"></label></td>
				</tr>
				<tr>
					<th>이름</th>
					<td><input type="text" id="staff_name" name="staff_name" value="${dto[0].staff_name }" class="big_Input"></td>
					<td><label id="staff_name-error" class="validFail" for="staff_name"></label></td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="password" id="staff_pw" name="staff_pw" class="big_input" maxlength="13"> </td>
					<td><label id="staff_pw-error" class="validFail" for="staff_pw"></label></td>
				</tr>
				<tr>
					<th>비밀번호 확인</th>
					<td><input type="password" id="staff_pwCon" name="staff_pwCon" class="big_input" maxlength="13"> </td>
					<td><label id="staff_pwCon-error" class="validFail" for="staff_pwCon"></label></td>
				</tr>
				<tr>
					<th>연락처</th>
					<td><input type="tel" id="staff_phone" name="staff_phone" class="big_input" value="${dto[0].staff_phone}" maxlength="11"></td>
					<td><label id="staff_phone-error" class="validFail" for="staff_phone"></label></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><input type="text" id="staff_email" name="staff_email" class="big_input" value="${dto[0].staff_email }" ></td>
					<td><label id="staff_email-error" class="validFail" for="staff_email"></label></td>
				</tr>
				<tr>
					<th>직책</th>
					<td>
						<select class='big_select' id='staff_position' name='staff_position' onchange="posiChange(this)">
							<option value='' selected='selected'>직책을 선택 해 주세요.</option>
							<option value='원감'>원감</option>
							<option value='차량기사'>차량기사</option>
							<option value='보육교사'>보육교사</option>
							<option value='행정실장'>행정실장</option>
						</select>
					</td>
					<td><label id="staff_position-error" class="validFail" for="staff_position"></label></td>
				</tr>
				<tr>
					<th>반</th>
					<td>
						<select class='big_select' id='class_id' name='class_id' onchange="classChange(this)">
							<option value='' selected='selected'>반을 선택 해 주세요.</option>
							<c:forEach items="${classList}" var="dto_c" varStatus="status">	
							   	<option value="${dto_c.class_id}">${dto_c.class_name}										   									
							</c:forEach>	
						</select>
					</td>
					<td><label id="class_name-error" class="validFail" for="class_name"></label></td>
				</tr>
				<tr id="checkTeach">
					<th width="80">담임/부담임</th>
					<td width="105">
						<input type="checkbox" name="staff_id_type" id="staff_id_1" value="staff_id_1">
						<label for="staff_id_1">담임</label>
					</td>
					<td width="105">
						<input type="checkbox" name="staff_id_type" id="staff_id_2" value="staff_id_2">
						<label for="staff_id_2">부담임</label>
					</td>
				</tr>
			</table>
 		</div>
	 	
	 	</div>
	 	
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<div class="pageBtn contentBottomBtn">						
			<div class="btnLeftBox">
				<input type="button" value="" class="btn_back" id="cusInputBtn1" onclick="accountBack()" id="bottomBtn-Input"> <!-- 이전버튼 클릭 -->
			</div>
			<div class="btnLeftBox">
				<input type="submit" value="" class="btn_update" id="cusInputBtn2" />
			</div>
<%-- 			onclick="updateForm('${dto[0].staff_id }')" --%>
			<div class="btnCnterBox">				  				
<!-- 	  			<input type="button" value="" class="btn_list" id="cusInputBtn3" onclick="location.replace('CarInfoView')"/>	 -->
	  		</div> 
		</div>
	</form>
</div>
<script type="text/javascript">
	$(document).ready(function(){
		var st_position ='${dto[0].staff_position}';		//구분 선택하기
		$("#staff_position").val(st_position).attr("selected", "selected");

		var st_className = '${dto[0].class_name}';			//반 선택하기
		$("#class_name").val(st_className).attr("selected", "selected");
	});
	

	function classChange(obj) {// 직책에 따른 권한
		console.log("obj"+obj);
		console.log("obj"+obj);
		var classId = obj.value;
		console.log("classId:"+classId);
			   
		$("#checkTeach").css("display","table-row"); 
	}
	
</script>
<script>

var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

function accountBack() {
	$.ajax({
		url : 'tab_teachers',
        type:'POST',
		beforeSend: function(xhr) {
              xhr.setRequestHeader(header, token);
           },
		//data: { "CODE_LEVEL": totcnt },    //escape 한글 깨짐 방지 구문  
		success : function(data) {
				$("#tabs-1").html(data); //str로 받은 data를 넘긴다.  
		},
		error : function(xhr, txtStatus, errorThrown) {
			alert("error" + errorThrown);
		}
	});

}
</script>
<script>
$(function() {			
	 $.validator.addMethod("regex", function(value, element, regexpr) {          
	     return regexpr.test(value);
	   });			 
	 
	$("#account_teacher").validate({
		errorClass: "validFail",
		validClass: "validSuccess",
		
	    rules: {
	    	staff_pw: {
	    		required: true,	
	    		regex: /^[a-zA-Z0-9]{6,13}$/
	    	},
	    	staff_pwCon: {
	    		required:true, 
	    		equalTo:'#staff_pw'
	    		}, 
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
	    	staff_position:{
	    		required: true
	    	}
	    },	    
	    messages: {
	        staff_pw: {
	        	 required: "비밀번호를 입력 해 주세요.",		            
		         regex : "영문, 숫자 6자 이상 입력 해 주세요."			    		
	        },
	        staff_pwCon: {
                   required: "비밀번호를 입력 해 주세요.",
                   equalTo:"비밀번호가 같지 않습니다." 
               },
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
	        },staff_position : {
	    		required: "직책을 선택 해 주세요."	    		
	    	}
	    },
	    submitHandler: function (frm){	
	    	var dataString = $(this.currentForm).serialize();
               frm.submit();   //유효성 검사를 통과시 전송
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

                 image.src = window.URL.createObjectURL(base64StringToBlob(base64));
                 image.className = "file_image";
                 holder.appendChild( image );
                
                 $("#holder img").each(function() {
                 	$(this).load(function(){ //이미지를 다 불러온후 확인하기 위해
             	        var imgWidth = this.naturalWidth; //이미지 크키가 정해져 있지 않을때
             	       	var imgHeight = this.naturalHeight;
             	   		
             	   		if(imgWidth>imgHeight){$("#holder img").addClass("landscape");}
             	   		else{$(".file_image").addClass("portrait");}
             	   		console.log("imgWidth:"+imgWidth);
             	   		console.log("imgHeight:"+imgHeight);
                     });
                 });
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

