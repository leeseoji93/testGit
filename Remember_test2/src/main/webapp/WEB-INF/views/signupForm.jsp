<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.Console"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<html>
<head>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/footer.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/includeStyle.css">

<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="js/jquery.validate.min.js"></script><!-- 유효성 검사 -->
<script type="text/javascript" src="js/additional-methods.min.js"></script><!-- 유효성 검사 -->

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<title>아티유자</title>
<link rel="shortcut icon" type="image/x-icon" href="images/favicon.ico" />
</head>
<body>

<div class="fullpage">
		<div class="page-wrapper">
			<div class="pageTitle"><h2>회원가입</h2></div>
			
			<div class="pageContent signupFormPage">
				<div class="loginLogo">
					<a href="home"><img src="images/header/image_logo_180x85(x2).png"> </a>
				</div>	
				<form:form action="signupForm_admin" method="get" id="AgreeForm" commandName="AgreeForm" name="AgreeForm"   onSubmit="return CheckForm(this)">	
					<div class="signUpAgreeBox marginbottom35">
						<span>이용약관 동의</span>
						<div class="signUpAgreeBox-Text">
							<jsp:include page="agreeTerms.jsp"/>
						</div>
						<div class="signUpAgreeBox-Check">
							<form:checkbox path="mAgreeTerms" label="회원가입약관에 동의합니다.(필수)" value="1" name="mAgreeTerms" id="mAgreeTerms" cssClass="agreeCheck"/>
							<label for="mAgreeTerms" class="validFail validSuccess"></label>
						</div>
					</div>
					
					<div class="signUpAgreeBox">
						<span>개인정보수집 및 이용동의</span>
						<div class="signUpAgreeBox-Text">
							<jsp:include page="agreePrivacy.jsp"/>
						</div>
						<div class="signUpAgreeBox-Check">
							<form:checkbox path="mAgreePrivacy" name="mAgreePrivacy" label="개인정보수집 및 이용동의에 동의합니다.(필수)"  id="mAgreePrivacy" value="1" cssClass="agreeCheck"/>
							<label for="mAgreePrivacy" class="validFail validSuccess"></label>
						</div>
					</div> 
					<div class="contentBottomBtn">
						<div class="btnLeftBox">
							<input type="button" value="" class="btn_back" id="cusInputBtn" onclick="history.back();" id="bottomBtn-Input" />
						</div>
						<div class="btnCnterBox">
							
						</div>
						<div class="btnRightBox">
							<input type="button" value="" id="cusInputBtn2" class="btn_next">
						</div>
					</div>
					                                						
				</form:form>
			</div>
		</div>
	</div>
<jsp:include page="include/footer.jsp"/>
<script>
	$(document).ready(function(){
        $("#cusInputBtn2").click(function(){    
            if($("#mAgreeTerms").is(":checked") == false){
                alert("모든 약관에 동의 하셔야 다음 단계로 진행 가능합니다.");
                return;
            }else if($("#mAgreePrivacy").is(":checked") == false){
                alert("모든 약관에 동의 하셔야 다음 단계로 진행 가능합니다..");
                return;
            }else{
//                 $("#AgreeForm").submit();
                document.getElementById('AgreeForm').submit();
                return false;
            }
        });    
    });
</script>
