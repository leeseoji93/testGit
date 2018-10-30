<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/OnOffRecord.css">

<style type="text/css">
.ui-datepicker-calendar { 
    display: none;
} 
.ui-datepicker-trigger{
	width: 27px;
	height: 27px;
	float: left;
	cursor: pointer;
}
.hasDatepicker{
	width: 203px;
    height: 27px;
    float: left;
}
.AttendanceList_contentRight_Content_table{
	border: 1px solid #000000;border-collapse:collapse;
}
.backslash {
	background: url('http://cdn.zetawiki.com/png/backslash.png');
	background-size: 100% 100%;
	text-align: left;
}
.slash div, .backslash div { text-align: right;width: 56px; }
.AttendanceList_contentRight_Content_table th,td{font-size: 13px;text-align: center;}
</style>

	<jsp:include page="../include/menu_admin.jsp">
      <jsp:param name="pageInMenu" value="자동이력"  /> 
      <jsp:param name="pageCategory" value="출석 이력"  />
      <jsp:param name="pageTitle" value="출석부 조회"  />
   </jsp:include>
	<div class="page">
		<div class="page-wrapper">
			<div class="pageTitle"><h2>출석부 조회</h2></div>
			
			<div class="pageContent">
				<c:choose>
					<c:when test="${fn:length(GcdList) eq 0}">
						<div class="msgBox msgBox_Error" id="msgBox" style="display: block;"><span>이번달 의 이력이 없습니다.</span></div>
					</c:when>
					
					<c:otherwise>
						<div class="msgBox" id="msgBox"></div>
					</c:otherwise>
				</c:choose>
				<div class="OnoffList_contentLeft">
					<table id="OnoffList_RouteList">
						<tr>
							<th><span>반리스트</span></th>
						</tr>
						<c:forEach var="classdto" items="${classList}" varStatus="vs">
							
								<c:choose>
									<c:when test="${class_id eq 'default'}">
										<c:choose>
											<c:when test="${vs.index eq 0}">
												<tr class="active">
													<td onclick="classClick('${classdto.class_id}',this)">${classdto.class_name}</td>		
												</tr>
											</c:when>
											
											<c:otherwise>
												<tr>
													<td onclick="classClick('${classdto.class_id}',this)">${classdto.class_name}</td>				
												</tr>
											</c:otherwise>
										</c:choose>	
									</c:when>
										
									<c:otherwise>
										<c:choose>
											<c:when test="${class_id eq classdto.class_id}">
												<tr class="active">
													<td onclick="classClick('${classdto.class_id}',this)">${classdto.class_name}</td>		
												</tr>
											</c:when>
											
											<c:otherwise>
												<tr>
													<td onclick="classClick('${classdto.class_id}',this)">${classdto.class_name}</td>				
												</tr>
											</c:otherwise>
										</c:choose>	
									</c:otherwise>
								</c:choose>																			
						</c:forEach>
					</table>
				</div>				
				
				<div class="AttendanceList_contentRight">	
					<div class="OnoffList_date_div">
						<input type="text" id="AttendanceList_date" name="AttendanceList_date" class="AttendanceList_date"/>
						<span>
							<img src="images/button/button_download_90x25.png" onclick="AttendanceList_Down()" class="downImgBtn">
						</span>	
					</div>
				
					
					<div id = "AttendanceList_contentRight_Content" class="AttendanceList_contentRight_Content">				
					<table id = "AttendanceList_contentRight_Content_table" class="AttendanceList_contentRight_Content_table">
					<c:set value="${startMonth}" var="startMonth"/>
						<tr style="text-align: center; height: 5mm">
						<td rowspan="2" colspan="15" style="border: 1px solid #000000;
						 border-top: 1px solid #ffffff;  border-left: 1px solid #ffffff">${startMonth}월 출석부</td>
						<th colspan="5" style="border: 1px solid #000000; font-weight: bold;">담임</th>
						<th colspan="5"  style="border: 1px solid #000000;font-weight: bold;">원감</th>
						<th colspan="5"  style="border: 1px solid #000000;font-weight: bold;">원장</th>
						<th rowspan="2" colspan="2" style="border: 1px solid #000000;font-weight: bold;">결제</th>
						</tr>
						<tr style="text-align: center; height: 18mm;">
						<td colspan="5" style="border: 1px solid #000000;">&nbsp;</td>
						<td colspan="5" style="border: 1px solid #000000;">&nbsp;</td>
						<td colspan="5" style="border: 1px solid #000000;">&nbsp;</td>
						</tr>
						<tr>
							<td class='backslash' style='padding:0px 0px;border: 1px solid #000000;width:60px'><div>일</div>이름</td>
							<%
								String month = (String)pageContext.getAttribute("month");
								List date = new ArrayList();
								for(int i=1; i<=31; i++){
							%>
								<td style="padding: 0px 2px;border: 1px solid #000000; text-align: center; font-size: 13px" width="20"><%=i %></td>
							<%								
								date.add(Integer.toString(i));								
								}
							%>
						</tr>
						<c:forEach items="${GcdList}" var="GcdDto" varStatus="vs">
							<c:set value="${GcdDto.today}" var="today"/>
							<c:set value="${GcdDto.on_type}" var="on_type"/>
							
							<tr>
								<td style="border: 1px solid #000000;">${GcdDto.kid_name}</td>
								<%
								for(int i = 0; i<date.size(); i++)
								{
									String[] today = ((String)pageContext.getAttribute("today")).split(",");
									String[] on_type = ((String)pageContext.getAttribute("on_type")).split(",");
									boolean check = false;
									for(int j = 0; j<today.length; j++)
									{	
										if(today[j].equals(date.get(i)))
										{
											check = true;
										%>						
											<td style="border: 1px solid #000000;">
											<%
												if(!(on_type[j].equals("X"))){
												%>O<%
												}
												else{
												%>
													<%=on_type[j] %>
												<%	
												}
											%>												
											</td>	
										<%
										}
									}
									
									if(!check){
								%>
										<td style="border: 1px solid #000000;">&nbsp;</td>												
								<%		
										check = false;
										}
									}
								%>		
	
							</tr>
						</c:forEach>
						
						<c:set value="${Gcd_size}" var="size"/>

						<%
							int size = Integer.parseInt((String)pageContext.getAttribute("size"));
							if(size > 30){
								size = 30;
							}
							for(int i = 0; i<(30-size); i++)
							{
								%>
								<tr height="10mm">												
								<%	
									for(int j = 0; j<32; j++)
									{
									%>
										<td style="border: 1px solid #000000;">&nbsp;</td>												
									<%	
									}
								%>
								</tr>												
								<%	
							}
						%>
					</table>	
					</div>	
				</div>
			</div>
		</div>	
	</div>
	<script type="text/javascript">
	var today = "${month}";
	$(document).ready(function(){
		$("#AttendanceList_date").val(today);
	});
	
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	
	var saveClass_id="${classList[0].class_id}";
	
	var saveDownCheck=false;
	
	var startDate = null;
    var endDate = null;
    var dateFormat = null;
    
    var senStartDate = null;
    var senEndDate = null;
    
    
	var Now = new Date();
	var NowTime = Now.getFullYear();
	NowTime += '-' + Now.getMonth() + 1 ;
	NowTime += '-' + ((Now.getDate() - Now.getDay())-1);

	$(function() {
		  $( "#AttendanceList_date" ).datepicker({
			  	changeMonth: true,
		        changeYear: true,
		        showButtonPanel: true,
		        closeText: "닫기",
		        showMonthAfterYear:true,
		        buttonImage : "images/button/button_calender_54x54.png",  // 우측 달력 icon 의 이미지 패스 
	            buttonImageOnly: true, //  inputbox 뒤에 달력icon만 표시한다. ('...' 표시생략)
		        showOn: "button",
		        buttonText: "달력",
		        dateFormat: 'yy-mm',		       
		        monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
		        onClose: function(dateText, inst) { 
		        	if(saveClass_id!=null){		
		        		var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();				
			            var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
			            $(this).datepicker('setDate', new Date(year, month, 1));
			            var resultText = "";
			           
		        		$.ajax({  
		  	              url : 'AttendanceList_updateTable',
		  	              dataType : 'json',
		  	              type:'POST',
		  	              data : { "class_id" : saveClass_id,
		  	            		   "month" : $( "#AttendanceList_date" ).val()
		  	            		}, 
		  	            	beforeSend: function(xhr) {
		  		 	              xhr.setRequestHeader(header, token);
		  		 	           },	
		  	              success: function(result) {  
		  	            	var size_GcdData = result.GcdList;
		  	            	if(size_GcdData.length==0){
		  	            		$('#msgBox').removeClass("msgBox_Success");
			  	            	$('#msgBox').addClass("msgBox_Error");
			  	            	$('#msgBox').html("<span>선택한 달 의 이력이 없습니다.</span>");
			  	            	document.getElementById('msgBox').style.display="block";
// 		  	            		$("#AttendanceList_date").val(null);
// 		  	            		saveDownCheck=false;
		  	            		return false;
		  	          		} 
		  	            	
		  	            	$('#msgBox').removeClass("msgBox_Success");
			            	$('#msgBox').removeClass("msgBox_Error");			  	             
		  	             	document.getElementById('msgBox').style.display="none";
		  	          		  		  	             	 
		  	            	$("#AttendanceList_contentRight_Content_table").empty();
		  	            	resultText = "<tr style='text-align: center; height: 5mm'>"
		  	            				+"<td rowspan='2' colspan='15' style='border: 1px solid #000000;border-top: 1px solid #ffffff; border-left: 1px solid #ffffff'>"
		  	                			+result.startMonth+"월 출석부</td>	"
		  	                			+"<th colspan='5' style='border: 1px solid #000000; font-weight: bold;'>담임</th>"
		  	                			+"<th colspan='5'  style='border: 1px solid #000000;font-weight: bold;'>원감</th>"
		  	                			+"<th colspan='5'  style='border: 1px solid #000000;font-weight: bold;'>원장</th>"
		  	                			+"<th rowspan='2' colspan='2' style='border: 1px solid #000000;font-weight: bold;'>결제</th>"
		  	                			+"</tr>"
		  	                			+"<tr style='text-align: center; height: 18mm;'>"
		  	                			+"<td colspan='5' style='border: 1px solid #000000;'>&nbsp;</td>"
		  	                			+"<td colspan='5' style='border: 1px solid #000000;''>&nbsp;</td>"
		  	                			+"<td colspan='5' style='border: 1px solid #000000;'>&nbsp;</td>"
		  	                			+"</tr>"
		  	                			+"<tr><td class='backslash' style='padding:0px 0px;border: 1px solid #000000;width:60px'><div>일</div>이름</td>";
		  	            			  	            
// 			            	var date = new ArrayList();
	  	                	for(var i =1; i<=31; i++){
	  	                		resultText +="<td style='padding: 0px 2px;border: 1px solid #000000;text-align: center;' width='20'>"+i+"</td>";	  	                		
	  	                		
// 	  	                		date.add(Integer.toString(i));							
	  	                	}
	  	                	resultText += "</tr>";
	  	                	for(var i=0; i < size_GcdData.length; i++){
	  	                		resultText +="<tr><td style='border: 1px solid #000000;'>"+result.GcdList[i].kid_name+"</td>";
	  	                		var today = (result.GcdList[i].today).split(",");
	  	                		var on_type  = (result.GcdList[i].on_type ).split(",");
	  	                		
	  	                		for(var z = 1; z<=31; z++){
	  	                			var check = false;
	  	                			for(var j = 0; j<today.length; j++)
									{	  
		  	                			var test = z.toString();		  	                			
		  	                			if(today[j]==test){
		  	                				check = true;
		  	                				if((on_type[j]!='X')){
		  	                					resultText += "<td style='border: 1px solid #000000;'>O</td>"
		  	                				}    
		  	                				else{
		  	                					resultText += "<td style='border: 1px solid #000000;'>"+on_type[j]+"</td>";
		  	                				}
		  	                				
		  	                			}
									}
		  	                		if(!check){
		  	                			resultText += "<td style='border: 1px solid #000000;'>&nbsp;</td>";
		  	                			check = false;
		  	                		}		  	                		
	  	                		}	
	  	                		resultText += "</tr>";
	  	                	}
	  	                	var size = result.Gcd_size; 
	  	                	for(var i = 0; i<(30-size); i++)
							{	  	
	  	                		resultText += "<tr height='10mm'>";
	  	                		for(var j = 0; j<32; j++){
	  	                			resultText += "<td style='border: 1px solid #000000;'>&nbsp;</td>";
	  	                		}
	  	                		resultText += "</tr>";
							}
	  	                	
	  	                	$("#AttendanceList_contentRight_Content_table")
	  	                	.append(resultText);  	        
	  	                	
		  	              },
		  	              error:function(request,status,error){                 
		  	           	   alert("code:"+request.status+"\n"+"error:"+error);
		  	              }		  	              
		  	          });
		        	}
		        	else{					
						if(saveClass_id==null){
							$('#msgBox').removeClass("msgBox_Success");
		  	            	$('#msgBox').addClass("msgBox_Error");
		  	            	$('#msgBox').html("<span>반부터 클릭해주세요.</span>");
		  	            	document.getElementById('msgBox').style.display="block";
						}
						else{
							$('#msgBox').removeClass("msgBox_Success");
		  	            	$('#msgBox').addClass("msgBox_Error");
		  	            	$('#msgBox').html("<span>날짜를 선택해주세요.</span>");
		  	            	document.getElementById('msgBox').style.display="block";
						}	
// 						$("#OnoffList_date").val(null);
						return false;
					}
		            var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
		            var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
		            $(this).datepicker('setDate', new Date(year, month, 1));		            
		        }
		  });
	});
	
	
	function classClick(class_id,thisObj){
		saveClass_id = class_id;

		var tr = $(thisObj).parent();
	    var td = tr.children();

// 	    $("#OnoffList_contentRight_Content_table").empty();	     
// 	    $("#OnoffList_contentRight_Content_table").css("display", "none");
	    $("#OnoffList_RouteList tr").removeClass("active"); 
// 		$("OnoffList_RouteList tr").removeClass("active"); 
		tr.addClass("active");
		
		 var resultText = "";
		$.ajax({			
              url : 'AttendanceList_updateTable',
              dataType : 'json',
              type:'POST',
              data : { "class_id" : saveClass_id,
            		   "month" : $( "#AttendanceList_date" ).val()
            		}, 
            	beforeSend: function(xhr) {
	 	              xhr.setRequestHeader(header, token);
	 	           },	
              success: function(result) {  
            	var size_GcdData = result.GcdList;
            	if(size_GcdData.length==0){
            		$('#msgBox').removeClass("msgBox_Success");
	            	$('#msgBox').addClass("msgBox_Error");
	            	$('#msgBox').html("<span>선택한 달 의 이력이 없습니다.</span>");
	            	document.getElementById('msgBox').style.display="block";
//	            		$("#AttendanceList_date").val(null);
//	            		saveDownCheck=false;
            		return false;
          		} 
            	
            	$('#msgBox').removeClass("msgBox_Success");
          	$('#msgBox').removeClass("msgBox_Error");			  	             
             	document.getElementById('msgBox').style.display="none";
          		  		  	             	 
            	$("#AttendanceList_contentRight_Content_table").empty();
            	resultText = "<tr style='text-align: center; height: 5mm'>"
            				+"<td rowspan='2' colspan='15' style='border: 1px solid #000000;border-top: 1px solid #ffffff; border-left: 1px solid #ffffff'>"
                			+result.startMonth+"월 출석부</td>	"
                			+"<th colspan='5' style='border: 1px solid #000000; font-weight: bold;'>담임</th>"
                			+"<th colspan='5'  style='border: 1px solid #000000;font-weight: bold;'>원감</th>"
                			+"<th colspan='5'  style='border: 1px solid #000000;font-weight: bold;'>원장</th>"
                			+"<th rowspan='2' colspan='2' style='border: 1px solid #000000;font-weight: bold;'>결제</th>"
                			+"</tr>"
                			+"<tr style='text-align: center; height: 18mm;'>"
                			+"<td colspan='5' style='border: 1px solid #000000;'>&nbsp;</td>"
                			+"<td colspan='5' style='border: 1px solid #000000;''>&nbsp;</td>"
                			+"<td colspan='5' style='border: 1px solid #000000;'>&nbsp;</td>"
                			+"</tr>"
                			+"<tr><td class='backslash' style='padding:0px 0px;border: 1px solid #000000;width:60px'><div>일</div>이름</td>";
            			  	            
//           	var date = new ArrayList();
            	for(var i =1; i<=31; i++){
            		resultText +="<td style='padding: 0px 2px;border: 1px solid #000000;text-align: center;' width='20'>"+i+"</td>";	  	                		
            		
//             		date.add(Integer.toString(i));							
            	}
            	resultText += "</tr>";
            	for(var i=0; i < size_GcdData.length; i++){
            		resultText +="<tr><td style='border: 1px solid #000000;'>"+result.GcdList[i].kid_name+"</td>";
            		var today = (result.GcdList[i].today).split(",");
            		var on_type  = (result.GcdList[i].on_type ).split(",");
            		
            		for(var z = 1; z<=31; z++){
            			var check = false;
            			for(var j = 0; j<today.length; j++)
						{	  
                			var test = z.toString();		  	                			
                			if(today[j]==test){
                				check = true;
                				if((on_type[j]!='X')){
                					resultText += "<td style='border: 1px solid #000000;'>O</td>"
                				}    
                				else{
                					resultText += "<td style='border: 1px solid #000000;'>"+on_type[j]+"</td>";
                				}
                				
                			}
						}
                		if(!check){
                			resultText += "<td style='border: 1px solid #000000;'>&nbsp;</td>";
                			check = false;
                		}		  	                		
            		}	
            		resultText += "</tr>";
            	}
            	var size = result.Gcd_size; 
            	for(var i = 0; i<(30-size); i++)
				{	  	
            		resultText += "<tr height='10mm'>";
            		for(var j = 0; j<32; j++){
            			resultText += "<td style='border: 1px solid #000000;'>&nbsp;</td>";
            		}
            		resultText += "</tr>";
				}
            	
            	$("#AttendanceList_contentRight_Content_table")
            	.append(resultText);  	        
            	
              },
              error:function(request,status,error){                 
           	   alert("code:"+request.status+"\n"+"error:"+error);
              }		  	              
          });
	}

	function AttendanceList_Down() {	 
		if($("#AttendanceList_date").val()!=""){
			$('#msgBox').removeClass("msgBox_Success");
        	$('#msgBox').removeClass("msgBox_Error");			  	             
           	document.getElementById('msgBox').style.display="none";
			location.href = 'AttendanceList_Down?class_id=' + encodeURIComponent(saveClass_id,'UTF-8')
			+'&month=' + encodeURIComponent($("#AttendanceList_date").val(),'UTF-8');
		}
		else{
			$('#msgBox').removeClass("msgBox_Success");
          	$('#msgBox').addClass("msgBox_Error");
          	$('#msgBox').html("<span>1개월 단위로 다운로드 가능합니다. 날짜를 선택해주세요.</span>");
          	document.getElementById('msgBox').style.display="block";
			return false;
		}
		
	}
	</script>
</body>
</html>