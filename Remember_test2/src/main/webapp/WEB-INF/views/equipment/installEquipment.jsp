<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<jsp:include page="../include/menu_admin.jsp">
		<jsp:param name="pageInMenu" value="기기관리"  />
		<jsp:param name="pageCategory" value="테블릿"  />
		<jsp:param name="pageTitle" value="테블릿설치조회"  /> 
	</jsp:include>
	
<div class="page">
	<div class="page-wrapper">
		<div class="pageTitle"><h2>테블릿 설치 조회</h2></div>

		<div class="pageContent">
			<div class="InstallContent">
				<div class="msgBox" id="msgBox"></div>
				<table>
					<tr>
						<th>기기분류</th>
						<td><input type="radio" id="equipment_type1" name="equipment_type" value="테블릿"><label for='equipment_type1'>테블릿</label> </td>
						<td><input type="radio" id="equipment_type2" name="equipment_type" value="게이트웨이"><label for='equipment_type2'>게이트웨이</label> </td>
						<td></td>
					</tr>
					<tr>
						<th>기기명</th>
						<td colspan="2"><input type="text" name="equipment_name" id="equipment_name" class="big_Input"> </td>
						<td><input type="button" name="equipment_btn" id="equipment_btn" value="찾기"> </td>
					</tr>
					<tr>
						<th>설치위치</th>
						<td colspan="2">
							<select class="big_select" id="equipment_install_loc" name="equipment_install_loc" onchange="staffId_Check1(this)">
								<option value="" label="설치위치 선택">설치위치 선택</option>
								<c:forEach items="${staffList}" var="dto" varStatus="s">	
						   			<option value="${dto.staff_id}">${dto.staff_name}</option>										   									
								</c:forEach>	
							</select>
						</td>
						<td></td>
					</tr>
					<tr>
						<th>설치일</th>
						<td colspan="2">
							<input type="text" class="big_Input" name="equipment_install_date" id="equipment_install_date">
						</td>
						<td></td>
					</tr>
					<tr>
						<th>설치자</th>
						<td colspan="2">
							<input type="text" class="big_Input" name="equipment_install_man" id="equipment_install_man">
						</td>
						<td></td>
					</tr>
					<tr>
						<th>사진</th>
						<td colspan="2"><input type="text" name="equipment_install" id="equipment_install" class="big_Input"> </td>
						<td><input type="button" name="addPhoto" id="addPhoto" value="사진첨부"> </td>
					</tr>
				</table>	
			</div>
			<div class="InstallList">
			
			</div>
		</div>
	</div>
</div>		
<jsp:include page="../include/footer.jsp"/>			
