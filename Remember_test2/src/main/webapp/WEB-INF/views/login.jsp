<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page session="true"%>
<head>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/footer.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/includeStyle.css">
<style>
.error {
	padding: 15px;
	margin-bottom: 20px;
	border: 1px solid transparent;
	border-radius: 4px;
	color: #a94442;
	background-color: #f2dede;
	border-color: #ebccd1;
}

.msg {
	padding: 15px;
	margin-bottom: 20px;
	border: 1px solid transparent;
	border-radius: 4px;
	color: #31708f;
	background-color: #d9edf7;
	border-color: #bce8f1;
}

#login-box {
	width: 300px;
	padding: 20px;
	margin: 100px auto;
	background: #fff;
	-webkit-border-radius: 2px;
	-moz-border-radius: 2px;
	border: 1px solid #000;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<title>아티유자</title>
<link rel="shortcut icon" type="image/x-icon" href="images/favicon.ico" />
</head>
<body onload='document.loginForm.username.focus();' bgcolor="#19B9A1">
	<div class="fullpage">
		<div class="page-wrapper">
			
			<div class="loginContent">
				<div class="loginLogo"><a href="index"><img src="images/header/image_logo_180x85(x2).png"> </a></div>
				
				<div id="loginBox">
							
					<c:if test="${not empty error}">
						<div class="error">${error}</div>
					</c:if>
					<c:if test="${not empty msg}">
						<div class="msg">${msg}</div>
					</c:if>
			
					<form name='loginForm' action="<c:url value='/auth/login_check?targetUrl=${targetUrl}' />"	method='POST'>
			
						<table>
							<tr>
								<td><input type='text' name='username' placeholder="아이디를 입력 해 주세요." class="loginInput"></td>
							</tr>
							<tr>
								<td><input type='password' name='password' placeholder="비밀번호를 입력 해 주세요."  class="loginInput"/></td>
							</tr>
						
							<tr>
								<td><input name="submit" type="submit" value="로그인" class="loginBtn" /></td>
							</tr>
										
						</table>
						
						<div class="loginBottom">
						<c:if test="${empty loginUpdate}">
							<input id = "remember_me" name ="_spring_security_remember_me" type = "checkbox"/>
							<label for="remember_me">로그인 상태 유지</label>
						</c:if>
							<div class="loginBottom-s">
								<ul>
									<li><a href="signupForm">회원가입</a></li>
									<li>&nbsp|&nbsp</li>
									<li><a href="findId">아이디찾기</a></li>
									<li>&nbsp|&nbsp</li>
									<li><a href="findPassWord">비밀번호찾기</a></li>
								</ul>
							</div>
						</div>
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			
					</form>
			
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="include/footer.jsp"/>
