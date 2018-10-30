<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<jsp:include page="../include/menu_admin.jsp">
		<jsp:param name="pageInMenu" value="접근제한"  />
		<jsp:param name="pageCategory" value=""  />
		<jsp:param name="pageTitle" value=""  /> 
	</jsp:include>
	
	<div class="page">
		<div class="page-wrapper ">
			
			<div class="pageContent textAlign-C">
				<div class="errorPage">
					<p><img src="images/image_380x130(x2).png"></p>
<!-- 					<p><span>권한이 없습니다.</span></p> -->
					<a href="home">메인으로 돌아가기</a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>