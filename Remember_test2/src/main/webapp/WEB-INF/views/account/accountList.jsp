<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="../include/menu_admin.jsp">
	<jsp:param name="pageInMenu" value="계정관리"  />
	<jsp:param name="pageCategory" value="계정조회"  />
	<jsp:param name="pageTitle" value=""  /> 
</jsp:include>
 <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/jquery-ui.css">
<script>
$( function() {
  $( "#tabs" ).tabs({
  });
} );

</script>
<div class="page">
	<div class="page-wrapper">
		<div class="pageTitle"><h2>계정 조회</h2></div>
		<div class="pageContent accountListPage">
			<div class="msgBox" id="msgBox"></div>
			<div class="AccountList">
				
				<div id="tabs">
					<ul>
					    <li><a href="#tabs-1" id="liBtn1">교직원</a></li>
					    <li><a href="#tabs-2" id="liBtn2">원아</a></li>
					    <li><a href="#tabs-3" id="liBtn3">학부모</a></li>
					</ul>
					<div id="tabs-1">
					   	<jsp:include page="tab_teachers.jsp"/>
					   	<%-- <table>
							<tr>
								<th width="100px">아이디</th>
								<th width="100px">이름</th>
								<th width="100px">구분</th>
								<th width="100px">직책</th>
								<th width="150px">반</th>
								<th width="130px">연락처</th>
								<th width="160px">Email</th>
								<th width="170px"></th>
							</tr>
							<c:forEach items="${staffList}" var="dto" varStatus="status">	
							<tr onclick="staffInfo('${dto.staff_id}')">
								<td>${dto.staff_id}</td>
								<td>${dto.staff_name}</td>
								<td>${dto.staff_position}</td>
								<td>${dto.staff_type}</td>
								<td>${dto.class_name}</td>
								<td>${dto.staff_phone}</td>
								<td>${dto.staff_email}</td>
								<td>
									<input type="button" class="btn_update" id="" value="" onclick="updateFormS('${dto.staff_id}')"> 
									<input type="button" class="btn_delete" id="" value="" onclick="">
								</td>
							</tr>							   									
							</c:forEach>
						</table> --%>
					</div>
					<div id="tabs-2">
					    <jsp:include page="tab_kid.jsp"/>
<!-- 					    <table> -->
<!-- 							<tr> -->
<!-- 								<th></th> -->
<!-- 								<th width="100px">이름</th> -->
<!-- 								<th width="100px">생년월일</th> -->
<!-- 								<th width="50px">성별</th> -->
<!-- 								<th width="100px">반</th> -->
<!-- 								<th width="50px">혈액형</th> -->
<!-- 								<th width="130px">보호자명</th> -->
<!-- 								<th width="260px">주소</th> -->
<!-- 								<th width="170px"></th> -->
<!-- 							</tr> -->
<%-- 							<c:forEach items="${kidsList}" var="dto" varStatus="s"> --%>
<!-- 							<tr> -->
<%-- 								<td>${s.index}</td> --%>
<%-- 								<td>${dto.kid_name}</td> --%>
<%-- 								<td>${dto.kid_birthday}</td> --%>
<%-- 								<td>${dto.kid_sex}</td> --%>
<%-- 								<td>${dto.class_name}</td> --%>
<%-- 								<td>${dto.kid_blood}</td> --%>
<%-- 								<td>${dto.par_name}</td> --%>
<%-- 								<td>${dto.kid_addr}</td> --%>
<!-- 								<td> -->
<%-- 									<input type="button" class="btn_update" id="" value="" onclick="updateKids('${dto.kid_system_code}')">  --%>
<!-- 									<input type="button" class="btn_delete" id="" value="" onclick=""> -->
<!-- 								</td> -->
<!-- 							</tr>	 -->
<%-- 							</c:forEach> --%>
<!-- 						</table> -->
					</div>
					<div id="tabs-3">
						<div id="tabs-3_div">
							<jsp:include page="tab_parent.jsp"/>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>
</div>
<jsp:include page="../include/footer.jsp"/>

</body>
</html>