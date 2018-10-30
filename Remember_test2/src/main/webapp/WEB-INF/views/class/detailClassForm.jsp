<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<jsp:include page="../include/menu_admin.jsp">
		<jsp:param name="pageInMenu" value="시설관리"  />
		<jsp:param name="pageCategory" value="반관리"  />
		<jsp:param name="pageTitle" value="반 상세조회"  /> 
	</jsp:include>
	
	<div class="page">
		<div class="page-wrapper">
			<div class="pageTitle"><h2>반 상세조회 </h2></div>
	
			<div class="pageContent700">
				<form action="addClass" method="post" id="addClass">
					<div class="msgBox" id="msgBox"></div>
					
					<div class="detailClassContent">
						<table>
						<c:forEach items="${detailClass}" var="dto_c" varStatus="s">	
							<tr>
								<th width="150px">반 이름</th>
								<td width="850px" colspan="3">${dto_c.class_name}
								<input type="hidden" name="class_id" id="class_id" value="${dto_c.class_id}" />
								</td>
							</tr>
							<tr>
								<th width="150px">담임</th>
								<td> 
									${dto_c.staff_name_1}
								</td>
								<th width="150px">부 담임</th>
								<td> 
									${dto_c.staff_name_2}
								</td>
							</tr>
							<tr>
								<th>연령</th>
								<td colspan="3">
									${dto_c.class_year}세 
								</td>
							</tr>
							<tr>
								<th>학기</th>
								<td colspan="3">
									${dto_c.class_sem}  
								</td>
							</tr>
						</c:forEach>
							<tr>
								<th>원아</th>
								<td colspan="3">
									<c:forEach var="dto_k" items="${detailClassKids}" varStatus="s">
									<div class="kidInClass"><span><img src="${dto_k.kid_pho}"></span>${dto_k.kid_name}</div>  	
									</c:forEach>
								</td>
							</tr>
						
						</table>
						
					</div>
					
					<div class="pageBtn contentBottomBtn">
						<div class="btnLeftBox">
							<input type="button" value="" class="btn_back" id="cusInputBtn" onclick="history.back();" id="bottomBtn-Input"> <!-- 이전버튼 클릭 -->
						</div>
						<div class="btnCnterBox">
							<input type="button" value="" id="cusInputBtn" class="btn_update" onclick="goPage()"/>
									  				
				  		</div>
				  		<div class="btnRightBox">
				  			<input type="button" value="" id="cusInputBtn" class="customM" onclick="location.href='ClassList'"/>		
				  		</div>
			  		</div>
		  		</form>
			</div>
			<div class="pageContent256">
				<div class="detailClassForm_right">
					<table id="classListContentTable">
						<tr>
							<th width="150px">반이름</th>
							<th width="110px">담임</th>
							<th width="110px">학기</th>
						</tr>
						<c:forEach items="${allClassList}" var="dto" varStatus="s">	
				   			<tr>
				   				<td onclick="location.href='detailClassForm?class_id=${dto.class_id}'">${dto.class_name}</td>
				   				<td align="center" onclick="location.href='detailClassForm?class_id=${dto.class_id}'">${dto.staff_name_1}</td>
				   				<td align="center" onclick="location.href='detailClassForm?class_id=${dto.class_id}'">${dto.class_sem}</td>
				   			</tr>									   									
						</c:forEach>
					</table>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../include/footer.jsp"/>
<script>

	function goPage(){
		var classId = $("#class_id").val();
		console.log("classId:"+classId);
		location.href='UpdateClassForm?class_id='+classId;
	}
</script>	
