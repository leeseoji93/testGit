<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="staffInfoBox" id="staffInfoBox">
	<c:set value="${staff_Info}" var="dto_k"/>
	<div class="myPageContent ">
		<div class="myPageContent_L">
			<img src="${dto_k[0].staff_phot}">
		</div>
		<div class="myPageContent_R staffInfoPage">
			<table>
				<tr>
					<th width="80" align="center">이   름</th>
					<td width="100">${dto_k[0].staff_name}</td>
					<th width="80" align="center">아이디</th>
					<td width="100">${dto_k[0].staff_id}</td>
				</tr>
				<tr>	
					<th>반</th>
					<td colspan="3">${dto_k[0].class_name}</td>
				</tr>
				<tr>	
					<th>직책</th>
					<td colspan="3">${dto_k[0].staff_position}</td>
				</tr>
				<tr>
					<th>연락처</th>
					<td colspan="3">${dto_k[0].staff_phone}</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td colspan="3">${dto_k[0].staff_email}</td>
				</tr>
				
			</table>
		</div>
	</div>
	
	<div class="pageBtn contentBottomBtn">						
		<div class="btnLeftBox">
			<input type="button" value="" class="btn_back" id="cusInputBtn" onclick="accountBack()" id="bottomBtn-Input"> <!-- 이전버튼 클릭 -->
		</div>
		<div class="btnLeftBox">
			<input type="submit" value="" class="btn_update" id="cusInputBtn"onclick=" updateForm('${dto_k[0].staff_id}')" />
		</div>
		<div class="btnCnterBox">				  				
<!--   			<input type="button" value="" class="btn_list" id="cusInputBtn" onclick="location.replace('CarInfoView')"/> -->
  			<input type="button" value="" id="cusInputBtn" class="customM" onclick="accountList()"/>	
  		</div> 
	</div>
</div>
<script>

var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

function accountBack() {
	$.ajax({
		url : 'tab_teachers',
        type:'POST',
		beforeSend: function(xhr) {
              xhr.setRequestHeader(header, token);
           },
		//data: { "CODE_LEVEL": totcnt },    //escape 한글 깨짐 방지 구문  
		success : function(data) {
				$("#tabs-1").html(data); //str로 받은 data를 넘긴다.  
			console.log("test");
		},
		error : function(xhr, txtStatus, errorThrown) {
			alert("error" + errorThrown);
		}
	});

}

function updateForm(obj) {
	console.log("obj:"+obj);
	$.ajax({
		url : 'tab_teachers_update',
        type:'POST',
        data : { "staff_id" : obj},
		beforeSend: function(xhr) {
              xhr.setRequestHeader(header, token);
           },
		//data: { "CODE_LEVEL": totcnt },    //escape 한글 깨짐 방지 구문  
		success : function(data) {
				$("#tabs-1").html(data); //str로 받은 data를 넘긴다.  
			console.log("test");
		},
		error : function(xhr, txtStatus, errorThrown) {
			alert("error" + errorThrown);
		}
	});

}


function accountList() {
	$.ajax({
		url : 'tab_teachers',
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

</body>
</html>