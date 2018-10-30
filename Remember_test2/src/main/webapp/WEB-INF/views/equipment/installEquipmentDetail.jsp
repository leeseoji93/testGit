<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
	<jsp:include page="../include/menu_admin.jsp">
		<jsp:param name="pageInMenu" value="기기관리"  />
		<jsp:param name="pageCategory" value="테블릿&게이트웨이"  />
		<jsp:param name="pageTitle" value="설치상세조회"  /> 
	</jsp:include>
<c:set value="${data}" var="dto_k"/>	
<div class="page">
	<div class="page-wrapper">
		<div class="pageTitle"><h2>설치 상세조회</h2></div>
		
		<div id="layerWindow" class="layerWindow">
			<span class="modalWindow"></span>
			<div id="loginLayer" class="loginLayer2 loginTypeA">
				<div class="layerPopContent" id="layerPopContent">
					<div class="findInfo" id="findInfo">
					</div>
					<input type="hidden" name="bus_id" id="bus_id" value="${dto_k[0].bus_id}">
					<a onclick="closeLayer(1)" style="cursor: hand">닫기</a>&nbsp;
				</div>
			</div>
		</div>
		<div class="pageContent700 ">
			<div class="installEquipmentDetail_Content">
				<div class="installEquipmentDetail_Content_img">
					<img src="${dto_k[0].equipment_install}">
				</div>
				<div class="installEquipmentDetail_Content_table">
					<table>
						<tr>
							<th width="75">기기명</th>
							<td width="150">${dto_k[0].equipment_name}</td>
							<th width="75">설치위치</th>
							<td width="150"><a onclick="info()" id="info">${dto_k[0].equipment_install_loc}</a></td>
						</tr>
						<tr>
							<th>설치일</th>
							<td>${dto_k[0].INSTALLDATEFORMAT}</td>
							<th>설치자</th>
							<td>${dto_k[0].equipment_install_man}</td>
						</tr>
						
					</table>
				</div>
				
			</div>
			
			<div class="pageBtn contentBottomBtn">						
				<div class="btnLeftBox">
				</div>
				<div class="btnCnterBox">
					<input type="submit" value="" class="btn_update" id="cusInputBtn"onclick="location.href='installEquipmentUpdate?equipment_id=${dto_k[0].equipment_id}'" />
				</div>
				<div class="btnRightBox">			
					<input type="button" value="" id="cusInputBtn" class="customM" onclick="location.href='installEquipmentList'"/>	  				
		  		</div> 
			</div>
		</div>	
				
		<div class="pageContent300">	
			<div class="installEquipment_List">
				<h3>설치 목록</h3>
				<table>
					<tr>
						<th width="128">게이트웨이명</th>
						<th width="128">설치위치</th>
					</tr>
					<c:forEach items="${equip_List}" var="dto_b" varStatus="s">
					<tr>
						<td onclick="location.href='installEquipmentDetail?equipment_id=${dto_b.equipment_id} &equipment_type=${dto_b.equipment_type}'">${dto_b.equipment_name}</td>
						<td onclick="location.href='installEquipmentDetail?equipment_id=${dto_b.equipment_id} &equipment_type=${dto_b.equipment_type}'">${dto_b.equipment_install_loc}</td>
					</tr>
					</c:forEach>
				</table>
			</div>
		</div>
	</div>
</div>
<jsp:include page="../include/footer.jsp"/>	
<script type="text/javascript">
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
$(document).ready(function(){	
	var bus_id= "${dto_k[0].bus_id}";
	if(bus_id==""){
// 		console.log("게이트웨이");
// 		$('#info').css('display','none');
// 		$("#equipment_install_loc").append("<option value='원 입구'>원 입구</option>");	
	}	
});
function info(){
	$('#layerWindow').css('display','block');

	var busId = $('#bus_id').val();
	console.log("busId:"+busId);
	
	if(busId==null){
		$.ajax({
			type : "get",
			url : "CarDetailInfo",
			data : { "num" : busId},
			beforeSend: function(xhr) {
	              xhr.setRequestHeader(header, token);
	           },
			success : function(data) {
				console.log("test");
//					setInterval('autoRefresh_div()', 3000);
				 var e = $(data).find('table');
//	 			 var refine = $("#layerPopContent").html(data).find('.pageTitle');
				 console.log("e:"+e);
				 $('#findInfo').html(e);
//	 			$('#layerPopContent').html(data.list[0].bus_name);
//					$('#msgBox').addClass("msgBox_Success");	
//		    		$('#msgBox').html("<span>삭제 되었습니다.</span>");
//		    		document.getElementById('msgBox').style.display="block";
			},
			error : function(xhr, txtStatus, errorThrown) {
				alert("error" + errorThrown);
			}
		});
	}else{
		$('#findInfo').html("정보가 없습니다.<br><br>");
	}
	
	
	
}

function closeLayer(obj){
	document.getElementById('layerWindow').style.display='none';	
}	
	
</script>		
