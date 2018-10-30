<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/menu_admin.jsp">
	<jsp:param name="pageInMenu" value="마이페이지"  />
	<jsp:param name="pageCategory" value="비밀번호변경"  />
	<jsp:param name="pageTitle" value=""  /> 
</jsp:include>
<div class="page">
	<div class="page-wrapper">
		<div class="pageTitle"><h2>비밀번호변경</h2></div>
		
		<div class="mypageTab">
			<table>
				<tr>
					<td width="115"><a href="mypage" class="mypageTab_A">내정보</a></td>
					<td width="115"><a href="checkedPassWord" class="mypageTab_active mypasswordTab" >비밀번호 변경</a></td>
				</tr>
			</table>
		</div>

		<div class="pageContent" id="pageContent">
			<div class="msgBox" id="msgBox"></div>
			<div id="changePassword">
				<table>
					<tr>
						<th>비밀번호를 입력 해 주세요.</th>
					</tr>
					<tr>
						<td><input type="password" name="staff_pw" id="staff_pw" class="big_Input"> </td>
					</tr>
				</table>
				
			</div>
			<div class="pageBtn contentBottomBtn">						
				<div class="btnLeftBox">
				</div>
				<div class="btnCnterBox">
					<input type="button" value="" class="btn_next" id="cusInputBtn"onclick="goSubmit()" />
				</div>
				<div class="btnRightBox">			
<!-- 					<input type="button" value="" id="cusInputBtn" class="customM" onclick="accountList()"/>	  				 -->
		  		</div> 
			</div>
			
		</div>
	</div>
</div>
<script type="text/javascript">
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

function goSubmit(){
	
	var check = $("#staff_pw").val();
	
		console.log("check:"+check);
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
// 					document.getElementById('layerWindow').style.display='none';
					$.ajax({
						type : "POST",
						url : "checkPassword",
						data : { "staff_pw" : check},
						beforeSend: function(xhr) {
				              xhr.setRequestHeader(header, token);
				           },
						success : function(data) {
							console.log("test");
//								setInterval('autoRefresh_div()', 3000);
//		 					$('#msgBox').addClass("msgBox_Success");	
//		 		    		$('#msgBox').html("<span>상태가 변경 되었습니다.</span>");
//		 		    		document.getElementById('msgBox').style.display="block";
//		 		    		location.href="MypageUpdate";
							$('#pageContent').load('changePassWord');
						},
						error : function(xhr, txtStatus, errorThrown) {
							alert("error" + errorThrown);
						}
					});
				}
//					setInterval('autoRefresh_div()', 3000);
//					$('#msgBox').addClass("msgBox_Success");	
//		    		$('#msgBox').html("<span>상태가 변경 되었습니다.</span>");
//		    		document.getElementById('msgBox').style.display="block";
//		    		
//					$('#tabs-3').load('accountList #tabs-3');
			},
			error : function(xhr, txtStatus, errorThrown) {
				alert("error" + errorThrown);
			}
		});
		
			
// 	document.getElementById('layerWindow').style.display='none';
}
</script>
</body>
</html>