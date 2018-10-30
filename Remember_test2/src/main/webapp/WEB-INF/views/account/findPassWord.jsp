<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<title>아티유자</title>
<link rel="shortcut icon" type="image/x-icon" href="images/favicon.ico" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/footer.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/includeStyle.css">
</head>
<body>
<div class="fullpage">
	<div class="page-wrapper">
		<div class="findAccount_Content">
			<div class="loginLogo">
				<a href="index"><img src="images/header/image_logo_180x85(x2).png"> </a>
			</div>
			<div class="findAccount" id="findAccount">
				<div class="findAccount_title">비밀번호 찾기</div>
				<form action="findPwForm" name="findPwForm" id="findPwForm">
					<table>
						<tr>
							<th>아이디</th>
							<td><input type="text" name="staff_id" id="staff_id" class="bigbig_Input"></td>
						</tr>
						<tr>
							<th>이름</th>
							<td><input type="text" name="staff_name" id="staff_name" class="bigbig_Input" maxlength="5"></td>
						</tr>
						<tr>
							<th>연락처</th>
							<td><input type="text" name="staff_phone" id="staff_phone" class="bigbig_Input" maxlength="11"></td>
						</tr>
					</table>
					<div class="pageBtn contentBottomBtn">						
						<div class="btnLeftBox">
						</div>
						<div class="btnCnterBox">
							<input type="button" value="" class="btn_send_text" id="cusInputBtn"onclick="goSubmit()" />
						</div>
						<div class="btnRightBox">			
						<!-- <input type="button" value="" id="cusInputBtn" class="customM" onclick="accountList()"/>	  				 -->
				  		</div> 
					</div>
				</form>
			</div>
		</div>
		
	</div>
</div>
<jsp:include page="../include/footer.jsp"/>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
function goSubmit(){
	var staff_id = $("#staff_id").val();
	var staff_name = $("#staff_name").val();
	var staff_phone =  $("#staff_phone").val();
// 	var staff_phone =  $("#staff_phone1").val()+$("#staff_phone2").val()+$("#staff_phone3").val();
	
	console.log("test");
	console.log("staff_name:"+staff_name+"//staff_phone"+staff_phone);
	
	$.ajax({  
        url : 'findPwForm',
        type:'POST',
        data : { "staff_id" : staff_id,"staff_name" : staff_name,"staff_phone" : staff_phone},
        beforeSend: function(xhr) {
            xhr.setRequestHeader(header, token);
        	},
        success: function(result) {	            	 	      
     		console.log("success!!!");
     		console.log("result:"+result.accountPw);
     		$("#findAccount").html(
     			"<div class='accountResult'><strong>비밀번호는</strong><span>"+result.accountPw+"</span>입니다.</div>"		
     		); //str로 받은 data를 넘긴다. 
        },
        error:function(request,status,error){                 
     	   alert("code:"+request.status+"\n"+"error:"+error);
        }
    });
}

</script>
