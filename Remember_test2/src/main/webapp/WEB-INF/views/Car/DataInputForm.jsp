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
<script language="JavaScript">
function CheckEnter(frm, objName)
{
	var keycode = event.keyCode;        
	var i = 0;
	console.log("tete:"+frm.length);
	if( keycode == 13 ){
		for( i = 0; i < frm.length; ++i ){
			if( objName.name == frm[i].name )
			break;
		}
		frm[++i].focus();
	}
}

</script>
	<jsp:include page="../include/menu_admin.jsp">
		<jsp:param name="pageInMenu" value="차량운행정보"  />
		<jsp:param name="pageCategory" value="차량 관리"  />
		<jsp:param name="pageTitle" value="차량 등록"  /> 
	</jsp:include>
	<div class="page">
		<div class="page-wrapper">
			<div class="pageTitle">
				<h2>차량 등록</h2>								
			</div>	
			
			<div class="pageContent DataInputForm">
				<div class="cusInsertTable1">	
				<div class="msgboxDiv"><div class="msgBox" id="msgBox"></div></div>
					<div class="cautionText">*는 필수 사항입니다.</div>
					
					<form:form  name="form_car" action="DataInput" method="post" id="CarDataForm" commandName="car"  onkeydown="if(event.keyCode==13){event.returnValue=false;}">
					<table>
						<tr>
							<th>차량명*</th>
							<td colspan="4">
								<form:input class="big_input" path="bus_name" id="bus_name" name="bus_name" onkeydown="CheckEnter(this.form,this)"/>
							
							</td>
						</tr>
						<tr>
							<th>차량번호*</th>
							<td colspan="4">
								<form:input  class="big_input" path="bus_num" id="bus_num" name="bus_num" maxlength="100" placeholder="예)12바1234"/>		
							</td>
						</tr>
						<tr class="errorRadiobtn">
							<th>탑승인원*</th>
							<td style="text-align:left;">
								<form:radiobutton class="" id="bus_borad_15" value="15" label="15명" name="bus_borad" path="bus_borad" />							
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
							   		<form:option value="" label="기사선택"/>
								   	<c:forEach items="${driver}" var="dto" varStatus="status">												   									
								   		<form:option value="${dto.staff_id}" label="${dto.staff_name}"/>
								   	</c:forEach>   				
							   	</form:select><br> 										   	
							</td>
						</tr>		
						<tr>
							<th>연락처*</th>
							<td colspan="4"> 
								<input class="big_input readonly" type="text" id="phoneNum" readonly="readonly"> 										
							</td>
						</tr>
						<tr>
							<th>게이트웨이</th>
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
								<form:input  class="big_input" path="bus_com" />	 							
							</td>
						</tr>
						<tr class="errorDatePicker">
							<th>종합보험 유효기간</th> 
							<td colspan="4">
								<input type="text" name="bus_insur" id="bus_insur" class="big_input" readonly="readonly">														
							</td>
						</tr>
					</table>										
						<input type="hidden" name="bus_use" value="true" >  
						<input type="hidden" name="registrant" id="registrant" value="${registrant}">
						<input type="hidden" name="center_code" id="center_code">						
						<input type="hidden" name="bus_id" id="bus_id">
						
						
						<div class="pageBtn contentBottomBtn">
							<div class="btnLeftBox">
								
							</div>
							<div class="btnCnterBox">
								<input type="submit" value="" id="cusInputBtn" class="customD"/>
										  				
					  		</div>
					  		<div class="btnRightBox">
					  			<input type="button" value="" id="cusInputBtn" class="customM" onclick="location.replace('CarInfoView')"/>		
					  		</div>
				  		</div>	

					</form:form>
				</div><!-- cusInsertTable1 -->			
			</div><!-- content -->
		</div><!-- page-wrapper -->
	</div><!-- page -->
	<jsp:include page="../include/footer.jsp"/>
	<script>
	var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
    
		$(document).ready(function(){
			$('#center_code').val('${center_code}');
          
	        $.ajax({  
	              url : 'equipment',
	              dataType : 'json',
	              type:'POST',
	              data : { "center_code" : '${center_code}' },
	              beforeSend: function(xhr) {
	  	            xhr.setRequestHeader(header, token);
	  	        	},
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
	              },
	              error:function(request,status,error){                 
	           	   alert("code:"+request.status+"\n"+"error:"+error);
	              }
	              
	          }); //기기 목록
		});
	</script> <!-- 버스 id, 센터 코드 히든값 셀렉 -->
	
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
	var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
    
	$(function() {			
		 $.validator.addMethod("regex", function(value, element, regexpr) {  
		     return regexpr.test(value);
		   });			 
		 
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
		            required: "차량명을 입력 해주세요",
		            remote : "이미 사용 되고 있는 차량이름 입니다.",
		            regex : "차량명은 한글(최소2자 이상 6자 이하 )만 가능 합니다."			    		
		        },
		        bus_num: {
		            required: "차량번호를 입력 해주세요",
		            remote : "이미 사용중인 차량 번호 입니다.",
		            regex : "차량번호 형식이 아닙니다. ex)12바1234"			    		
		        },
		        bus_borad: {
		        	required: "탑승 인원을 체크해주세요."
		        },
		        staff_id: {
		        	required: "차량 기사를 선택 해주세요."
		        },
		    	equipment_gate_id: {
		    		required: "게이트웨이를 선택 해주세요.",
		    		remote : "이미 사용되고 있는 게이트웨이입니다."
		    	},
		    	equipment_tablet_id: {
		    		required: "태블릿를 선택 해주세요.",
		    		remote : "이미 사용되고 있는 태블릿 입니다."
		    	},
		    	bus_com: {
		    		required: "운행사를 입력 해주세요."
		    	},
		    	bus_insur: {
		    		required: "종합보험을 선택 해주세요."
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
	<!-- 중복 확인 /등록 클릭 -->	
	
	<script>
	var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
     
    
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
</body>
</html>