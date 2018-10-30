<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div id="changePassword">
	<form action="saveChangePassword" name="saveChangePassword" id="saveChangePassword" method="post">
	<table>
		<tr>
			<th>새 비빌번호</th>
			<td><input type="password" name="staff_pw" id="staff_pw" class="big_Input"> </td>
		</tr>
		<tr>
			<th>비빌번호 확인</th>
			<td><input type="password" name="staff_pwCon" id="staff_pwCon" class="big_Input"> </td>
		</tr>
	</table>
	<input type="hidden" name="${_csrf.parameterName}" id="csrf" value="${_csrf.token}" />
	<div class="pageBtn contentBottomBtn">						
		<div class="btnLeftBox">
		</div>
		<div class="btnCnterBox">
			<input type="submit" value="" class="btn_update" id="cusInputBtn"/>
		</div>
		<div class="btnRightBox">			
		<!--<input type="button" value="" id="cusInputBtn" class="customM" onclick="accountList()"/>	  				 -->
  		</div> 
	</div>
	</form>
</div>
	
<script type="text/javascript">
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

</script>

<script>
$(function() {			
	 $.validator.addMethod("regex", function(value, element, regexpr) {          
	     return regexpr.test(value);
	   });			 
	 
	$("#saveChangePassword").validate({
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
</body>
</html>