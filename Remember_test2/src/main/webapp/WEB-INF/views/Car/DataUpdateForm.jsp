<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<style>
label {
	position: absolute;
}
.validFail{
	font-size: 13px;
}
.errorRadiobtn td label{
 	position: relative;
}
.errorUsechecktd td label{
 	position: relative;
}
.ui-datepicker-trigger {
	 position:absolute;
	 width: 27px;
	 height: 27px;	 
}
.msgboxDiv{
    width: 450px;
    margin: 0 auto;
}
</style>

	<jsp:include page="../include/menu_admin.jsp">
		<jsp:param name="pageInMenu" value="차량운행정보"  />
		<jsp:param name="pageCategory" value="차량 관리"  />
		<jsp:param name="pageTitle" value="차량 정보 수정"  /> 
	</jsp:include>
	<div class="page">
		<div class="page-wrapper">
			<div class="pageTitle">
				<h2>차량 정보 수정</h2>								
			</div>
			
			<div class="pageContent DataUpdateForm">
				<div class="cusInsertTable1">	
				<div class="msgboxDiv"><div class="msgBox" id="msgBox"></div></div>
					<div class="cautionText">*는 필수 사항입니다.</div>
					<form:form action="DataUpdate" method="post" id="CarDataForm" commandName="car"  onkeydown="if(event.keyCode==13){event.returnValue=false;}">      
						<table>				
							<c:set value="${baseCar}" var="dto"/>							
								<tr>
									<th>차량명*</th>
									<td colspan="4">
										<form:input class="big_input" path="bus_name" id="bus_name"  name="bus_name" value="${dto[0].bus_name }" />										
									</td>
								</tr>
								
								<tr>
									<th>차량번호*</th>
									<td colspan="4">
										<form:input class="big_input" path="bus_num" id="bus_num"  name="bus_num" value="${dto[0].bus_num }" placeholder="예)12바1234"/>
					   					
									</td>
								</tr>
								<tr class="errorRadiobtn">
									<th>탑승인원*</th>
									<td style="text-align:left;">
										<form:radiobutton class="" id="bus_borad_15" value="15" label="15명" name="bus_borad" path="bus_borad"/>							
									</td>
									<td style="text-align:left;">
										<form:radiobutton  id="bus_borad_25" value="25" label="25명" name="bus_borad" path="bus_borad"/> 
									</td>
									<td style="text-align:left;">
										<form:radiobutton  id="bus_borad_35" value="35" label="35명" name="bus_borad" path="bus_borad"/>
									</td>
									<td style="text-align:left;">	
										<form:radiobutton  id="bus_borad_44" value="44" label="44명" name="bus_borad" path="bus_borad"/>
									</td>																
								</tr>
								<tr>
									<th>차량기사*</th>
									<td colspan="4">									
										<form:select class="big_select_busForm" path="staff_id" onchange="input_phoneNum(this)" id="staff_id" name="staff_id">
							   				<form:option value="" label="기사선택" />
							   				<c:forEach items="${driver}" var="ddto">   					
					   							<form:option value="${ddto.staff_id}" label="${ddto.staff_name}" />
					   						</c:forEach>
					   					</form:select> 					   					
									</td>
								</tr>		
								<tr>
									<th>연락처*</th>
									<td colspan="4">
										<input class="big_input readonly" type="text" id="phoneNum" readonly="readonly">	   						
									</td>
								</tr>
								<tr>
									<th>게이트웨이/태블릿</th>
									<td colspan="4">
										<form:select class="big_select_busForm" path="equipment_gate_id" id="equipment_gate_id" name="equipment_gate_id">
								   			<form:option value="" label="기기선택"/>
						     				
										</form:select><br> 																
									</td>
								</tr>
								<tr>
									<th>태블릿</th>
									<td colspan="4">
										<form:select class="big_select_busForm" path="equipment_tablet_id" id="equipment_tablet_id" name="equipment_tablet_id">
									   		<form:option value="" label="기기선택"/>								     				
										</form:select><br> 												
									</td>
								</tr>
								<tr>
									<th>운행사</th>
									<td colspan="4">
										<form:input class="big_input" path="bus_com" value="${dto[0].bus_com}"/>											  						 							
									</td>
								</tr>								
								<tr class="errorDatePicker">
									<th>종합보험 유효기간</th> 
									<td colspan="4">
										<input type="text" name="bus_insur" id="bus_insur" class="big_input" readonly="readonly">														
									</td>
								</tr>
								<tr class="errorUsecheck">
									<th>사용여부</th>
									<td colspan="2">
										<form:radiobutton path="bus_use" name = "bus_use" value="true" label="사용"/>
									</td>
									<td colspan="2">
										<form:radiobutton path="bus_use" name = "bus_use" value="false" label="미사용"/>			  						 							
									</td>
								</tr>							  							
						</table>				
						<input type="hidden" name="${_csrf.parameterName}" id="csrf" value="${_csrf.token}" />			  			
						<input type="hidden"name="bus_id" value="${dto[0].bus_id }">
						<div class="pageBtn contentBottomBtn">						
							<div class="btnLeftBox">
								<input type="button" value="" class="btn_back" id="cusInputBtn" onclick="history.back();" id="bottomBtn-Input"> <!-- 이전버튼 클릭 -->
							</div>
							<div class="btnLeftBox">
								<input type="submit" value="" class="btn_update" id="cusInputBtn"/>
							</div>
							<div class="btnCnterBox">				  				
					  			<input type="button" value="" class="btn_list" id="cusInputBtn" onclick="location.replace('CarInfoView')"/>	
					  		</div> 
						</div>
					</form:form >
					</div><!-- cusInsertTable1 -->	
				</div><!-- content -->
			</div><!-- page-wrapper -->
		</div><!-- page -->
		<jsp:include page="../include/footer.jsp"/>
	<script>
		$(document).ready(function(){	
			var str = "${baseCar[0].bus_borad}";
			
			$("input:radio[name='bus_borad']:radio[value="+str+"]").prop("checked",true);

		}); //탑승인원 수정전 데이터 체크
	</script><!-- 탑승인원 수정전 데이터 미리표시 -->
	
	<script type="text/javascript">
		$(document).ready(function(){	
			var str = "${baseCar[0].staff_id}";
			var equipment_gate_id = "${baseCar[0].equipment_gate_id}";
			var equipment_tablet_id = "${baseCar[0].equipment_tablet_id}";
			$("#staff_id").val(str).attr("selected", "selected");
			
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			 
		       $.ajax({  
   	              url : 'equipment',
   	              dataType : 'json',
   	              type:'POST',
	   	          beforeSend: function(xhr) {
			           xhr.setRequestHeader(header, token);
			      },
   	              data : { "center_code" : "${baseCar[0].center_code}" },              
   	              success: function(result) {	            	 	      
   	           	  
   	           	   var size_data=result.equipment; 
   	           	 	      	           	   		
   	          		for(var i=0; i < size_data.length; i ++){	      	
   	          			if(result.equipment[i].equipment_type=="게이트웨이"){      	          				
   	          				$("#equipment_gate_id").append("<option value="+result.equipment[i].equipment_id+">"+result.equipment[i].equipment_name+"</option>");
	          				}
   	          			else{
   	          				$("#equipment_tablet_id").append("<option value="+result.equipment[i].equipment_id+">"+result.equipment[i].equipment_name+"</option>");
   	          			}
   	          		}   	          		
	   	          	$("#equipment_gate_id").val(equipment_gate_id).attr("selected", "selected");
	   				$("#equipment_tablet_id").val(equipment_tablet_id).attr("selected", "selected");
   	              },
   	              error:function(request,status,error){                 
   	           	   alert("code:"+request.status+"\n"+"error:"+error);
   	              }
   	              
   	          }); //기기 목록
			     	
		}); //차량기사 수정전 데이터 체크
	</script><!-- 차량기사,기기 수정전 데이터 미리표시 -->
	
	<script>
		$(document).ready(function(){	
			var str = "${baseCar[0].bus_use}";	
			var str1 = "${baseCar[0].bus_insur}";	
			
			$("input:radio[name='bus_use']:radio[value="+str+"]").prop("checked",true);
			$("#bus_insur").val(str1);	
			
		}); //탑승인원 수정전,종합보험  데이터 체크
	</script><!-- 사용여부 수정전 데이터,종합보험 미리표시 -->
	
	<script>
		$(document).ready(function(){
			 var token = $("meta[name='_csrf']").attr("content");
			 var header = $("meta[name='_csrf_header']").attr("content");
			 
			 $.ajax({  
	              url : 'phoneInput',
	              dataType : 'json',
	              type:'POST',
	              data : { "name" : $("#staff_id option:selected").val() },
	              beforeSend: function(xhr) {
  		            xhr.setRequestHeader(header, token);
  		          },
	              success: function(result) {	            	 	      
	           	  
	            	  var size_data=result.data;  
	            	   
	            	    if(size_data.length==0){
	       	    		$('#phoneNum').val("");
	       	    		}
		          		for(var i=0; i < size_data.length; i ++){
		          			$('#phoneNum').val(result.data[i].staff_phone);	       					
		          		}
	               },
	               error:function(request,status,error){                 
	            	   alert("code:"+request.status+"\n"+"error:"+error);
	               }	              
	          });
		});//초기 셀렉박스 값에따른 번호	
	
		function input_phoneNum(obj) {			
			
			$.ajax({  
	               url : 'phoneInput',
	               dataType : 'json',
	               type:'POST',
	               data : { "name" : obj.value },   
	               beforeSend: function(xhr) {
	  		            xhr.setRequestHeader(header, token);
	  		       },
	               success: function(result) {	            	 	      
	            	  
	            	   var size_data=result.data;  
	            	   
	            	    if(size_data.length==0)
	       	    	{
	       	    		$('#phoneNum').val("");
	       	    	}
            		for(var i=0; i < size_data.length; i ++){
            			$('#phoneNum').val(result.data[i].staff_phone);	       					
            		}
	               },
	               error:function(request,status,error){                 
	            	   alert("code:"+request.status+"\n"+"error:"+error);
	               }	               
	           });//변경된 셀렉박스에 따른 번호		
		}
	</script><!-- 차량 기사 연락처 자동입력 -->	
	
	
	<script>	
	$(function() {
		  $( "#bus_insur" ).datepicker({
				changeMonth : true,
			    changeYear : true,
			    showMonthAfterYear:true,
				buttonImage: 'images/button/button_calender_54x54.png',  // 우측 달력 icon 의 이미지 패스 
	            buttonImageOnly: true, //  inputbox 뒤에 달력icon만 표시한다. ('...' 표시생략)
			    showOn: "button",
			    dateFormat : "yy-mm-dd",
			    dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
			    dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],  
			    monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
			    monthNames : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']

		  });
		});  
	</script><!-- datePiker -->
	
	<script>
	$(function() {			
		 $.validator.addMethod("regex", function(value, element, regexpr) {          
		     return regexpr.test(value);
		   });			 
		 var token = $("meta[name='_csrf']").attr("content");
		 var header = $("meta[name='_csrf_header']").attr("content");
		 
		$("#CarDataForm").validate({
			errorClass: "validFail",
			validClass: "validSuccess",
			
		    rules: {
		    	bus_name : {
		    		required: true,
		    		remote: {
	    				url:  "checkName",
	    				type: "post",
	    				beforeSend: function(xhr) {
	    		            xhr.setRequestHeader(header, token);
	    		        },
	    				data: {	    					
    						formData: function() {
	    						return $("#bus_name").val();
	    						},
	    					baseData: function() {
	    						return "${baseCar[0].bus_name}";
	    						}
	    				}
	    			},						    		
		    		regex: /^[가-힣\s]{2,6}$/			    		
		    	},
		    	bus_num: {
		    		required: true,
		    		remote: {
	    				url:  "checkNum",
	    				type: "post",
	    				beforeSend: function(xhr) {
	    		            xhr.setRequestHeader(header, token);
	    		        },
	    				data: {
	    					formData: function() {
	    						return $("#bus_num").val();
	    						},
	    					baseData: function() {
	    						return "${baseCar[0].bus_num}";
	    						}
	    				}
	    			},						    		
		    		regex: /^\d{2}[가-힣]{1}\d{4}$/
		    	},   
		    	bus_borad: {
		    		required: true
		    	},
		    	staff_id: {
		    		required: true
		    	},
		    	equipment_gate_id: {
		    		required: true,
		    		remote: {
	    				url:  "checkgate",
	    				type: "post",
	    				beforeSend: function(xhr) {
	    		            xhr.setRequestHeader(header, token);
	    		        },
	    				data: {
	    					formData: function() {
	    						return $("#equipment_gate_id").val();
	    						},
	    					baseData: function() {
	    						return "${baseCar[0].equipment_gate_id}";
	    						}
    				}
	    			}	
		    	},
		    	equipment_tablet_id: {
		    		required: true,
		    		remote: {
	    				url:  "checktablet",
	    				type: "post",
	    				beforeSend: function(xhr) {
	    		            xhr.setRequestHeader(header, token);
	    		        },
	    				data: {
	    					formData: function() {
	    						return $("#equipment_tablet_id").val();
	    						},
	    					baseData: function() {
	    						return "${baseCar[0].equipment_tablet_id}";
	    						}
	    				}
	    			}
		    	},
		    	bus_com: {
		    		required: true
		    	},
		    	bus_insur: {
		    		required: true
		    	}
		    },			    

		    messages: {

		    	bus_name: {
		            required: "차량 이름을 입력해주세요",
		            remote : "이미 사용되고 있는 차량이름입니다.",
		            regex : "차량명은 한글(최소2자 이상 6자 이하 )만 가능 합니다."			    		
		        },
		        bus_num: {
		            required: "차량넘버를 입력해주세요",
		            remote : "이미 사용중인 차량 넘버입니다.",
		            regex : "차량넘버 형식이 아닙니다. 예)12바1234"			    		
		        },
		        bus_borad: {
		        	required: "탑승 인원을 체크해주세요."
		        },
		        staff_id: {
		        	required: "차량기사를 선택해주세요"
		        },
		    	equipment_gate_id: {
		    		required: "게이트웨이를 선택해주세요",
		    		remote : "이미 사용되고 있는 게이트웨이입니다."
		    	},
		    	equipment_tablet_id: {
		    		required: "테블릿를 선택해주세요",
		    		remote : "이미 사용되고 있는 태블릿입니다."
		    	},
		    	bus_com: {
		    		required: "운행사를 입력해주세요"
		    	},
		    	bus_insur: {
		    		required: "종합보험을 선택해주세요"
		    	}
		    },		    
		    success: function(label) {
//              label.addClass("validSuccess").text("정상입니다.");		   		
		    },
		    invalidHandler: function(form, validator){ //입력값이 잘못된 상태에서 submit 할때 호출
				var errors = validator.numberOfInvalids();
				if (errors) {						
					validator.errorList[0].element.focus();
	//				console.log(validator.errorList[0].message);
					$('#msgBox').empty();	        	
		        	$('#msgBox').removeClass("msgBox_Success");
		        	$('#msgBox').addClass("msgBox_Error");
		        	$('#msgBox').html(validator.errorList[0].message);
		        	document.getElementById('msgBox').style.display="block";
				} 
			},
			errorPlacement: function(error, element)
		    {	
		     
		    }
		});	
	});
	</script>
	<!-- 중복 확인/수정 클릭 -->
