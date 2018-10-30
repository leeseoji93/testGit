<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
	<jsp:include page="include/menu_admin.jsp">
		<jsp:param name="pageCategory" value="회원가입"  />
		<jsp:param name="pageTitle" value="담당선택"  /> 
	</jsp:include>
	<div class="page">
		<div class="page-wrapper">
	
			<div class="pageTitle"><h2>담당선택</h2></div>
			<div class="pageContent textAlign-C">
				<div class="member_box">
					<a href="signupForm_admin?type=3"><img src="images/womanIcon.png"> 원장</a>
				</div>
				<div class="member_box">
					<a href="signupForm?type=2"><img src="images/womanIcon.png">교사</a>
				</div>
				<div class="member_box">
					<a href="signupForm?type=1"><img src="images/manIcon.png">운전기사</a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>