<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

	<jsp:include page="../include/menu_admin.jsp">
		<jsp:param name="pageInMenu" value="시설관리"  />
		<jsp:param name="pageCategory" value="반관리"  />
		<jsp:param name="pageTitle" value="반등록"  /> 
	</jsp:include>
	
	<div class="page">
		<div class="page-wrapper">
			<div class="pageTitle"><h2>반 등록 </h2></div>
	
			<div class="pageContent700 addClassForm">
				<div class="categoryContent">
					<form action="addClass" method="post" id="addClass">
						<div class="msgBox" id="msgBox"></div>
						<div class="classInput textAlign-C addClassList">
							<table>
								<tr>
									<th>반 이름</th>
									<td><input type="text" class="long_input2" name="class_name" id="class_name"> 
										<p><label id="class_name-error" class="validFail validSuccess" for="class_name"></label></p>
									</td>
								</tr>
								<tr>
									<th>담임</th>
									<td> 
										<select class="long_select" id="staff_id_1" name="staff_id_1" onchange="staffId_Check1(this)">
											<option value="" label="담임 선택">담임 선택</option>
											<c:forEach items="${staffList}" var="dto" varStatus="s">	
									   			<option value="${dto.staff_id}">${dto.staff_name}</option>									   									
											</c:forEach>	
										</select>
									<p><label id="staff_id_1-error" class="validFail validSuccess" for="staff_id_1"></label></p>
									</td>
								</tr>
								<tr>
									<th>부 담임</th>
									<td> 
										<select class="long_select" id="staff_id_2" name="staff_id_2"> <!-- onchange="staffId_Check2(this)" -->
											<option value="" label="부담임 선택">부담임 선택</option>
											<c:forEach items="${staffList}" var="dto" varStatus="status">	
									   			<option value="${dto.staff_id}">${dto.staff_name}</option>											   									
											</c:forEach>	
										</select>
									<p><label id="staff_id_2-error" class="validFail validSuccess" for="staff_id_2"></label></p>
									</td>
								</tr>
								<tr>
									<th>연령</th>
									<td>
										<input type="radio" class="" name="class_year" id="class_year3" checked="checked" value="3"><label for="class_year3">3세</label>
										<input type="radio" class="" name="class_year" id="class_year4" value="4"><label for="class_year4">4세</label>
										<input type="radio" class="" name="class_year" id="class_year5" value="5"><label for="class_year5">5세</label>
										<input type="radio" class="" name="class_year" id="class_year6" value="6"><label for="class_year6">6세</label>
										<input type="radio" class="" name="class_year" id="class_year7" value="7"><label for="class_year7">7세</label> 
									</td>
								</tr>
								<tr>
									<th>학기</th>
									<td>
										<input type="radio" class="" name="class_sem" id="class_sem1" checked="checked" value="1학기"><label for="class_sem1">1학기</label>
										<input type="radio" class="" name="class_sem" id="class_sem2" value="2학기"><label for="class_sem2">2학기</label> 
									</td>
								</tr>
							</table>
							<input type="hidden" name="class_id" id="class_id" value="" />
							<input type="hidden" name="${_csrf.parameterName}" id="csrf" value="${_csrf.token}" />
							
							<div class="pageBtn contentBottomBtn">
								<div class="btnLeftBox">
									<input type="button" value="" class="btn_back" id="cusInputBtn" onclick="history.back();" id="bottomBtn-Input"> <!-- 이전버튼 클릭 -->
								</div>
								<div class="btnCnterBox">
									<input type="submit" value="" id="cusInputBtn" class="customD" />
<!-- 											  				onclick="goSubmit()" -->
						  		</div>
						  		<div class="btnRightBox">
	<!-- 					  			<input type="button" value="" id="cusInputBtn" class="customM" onclick="accountBack()"/>		 -->
						  		</div>
					  		</div>
						</div>
						
			  		</form>
				</div>
			</div>	
				
			<div class="pageContent300">
				<div class="addClassFormList" id="addClassFormList">
					<div class="categoryList_con listInAddClass">
						<h3>반 목록</h3>
						<table id="">
							<tr>
								<th width="88">반이름</th>
								<th>담임</th>
								<th>부담임</th>
								<th>학기</th>
							</tr>
							<c:forEach items="${allClassList}" var="dto" varStatus="s">	
					   			<tr>
					   				<td onclick="location.href='detailClassForm?class_id=${dto.class_id}'"><center>${dto.class_name}</center></td>
					   				<td onclick="location.href='detailClassForm?class_id=${dto.class_id}'">${dto.staff_name_1}</td>
					   				<td onclick="location.href='detailClassForm?class_id=${dto.class_id}'">${dto.staff_name_2}</td>
					   				<td onclick="location.href='detailClassForm?class_id=${dto.class_id}'">${dto.class_sem}</td>
					   			</tr>									   									
							</c:forEach>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../include/footer.jsp"/>
<script>
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

	$(document).ready(function(){	
		
	});
	
	function staffId_Check1(obj){
		console.log("담임 선택 완료");
		var staffId_1 = $("#staff_id_1 option:selected").val();
		console.log("staffId:"+staffId_1);
		
		<c:forEach items="${allClassList}" var="dto" varStatus="s">
// 			if(selectVal=="${dto.staff_name_1}"){
// 				console.log("똑같음...");
				
// 				$('#msgBox').addClass("msgBox_Error");	
// 	    		$('#msgBox').html("<span>이미 배정 되어있습니다.</span>");
// 	    		document.getElementById('msgBox').style.display="block";
	    		
// 				$("#staff_id_1 option:eq("+i+")").attr("disable",true);
// 			}
						
		</c:forEach>	
// 		if(staffId_1==staffId_2){
// 			$('#msgBox').addClass("msgBox_Error");	
//     		$('#msgBox').html("<span>담임과 부담임이 같습니다. 부담임을 다시 선택 해 주세요.</span>");
//     		document.getElementById('msgBox').style.display="block";
    		
//     		$('#staff_id_2').find('option:first').attr('selected', 'selected');
//     		$('#staff_id_2').focus();
// 		}
// 		else{
// 			document.getElementById('msgBox').style.display="none";
// 		}
		
	}	
	function staffId_Check2(obj){
		console.log("부담임 선택 완료");
		var staffId_1 = $("#staff_id_1 option:selected").val();
		var staffId_2 = $("#staff_id_2 option:selected").val();
		var staff_Chk_Name = $("#staff_id_2 option:selected").text();
		console.log("signOut_Chk:"+staff_Chk_Name.length);
		var signOut_Chk = staff_Chk_Name.substring(staff_Chk_Name.length - 4);
		console.log("signOut_Chk:"+signOut_Chk+"/staffId2:"+staffId_2);
		if(signOut_Ch=="(탈퇴)"){
			$('#msgBox').addClass("msgBox_Error");	
    		$('#msgBox').html("<span>담임과 부담임이 같습니다. 부담임을 다시 선택 해 주세요.</span>");
    		document.getElementById('msgBox').style.display="block";
		}
		if(staffId_1==staffId_2){
			$('#msgBox').addClass("msgBox_Error");	
    		$('#msgBox').html("<span>담임과 부담임이 같습니다. 부담임을 다시 선택 해 주세요.</span>");
    		document.getElementById('msgBox').style.display="block";
    		
    		$('#staff_id_2').find('option:first').attr('selected', 'selected');
    		$('#staff_id_2').focus();
		}
		else{
			document.getElementById('msgBox').style.display="none";
		}
		
	}	
	function goSubmit(){
		$.ajax({  
            url : 'classId_Check',
            dataType : 'json',
            type:'POST',
            beforeSend: function(xhr) {
	            xhr.setRequestHeader(header, token);
	        	},
            success: function(result) {	            	 	      
         	  console.log("success!!!");
         	   var size_data=result.class_count; 
         	   
//          		console.log(result.kid_code_count[0].maxcount);
        		for(var i=0; i < size_data.length; i ++){
        			$('#class_id').val("_C0_"+result.class_count[i].maxcount);	      	          			
        		}
        		
        		addClass.submit();
            },
            error:function(request,status,error){                 
         	   alert("code:"+request.status+"\n"+"error:"+error);
            }
            
        }); //ajax 버스 id 몇개 있는지 파악
        
		
	}
</script>	
<script>
	$(function() {				
		 $.validator.addMethod("regex", function(value, element, regexpr) {          
		     return regexpr.test(value);
		   });
		 
		 $.validator.addMethod("signOut", function(value, element) {     
			 var staff_Chk_Name = $("#staff_id_1 option:selected").text();
			 var signOut_Chk = staff_Chk_Name.substring(staff_Chk_Name.length - 4);
			 if(signOut_Chk=="(탈퇴)"){ return false; }
			 else{ return true; }
		   });
		 $.validator.addMethod("signOut2", function(value, element) {     
			 var staff_Chk_Name = $("#staff_id_2 option:selected").text();
			 var signOut_Chk = staff_Chk_Name.substring(staff_Chk_Name.length - 4);
			 if(signOut_Chk=="(탈퇴)"){return false; }
			 else{ return true; }
		   });

		 var token = $("meta[name='_csrf']").attr("content");
		 var header = $("meta[name='_csrf_header']").attr("content");
		    
		$("#addClass").validate({
			errorClass: "validFail",
			validClass: "validSuccess",
			ignore : "",
		    rules: {
		    	class_name : {
		    		required: true,
		    		remote: {
	    				url:  "checkName_class_name",
	    				type: "post",
	    				beforeSend: function(xhr) {
	    		            xhr.setRequestHeader(header, token);
	    		        },
	    				data: {
	    					formData: function() {
	    						return $("#class_name").val();
	    					}
	    				}
	    			},		
		    		regex: /^[\s|ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|\*]{2,8}$/			    		
		    	},
		    	staff_id_1: {
		    		required: true,
		    		remote: {
	    				url:  "checkName_staff",
// 	    				type: "post",
	    				beforeSend: function(xhr) {
	    		            xhr.setRequestHeader(header, token);
	    		        },
	    				data: {
	    					formData: function() {
	    						return $("#staff_id_1 option:selected").val();
	    					},class_sem: function() {
	    						return  $(':input[name="class_sem"]:radio:checked').val();
    						},
	    					chk : function() {
	    						return "1";
    						}
	    				}
	    			},
	    			signOut: true
		    	},
		    	staff_id_2: {
		    		required: true,
		    		notEqualTo: "#staff_id_1",
		    		remote: {
	    				url:  "checkName_staff",
// 	    				type: "post",
	    				beforeSend: function(xhr) {
	    		            xhr.setRequestHeader(header, token);
	    		        },
	    				data: {
	    					formData: function() {
	    						return $("#staff_id_2 option:selected").val();
	    					},class_sem: function() {
	    						return  $('input[name="class_sem"]:radio:checked').val();
    						},
	    					chk : function() {
	    						return "2";
    						}
	    				}
	    			},
	    			signOut2: true
		    	}
		    },			    

		    messages: {
		    	class_name: {
		            required: "반 이름을 입력 해 주세요.",
		            remote : "이미 사용되고 있습니다.",
		            regex : "2~8자 이내로 입력해주세요."
		        },
		        staff_id_1: {
		        	required : "담임을 선택 해 주세요.",
		        	remote: "다른반에 배정 되어있습니다."	,
		        	signOut : "탈퇴한 교사는 배정 할 수 없습니다."
		        },
		        staff_id_2: {
		        	required : "부담임을 선택 해 주세요.",
		        	remote: "다른반에 배정 되어있습니다."	,        
		        	notEqualTo: "담임과 같습니다. 다시 선택 해 주세요.",
		        	signOut2 : "탈퇴한 교사는 배정 할 수 없습니다."
		        }
		    },		    
		    success: function(label) {
//                   label.addClass("validSuccess").text("사용가능합니다.");
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
