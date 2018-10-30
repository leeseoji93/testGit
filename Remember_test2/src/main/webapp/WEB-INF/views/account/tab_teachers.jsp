<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="teacherListTab" id="category">
<!-- 	<div class="AllUpdate"> -->
<!-- 		<input type="button" class="btn_update" id="" value="" onclick="updateFormAll()"> -->
<!-- 	</div> -->
	<div id="layerWindow_t" class="layerWindow">
		<span class="modalWindow"></span>
	
		<div id="loginLayer" class="loginLayer loginTypeA">
			<div class="layerPopContent">
				<p>삭제 하시겠습니까?</p>  
				<input id="staff_id" type="hidden" name="staff_id" />
				<input id="staff_name" type="hidden" name="staff_name" />
				<input type="button" class="btn_confirming_text" onclick="closeLayer_t(1)" >
				<input type="button" class="btn_close_text" onclick="closeLayer_t(0)" >
			</div>
		</div>
	</div>
	
	<div class="accoutTitleFix">
		<table>
			<tr>
				<th width="100px">아이디</th>
				<th width="100px">이름</th>
				<th width="100px">직책</th>
				<th width="150px">반</th>
				<th width="130px">연락처</th>
				<th width="160px">Email</th>
				<th width="80px"></th>
			</tr>
		</table>
	</div>
	<div class="accoutListContent" id="accoutListContent">
		<table>
		<c:choose>
			<c:when test="${fn:length(staffList) eq 0}">
				<tr><td align="center" width="860px">등록된 교사가 없습니다.</td></tr>
			</c:when>
			
			<c:otherwise>
				<c:forEach items="${staffList}" var="dto" varStatus="status">	
					<tr style="cursor:pointer;">
						<td width="100px" onclick="staffInfo('${dto.staff_id}')">${dto.staff_id}</td>
						<td width="100px" onclick="staffInfo('${dto.staff_id}')">${dto.staff_name}</td>
						<td width="100px" onclick="staffInfo('${dto.staff_id}')">${dto.staff_position}</td>
						<td width="150px" onclick="staffInfo('${dto.staff_id}')">${dto.class_name}</td>
						<td width="130px" onclick="staffInfo('${dto.staff_id}')">${dto.staff_phone}</td>
						<td width="170px" onclick="staffInfo('${dto.staff_id}')">${dto.staff_email}</td>
						<td width="80px">
			<%-- 				<input type="button" class="btn_update" id="" value="" onclick="updateForm('${dto.staff_id}')">  --%>
							<input type="button" class="btn_delete_40" id="" value="" onclick="deleteStaff('${dto.staff_id}','${dto.staff_name}')">
						</td>
					</tr>							   									
				</c:forEach>
			</c:otherwise>
		</c:choose>
		</table>
	</div>
	

<script>
$(document).ready(function(){
	
});
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	
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
//					setInterval('autoRefresh_div()', 3000);
	    		$("#tabs-1").html(data); //str로 받은 data를 넘긴다.  
// 				$('#tabs-1').load('staffInfo #tabs-3');
			},
			error : function(xhr, txtStatus, errorThrown) {
				alert("error" + errorThrown);
			}
		});
	}
	function deleteStaff(staff_id,staff_name){
		console.log("staff_id:"+staff_id);
		document.getElementById('msgBox').style.display="none";
		
		$('#layerWindow_t').css('display','block');
		$("#staff_id").val(staff_id);
		$("#staff_name").val(staff_name);
	}
	function closeLayer_t(obj){
		var staff_id = $("#staff_id").val();
		var staff_name = $("#staff_name").val();
		
		if(obj == 1){
			$.ajax({
				type : "POST",
				url : "tab_teacher_delete",
				data : { "staff_id" : staff_id,"staff_name":staff_name},
				contentType:"application/x-www-form-urlencoded; charset=UTF-8",
				beforeSend: function(xhr) {
		              xhr.setRequestHeader(header, token);
		           },
				//data: { "CODE_LEVEL": totcnt },    //escape 한글 깨짐 방지 구문  
				success : function(data) {
					var check = data.tab_teacher_delete;
					console.log("check : " + check);
					$('#msgBox').removeClass("msgBox_Error");
					$('#msgBox').removeClass("msgBox_Success");
					$('#msgBox').empty();
					if(check==1){
						console.log("1");
						$('#msgBox').addClass("msgBox_Success");	
			    		$('#msgBox').html("<span>삭제 되었습니다.</span>");
			    		document.getElementById('msgBox').style.display="block";
						$('#accoutListContent').load('accountList #accoutListContent');
					}
					else{
						console.log("2");
						$('#msgBox').addClass("msgBox_Error");	
			    		$('#msgBox').html("<span>이미 탈퇴된 회원입니다.</span>");
			    		document.getElementById('msgBox').style.display="block";
// 						$('#accoutListContent').load('accountList #accoutListContent');
					}								
				},
				error : function(xhr, txtStatus, errorThrown) {
					alert("error" + errorThrown);
				}
			});
			document.getElementById('layerWindow_t').style.display='none';
		}
		else{
			document.getElementById('layerWindow_t').style.display='none';
			return false;
		}
	}
	function updateFormAll() {
		$.ajax({
			url : 'accountUpdate',
            type:'POST',
			beforeSend: function(xhr) {
	              xhr.setRequestHeader(header, token);
	           },
			//data: { "CODE_LEVEL": totcnt },    //escape 한글 깨짐 방지 구문  
			success : function(data) {
					$("#tabs-1").html(data); //str로 받은 data를 넘긴다.  
			},
			error : function(xhr, txtStatus, errorThrown) {
				alert("error" + errorThrown);
			}
		});

	}
</script>

	
</div>
