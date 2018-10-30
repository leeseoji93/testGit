<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<jsp:include page="../include/menu_admin.jsp">
		<jsp:param name="pageInMenu" value="시설관리"  />
		<jsp:param name="pageCategory" value="반관리"  />
		<jsp:param name="pageTitle" value="반수정"  /> 
	</jsp:include>
	
	<div class="page">
		<div class="page-wrapper">
			<div class="pageTitle"><h2>반 수정 </h2></div>
	
			<div class="pageContent700">
				<form action="saveupdateClassForm" method="post" id="updateClassForm">
					<div class="msgBox" id="msgBox"></div>
					<c:forEach items="${detailClass}" var="dto_c" varStatus="s">
					<div class="categoryContent " id="updateClassFormContent">
						<div class="updateClassFormContent">
							<table>
								<tr>
									<th width="100">반 이름</th>
									<td width="150"><input type="text" class="big_input" name="class_name" id="class_name" value="${dto_c.class_name}"> </td>
								</tr>
								<tr>
									<th>담임</th>
									<td> 
										<select class="big_select" id="staff_id_1" name="staff_id_1">
											<option value="" label="담임 선택">담임 선택</option>
											<c:forEach items="${staffList}" var="dto" varStatus="s">	
									   			<option value="${dto.staff_id}">${dto.staff_name}</option>										   									
											</c:forEach>	
										</select>
									</td>
								</tr>
								<tr>
									<th>부 담임</th>
									<td> 
										<select class="big_select" id="staff_id_2" name="staff_id_2" onchange="staffId_Check(this)">
											<option value="" label="부담임 선택">부담임 선택</option>
											<c:forEach items="${staffList}" var="dto" varStatus="status">	
									   			<option value="${dto.staff_id}">${dto.staff_name}</option>											   									
											</c:forEach>	
										</select>
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
						</div>
						<input type="hidden" name="class_id" id="class_id" value="${dto_c.class_id}" />
						<input type="hidden" name="${_csrf.parameterName}" id="csrf" value="${_csrf.token}" />
					</div>
					</c:forEach>	
					<div class="pageBtn contentBottomBtn">
						<div class="btnLeftBox">
							<input type="button" value="" class="btn_back" id="cusInputBtn" onclick="history.back();" id="bottomBtn-Input"> <!-- 이전버튼 클릭 -->
						</div>
						<div class="btnCnterBox">
							<input type="submit" value="" id="cusInputBtn" class="btn_update"/>
				  		</div>
				  		<div class="btnRightBox">
				  			<input type="button" value="" id="cusInputBtn" class="customM" onclick="location.href='ClassList'"/>		
				  		</div>
			  		</div>
		  		</form>	
			</div>	
				
			<div class="pageContent300">			
				<div class=" UpdateClassFormList">
					<h3>반 목록</h3>
					<table>
						<tr>
							<th width="90">반이름</th>
							<th width="52">담임</th>
							<th width="52">부담임</th>
							<th width="52">학기</th>
						</tr>
					<c:forEach var="dto_k" items="${allClassList}" varStatus="s">
						<tr>
							<td onclick="location.href='detailClassForm?class_id=${dto_k.class_id}'">${dto_k.class_name}</td>
			   				<td onclick="location.href='detailClassForm?class_id=${dto_k.class_id}'">${dto_k.staff_name_1}</td>
			   				<td onclick="location.href='detailClassForm?class_id=${dto_k.class_id}'">${dto_k.staff_name_2}</td>
			   				<td onclick="location.href='detailClassForm?class_id=${dto_k.class_id}'">${dto_k.class_sem}</td>
						</tr>
					</c:forEach>
					</table>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../include/footer.jsp"/>
<script>
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

	
	$(document).ready(function(){	
		<c:forEach items="${detailClass}" var="dto_c" varStatus="s">
		$("#staff_id_1").val("${dto_c.staff_id_1}").prop("selected", true);
		$("#staff_id_2").val("${dto_c.staff_id_2}").prop("selected", true);
		</c:forEach>
	});	
	
// 	function staffId_Check(obj){
// 		console.log("부담임 선택 완료");
// 		var staffId_1 = $("#staff_id_1 option:selected").val();
// 		var staffId_2 = $("#staff_id_2 option:selected").val();
// 		console.log("staffId:"+staffId_1+"/staffId2:"+staffId_2);
		
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
		
// 	}
</script>
<script>
	$(function() {				
		 $.validator.addMethod("regex", function(value, element, regexpr) {          
		     return regexpr.test(value);
		   });	 
		 var token = $("meta[name='_csrf']").attr("content");
		 var header = $("meta[name='_csrf_header']").attr("content");
		    
		 console.log($('input[name="class_sem"]:radio:checked').val());
		$("#updateClassForm").validate({
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
	    					},baseData: function() {
	    						return "${detailClass[0].class_name}";
    						}
	    				}
	    			},		
		    		regex: /^[\s|ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|\*]{2,8}$/			    		
		    	},
		    	staff_id_1: {
		    		required: true,
		    		remote: {
	    				url:  "checkName_staff",
	    				type: "post",
	    				beforeSend: function(xhr) {
	    		            xhr.setRequestHeader(header, token);
	    		        },
	    				data: {
	    					formData: function() {
	    						return $("#staff_id_1 option:selected").val();
	    					},baseData: function() {
	    						return "${detailClass[0].staff_id_1}";
    						},class_sem: function() {
	    						return  $(':input[name="class_sem"]:radio:checked').val();
    						},
	    					chk : function() {
	    						return "1";
    						}
	    				}
	    			}
		    	},
		    	staff_id_2: {
		    		required: true,
		    		notEqualTo: "#staff_id_1",
		    		remote: {
	    				url:  "checkName_staff",
	    				type: "post",
	    				beforeSend: function(xhr) {
	    		            xhr.setRequestHeader(header, token);
	    		        },
	    				data: {
	    					formData: function() {
	    						return $("#staff_id_2 option:selected").val();
	    					},baseData: function() {
	    						return "${detailClass[0].staff_id_2}";
    						},class_sem: function() {
	    						return  $('input[name="class_sem"]:radio:checked').val();
    						},
	    					chk : function() {
	    						return "2";
    						}
	    				}
	    			}
		    	}
		    },			    

		    messages: {
		    	class_name: {
		            required: "반 이름을 입력 해 주세요.",
		            remote : "이미 사용 중 입니다.",
		            regex : "2자 이상 입력 해 주세요."
		        },
		        staff_id_1: {
		        	required : "담임을 선택 해 주세요.",
		        	remote: "다른반에 배정 되어있습니다."	        
		        },
		        staff_id_2: {
		        	required : "부담임을 선택 해 주세요.",
		        	remote: "다른반에 배정 되어있습니다."	,        
		        	notEqualTo: "담임과 같습니다. 다시 선택 해 주세요."	        
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
