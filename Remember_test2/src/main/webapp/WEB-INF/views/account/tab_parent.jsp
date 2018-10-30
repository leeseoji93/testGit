<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<div class="parentList">
	<div id="layerWindow_p" class="layerWindow">
		<span class="modalWindow"></span>
	
		<div id="loginLayer" class="loginLayer loginTypeA">
			<div class="layerPopContent">
				<p><span class="re_question"></span>하시겠습니까?</p> 
				<input id="parId" type="hidden" name="parId" /> 
				<input id="kid_code" type="hidden" name="kid_code" /> 
				<input type="button" class="btn_confirming_text" onclick="closeLayer2(1)" >
				<input type="button" class="btn_close_text" onclick="closeLayer2(0)" >
			</div>
		</div>
	</div>
</div>
<div class="accoutTitleFix">
	<table>
		<tr>
			<th width="100px">아이디</th>
			<th width="100px">이름</th>
			<th width="100px">자녀</th>
			<th width="180px">연락처</th>
			<th width="210px">Email</th>
			<th width="170px">상태</th>
			<th></th>
		</tr>
	</table>
</div>
<div class="accoutListContent">
	<table>
		<c:choose>
			<c:when test="${fn:length(parentList) eq 0}">
				<tr><td align="center" width="860px">등록된 학부모가 없습니다.</td></tr>
			</c:when>
			
			<c:otherwise>
				<c:forEach items="${parentList}" var="dto_p" varStatus="s">
					<tr>
						<td width="100px">${dto_p.par_id}</td>
						<td width="100px">${dto_p.par_name}</td>
						<td width="100px">${dto_p.kid_name}</td>
						<td width="180px">${dto_p.par_phone}</td>
						<td width="210px">${dto_p.par_email}</td>
						<td width="170px">
							<c:choose>
								<c:when test="${dto_p.check_stater == '대기'}">
									<!-- btn_update btn_delete-->
									<!-- 								    		<a href="#layerWindow" onclick="">눌러봐요</a> -->
									<input type="button" class="btn_approval_text" id="" value=""
										onclick="openLayer('${dto_p.par_id}','${dto_p.kid_system_code}','1')">
									<input type="button" class="btn_refusal_text" id="" value=""
										onclick="openLayer('${dto_p.par_id}','${dto_p.kid_system_code}','0')">
								</c:when>
								<c:otherwise>
									-	
			    				</c:otherwise>
							</c:choose>
						</td>
						<td>
							<c:choose>
								<c:when test="${dto_p.check_stater == '대기'}">
									<!-- btn_update btn_delete-->
			
								</c:when>
								<c:otherwise>
									<input type="button" class="btn_delete_40" id="" value="" onclick="openLayer('${dto_p.par_id}','${dto_p.kid_system_code}','2')">
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
		
	</table>
</div>


<script>
$(document).ready(function(){
	var has = $('#msgBox').hasClass("inlieClass");
	if(has){ $('#msgBox').removeClass("inlieClass");$('#msgBox').addClass("noneClass");}
});
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	var onOffcheck = 0; // 0 대기, 1 거절, 2 승인
	
	function staffInfo(staffId){			//교직원 상세 정보
		console.log("staffId"+staffId);
		
		$.ajax({
			type : "GET",
			url : "staffInfo",
			data : { "staffId" : staffId},
			beforeSend: function(xhr) {
	              xhr.setRequestHeader(header, token);
	           },
			success : function(data) {
				console.log("test");
//					setInterval('autoRefresh_div()', 3000);
	    		$("#tabs-1").html(data); //str로 받은 data를 넘긴다.  
// 				$('#tabs-1').load('staffInfo #tabs-3');
			},
			error : function(xhr, txtStatus, errorThrown) {
				alert("error" + errorThrown);
			}
		});
		
		
	}
		
	function deleteParents(obj) {
		$.ajax({
			type : "POST",
			url : "tab_kid_update",
			data : { "kid_system_code" : obj},
			contentType:"application/x-www-form-urlencoded; charset=UTF-8",
			beforeSend: function(xhr) {
	              xhr.setRequestHeader(header, token);
	           },
			//data: { "CODE_LEVEL": totcnt },    //escape 한글 깨짐 방지 구문  
			success : function(data) {
					$("#tabs-2").html(data); //str로 받은 data를 넘긴다.  
				console.log("test");
			},
			error : function(xhr, txtStatus, errorThrown) {
				alert("error" + errorThrown);
			}
		});

	}
	function autoRefresh_div()
	{
		var currentLocation = window.location;
		$("#tabs-3").load(currentLocation + '#tabs-3');
	}
	
	function openLayer(parId,kid_code,check){
		console.log("parId:"+parId);
		$('#parId').val(parId);
		$('#kid_code').val(kid_code);
		$('#layerWindow_p').css('display','block');
		console.log("parId:"+parId);
		if(check==1){
			$('.re_question').text("승인");
		}
		else if(check==2){
			$('.re_question').text("삭제");
		}
		else {
			$('.re_question').text("거절");
		}
		
	}
	function closeLayer2(obj){
		var parId = $('#parId').val();
		var kid_code = $('#kid_code').val();
		
		var check = $(".re_question").text();
		
		var msgText ="";
		console.log("obj:"+obj);
		console.log("check:"+check);
		if(obj==1){		//승인 확인
			console.log("1");
			if(check=="삭제"){
				check=null;
				msgText = "<span>삭제 되었습니다.</span>";
			}else if(check=="승인"){
				msgText = "<span>승인 되었습니다.</span>";
			}else{
				msgText = "<span>거절 되었습니다.</span>";
			}
			$.ajax({
				type : "POST",
				url : "parent_checkStater",
				data : { "check_stater" : check,"par_id":parId,"kid_code":kid_code},
				beforeSend: function(xhr) {
		              xhr.setRequestHeader(header, token);
		           },
				success : function(data) {
// 					setInterval('autoRefresh_div()', 3000);
					$('#msgBox').addClass("msgBox_Success");
		    		$('#msgBox').html(msgText);
		    		document.getElementById('msgBox').style.display="block";
		    		
					$('#tabs-3').load('accountList #tabs-3_div');
				},
				error : function(xhr, txtStatus, errorThrown) {
					alert("error" + errorThrown);
				}
			});
		}
		document.getElementById('layerWindow_p').style.display='none';
	}
	
</script>
