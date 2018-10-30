<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="include/menu_admin.jsp"/>
	<div class="page-wrapper">

		<div class="pageTitle"><h2>회원목록</h2></div>
		 <table border="1">
			 <tr>
		<!-- 		 <td>번호</td> -->
				 <td>아이디</td>
				 <td>이름</td>
				 <td>전화번호</td>
				 <td>이메일</td>
				 <td>구분</td>
			 </tr>
		
		 	<c:forEach var="obj" items="${userList}">
			 <tr>
	<%-- 			 <td>${obj.mNo}</td>  --%>
				 <td>${obj.mId}</td>
				 <td>${obj.mName}</td>
				 <td>${obj.mPhone}</td>
				 <td>${obj.mEmail}</td>
				 <td>${obj.mGrade}</td>
			</tr>	
		 	</c:forEach>
		</table>
	
		<c:if test="${page>1}">
			<a href="userList?page=${page-1}">[이전]</a>
		</c:if>
		[${page}]
		<c:if test="${page<lastPage}">
			<a href="userList?page=${page+1}">[다음]</a>
		</c:if>
	

	<a href="/dev3">홈으로 돌아가기</a>
	</div>

</body>
</html>