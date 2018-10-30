<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<div class="staffInfoBox" id="staffInfoBox">
	<c:set value="${kid_Info}" var="dto_k"/>
	
	<div class="kifInfoContent">
		<div class="kifInfoContent_L">
			<img src="${dto_k[0].kid_pho}" class="profile_photo">
		</div>
		<div class="kifInfoContent_R">
			<table>
				<tr>
					<th width="100">이름</th>
					<td width="160">${dto_k[0].kid_name}</td>
					<th width="100">성별</th>
					<td width="160">${dto_k[0].kid_sex}</td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td>${dto_k[0].kid_birthday}</td>
					<th>혈액형</th>
					<td>${dto_k[0].kid_blood}</td>
				</tr>
			</table>
<%-- 			<c:set var="length" value="${length}" /> --%>
			<c:set value="${kidsParent}" var="dto_p"/>
				 <c:set var="legth" value="${length}" />
 				 <% 
 					Object legth = pageContext.getAttribute("legth");
 				 	String legth_S = legth.toString();
 				 	
 				 	if(legth_S.equals("0")){
 				 %>
 				 	<table>
						<tr>
							<th width="100">보호자1</th>
							<td width="160">-</td>
							<td width="260" colspan="2">-</td>
						</tr>
						<tr>
							<th>보호자2</th>
		 					<td>-</td> 
		 					<td colspan="2">-</td> 
						</tr>
					</table>
 				 
 				 <%		
 				 	}else if(legth_S.equals("1")){
 				 %>
 				 	<table>
						<tr>
							<th width="100">보호자1</th>
							<td width="160">${dto_p[0].par_name}</td>
							<td width="260" colspan="2">${dto_p[0].par_phone}</td>
						</tr>
						<tr>
							<th>보호자2</th>
		 					<td>-</td> 
		 					<td colspan="2">-</td> 
						</tr>
					</table>
 				 
 				 <%		
 				 	}else{
 				 		
 				 %>
 				 	<table>
						<tr>
							<th width="100">보호자1</th>
							<td width="160">${dto_p[0].par_name}</td>
							<td width="260" colspan="2">${dto_p[0].par_phone}</td>
						</tr>
						<tr>
							<th>보호자2</th>
		 					<td>${dto_p[1].par_name}</td> 
		 					<td colspan="2">${dto_p[1].par_phone}</td> 
						</tr>
					</table>
 				 <%		
 				 	}
 				 %> 
 				 

		
		</div>
	</div>
	
	<div class="pageBtn contentBottomBtn">						
		<div class="btnLeftBox">
			<input type="button" value="" class="btn_back" id="cusInputBtn" onclick="accountBack()" id="bottomBtn-Input"> <!-- 이전버튼 클릭 -->
		</div>
		<div class="btnCnterBox">
			<input type="submit" value="" class="btn_update" id="cusInputBtn"onclick="updateForm('${dto_k[0].kid_system_code}')" />
		</div>
		<div class="btnRightBox">			
			<input type="button" value="" id="cusInputBtn" class="customM" onclick="accountList()"/>	  				
  		</div> 
	</div>
</div>
<script>

var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

function accountBack() {
	$.ajax({
		url : 'tab_kid',
        type:'POST',
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

function updateForm(obj) {
	console.log("updateForm obj:"+obj);
	$.ajax({
		url : 'tab_kid_update',
        type:'GET',
        data : { "kid_system_code" : obj},
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

function accountList() {
	$.ajax({
		url : 'tab_kid',
        type:'POST',
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
</script>

</body>
</html>