<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="" id="category">
<form action="UpdateAllStaff" method="POST" name="UpdateAllStaff" id="UpdateAllStaff">
	<div class="accountUpdateContent">
		<div class="accountUpdateContent_title">
			<table>
				<tr>
					<th width="180px">아이디</th>
					<th width="180px">이름</th>
					<th width="180px">연락처</th>
					<th width="180px">직책</th>
					<th width="240px">Email</th>
				</tr>
			</table>	
		</div>
		<div class="accountUpdateContent_con">
			<table>	
				<c:forEach items="${staffAccount}" var="dto" varStatus="s">
				<tr>
					<td><input type=text name='staff_id' id='staff_id' value="${dto.staff_id}" class="smallInput" readonly="readonly"></td>
					<td><input type=text name='staff_name' id='staff_name' value="${dto.staff_name}" class="smallInput"></td>
					<td><input type=text name='staff_phone' id='staff_phone' value="${dto.staff_phone}" class="smallInput"></td>
					<td>
						<select class='middle_select' id='staff_position${s.count}' name='staff_position' onchange="posiChange(this,'${s.count}')">
							<option value='' selected='selected'>선택 해 주세요.</option>
							<option value='원감'>원감</option>
							<option value='차량기사'>차량기사</option>
							<option value='보육교사'>보육교사</option>
							<option value='행정실장'>행정실장</option>
						</select>
					</td>
					<td>
						<input type="text" id="staff_email" name="staff_email" value="${dto.staff_email }" class="middle_input">
						<input type="hidden" id="role${s.count}" name="role" value="${dto.role }">
						<input type="hidden" id="staff_type${s.count}" name="staff_type" value="${dto.staff_type }">
					</td>
				</tr>
				</c:forEach>
			</table>
		</div>
	</div>
	
	
	<input type="hidden" name="${_csrf.parameterName}" id="csrf" value="${_csrf.token}" />
	<div class="pageBtn contentBottomBtn">						
		<div class="btnLeftBox">
			<input type="button" value="" class="btn_back" id="cusInputBtn1" onclick="accountBack()" id="bottomBtn-Input"> <!-- 이전버튼 클릭 -->
		</div>
		<div class="btnLeftBox">
			<input type="submit" value="" class="btn_update" id="cusInputBtn2" onclick="goSubmit()"/>
		</div>
		<div class="btnCnterBox">				  				
  			<input type="button" value="" class="btn_list" id="cusInputBtn3" onclick="location.replace('CarInfoView')"/>	
  		</div> 
	</div>
	
</form>
</div>	

	
<script type="text/javascript">
	$(document).ready(function(){
		
		<c:forEach items="${staffAccount}" var="dto" varStatus="s">
			var st_type='${dto.staff_type}';
			
			var st_position ='${dto.staff_position}';		//구분 선택하기
			$("#staff_position${s.count}").val(st_position).attr("selected", "selected");
			
		</c:forEach>
		
// 		$("#staff_type").val(st_position).attr("selected", "selected");
		
		var st_position ='${dto.staff_position}';		//구분 선택하기
		$("#staff_position").val(st_position).attr("selected", "selected");

		var st_className = '${dto.class_name}';			//반 선택하기
		$("#class_name").val(st_className).attr("selected", "selected");
	});
	
	function goSubmit(){
		kidsUpdateForm.submit();
	}
	
	function posiChange(obj,index) {// 직책에 따른 권한
		
		$("#role").empty();
		var selectId = "#staff_position"+index; 
		var value = $(selectId+" option:selected").val();
		var rowIndex = obj.parentElement.parentElement.rowIndex;
		var staffPosition = value;
		var parentId =document.getElementById(obj.getAttribute('id')).getAttribute('id');	//부모 ID값
		
		if(value=="차량기사"){
			document.getElementById("staff_type"+index).value=value;		//staff_type 값 입력	
		}
		else{
			document.getElementById("staff_type"+index).value="보육교사";		//staff_type 값 입력	
		}
		
		
		if(parentId=="staff_position2"){
			if(staffPosition=="원감"){
				document.getElementById("role"+index).value="ROLE_SEMI_ADMIN";
			}
			else if(staffPosition=="보육교사"){
				document.getElementById("role"+index).value="ROLE_MEMBER";
			}
			else{
				document.getElementById("role"+index).value="ROLE_USER";
			}
		}
		else{
			if(staffPosition=="원감"){
				document.getElementById("role"+index).value="ROLE_SEMI_ADMIN";
			}
			else if(staffPosition=="보육교사"){
				document.getElementById("role"+index).value="ROLE_MEMBER";
			}
			else{
				document.getElementById("role"+index).value="ROLE_USER";
			}
		}
		
	}
	
</script>


