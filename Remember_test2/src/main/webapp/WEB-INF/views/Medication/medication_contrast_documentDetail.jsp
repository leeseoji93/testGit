<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

	<jsp:include page="../include/menu_admin.jsp">
      <jsp:param name="pageInMenu" value="소통"  /> 
      <jsp:param name="pageCategory" value="투약대조서"  />
      <jsp:param name="pageTitle" value="투약대조서 상세정보"  /> 
   </jsp:include>
	<div class="page">
		<div class="page-wrapper">
			<div class="pageTitle"><h2>투약대조서 상세정보</h2></div>
			
			<div class="pageContent">
				<div class="medication_contrast_documentDetail_content">
				<div class="medication_contrast_documentDetail_contentLeft">
					<c:set value="${medication_requestList}" var="medication_requestListdto"/>
					<div><h3>투약 의뢰서</h3></div>					
					<div>금일 아래 유아의 투약을 의뢰합니다.</div>
					<table>
						<tr><th>이름(반) :</th><td>${medication_requestListdto[0].kid_name}(${medication_requestListdto[0].class_name})</td></tr>
						<tr><th>증상 :</th><td>${medication_requestListdto[0].symptom}</td></tr>
						<tr><th>약의 종류 :</th><td>${medication_requestListdto[0].medication_kind}</td></tr>
						<tr><th>투약 용량 :</th><td>${medication_requestListdto[0].volume}</td></tr>
						<tr><th>투약 횟수 :</th><td>${medication_requestListdto[0].count}</td></tr>
						<tr><th>투약 시간 :</th><td>${medication_requestListdto[0].dosing_time}</td></tr>
						<tr><th>보관 방법 :</th><td>${medication_requestListdto[0].keep}</td></tr>
						<tr><th>특이사항 :</th><td>${medication_requestListdto[0].uniqueness}</td></tr>
					</table>
					<div>${medication_requestListdto[0].medication_date}</div>
					<div><span>보호자 : ${medication_requestListdto[0].par_name}</span>
					<span>(인)</span>
<%-- 					<img width="100px" height="100px" id="sign_parent" src="data:image/png;base64,${imageContent_parent}"/> --%>
						<img width="100px" height="100px" id="sign_parent" src='${sign_url_parent}'/>
					</div>
					<div class="responsibility">※투약으로 인한 책임은 의뢰자가 집니다.</div>
				</div>
				
				<div class="medication_contrast_documentDetail_contentRight">
				<c:set value="${medication_confirmationList}" var="medication_confirmationdto1"/>
					<div><h3>투약 확인서</h3></div>
					<table>
						<tr><th>구분</th><th>투약시간</th><th>용량</th><th>횟수</th><th>투약자</th></tr>
						<c:forEach var="medication_confirmationdto" items="${medication_confirmationList}" varStatus="vs">
							<tr><td>${vs.count}</td><td>${medication_confirmationdto.dosing_time}</td>
							<td>${medication_confirmationdto.volume}</td><td>${medication_confirmationdto.count}</td>
							<td>${medication_confirmationdto.staff_name}</td></tr>
							<tr><th>특이사항</th><td colspan="4">${medication_confirmationdto.uniqueness}</td></tr>
						</c:forEach>
					</table>
					<div class="responsibility">금일 본원의 아동에 대해서 의뢰하신 내용대로<br>투약하엿음을 보고합니다.</div>
					<div>${medication_confirmationdto1[0].medication_date}</div>
					<div><span>담당교사 : ${medication_confirmationdto1[0].staff_name}</span>
					<span>(인)</span>
<%-- 					<img width="100px" height="100px" id="sign_teacher" src="data:image/png;base64,${imageContent_teacher}"/> --%>
						<img width="100px" height="100px" id="sign_teacher" src='${sign_url_teacher}'/>
					</div>					
					<div class = medication_contrast_documentDetail_centerName>${medication_confirmationdto1[0].center_name}</div>
				</div>
				
				</div>		
				
				<div class="contentBottomBtn" id="medication_diaryDetail_DownLoadbtn">
					<div class="btnLeftBox"><img src="images/button/button_back_80x25.png" class="medication_contrast_documentDetail_back" onclick="history.back();"></div>
					<div class="btnCnterBox centerDownBtn"><img src="images/button/button_download_90x25.png" class="medication_contrast_documentDetail_down" onclick="medication_contrast_documentDetail_Down()"></div>
					<div class="btnRightBox"></div>								
				</div>
				
				
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
	$(document).ready(function(){
	});	
	
	function medication_contrast_documentDetail_Down() {	
		var Arraylist = new Array();
	
		Arraylist.push("${request_id}");		          


		location.href = 'medication_contrast_document_multiDown?request_id=' + encodeURIComponent(Arraylist,'UTF-8');
	}
	</script>
	
</body>
</html>