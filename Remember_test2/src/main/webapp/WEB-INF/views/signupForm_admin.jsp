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
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=976c390ffb0cfa7e527d182e55644f4f&libraries=services"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<title>아티유자</title>
<link rel="shortcut icon" type="image/x-icon" href="images/favicon.ico" />
</head>
<body>

<div class="fullpage">
	<div class="page-wrapper ">
		<div class="signupForm_admin_Content">
			<div class="loginLogo">
				<a href="index"><img src="images/header/image_logo_180x85(x2).png">  </a>
			</div>
				<form action="insert_admin" method="post" id="adminForm">	
			                                                   		
					<input type="hidden" id="staffType" name="staffType" value="원장">
					<div class="addCenterBoxTitle">회원 정보</div>
					<div class="cusSignupTable">
					
						<table>
							<tr>
								<th>아이디</th>
								<td><input type="text" id="staff_id" name="staff_id" class="big_input280" >
									<small>영문 + 숫자 포함 해서 6~13 자 이내로 입력 해 주세요.</small>
								</td>						
							</tr>
							<tr>
								<th>이름</th>
								<td><input type="text" id="staff_name" name="staff_name" class="big_input280">
								</td>
							</tr>
							<tr>
								<th>비밀번호</th>
								<td><input type="password" id="staff_pw" name="staff_pw" class="big_input280">
								<small>영문 + 숫자 포함 해서 6~13 자 이내로 입력 해 주세요.</small></td>
							</tr>
							<tr>
								<th>비밀번호 확인</th>
								<td><input type="password" id="staff_pwCon" name="staff_pwCon" class="big_input280"></td>
							</tr>
							<tr>
								<th>핸드폰</th>
								<td><input type="text" id="staff_phone" name="staff_phone" class="big_input280" placeholder="ex) 01012345678">
								</td>
							</tr>
							<tr>
								<th>Email</th>
								<td><input type="text" id="staff_email" name="staff_email" class="big_input280"></td>
							</tr>
						</table>
								<input type="hidden" id="staff_position" name="staff_position" class="big_input280" value="원장">
								<input type="hidden" id="staff_type" name="staff_type" class="big_input280" value="원장">
					</div> 		
					
					<div class="addCenterBoxTitle">원 정보</div>
					<div class="addCenterBox cusSignupTable">
<!-- 						<div class="cautionText">*는 필수 사항입니다.</div> -->
						
						<table>
							<tr>
								<th>기관명*</th>
								<td><input type="text" id="center_name" name="center_name" class="big_input280"></td>						
							</tr>
							<tr>
								<th>대표자*</th>
								<td><input type="text" id="center_repn" name="center_repn" class="big_input280"></td>
							</tr>
							<tr>
								<th>원장*</th>
								<td><input type="text" id="center_dirn" name="center_dirn" class="big_input280"></td>						
							</tr>
							<tr>
								<th>원 전화번호*</th>
								<td><input type="text" id="center_phon" name="center_phon" class="big_input280" placeholder="ex) 0511234567"></td>
							</tr>
							<tr>
								<th>사업자등록번호*</th>
								<td><input type="text" id="center_num" name="center_num" class="big_input280" placeholder="ex) 123-45-67890"></td>
							</tr>
							<tr>
								<th>원 주소*</th>
								<td>
									<select class="middle_select" id="center_addr_si" name="center_addr_si" onchange="guChange(this)">
										<option value="" label="시 선택">시 선택
<!-- 										<option value="">직업선택</option> -->
<!-- 									    <option value="학생">학생</option> -->
<!-- 									    <option value="회사원" selected="selected">회사원</option> -->
<!-- 									    <option value="기타">기타</option> -->
										<c:forEach items="${area_cityName}" var="dto" varStatus="status">	
								   			<option value="${dto.city_code}" label="${dto.city_name}">${dto.city_name}</option>										   									
										</c:forEach>	
									</select>
									
									<select class="middle_select" id="center_addr_gu" name="center_addr_gu" onchange="dongChange(this)">
										<option value="" label="동 선택"></option>	
									</select>

									<select class="middle_select" id="center_addr_dong" name="center_addr_dong" onchange="selectCode(this)">
										<option value="" label="동 선택"></option>	
									</select>
								</td>
							</tr>
							<tr>
								<th></th>
								<td>		
									<input type="text" id="center_addr_rem" name="center_addr_rem" class="big_input280" placeholder="상세주소를 입력 해 주세요.">
								</td>
							</tr>
							<tr>
								<th>설립유형*</th>
								<td>
									<input type="radio" value="어린이집" name="center_type" id="center_type1" checked="checked"><label for="center_type">어린이집</label>
									<input type="radio" value="유치원" name="center_type" id="center_type2"><label for="center_type">유치원</label>
								</td>
							</tr>
						</table>
					</div>
					<input type="hidden" id="role" name="role" class="big_input280" value="ROLE_ADMIN">
					<input type="hidden" id="center_addr" name="center_addr" class="big_input280">
					<input type="hidden" id="latitude" name="latitude" class="big_input280">
					<input type="hidden" id="longitude" name="longitude" class="big_input280">
					<input type="hidden" id="admin_area" name="admin_area" class="big_input280">
					<input type="hidden" id="center_code" name="center_code" class="big_input280">
					<input type="hidden" name="${_csrf.parameterName}" id="csrf" value="${_csrf.token}" />
				</form>
				
					<div class="pageBtn contentBottomBtn">
						<div class="btnLeftBox">
							<input type="button" value="" class="btn_back" id="cusInputBtn" onclick="history.back();" id="bottomBtn-Input" />
						</div>
						<div class="btnCnterBox">
							<input type="button" value="" id="cusInputBtn" class="btn_add" onClick='goSubmit();'>
						</div>
						<div class="btnRightBox">
						</div>
					</div>
			</div>
		</div>
	</div>
	<jsp:include page="include/footer.jsp"/>
<script>
function goSubmit(){
	var addr_si = $("#center_addr_si option:selected").text();
	var addr_gu = $("#center_addr_gu option:selected").text();
	var addr_dong = $("#center_addr_dong option:selected").text();
	var addr_rem = $("#center_addr_rem").val();
	var center_addr =$.trim(addr_si)+" "+addr_gu+" "+addr_dong+" "+addr_rem;
	var latitude="";
	var longitude="";
	 
	console.log("center_addr :"+center_addr);
	// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new daum.maps.services.Geocoder();

		// 주소로 좌표를 검색합니다
		geocoder.addressSearch(center_addr, function(result, status) {
			console.log("addr_si :"+addr_si+"/addr_gu:"+addr_gu+"/addr_dong"+addr_dong+"/addr_rem:"+addr_rem);
		    // 정상적으로 검색이 완료됐으면 
		     if (status === daum.maps.services.Status.OK) {
		    	 console.log("status :");
				latitude =result[0].y;
				longitude=result[0].x;
//	 			document.getElementById("latitude").value=result[0].y;
//	 			document.getElementById("longitude").value=result[0].x;
				document.getElementById("latitude").value=latitude;
				document.getElementById("longitude").value=longitude;
				document.getElementById("center_addr").value=center_addr;
				
				  adminForm.submit();
		    } 
		});   
}
</script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="js/jquery.validate.min.js"></script><!-- 유효성 검사 -->
<script type="text/javascript" src="js/additional-methods.min.js"></script><!-- 유효성 검사 -->	
<script type="text/javascript">
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

function guChange(obj) {// 대분류 변한 경우
	$("#center_addr_gu").empty();
	
	$.ajax({  
        url : 'guSelect',
        dataType : 'json',
        type:'POST',
        data : { "cityCode" : obj.value },  
        beforeSend: function(xhr) {
            xhr.setRequestHeader(header, token);},
        success: function(result) {	            	 	      
     		console.log("cityCode Success");
     		var size_data=result.data;  
     		
     		$("#center_addr_gu").append("<option value=''>구를 선택 해 주세요.</option>");
     		
	 		for(var i=0; i < size_data.length; i ++){
	 			console.log(result.data[i].district_code);	    
	 			console.log(result.data[i].district_name);
	 			$("#center_addr_gu").append("<option value="+result.data[i].district_code+">"+result.data[i].district_name+"</option>");
	 		}
        },
        error:function(request,status,error){                 
     	   alert("code:"+request.status+"\n"+"error:"+error);
        }	               
    });//변경된 셀렉박스에 따른 번호		
}//guChange
function dongChange(obj){
$("#center_addr_dong").empty();
	
	$.ajax({  
        url : 'dongSelect',
        dataType : 'json',
        type:'POST',
        data : { "districtCode" : obj.value },  
        beforeSend: function(xhr) {
            xhr.setRequestHeader(header, token);},
        success: function(result) {	            	 	      
     		console.log("cityCode Success");
     		var size_data=result.data;  
     		
     		$("#center_addr_dong").append("<option value=''>구를 선택 해 주세요.</option>");
     		
	 		for(var i=0; i < size_data.length; i ++){
	 			console.log(result.data[i].township_code);	    
	 			console.log(result.data[i].township_name);
	 			$("#center_addr_dong").append("<option value="+result.data[i].township_code+">"+result.data[i].township_name+"</option>");
	 		}
        },
        error:function(request,status,error){                 
     	   alert("code:"+request.status+"\n"+"error:"+error);
        }	               
    });//변경된 셀렉박스에 따른 번호	
}
function selectCode(obj){
	$("#center_code").empty();
	$('#center_addr').empty();
	var now_CenterCode;
	
	$.ajax({  
        url : 'selectCode',
        dataType : 'json',
        type:'POST',
        data : { "adminArea" : obj.value },  
        beforeSend: function(xhr) {
            xhr.setRequestHeader(header, token);},
        success: function(result) {	            	 	      
     		console.log("selectCode Success");
     		var size_data=result.data;  
     		
     		var target_si = document.getElementById("center_addr_si");
     		target_si= target_si.options[target_si.selectedIndex].text;
     		var target_gu = document.getElementById("center_addr_gu");
     		target_gu = target_gu.options[target_gu.selectedIndex].text;
     		var target_dong = document.getElementById("center_addr_dong");
     		target_dong = target_dong.options[target_dong.selectedIndex].text;
     		
     		$('#center_addr').val(target_si+" "+target_gu+" "+target_dong);
     		
     		$('#admin_area').val(obj.value);
     		
     		if(size_data==""){
     			$("#center_code").val(obj.value+"_01");
     		}
     		else{
     			now_CenterCode = parseInt(result.data[0].center_code);	//string->int
     			now_CenterCode+=1;
     			
     			if(now_CenterCode<10){					//10미만 0 붙이기 
     				now_CenterCode+="";					//int -> String 
     				now_CenterCode= "0"+now_CenterCode;
     			}
     			else{
     				now_CenterCode+="";
     			}
     			$("#center_code").val(obj.value+"_"+now_CenterCode);
     		}
        },
        error:function(request,status,error){                 
     	   alert("code:"+request.status+"\n"+"error:"+error);
        }	               
    });//변경된 셀렉박스에 따른 번호	
}
</script>
<script>
	$(function() {			
		 $.validator.addMethod("regex", function(value, element, regexpr) {          
		     return regexpr.test(value);
		   });			 
		 
		$("#adminForm").validate({
			errorClass: "validFail",
			validClass: "validSuccess",
			
		    rules: {
		    	staff_id : {
		    		required: true,
		    		regex: /^[a-zA-Z0-9]{6,13}$/			    		
		    	},
		    	staff_pw: {
		    		required: true,	
		    		regex: /^[a-zA-Z0-9]{6,13}$/
		    	},
		    	staff_pwCon: {
		    		required:true, 
		    		equalTo:'#staff_pw'
		    		}, 
		    	staff_name: {
		    		required: true,
		    		regex: /^[ㄱ-ㅎ가-힣]{2,5}$/
		    	},
		    	staff_phone: {
		    		required: true,
		    		regex: /[0-9]{10,11}/ 
		    	},
		    	staff_email:	{
		    		required: true,
		    		regex : /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/
		    	},center_name : {
		    		required: true,
		    		regex: /^[\s|ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|\*]{2,10}$/			    		
		    	},center_repn : {
		    		required: true,
		    		regex: /^[ㄱ-ㅎ가-힣]{2,5}$/		    		
		    	},center_dirn : {
		    		required: true,
		    		regex: /^[ㄱ-ㅎ가-힣]{2,5}$/			    		
		    	},center_num : {
		    		required: true,
		    		regex: /^\d{3}-\d{2}-\d{5}$/;		
		    	},center_phon : {
		    		required: true,
		    		regex: /[0-9]{10,11}/			    		
		    	},center_addr_rem : {
		    		required: true,
		    		regex: /([\w-\.]+){2,20}$/			    		
		    	},center_type : {
		    		required: true		    		
		    	}
		    },	    
		    messages: {
		    	staff_id: {
		            required: "입력해주세요",		            
		            regex : "정규식이 틀립니다."			    		
		        },
		        staff_pw: {
		        	 required: "입력해주세요",		            
			         regex : "정규식이 틀립니다."			    		
		        },
		        staff_pwCon: {
                    required: "암호확인를 입력하시오.",
                    equalTo:"암호를 다시 확인하세요" 
                },
		        staff_name: {
		        	 required: "입력해주세요",		            
			         regex : "정규식이 틀립니다."	
		        },
		        staff_phone: {
		        	required: "입력해주세요",		            
		            regex : "정규식이 틀립니다."
		        },
		        staff_email: {
		        	required: "입력해주세요",		            
		        	regex : "정규식이 틀립니다."
		        },center_name : {
		        	required: "입력해주세요",		            
		        	regex : "정규식이 틀립니다."			    		
		    	},center_repn : {
		    		required: "입력해주세요",		            
		        	regex : "정규식이 틀립니다."		    		
		    	},center_dirn : {
		    		required: "입력해주세요",		            
		        	regex : "정규식이 틀립니다."		    		
		    	},center_num : {
		    		required: "입력해주세요",		            
		        	regex : "정규식이 틀립니다."
		    	},center_phon : {
		    		required: "입력해주세요",		            
		        	regex : "정규식이 틀립니다."		    		
		    	},center_addr_rem : {
		    		required: "입력해주세요",		            
		        	regex : "정규식이 틀립니다."			    		
		    	},center_type : {
		    		required: "입력해주세요"	    		
		    	}
		    },
		    submitHandler: function (frm){	
		    	var dataString = $(this.currentForm).serialize();
	            alert(dataString);
                frm.submit();   //유효성 검사를 통과시 전송
            },
		    success: function(label) {
//                    label.addClass("validSuccess").text("사용가능합니다.");
		    },
		    invalidHandler: function(form, validator){ //입력값이 잘못된 상태에서 submit 할때 호출
				var errors = validator.numberOfInvalids();
				if (errors) {						
					validator.errorList[0].element.focus();
				} 
			}
		});	
	});
	</script>
