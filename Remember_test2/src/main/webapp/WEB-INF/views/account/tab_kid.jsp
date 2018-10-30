<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<div class="tabKidsList" id="category">

	<div id="layerWindow" class="layerWindow">
		<span class="modalWindow"></span>
		<div id="loginLayer" class="loginLayer loginTypeA">
			<div class="layerPopContent">
				<p>삭제 하시겠습니까?</p> 
				<input id="kidSystemCode" type="hidden" name="kidSystemCode" /> 
				<input type="button" class="btn_confirming_text" onclick="closeLayer3(1)" >
				<input type="button" class="btn_close_text" onclick="closeLayer3(0)" >
			</div>
		</div>
	</div>
	
	<div class="accoutTitleFix">
		<table>
			<tr>
				<th width="100px">이름</th>
				<th width="100px">생년월일</th>
				<th width="50px">성별</th>
				<th width="100px">반</th>
				<th width="50px">혈액형</th>
				<th width="130px">대표 보호자</th>
				<th width="260px">주소</th>
				<th width="170px"></th>
			</tr>
		</table>
	</div>
	<div class="accoutListContent">
		<table>
			<c:choose>
				<c:when test="${fn:length(kidsList) eq 0}">
					<tr><td align="center" width="860px">등록된 원아가 없습니다.</td></tr>
				</c:when>
				
				<c:otherwise>
					<c:forEach items="${kidsList}" var="dto" varStatus="status">	
						<tr style="cursor:pointer;">
							<td width="100px" onclick="kidInfo('${dto.kid_system_code}')">${dto.kid_name}</td>
							<td width="100px" onclick="kidInfo('${dto.kid_system_code}')">${dto.kid_birthday}</td>
							<td width="50px" onclick="kidInfo('${dto.kid_system_code}')">${dto.kid_sex}</td>
							<td width="100px" onclick="kidInfo('${dto.kid_system_code}')">${dto.class_name}</td>
							<td width="50px" onclick="kidInfo('${dto.kid_system_code}')">${dto.kid_blood}</td>
							<td width="130px">
								<select class="" id="par_id${s.count}" name="par_id${s.count}" onchange="repreParent('${dto.kid_system_code}','${s.count}')">
									<option value=''>선택
									<c:forEach items="${kidParentList}" var="p" varStatus="k">	
										<c:choose>
											<c:when test="${dto.kid_system_code eq p.kid_system_code}">
												<option value="${p.par_id}">${p.par_name}</option>
											</c:when>
										</c:choose>
									</c:forEach>								   									
								</select>			   									
							</td>
							<td width="290px" onclick="kidInfo('${dto.kid_system_code}')">${dto.kid_addr}</td>
							<td width="140px">
								<input type="button" class="btn_correct_40" id="" value="" onclick="updateKids('${dto.kid_system_code}')"> 
								<input type="button" class="btn_delete_40" id="" value="" onclick="deleteKids('${dto.kid_system_code}')">
							</td>
						</tr>	
					</c:forEach>
				</c:otherwise>
			</c:choose>
			
			
		</table>
	</div>
	
</div>
<script>
	
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$(document).ready(function(){
		var listLength = "${fn:length(kidsList)}";
		<c:forEach items="${kidsList}" var="dto" varStatus="s">
// 			$("input[value='"+par_id+"']").attr('checked', true);
			$("#par_id${s.count}").val("${dto.par_id}").attr('selected', true);
		</c:forEach>
		
	});
	
	function repreParent(kid_code,cnt){
		console.log("kid_code:"+kid_code);
// 		$("#par_id"+cnt).val("${dto.par_id}").attr('selected', true);
		var id = "#par_id"+cnt
		var par_id = $(id+" option:selected").val();
		
		console.log("par_id:"+par_id);

		$.ajax({
			type : "GET",
			url : "updateRepreParent",
			data : { "kid_code" : kid_code,"par_id":par_id},
			beforeSend: function(xhr) {
	              xhr.setRequestHeader(header, token);
	           },
			success : function(data) {
	//				setInterval('autoRefresh_div()', 3000);
	    		console.log("성공");
	    		$('#msgBox').addClass("msgBox_Success");	
	    		$('#msgBox').html("<span>대표 보호자가 변경 되었습니다.</span>");
	    		$('#msgBox').addClass("inlieClass");
			},
			error : function(xhr, txtStatus, errorThrown) {
				alert("error" + errorThrown);
			}
		});
	}
	
	

	function kidInfo(kidCode){			//원아 상세 정보
		console.log("kidCode"+kidCode);
	
		var has = $('#msgBox').hasClass("inlieClass");
		if(has){ $('#msgBox').removeClass("inlieClass");$('#msgBox').addClass("noneClass");}
		
		$.ajax({
			type : "GET",
			url : "kidInfo",
			data : { "kidCode" : kidCode},
			beforeSend: function(xhr) {
	              xhr.setRequestHeader(header, token);
	           },
			success : function(data) {
	//				setInterval('autoRefresh_div()', 3000);
	    		$("#tabs-2").html(data); //str로 받은 data를 넘긴다.  
	//				$('#tabs-1').load('kidInfo #tabs-3');
			},
			error : function(xhr, txtStatus, errorThrown) {
				alert("error" + errorThrown);
			}
		});
	}


	function updateKids(obj) {
		
		$.ajax({
			type : "GET",
			url : "tab_kid_update",
			data : { "kid_system_code" : obj},
			contentType:"application/x-www-form-urlencoded; charset=UTF-8",
			beforeSend: function(xhr) {
	              xhr.setRequestHeader(header, token);
	           },
			//data: { "CODE_LEVEL": totcnt },    //escape 한글 깨짐 방지 구문  
			success : function(data) {
				
					$("#tabs-2").html(data); //str로 받은 data를 넘긴다.  
			},
			error : function(xhr, txtStatus, errorThrown) {
				alert("error" + errorThrown);
			}
		});

	}
	
	function deleteKids(obj) {
		$('#layerWindow').css('display','block');
		$("#kidSystemCode").val(obj);
	}
	function closeLayer3(obj){
		var classId = $('#classId').val();
		var kidSystemCode = $("#kidSystemCode").val();
		if(obj==1){		//승인 확인
			$.ajax({
				type : "POST",
				url : "tab_kid_delete",
				data : { "kid_system_code" : kidSystemCode},
				contentType:"application/x-www-form-urlencoded; charset=UTF-8",
				beforeSend: function(xhr) {
		              xhr.setRequestHeader(header, token);
		           },
				//data: { "CODE_LEVEL": totcnt },    //escape 한글 깨짐 방지 구문  
				success : function(data) {
					console.log(data.deleteKid);
					if(data.deleteKid=="1"){
						$('#msgBox').empty();
						$('#msgBox').addClass("msgBox_Success");	
			    		$('#msgBox').html("<span>원아가 삭제 되었습니다.</span>");
// 			    		$('#tabs-2').load('accountList #category');
			    		$('#tabs-2').load('accountList #tabs-2');
					}else{
						$('#msgBox').empty();
						$('#msgBox').addClass("msgBox_Error");	
			    		$('#msgBox').html("<span>원아가 노선에 배정되어 삭제 할 수 없습니다.</span>");
// 			    		$('#tabs-2').load('accountList #category');
						return false;
					}
				},
				error : function(xhr, txtStatus, errorThrown) {
					alert("error" + errorThrown);
				}
			});
		}document.getElementById('layerWindow').style.display='none';
	}
</script>