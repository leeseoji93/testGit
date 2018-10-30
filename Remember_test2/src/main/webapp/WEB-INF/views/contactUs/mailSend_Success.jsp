<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<jsp:include page="../include/menu_admin.jsp">
	<jsp:param name="pageInMenu" value="기기관리" />
	<jsp:param name="pageCategory" value="A/S신청" />
	<jsp:param name="pageTitle" value="" />
</jsp:include>

<div class="page">
	<div class="page-wrapper">
		<div class="pageTitle">
			<h2>A/S신청 완료</h2>
		</div>
		
		<div class="msgBox" id="msgBox"></div>
		<div class="pageContent asSend_Success" id="pageContent">
			<img src="images/equipment/image_AS_1100x600.png">
			
			<div class="asSend_Success_text">
				잠시 후 메인화면으로 이동됩니다. 
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
$(document).ready(function(){	
	setTimeout('go_url()',5000);  // 5초후 go_url() 함수를 호출한다.
});
function go_url(){

    location.href="home"  // 페이지 이동...

 }
</script>
<jsp:include page="../include/footer.jsp"/>
