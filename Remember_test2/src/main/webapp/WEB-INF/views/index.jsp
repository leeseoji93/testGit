<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>아티유자</title>
<link rel="shortcut icon" type="image/x-icon" href="images/favicon.ico" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="index_part1">
	<div class="index_loginBox">
		<div class="index_part_loginBox">
			<img src="images/index/Indexlog.png" class="index_logo">
			<h3>test</h3>
			<ul>
				<li><img src="images/index/main_1_butten_login.png" onclick="location.href='login'"> </li>
				<li><img src="images/index/main_1_butten_menber.png" onclick="location.href='signupForm'"> </li>
			</ul>
		</div>	
	</div>
</div>
<div class="index_part2">
	<div class="index_part_banner">
		<img src="images/index/bannerText.png"> 
	</div>
</div>
<div class="index_part3">
	<div class="index_part_banner2">
		<img src="images/index/main_1-3.png"> 
	</div>
</div>
<jsp:include page="include/footer.jsp"/>
</body>
</html>