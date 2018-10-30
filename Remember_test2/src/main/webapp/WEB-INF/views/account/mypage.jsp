<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/menu_admin.jsp">
	<jsp:param name="pageInMenu" value="마이페이지"  />
	<jsp:param name="pageCategory" value="내정보"  />
	<jsp:param name="pageTitle" value=""  /> 
</jsp:include>
<div class="page">
	<div class="page-wrapper mypagePage">
		<div class="pageTitle"><h2>내 정보</h2></div>
		
		<div class="mypageTab">
			<table>
				<tr>
					<td><a href="mypage" class="mypageTab_active mypageTab_A">내정보</a></td>
					<td><a href="checkedPassWord" class="mypasswordTab">비밀번호 변경</a></td>
				</tr>
			</table>
		</div>
		
		<div id="layerWindow" class="layerWindow">
			<span class="modalWindow"></span>
		
			<div id="loginLayer" class="loginLayer loginTypeA">
				<div class="msgBox" id="msgBox"></div>
				<div class="layerPopContent">
					<span class="re_question">비밀번호 </span>
					<input id="staff_pw" type="password" name="staff_pw" class="big_Input" /> 
					<br>
					
<!-- 					<a onclick="closeLayer(0)" style="cursor: hand">취소</a>&nbsp; -->
				</div>
				<input type="button" onclick="closeLayer(1)" class="btn_confirming_text">
			</div>
		</div>



		<div class="pageContent">
		<c:set value="${staffInfo}" var="dto_c"/>
			<div class="myPageContent">
				<div class="myPageContent_L">
					<img src="${dto_c[0].staff_phot}">
				</div>
				<div class="myPageContent_R">
					<table>
						<tr>
							<th width="100">이   름</th>
							<td width="150">${dto_c[0].staff_name}</td>
							<th width="100">아이디</th>
							<td width="150">${dto_c[0].staff_id}</td>
						</tr>
						<tr>
							<th>직책</th>
							<td>${dto_c[0].staff_position}</td>
							<th>담당</th>
							<td>${dto_c[0].class_name}</td>
						</tr>
						<tr>
							<th>전화번호</th>
							<td colspan="3">${dto_c[0].staff_phone}</td>
						</tr>
						<tr>
							<th>이메일</th>
							<td colspan="3">${dto_c[0].staff_email}</td>
						</tr>
						
					</table>
				</div>
			</div>
			
			<div class="pageBtn contentBottomBtn">						
				<div class="btnLeftBox">
				</div>
				<div class="btnCnterBox">
					<input type="button" value="" class="btn_update" id="cusInputBtn"onclick="openLayer()" />
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
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

function openLayer(){
	$('#layerWindow').css('display','block');
}
function closeLayer(obj){
	
	var check = $("#staff_pw").val();
	
		console.log("check:"+check);
		if(obj==1){
			$.ajax({
				type : "POST",
				url : "checkPassword",
				data : { "staff_pw" : check},
				beforeSend: function(xhr) {
		              xhr.setRequestHeader(header, token);
		           },
				success : function(data) {			
					console.log("staff_pw:"+data.passwordCheck);
					
					if(data.passwordCheck==false){
						$('#msgBox').addClass("msgBox_Error");	
	 		    		$('#msgBox').html("<span>비밀번호가 틀립니다.</span>");
	 		    		document.getElementById('msgBox').style.display="block";
					}else{
						document.getElementById('layerWindow').style.display='none';
						location.href="MypageUpdate";
					}
//						setInterval('autoRefresh_div()', 3000);
// 					$('#msgBox').addClass("msgBox_Success");	
// 		    		$('#msgBox').html("<span>상태가 변경 되었습니다.</span>");
// 		    		document.getElementById('msgBox').style.display="block";
// 		    		
// 					$('#tabs-3').load('accountList #tabs-3');
				},
				error : function(xhr, txtStatus, errorThrown) {
					alert("error" + errorThrown);
				}
			});
		}
		
	
}
</script>
