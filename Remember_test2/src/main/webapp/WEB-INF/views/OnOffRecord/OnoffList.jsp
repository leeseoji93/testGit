<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/OnOffRecord.css">
<style type="text/css">
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
</style>

	<jsp:include page="../include/menu_admin.jsp">
      <jsp:param name="pageInMenu" value="자동이력"  /> 
      <jsp:param name="pageCategory" value="승하차 이력"  />
      <jsp:param name="pageTitle" value="등하원 이력"  />
   </jsp:include>
	<div class="page">
		<div class="page-wrapper">
			<div class="pageTitle"><h2>등하원 이력</h2></div>
			
			<div class="pageContent">
				<div class="msgBox" id="msgBox"></div>
				<div class="OnoffList_Content">
					<div class="OnoffList_contentLeft">
						<table id="OnoffList_RouteList">
							<tr>
								<th><span>반리스트</span></th>
							</tr>
							<c:forEach var="classdto" items="${classList}" varStatus="vs">
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
							</c:forEach>
						</table>
					</div>	
					
					<div class="OnoffList_contentRight">			
						<div class="OnoffList_date_div"><input type="text" id="OnoffList_date" name="OnoffList_date" class="OnoffList_date"/>
							<span>
								<img src="images/button/button_download_90x25.png" onclick="OnoffList_Down()" class="downImgBtn">
							</span>
						</div>
						<div id = "OnoffList_contentRight_Content">		
							<table id="OnoffList_contentRight_Content_table_title">
								<tr>
									<th width="222">날짜</th><th width="124">등원시간</th><th width="106">등원방법</th><th width="124">하원시간</th><th width="117">하원방법</th>
								</tr>
							</table>
							<div class="OnoffList_contentRight_Content_table_Content">
								<table id = "OnoffList_contentRight_Content_table" class="OnoffList_contentRight_Content_table">
									<c:choose>
											<c:when test="${fn:length(OnOffList) eq 0}">
												<tr><td>이력이 없습니다.</td></tr>
											</c:when>
											
											<c:otherwise>
												<%
													String saveName = ""; //저장 이름
												%>	
												<c:forEach items="${OnOffList}" var="OnOffDto" varStatus="vs">
												<c:set value="${OnOffDto.kid_system_code}" var="name"/>
												<%
													if(saveName == ""){
												%>
													<tr class='OnoffList_onoff_name_filter'>	
														<c:choose>
															<c:when test="${empty OnOffDto.kid_pho}">
																<td colspan='6' class='OnoffList_onoff_name'><img width='50px' height='50px' class='OnoffList_kid_pho' 
																src='http://13.125.170.255:8080/Spring/Default/image_ujacar_290x290.png'/>${OnOffDto.kid_name}</td>
															</c:when>									
															<c:otherwise>
																<td colspan='6' class='OnoffList_onoff_name'><img width='50px' height='50px' class='OnoffList_kid_pho' src="${OnOffDto.kid_pho}"/>${OnOffDto.kid_name}</td>
															</c:otherwise>									
														</c:choose>
													</tr>
												<%		
													}
													else if(!(saveName.equals((String)pageContext.getAttribute("name"))))
													{
												%>	
												<tr class='OnoffList_onoff_name_filter'>
													<c:choose>
														<c:when test="${empty OnOffDto.kid_pho}">
															<td colspan='6' class='OnoffList_onoff_name'><img width='50px' height='50px' class='OnoffList_kid_pho' 
															src='http://13.125.170.255:8080/Spring/Default/image_ujacar_290x290.png'/>${OnOffDto.kid_name}</td>
														</c:when>									
														<c:otherwise>
															<td colspan='6' class='OnoffList_onoff_name'><img width='50px' height='50px' class='OnoffList_kid_pho' src="${OnOffDto.kid_pho}"/>${OnOffDto.kid_name}</td>
														</c:otherwise>									
													</c:choose>
												</tr>
												<%		
													}
													saveName = (String)pageContext.getAttribute("name");								
												%>
												<c:choose>
												<c:when test="${(OnOffDto.on_type eq '-') and (OnOffDto.off_type eq '-')}"> <%-- 결석 --%>
													<tr>
														<td width="232">${OnOffDto.today}</td>
														<td width="124">${OnOffDto.on_type}</td>
														<td width="106">결석</td>
														<td width="124">${OnOffDto.off_type}</td>
														<td width="107">결석</td>
													</tr>
												</c:when>
												
												<c:otherwise>
													<tr>
														<td width="232">${OnOffDto.today}</td>
														<td width="124">${OnOffDto.on_type}</td>					
													<c:choose>
													<c:when test="${OnOffDto.on_time ne '도보'}">
														<td width="106">차량</td>
													</c:when>
													<c:otherwise>
														<td width="106">${OnOffDto.on_time}</td>
													</c:otherwise>
													</c:choose>					
														<td width="124">${OnOffDto.off_type}</td>
													<c:choose>
													<c:when test="${OnOffDto.off_time ne '도보'}">
														<td width="107">차량</td>
													</c:when>
													<c:otherwise>
														<td width="107">${OnOffDto.off_time}</td>
													</c:otherwise>
													</c:choose>
												
													</tr>
												</c:otherwise>
												</c:choose>
												</c:forEach>
											</c:otherwise>
									</c:choose>			
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>	
	</div>
	<script type="text/javascript">
	var saveClass_id="${classList[0].class_id}";
	
// 	var saveDownCheck=false;
	
	var startDate = "${startDate}";
    var endDate = "${endDate}";
    var dateFormat = null;
    
    var senStartDate = startDate;
    var senEndDate = endDate;
    var week = startDate + "~" + endDate;
    
    $(document).ready(function(){
		$("#OnoffList_date").val(week);
	});
    
    <%
    Date now = new Date();
    Calendar cal = Calendar.getInstance();
    cal.setTime(now);
    int num = cal.get(Calendar.DAY_OF_WEEK); 
    cal.add(Calendar.DATE, -num);
    DateFormat sdFormat1 = new SimpleDateFormat("yyyy-MM-dd");
	String tempDate1 = sdFormat1.format(cal.getTime());
	%>   
	var NowTime = "<%=tempDate1 %>";
	
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	
	
	$(function() {
			$('#OnoffList_date').datepicker({
			maxDate : NowTime,
			changeMonth: true,
		    changeYear: true,
		    showButtonPanel: true,
		    closeText: "닫기",
		    showMonthAfterYear:true,
		    buttonImage : "images/button/button_calender_54x54.png",  // 우측 달력 icon 의 이미지 패스 
            buttonImageOnly: true, //  inputbox 뒤에 달력icon만 표시한다. ('...' 표시생략)
		    showOn: "button",
		    buttonText: "달력",
		    dateFormat: 'yy-mm-dd',	
		    dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
            dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
		    monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
		    onSelect: function(dateText, inst) { 
	            setTimeout("applyWeeklyHighlight()", 100);	            
	        },
	        onClose: function(dateText, inst) { 
	            var date = $(this).datepicker('getDate');
	            startDate = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay());
	            endDate = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay() + 6);
	            dateFormat = inst.settings.dateFormat || $.datepicker._defaults.dateFormat;
	            $('#OnoffList_date').val($.datepicker.formatDate( dateFormat, startDate, inst.settings )+"~"
						+$.datepicker.formatDate( dateFormat, endDate, inst.settings ));
	            
	            senStartDate = $.datepicker.formatDate( dateFormat, startDate, inst.settings );
	            senEndDate = $.datepicker.formatDate( dateFormat, endDate, inst.settings );
	        	
	        	if(saveClass_id!=null && $( "#OnoffList_date" ).val()!=""){	
	        		dateFormat = inst.settings.dateFormat || $.datepicker._defaults.dateFormat;
	        		var saveOnoff_name = "";
	        		
	        		$.ajax({  
			            url : 'OnoffList_updateTable',
			            dataType : 'json',
			            type:'POST',
			            beforeSend: function(xhr) {
			 	              xhr.setRequestHeader(header, token);
			 	           },
			            data : { "class_id" : saveClass_id,
			            		 "startDate" : $.datepicker.formatDate( dateFormat, startDate, inst.settings ),
			            		 "endDate" : $.datepicker.formatDate( dateFormat, endDate, inst.settings )
			          		},              
			            success: function(result) {   	 	       
				            	var size_onoffData = result.OnOffList; 
				            	
				            	if(size_onoffData.length==0){
				            		$('#msgBox').removeClass("msgBox_Success");
					            	$('#msgBox').removeClass("msgBox_Error");
					            	document.getElementById('msgBox').style.display="none";
					            	$("#OnoffList_contentRight_Content_table").empty();	
					            	$("#OnoffList_contentRight_Content_table")
			  	                	.append("<tr><td>이력이 없습니다.</td></tr>");
// 			  	            		$("#OnoffList_date").val(null);
// 			  	            		saveDownCheck=false;
			  	            		return false;
				  	            }
				            	
				            	$('#msgBox').removeClass("msgBox_Success");
				            	$('#msgBox').removeClass("msgBox_Error");			  	             
			  	             	document.getElementById('msgBox').style.display="none";
				            	
				            	var kid_image = null;
			            		var onOff_time = null;

			            		$("#OnoffList_contentRight_Content_table").empty();	    
// 				            	$("#OnoffList_contentRight_Content_table")
// 		  	                	.append("<tr><th>날짜</th><th>등원시간</th><th>등원방법</th><th>하원시간</th><th>하원방법</th></tr>");
				            	for(var i=0; i < size_onoffData.length; i++){			            		
				            		if(saveOnoff_name==null || saveOnoff_name != result.OnOffList[i].kid_system_code){
				            			console.log("i : " + i +" sv : " + saveOnoff_name + " re : " 
				            					+  result.OnOffList[i].kid_system_code );
				            			if(result.OnOffList[i].kid_pho == null){
					            			kid_image = "<tr class='OnoffList_onoff_name_filter'><td colspan='6' class='OnoffList_onoff_name'><img width='50px' height='50px' class='OnoffList_kid_pho' src='http://13.125.170.255:8080/Spring/Default/image_ujacar_290x290.png'/>"
				  	                			+result.OnOffList[i].kid_name+"</td>";    			
					       			
					            		}else{
					            			kid_image = "<tr class='OnoffList_onoff_name_filter'><td colspan='6' class='OnoffList_onoff_name'><img width='50px' height='50px' class='OnoffList_kid_pho' src='"+result.OnOffList[i].kid_pho
			  	                			+"'/>"+result.OnOffList[i].kid_name
			  	                			+"</td>";
					            		}//프사가 등록되있거나 안되있을경우
					            		$("#OnoffList_contentRight_Content_table")
				  	                	.append(kid_image);
					            		saveOnoff_name = result.OnOffList[i].kid_system_code;
				            		}
				            		
				            		if((result.OnOffList[i].on_type == '-')&&
				            				(result.OnOffList[i].off_type == '-')){
				            			
				            			onOff_time = "<tr><td>"+result.OnOffList[i].today+"</td><td>"
				            			+result.OnOffList[i].on_type+"</td><td>결석</td><td>"+result.OnOffList[i].off_type+"</td><td>결석</td></tr>"
				            			
				            		}
				            		else{
				            			onOff_time = "<tr><td>"+result.OnOffList[i].today+"</td><td>"
				            			+result.OnOffList[i].on_type
				            			if(result.OnOffList[i].on_time != '도보'){
				            				onOff_time += "<td>차량</td>"
				            			}else{
				            				onOff_time += "<td>"+result.OnOffList[i].on_time+"</td>"
				            			}
				            			onOff_time += "<td>"+result.OnOffList[i].off_type+"</td>"
				            			
				            			if(result.OnOffList[i].off_time != '도보'){
				            				onOff_time += "<td>차량</td>"
				            			}else{
				            				onOff_time += "<td>"+result.OnOffList[i].off_time+"</td>"
				            			}
				            			
				            		}
				            		$("#OnoffList_contentRight_Content_table")
			  	                	.append(onOff_time);
// 				            		saveDownCheck = true;
				            	}
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
	  	            	$('#msgBox').html("<span>반 을 선택해주세요.</span>");
	  	            	document.getElementById('msgBox').style.display="block";
					}
					else{
						$('#msgBox').removeClass("msgBox_Success");
	  	            	$('#msgBox').addClass("msgBox_Error");
	  	            	$('#msgBox').html("<span>날짜를 선택해주세요.</span>");
	  	            	document.getElementById('msgBox').style.display="block";
					}	
// 					$("#OnoffList_date").val(null);
					return false;
				}
	        },
	        beforeShow : function() {
				setTimeout("applyWeeklyHighlight()", 100);
			},
	        onChangeMonthYear: function (year, month, inst) {
				setTimeout("applyWeeklyHighlight()", 100);
	        }
		});
	});
	
	function applyWeeklyHighlight() {

		$('.ui-datepicker-calendar tr').each(function() {

			if ($(this).parent().get(0).tagName == 'TBODY') {
				$(this).mouseover(function() {
					$(this).find('a').css({
						'background' : '#ffffcc',
						'border' : '1px solid #dddddd'
					});
					$(this).find('a').removeClass('ui-state-default');
					$(this).css('background', '#ffffcc');
				});
				
				$(this).mouseout(function() {
					$(this).css('background', '#ffffff');
					$(this).find('a').css('background', '');
					$(this).find('a').addClass('ui-state-default');
				});
			}

		});
	}
	
	
	function classClick(class_id,thisObj){
		saveClass_id = class_id;

		var tr = $(thisObj).parent();
	    var td = tr.children();

	    $("#OnoffList_RouteList tr").removeClass("active");
		tr.addClass("active");
		
		var saveOnoff_name = "";
		
		$.ajax({  
            url : 'OnoffList_updateTable',
            dataType : 'json',
            type:'POST',
            beforeSend: function(xhr) {
 	              xhr.setRequestHeader(header, token);
 	           },
            data : { "class_id" : saveClass_id,
            		 "startDate" : senStartDate,
            		 "endDate" : senEndDate
          		},              
            success: function(result) {   	 	       
	            	var size_onoffData = result.OnOffList; 
	            	
	            	if(size_onoffData.length==0){
	            		$('#msgBox').removeClass("msgBox_Success");
		            	$('#msgBox').removeClass("msgBox_Error");
		            	document.getElementById('msgBox').style.display="none";
		            	$("#OnoffList_contentRight_Content_table").empty();	
		            	$("#OnoffList_contentRight_Content_table")
  	                	.append("<tr><td>이력이 없습니다.</td></tr>");
//	  	            		$("#OnoffList_date").val(null);
//	  	            		saveDownCheck=false;
  	            		return false;
	  	            }
	            	
	            	$('#msgBox').removeClass("msgBox_Success");
	            	$('#msgBox').removeClass("msgBox_Error");			  	             
  	             	document.getElementById('msgBox').style.display="none";
	            	
	            	var kid_image = null;
            		var onOff_time = null;

            		$("#OnoffList_contentRight_Content_table").empty();	    
//		            	$("#OnoffList_contentRight_Content_table")
//	                	.append("<tr><th>날짜</th><th>등원시간</th><th>등원방법</th><th>하원시간</th><th>하원방법</th></tr>");
	            	for(var i=0; i < size_onoffData.length; i++){			            		
	            		if(saveOnoff_name==null || saveOnoff_name != result.OnOffList[i].kid_system_code){
	            			console.log("i : " + i +" sv : " + saveOnoff_name + " re : " 
	            					+  result.OnOffList[i].kid_system_code );
	            			if(result.OnOffList[i].kid_pho == null){
		            			kid_image = "<tr class='OnoffList_onoff_name_filter'><td colspan='6' class='OnoffList_onoff_name'><img width='50px' height='50px' class='OnoffList_kid_pho' src='http://13.125.170.255:8080/Spring/Default/image_ujacar_290x290.png'/>"
	  	                			+result.OnOffList[i].kid_name+"</td>";    			
		       			
		            		}else{
		            			kid_image = "<tr class='OnoffList_onoff_name_filter'><td colspan='6' class='OnoffList_onoff_name'><img width='50px' height='50px' class='OnoffList_kid_pho' src='"+result.OnOffList[i].kid_pho
  	                			+"'/>"+result.OnOffList[i].kid_name
  	                			+"</td>";
		            		}//프사가 등록되있거나 안되있을경우
		            		$("#OnoffList_contentRight_Content_table")
	  	                	.append(kid_image);
		            		saveOnoff_name = result.OnOffList[i].kid_system_code;
	            		}
	            		
	            		if((result.OnOffList[i].on_type == '-')&&
	            				(result.OnOffList[i].off_type == '-')){
	            			
	            			onOff_time = "<tr><td>"+result.OnOffList[i].today+"</td><td>"
	            			+result.OnOffList[i].on_type+"</td><td>결석</td><td>"+result.OnOffList[i].off_type+"</td><td>결석</td></tr>"
	            			
	            		}
	            		else{
	            			onOff_time = "<tr><td>"+result.OnOffList[i].today+"</td><td>"
	            			+result.OnOffList[i].on_type
	            			if(result.OnOffList[i].on_time != '도보'){
	            				onOff_time += "<td>차량</td>"
	            			}else{
	            				onOff_time += "<td>"+result.OnOffList[i].on_time+"</td>"
	            			}
	            			onOff_time += "<td>"+result.OnOffList[i].off_type+"</td>"
	            			
	            			if(result.OnOffList[i].off_time != '도보'){
	            				onOff_time += "<td>차량</td>"
	            			}else{
	            				onOff_time += "<td>"+result.OnOffList[i].off_time+"</td>"
	            			}
	            			
	            		}
	            		$("#OnoffList_contentRight_Content_table")
  	                	.append(onOff_time);
//		            		saveDownCheck = true;
	            	}
            },
            error:function(request,status,error){                 
         	   alert("code:"+request.status+"\n"+"error:"+error);
            }		  	              
        }); 

	}

	function OnoffList_Down() {	 

// 		if(saveDownCheck){
		if($("#OnoffList_date").val()!=""){		
			location.href = 'OnoffList_Down?class_id=' + encodeURIComponent(saveClass_id,'UTF-8')
			+'&startDate=' + encodeURIComponent(senStartDate,'UTF-8')
			+'&endDate=' + encodeURIComponent(senEndDate,'UTF-8');
		}
		else{
			$('#msgBox').removeClass("msgBox_Success");
          	$('#msgBox').addClass("msgBox_Error");
          	$('#msgBox').html("<span>1주일 단위로 다운로드 가능합니다. 날짜를 선택해주세요.</span>");
          	document.getElementById('msgBox').style.display="block";
			return false;
		}
		
	}
	</script>
</body>
</html>