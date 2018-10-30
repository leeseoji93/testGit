<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<jsp:include page="../include/menu_admin.jsp">
		<jsp:param name="pageInMenu" value="시설관리"  />
		<jsp:param name="pageCategory" value="원정보"  />
		<jsp:param name="pageTitle" value="원조회"  /> 
	</jsp:include>
	<c:set value="${detailCenter}" var="dto_c"/>
<div class="page">
	<div class="page-wrapper">
		<div class="pageTitle"><h2>원정보 </h2></div>
		<div class="pageContent ">
			<div class="centerInfoContent">
				<div class="centerInfoContent_L">
				<div class="big_thumbnail-wrapper">
					<div class="thumbnail">
						<div class="centered">
							<img src="${dto_c[0].center_pho}" class="equiptment_BigImg">
						</div>
					</div>
				</div>
				
				</div>
				<div class="centerInfoContent_R">
					<table>
					
		<%-- 			<c:forEach items="${detailCenter}" var="dto_c" varStatus="s"> --%>
						<tr>
							<th width="100">기관명</th>
							<td colspan="3">${dto_c[0].center_name}</td>
						</tr>
						<tr>
							<th>대표자명</th>
							<td colspan="3">${dto_c[0].center_repn}</td>
						</tr>
						<tr>
							<th>원장명</th>
							<td colspan="3">${dto_c[0].center_dirn}</td>
						</tr>
						<tr>
							<th>전화번호</th>
							<td colspan="3">${dto_c[0].center_phon}</td>
						</tr>
						<tr>
							<th>주소</th>
							<td colspan="3">${dto_c[0].center_addr}</td>
						</tr>
						<tr>
							<th>설립유형</th>
							<td colspan="3">${dto_c[0].center_type}</td>
						</tr>
					</table>
					<table>
						<tr>
							<th width="100">운영시간</th>
							<td colspan="3">${dto_c[0].center_otim}</td>
						</tr>
						<tr>
							<th>설립일</th>
							<td colspan="3">${dto_c[0].center_dest}</td>
						</tr>
						<tr>
							<th>개원일</th>
							<td colspan="3">${dto_c[0].center_open}</td>
						</tr>
						<tr>
							<th>관할행정기관</th>
							<td colspan="3">${dto_c[0].center_adma}</td>
						</tr>
						<tr>
							<th>평가인증 연월</th>
							<td colspan="3">${dto_c[0].center_eval}</td>
						</tr>
						<tr>
							<th>홈페이지 URL</th>
							<td colspan="3">${dto_c[0].center_web}</td>
						</tr>
					</table>
				</div>
			</div>
			
			
			<div class="pageBtn contentBottomBtn centerInfoBlock">						
				<div class="btnLeftBox">
				</div>
				<div class="btnCnterBox">
					<input type="submit" value="" class="btn_update" id="cusInputBtn"onclick="location.href='centerUpdate'" />
				</div>
				<div class="btnRightBox">			
<!-- 					<input type="button" value="" id="cusInputBtn" class="customM" onclick="accountList()"/>	  				 -->
		  		</div> 
			</div>
		</div>
	</div>
</div>
<jsp:include page="../include/footer.jsp"/>
<script type="text/javascript">

$(document).ready(function(e) {
	 
    $(".thumbnail .centered img").each(function() {
    	
    	   console.log("test:");
     	var imgWidth = this.naturalWidth; //이미지 크키가 정해져 있지 않을때
     	var imgHeight = this.naturalHeight;
		var imgWidth2 = $(this).width(); //이미지 크키가 정해져 있을때
		
		if(imgWidth>imgHeight){$(".thumbnail .centered img").addClass("landscape");}
		else{$(".thumbnail .centered img").addClass("portrait");}
		console.log("imgWidth:"+imgWidth);
		console.log("imgHeight:"+imgHeight);
		console.log("imgWidth2:"+imgWidth2);
	
    });
});
</script>
