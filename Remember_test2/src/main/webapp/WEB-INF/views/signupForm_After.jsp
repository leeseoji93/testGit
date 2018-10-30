<%@page import="java.io.Console"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<style type="text/css">
	input.error, textarea.error{
		border:1px dashed red;
	}
	label.validFail{	 
		color:red;
	}
	label.validSuccess{
 		color:green;
	}
</style>
	<jsp:include page="include/menu_admin.jsp">
		<jsp:param name="pageCategory" value="회원가입"  />
		<jsp:param name="pageTitle" value="회원가입 완료"  /> 
	</jsp:include>
	<div class="page">
		<div class="page-wrapper">
			<div class="pageTitle"><h2>회원가입 완료</h2></div>
			
			<div class="pageContent">		
				<div class="signupAfter_text">
					회원가입이 완료 되었습니다.
				</div>
				<div class="signupAfter_text">
					<a href="login">로그인</a>
					<a href="home">홈으로</a>
				</div>
			</div>
		</div>
	</div>

</body>
</html>