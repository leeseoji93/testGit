<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@ page import="org.springframework.security.core.Authentication"%>
<%@ page import="org.springframework.security.core.userdetails.UserDetails"%>
<%@ page import="org.springframework.security.core.userdetails.UserDetailsService"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="include/menu_admin.jsp"/>
	<div class="page-wrapper">
		<div style="display: inline-block;">
			<div style="float: right;">
				접근권한이 없습니다. 담당자에게 문의하여 주시기 바랍니다.
	
	
				<%
	        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	        Object principal = auth.getPrincipal();
	        if (principal instanceof UserDetails) {
	            String username = ((UserDetails) principal).getUsername();
	            String password = ((UserDetails) principal).getPassword();
	            out.println("Account : " + username.toString() + "");
	        }
	        %>
				<a href="home">홈으로 이동</a>
			</div>
		</div>
	</div>
</body>
</html>