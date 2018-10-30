<%@page import="java.io.Console"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Insert title here</title>

<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="js/jquery.validate.min.js"></script><!-- 유효성 검사 -->
<script type="text/javascript" src="js/additional-methods.min.js"></script><!-- 유효성 검사 -->

</head>
<body>

<form action="stationInsert" method="post" id="userForm">
	<input type="text" class="big_input" id="mId">
	
	<input type="submit" value="전송">
</form>
<script>
	$(function() {			
		 $.validator.addMethod("regex", function(value, element, regexpr) {          
		     return regexpr.test(value);
		   });			 
		 
		$("#userForm").validate({
			errorClass: "validFail",
			validClass: "validSuccess",
			
		    rules: {
		    	mId : {
		    		required: true,		    					    		
		    		regex: /^[a-zA-Z0-9]{6,13}$/			    		
		    	}
		    },	    
		    messages: {
		    	mId: {
		            required: "입력해주세요",		            
		            regex : "정규식이 틀립니다."			    		
		        }
		    },		    
		    success: function(label) {
                   label.addClass("validSuccess").text("Ok!");
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