<%@page import="com.test.rememberTest.Dto.StaffDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="org.springframework.security.core.Authentication" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.userdetails.UserDetails" %>
<%@ page import="com.test.rememberTest.Dto.MemberInfo" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<title>아티유자</title>
<link rel="shortcut icon" type="image/x-icon" href="images/favicon.ico" />
</head>
<body>

<script>
	function formSubmit() {
		console.log("formSubmit");
		document.getElementById("logoutForm").submit();
	}
</script>
<%	
	String pageInMenu = (String) request.getParameter("pageInMenu"); 
	String pageTitle = (String) request.getParameter("pageTitle"); 
	String pageCategory = (String) request.getParameter("pageCategory"); 
%>
	<input type="hidden" name="${_csrf.parameterName}" id="csrf" value="${_csrf.token}" />
	<div class="headerBar" id="head">
		<div class="mainLogo"> <!-- 메뉴 위에 로고 박스 -->
			<a href="home"><img src="images/header/mainLogo.png"></a>
		</div>
		<div class="navi"> <!-- 페이지 네비게이션 -->
			<%
				if(pageCategory==null && pageTitle==null){
			%>
				<ul>
					<li><img src="images/header/header_navigation_1.png"></li>
					<li>&nbsp;>&nbsp;</li>
					<li>HOME</li>
				</ul>		
			<%	
				}else{
			%>
				<ul>
					<li><img src="images/header/header_navigation_1.png"></li>
					<li>&nbsp;>&nbsp;</li>
					<li><%=pageInMenu %></li>
					<%
						if(pageCategory !=""){
					%>
					<li>&nbsp;>&nbsp;</li>
					<li><%=pageCategory %></li>
					<%
					}
						if(pageTitle !=""){
					%>
					<li>&nbsp;>&nbsp;</li>
					<li><%=pageTitle %></li>
					<%
					}
					%>
				</ul>
			<%		
				}
		
			%>
			
		</div>
<%-- 		${pageContext.request.userPrincipal. --%>
		<div class="peopleBox"> <!-- 오른쪽 상단에 로그인부분 -->
			<sec:authorize access="isAnonymous()"> <!-- 로그인 하지 않았을 때 -->
<!-- 			    <ul> -->
<!-- 			    	<li><a href="signupForm" >회원가입</a></li> -->
<!-- 			    	<li>&nbsp|&nbsp</li> -->
<!-- 			    	<li><a href="login" target="_self">로그인</a></li> -->
<!-- 			    </ul> -->
			</sec:authorize>
			<sec:authorize access="isAuthenticated()"> <!-- 로그인 했을 때 -->
			    <c:if test="${pageContext.request.userPrincipal.name != null}">
			    
			    <ul>
				    <li class="sub-menu-parent">
				     	<a href="mypage">${pageContext.request.userPrincipal.name}</a>
				     	<ul class="sub-menu">
					        <li class="" style="cursor:pointer;">
					        	<form action="j_spring_security_logout" method="post">
									<input type="submit" value="로그아웃" id="logoutBtn" style="cursor:pointer;"/>
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
								</form>
					        </li>
					        <li><a href="mypage">마이페이지</a></li>
				     	</ul>
				    </li>
			   	</ul>
				</c:if>
			</sec:authorize>
		</div>
	</div>
