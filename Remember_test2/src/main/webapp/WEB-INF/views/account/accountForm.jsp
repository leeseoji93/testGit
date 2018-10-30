<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script language="javascript">
   var count = 1;
   var addCount =1;

   //행추가
   function addInputBox() {
//       var tableTr = document.getElementById("staffTable").getElementsByTagName("tr").length;
      var tableTr = $("#staffTable tr").length;
      console.log("tableTr:"+tableTr);
      
//       if(addCount>1 && tableTr>2){
//          console.log("addCount!=0");
//          var nowRowId = "addRowBtn"+(addCount-1);
//          console.log("nowRowId :"+nowRowId);
//          document.getElementById(nowRowId).style.display = "none";
//       }
      
      
      var addStr = "<tr>"
            + "<td width='170'><input type='text' name='staff_id' id='staff_id' ></td>"
            + "<td width='170'><input type='password' name='staff_pw' id='staff_pw' ></td>"
            + "<td width='170'><input type='text' name='staff_name' id='staff_name' ></td>"
            + "<td width='170'><input type='tel' name='staff_phone' id='staff_phone'  placeholder='ex)01012345678' ></td>"
            + "<td width='170'>"
//                +"<input type=selextbox  value ="+addCount+" name=test"+addCount+" size=40>"
               +"<select class='middle_select' id='staff_position2' name='staff_position' onchange='posiChange(this,"+addCount+")'>"
               +"<option value='' selected='selected'>선택 해 주세요.</option>"
               +"<option value='원감'>원감</option>"
               +"<option value='차량기사'>차량기사</option>"
               +"<option value='보육교사'>보육교사</option>"
               +"<option value='행정실장'>행정실장</option>"
               +"</select>"
            +"</td>"
            +"<td>"
            +"<input type='hidden' id='staff_type"+addCount+"' name='staff_type' class='big_input' value=''>"
            +"<input type='hidden' id='role"+addCount+"' name='role' class='big_input' value=''>"
            +"<input type='button' value='' id='delRowBtn"+addCount+"' onclick='javascript:subtractInputBox(this);' class='btn_sub_25'>"
            + "</tr>";

            
      var table = document.getElementById("staffTable");
      var newRow = table.insertRow();         //줄 생성
//       var newCell = newRow.insertCell();      //td 만드는거
      newRow.innerHTML = addStr;
      count++;
      addCount =count;
   }

   //행삭제
   function subtractInputBox(obj) {

      var rowIndex = obj.parentElement.parentElement.rowIndex;
      console.log("DEL_rowIndex:" + rowIndex);
      var table = document.getElementById("staffTable");
      //var max = document.account_Form.checkList.length;
      //alert(max);
      var rows = staffTable.rows.length;
      console.log("rows:" + rows);
      if (rows > 2) {
         table.deleteRow(rowIndex);
      } else {
         alert("더이상 삭제할 수 없습니다.");
      }
      
   }

   function submitbutton() {
      // account_Form.count.value = count;
      var account_Form = document.account_Form;
      account_Form.count.value = count;
      alert(count);
      account_Form.submit();
      return;
   }
</script>

   <jsp:include page="../include/menu_admin.jsp">
      <jsp:param name="pageInMenu" value="계정관리"  />
      <jsp:param name="pageCategory" value="교직원"  />
      <jsp:param name="pageTitle" value="계정 등록"  /> 
   </jsp:include>
<div class="page">
   <div class="page-wrapper">
      <div class="pageTitle"><h2>교직원 계정 등록 </h2></div>

      <div class="pageContent accountFormPage">
      <form name="account_Form" action="insertAllStaff" method="post" id="account_Form" onkeydown="if(event.keyCode==13){event.returnValue=false;}"
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
					<th width="100">아이디</th>
					<td width="200" colspan="2"><input type="text" id="staff_id" name="staff_id" maxlength="13" value="" class="big_Input" maxlength="13"></td>
					<td><label id="staff_id-error" class="validFail" for="staff_id"></label></td>
				</tr>
				<tr>
					<th>이름</th>
					<td colspan="2"><input type="text" id="staff_name" name="staff_name" value="" class="big_Input" maxlength="5"></td>
					<td><label id="staff_name-error" class="validFail" for="staff_name"></label></td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td colspan="2"><input type="password" id="staff_pw" name="staff_pw" class="big_input" maxlength="13"> </td>
					<td><label id="staff_pw-error" class="validFail" for="staff_pw"></label></td>
				</tr>
				<tr>
					<th>비밀번호 확인</th>
					<td colspan="2"><input type="password" id="staff_pwCon" name="staff_pwCon" class="big_input" maxlength="13"> </td>
					<td><label id="staff_pwCon-error" class="validFail" for="staff_pwCon"></label></td>
				</tr>
				<tr>
					<th>연락처</th>
					<td colspan="2"><input type="tel" id="staff_phone" name="staff_phone" class="big_input" value="" maxlength="11"></td>
					<td><label id="staff_phone-error" class="validFail" for="staff_phone"></label></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td colspan="2"><input type="text" id="staff_email" name="staff_email" class="big_input" value="" ></td>
					<td><label id="staff_email-error" class="validFail" for="staff_email"></label></td>
				</tr>
				<tr>
					<th>직책</th>
					<td colspan="2">
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
				<tr id="checkClass">
					<th width="80">반</th>
					<td width="210" colspan="2">
						<select class='big_select' id='class_id' name='class_id'  onchange="classChange(this)">
							<option value='' selected='selected'>반을 선택 해 주세요.</option>
							<c:forEach items="${classList}" var="dto_c" varStatus="status">	
							   	<option value="${dto_c.class_id}">${dto_c.class_name}</option>										   									
							</c:forEach>	
						</select>
					</td>
				</tr>
				<tr id="checkTeach">
					<th width="80" align="left">담임/부담임</th>
					<td width="105" align="left">
						<input type="checkbox" name="staff_id_type" id="staff_id_1" value="staff_id_1">
						<label for="staff_id_1">담임</label>
					</td>
					<td width="105" align="left">
						<input type="checkbox" name="staff_id_type" id="staff_id_2" value="staff_id_2">
						<label for="staff_id_2">부담임</label>
					</td>
				</tr>
				
			</table>
 		</div>
	 	
	 	</div>
	 	<input type="hidden" id="staff_type" name="staff_type" class="big_input" value="">
        <input type="hidden" id="role" name="role" class="big_input" value="">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<div class="pageBtn contentBottomBtn">						
			<div class="btnLeftBox">
<!-- 				<input type="button" value="" class="btn_back" id="cusInputBtn1" onclick="javascript:history.back()" id="bottomBtn-Input"> 이전버튼 클릭 -->
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
   </div>


</div>
<jsp:include page="../include/footer.jsp"/>
<script>
$(document).ready(function() {
    //radio버튼처럼 checkbox name값 설정
    $('input[type="checkbox"][name="staff_id_type"]').click(function(){
        //click 이벤트가 발생했는지 체크
        if ($(this).prop('checked')) {
            //checkbox 전체를 checked 해제후 click한 요소만 true지정
            $('input[type="checkbox"][name="staff_id_type"]').prop('checked', false);
            $(this).prop('checked', true);
        }
    });
});

function classChange(obj) {// 직책에 따른 권한
	console.log("obj"+obj);
	console.log("obj"+obj);
	var classId = obj.value;
	console.log("classId:"+classId);
		   
	$("#checkTeach").css("display","table-row"); 
}
function posiChange(obj,index) {// 직책에 따른 권한
	
	
	$("#role").empty();
   var rowIndex = obj.parentElement.parentElement.rowIndex;
   var staffPosition = obj.value;
//    var test = obj.parent().attr("id");
   console.log("index:"+index);
   var parentId =document.getElementById(obj.getAttribute('id')).getAttribute('id');   //부모 ID값
   
   
      if(staffPosition=="원감"){
    	  $("#checkClass").css("display","none");
         console.log("원감posiChange:"+obj.value);
         document.getElementById("role").value="ROLE_SEMI_ADMIN";
         $("#staff_type").val("원감");
      }
      else if(staffPosition=="보육교사"){
    	  $("#checkClass").css("display","table-row");
    	  
         console.log("보육교사posiChange:"+obj.value);
//          $("#role").append("ROLE_MEMBER");
         document.getElementById("role").value="ROLE_MEMBER";
         $("#staff_type").val("보육교사");
      }
      else if(staffPosition=="차량기사"){
    	  $("#checkClass").css("display","none");
         document.getElementById("role").value="ROLE_USER";
         $("#staff_type").val("차량기사");
      }
      else{
    	  $("#checkClass").css("display","none");
         console.log("그외posiChange:"+obj.value);
//          $("#role").append("ROLE_USER");
         document.getElementById("role").value="ROLE_USER";
         $("#staff_type").val("보육교사");
      }
   
//    if(staffPosition=="보육교사"){
// 	   $(".mypageUpdate_Content_R table").append("<tr>"
// 				+"<th>담임/부담임</th>"
// 				+"<td>"
// 				+"	<input type='radio' id='staff_id_1' class='' name='staff_id_type' value='staff_id_1' checked='checked'><label for='staff_id_1'>담임</label>"
// 				+"</td>"
// 				+"<td>"
// 				+"	<input type='radio' id='staff_id_2' class='' name='staff_id_type' value='staff_id_2'><label for='staff_id_2'>부담임</label>"
// 				+"</td>"
// 			   +"</tr>");
//    }
   
//    console.log("staffPosition:"+staffPosition);
//    console.log("staffPosition_id:"+staffPosition_id);
   
}
</script>

<script>
$(function() {			
	 $.validator.addMethod("regex", function(value, element, regexpr) {          
	     return regexpr.test(value);
	   });	
	 
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
		
	$("#account_Form").validate({
		errorClass: "validFail",
		validClass: "validSuccess",
		
	    rules: {
	    	staff_id: {
	    		required: true,	
	    		regex: /^[a-zA-Z0-9|~!@#$%^&*()_+|<>?:{}]{6,13}$/,
	    		remote: {
	    				url:  "check_staff_id",
	    				type: "post",
	    				beforeSend: function(xhr) {
	    		            xhr.setRequestHeader(header, token);
	    		        },
	    				data: {
	    					formData: function() {
	    						return $("#staff_id").val();
	    						}
	    				}
	    		}
	    	},	    	
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
	    		regex: /^[ㄱ-ㅎ가-힣|0-9]{2,5}$/
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
	    	staff_id: {
	    		required: "아이디를 입력 해 주세요.",	
	    		regex: "영문, 숫자 6자 이상 입력 해 주세요.",
	    		remote: "이미 사용중인 아이디 입니다."
	    	},	    	
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

   
</body>
</html>