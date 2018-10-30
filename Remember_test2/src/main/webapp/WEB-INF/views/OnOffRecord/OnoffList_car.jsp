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
      <jsp:param name="pageCategory" value="승하차이력"  />
      <jsp:param name="pageTitle" value="승하차 이력"  />
   </jsp:include>
	<div class="page">
		<div class="page-wrapper">
			<div class="pageTitle"><h2>승하차 일지</h2></div>
			
			<div class="pageContent">
				<div class="msgBox" id="msgBox"></div>
				<div class="medication_diaryList_Content">
					<div class="OnoffList_contentLeft">
						<table id="OnoffList_RouteList">
							<tr>
								<th><span>노선 리스트</span></th>
							</tr>
							<c:forEach var="routedto" items="${routeList}" varStatus="vs">
								<c:choose>
									<c:when test="${vs.index eq 0}">
										<tr class="active">
											<td onclick="routeClick('${routedto.route_id}','${routedto.route_type}',this)">
											<c:choose>
												<c:when test="${routedto.route_type eq '등원'}">
													<img class="routeList_img" src="images/button/button_goschool_O_30x18(x2).png">
													<div class="routeList_text">${routedto.route_name}</div>
												</c:when>												
												<c:otherwise>
													<img class="routeList_img" src="images/button/button_gohome_O_30x18(x2).png">
													<div class="routeList_text">${routedto.route_name}</div>
												</c:otherwise>
											</c:choose>											
											</td>		
										</tr>
									</c:when>
									
									<c:otherwise>
										<tr>
											<td onclick="routeClick('${routedto.route_id}','${routedto.route_type}',this)">
											<c:choose>
												<c:when test="${routedto.route_type eq '등원'}">
													<img class="routeList_img" src="images/button/button_goschool_O_30x18(x2).png">
													<div class="routeList_text">${routedto.route_name}</div>
												</c:when>												
												<c:otherwise>
													<img class="routeList_img" src="images/button/button_gohome_O_30x18(x2).png">
													<div class="routeList_text">${routedto.route_name}</div>
												</c:otherwise>
											</c:choose>	
											</td>		
										</tr>
									</c:otherwise>
								</c:choose>													
							</c:forEach>
						</table>
					</div>			
						
					<div class="OnoffList_contentRight">			
						<div class="OnoffList_date_div">
							<input type="text" id="OnoffList_date" name="OnoffList_date" class="OnoffList_date"/>
							<span>
								<img src="images/button/button_download_90x25.png" onclick="OnoffList_Down()" class="downImgBtn">
							</span>	
						</div>
						
						
						<div id = "OnoffList_contentRight_Content">
							<table id="OnoffList_contentRight_Content_table_title">
								<tr>
									<th width="140">원아</th><th width="58">상태</th><th width="194">정류장</th><th width="70">승·하차시간</th><th width="100">사유</th><th width="120">학부모 연락처</th>
								</tr>
							</table>
							<div class="OnoffList_contentRight_Content_table_Content">
								<table id = "OnoffList_contentRight_Content_table" class="OnoffList_contentRight_Content_table">
									<c:choose>
										<c:when test="${fn:length(onoffData) eq 0}">
											<tr><td>이력이 없습니다.</td></tr>
										</c:when>
										
										<c:otherwise>
											<c:set value="${route_type}" var="route_type_dto"/>
											<c:choose>
												<c:when test="${route_type_dto eq '등원'}">
													<%
														String savetoday = ""; //저장 날짜
														boolean boardCheck = false;
													%>	
														
													<c:set value="${centerList[0].center_name}" var="center_name"/>
													<c:forEach var="onoffdto" items="${onoffData}" varStatus="vs">	
													
													<c:choose>
														<c:when test="${(onoffdto.on_time eq '-') and (onoffdto.off_time eq '-')}"> <%-- 결석 --%>
														<c:forEach var="board_and_kidDto" items="${board_and_kidList}" varStatus="vs_1">
							
														<c:if test="${onoffdto.kid_system_code eq board_and_kidDto.kid_system_code}">
															<c:set value="${onoffdto.today}" var="today"/>											
																	<%
																		if(savetoday == ""){
																	%>
																		<tr class='OnoffList_onoff_date_filter'>
																		<td colspan='6' class='OnoffList_onoff_date'>${onoffdto.today}</td>
																		</tr>
																	<%		
																		}
																		else if(!(savetoday.equals(pageContext.getAttribute("today")))){								
																	%>
																		<tr class='OnoffList_onoff_date_filter'>
																			<td colspan='6' class='OnoffList_onoff_date'>${onoffdto.today}</td>
																		</tr>
																	<%		
																		}
																		savetoday = (String)pageContext.getAttribute("today");
																		boardCheck = true;
																	%>
																	<tr>
																	<c:choose>
																		<c:when test="${empty onoffdto.kid_pho}">
																			<td rowspan="2" width="140"><img width='50px' height='50px' class='OnoffList_kid_pho' 
																			src='http://13.125.170.255:8080/Spring/Default/image_ujacar_290x290.png'/><c:choose><c:when test="${empty onoffdto.kid_name or onoffdto.kid_name eq ''}">등록안됨</c:when><c:otherwise>${onoffdto.kid_name}</c:otherwise></c:choose></td>
																		</c:when>									
																		<c:otherwise>
																			<td rowspan="2" width="140"><img width='50px' height='50px' class='OnoffList_kid_pho' src="${onoffdto.kid_pho}"/>${onoffdto.kid_name}</td>
																		</c:otherwise>									
																	</c:choose>
							
																	<td style="border-bottom:1px solid #fff" width="58">탑승</td><td style="border-bottom:1px solid #fff" width="194">-</td>
																		<td style="border-bottom:1px solid #fff" width="70">${onoffdto.on_time}</td>										
																		<c:choose>
																			<c:when test="${empty onoffdto.late_date}">
																				<td rowspan="2" width="100">
																					결석 <br>이유: 사유없음
																				</td>
																			</c:when>
																			
																			<c:otherwise>
																				<td rowspan="2" width="100">
																					${onoffdto.late_abse_type} <br>이유: ${onoffdto.late_abse_cont}
																				</td>
																			</c:otherwise>
																		</c:choose>				
																	<td width="120" style="border-bottom:1px solid #fff">${onoffdto.par_name}</td>  	                																				
																	</tr>
																	<tr>
																	<td>하차</td><td>${center_name}</td>
																	<td>${onoffdto.off_time}</td><td>${onoffdto.par_phone}</td>
																	</tr>
																</c:if>
															</c:forEach>
															
															<%		
															if(!boardCheck){
															%>
																<tr><td>이력이 없습니다.</td></tr>
															<%
					        		    		  	          boardCheck = false;
					        		            			}	
															%>
						
														</c:when>
														
														<c:when test="${(onoffdto.on_time eq '-') and (onoffdto.off_time ne '-')}"> <%-- 지각 --%>
															<c:forEach var="board_and_kidDto" items="${board_and_kidList}" varStatus="vs_1">
														
																<c:if test="${onoffdto.kid_system_code eq board_and_kidDto.kid_system_code}">
																
																	<c:set value="${onoffdto.today}" var="today"/>	
																
																	<%
																		if(savetoday == ""){
																	%>
																		<tr class='OnoffList_onoff_date_filter'>
																		<td colspan='6' class='OnoffList_onoff_date'>${onoffdto.today}</td>
																		</tr>
																	<%		
																		}
																		else if(!(savetoday.equals(pageContext.getAttribute("today")))){								
																	%>
																		<tr class='OnoffList_onoff_date_filter'>
																			<td colspan='6' class='OnoffList_onoff_date'>${onoffdto.today}</td>
																		</tr>
																	<%		
																		}
																		savetoday = (String)pageContext.getAttribute("today");	
																		boardCheck = true;
																	%>
																	<tr>
																	<c:choose>
																		<c:when test="${empty onoffdto.kid_pho}">
																			<td rowspan="2" width="140"><img width='50px' height='50px' class='OnoffList_kid_pho' 
																			src='http://13.125.170.255:8080/Spring/Default/image_ujacar_290x290.png'/><c:choose><c:when test="${empty onoffdto.kid_name or onoffdto.kid_name eq ''}">등록안됨</c:when><c:otherwise>${onoffdto.kid_name}</c:otherwise></c:choose></td>
																		</c:when>									
																		<c:otherwise>
																			<td rowspan="2" width="140"><img width='50px' height='50px' class='OnoffList_kid_pho' src="${onoffdto.kid_pho}"/>${onoffdto.kid_name}</td>
																		</c:otherwise>									
																	</c:choose>
							
																	<td style="border-bottom:1px solid #fff" width="58">탑승</td><td style="border-bottom:1px solid #fff" width="194">-</td>
																		<td style="border-bottom:1px solid #fff"  width="70">${onoffdto.on_time}</td>										
																		<c:choose>
																			<c:when test="${empty onoffdto.late_date}">
																				<td rowspan="2"  width="100">
																				지각 <br>이유: 사유없음</td>
																			</c:when>
																			
																			<c:otherwise>
																				<td rowspan="2" width="100">
																				(${onoffdto.late_abse_type}) <br>이유: ${onoffdto.late_abse_cont}</td>
																			</c:otherwise>
																		</c:choose>				
																	<td width="120" style="border-bottom:1px solid #fff">${onoffdto.par_name}</td>  	                																				
																	</tr>
																	<tr>
																	<td>하차</td><td>${center_name}</td>
																	<td>${onoffdto.off_time}</td><td>${onoffdto.par_phone}</td>
																	</tr>
																</c:if>
															</c:forEach>
															<%		
															if(!boardCheck){
															%>
																<tr><td>이력이 없습니다.</td></tr>
															<%
					        		    		  	          boardCheck = false;
					        		            			}	
															%>	
														</c:when>
														
														<c:otherwise>
															<c:set value="${onoffdto.today}" var="today"/>	
															<%
																if(savetoday == ""){
															%>
																<tr class='OnoffList_onoff_date_filter'>
																<td colspan='6'class='OnoffList_onoff_date'>${onoffdto.today}</td>
																</tr>
															<%		
																}
																else if(!(savetoday.equals(pageContext.getAttribute("today")))){								
															%>
																<tr class='OnoffList_onoff_date_filter'>
																	<td colspan='6' class='OnoffList_onoff_date'>${onoffdto.today}</td>
																</tr>
															<%		
																}
																savetoday = (String)pageContext.getAttribute("today");								
															%>
															<tr>
															<c:choose>
																<c:when test="${empty onoffdto.kid_pho}">
																	<td rowspan="2" width="140"><img width='50px' height='50px' class='OnoffList_kid_pho' 
																	src='http://13.125.170.255:8080/Spring/Default/image_ujacar_290x290.png'/><c:choose><c:when test="${empty onoffdto.kid_name or onoffdto.kid_name eq ''}">등록안됨</c:when><c:otherwise>${onoffdto.kid_name}</c:otherwise></c:choose></td>
																</c:when>									
																<c:otherwise>
																	<td rowspan="2" width="140" ><img width='50px' height='50px' class='OnoffList_kid_pho' src="${onoffdto.kid_pho}"/>${onoffdto.kid_name}</td>
																</c:otherwise>									
															</c:choose>									
						
															<td style="border-bottom:1px solid #fff"  width="58">탑승</td><td style="border-bottom:1px solid #fff" width="194" >${onoffdto.station_name}</td>
															<td style="border-bottom:1px solid #fff" width="70" >${onoffdto.on_time}</td><td rowspan="2" width="100" >-</td><td  width="120" style="border-bottom:1px solid #fff">${onoffdto.par_name}</td>		
															</tr>
															<tr>							
															<td>하차</td><td>${center_name}</td>
															<td>${onoffdto.off_time}</td><td>${onoffdto.par_phone}</td>
															</tr>
														</c:otherwise>
													</c:choose>	
													</c:forEach>
												</c:when>
												
												<c:otherwise><%-- 하원일때 --%>
													<%
														String savetoday = ""; //저장 날짜
														boolean boardCheck = false;
													%>	
			<!-- 										<tr><th>원아</th><th>상태</th><th>정류장</th><th>승·하차시간</th><th>사유</th><th>학부모 연락처</th></tr>	 -->
													<c:set value="${centerList[0].center_name}" var="center_name"/>
													<c:forEach var="onoffdto" items="${onoffData}" varStatus="vs">	
													
													<c:choose>
														<c:when test="${(onoffdto.on_time eq '-') and (onoffdto.off_time eq '-')}"> <%-- 결석 --%>
														<c:forEach var="board_and_kidDto" items="${board_and_kidList}" varStatus="vs_1">
							
														<c:if test="${onoffdto.kid_system_code eq board_and_kidDto.kid_system_code}">
															<c:set value="${onoffdto.today}" var="today"/>											
																	<%
																		if(savetoday == ""){
																	%>
																		<tr class='OnoffList_onoff_date_filter'>
																		<td colspan='6' class='OnoffList_onoff_date'>${onoffdto.today}</td>
																		</tr>
																	<%		
																		}
																		else if(!(savetoday.equals(pageContext.getAttribute("today")))){								
																	%>
																		<tr class='OnoffList_onoff_date_filter'>
																			<td colspan='6' class='OnoffList_onoff_date'>${onoffdto.today}</td>
																		</tr>
																	<%		
																		}
																		savetoday = (String)pageContext.getAttribute("today");	
																		boardCheck = true;
																	%>
																	<tr>
																	<c:choose>
																		<c:when test="${empty onoffdto.kid_pho}">
																			<td rowspan="2" width="140"><img width='50px' height='50px' class='OnoffList_kid_pho' 
																			src='http://13.125.170.255:8080/Spring/Default/image_ujacar_290x290.png'/><c:choose><c:when test="${empty onoffdto.kid_name or onoffdto.kid_name eq ''}">등록안됨</c:when><c:otherwise>${onoffdto.kid_name}</c:otherwise></c:choose></td>
																		</c:when>									
																		<c:otherwise>
																			<td rowspan="2" width="140" ><img width='50px' height='50px' class='OnoffList_kid_pho' src="${onoffdto.kid_pho}"/>${onoffdto.kid_name}</td>
																		</c:otherwise>									
																	</c:choose>
							
																	<td style="border-bottom:1px solid #fff" width="58" >탑승</td><td  width="194" style="border-bottom:1px solid #fff">${center_name}</td>
																		<td  width="70" style="border-bottom:1px solid #fff">${onoffdto.on_time}</td>										
																		<c:choose>
																			<c:when test="${empty onoffdto.late_date}">
																				<td rowspan="2" width="100" >
																					결석 <br>이유: 사유없음
																				</td>
																			</c:when>
																			
																			<c:otherwise>
																				<td rowspan="2" width="100" >
																					(${onoffdto.late_abse_type}) <br>이유: ${onoffdto.late_abse_cont}
																				</td>
																			</c:otherwise>
																		</c:choose>				
																	<td width="120" style="border-bottom:1px solid #fff">${onoffdto.par_name}</td>  	                																				
																	</tr>
																	<tr>
																	<td>하차</td><td>-</td>
																	<td>${onoffdto.off_time}</td><td>${onoffdto.par_phone}</td>
																	</tr>
																</c:if>
															</c:forEach>
															<%		
															if(!boardCheck){
															%>
																<tr><td>이력이 없습니다.</td></tr>
															<%
					        		    		  	          boardCheck = false;
					        		            			}	
															%>							
														</c:when>
														
														<c:when test="${(onoffdto.on_time ne '-') and (onoffdto.off_time eq '-')}"> <%-- 도보 --%>
															<c:forEach var="board_and_kidDto" items="${board_and_kidList}" varStatus="vs_1">
							
																<c:if test="${onoffdto.kid_system_code eq board_and_kidDto.kid_system_code}">
																
																	<c:set value="${onoffdto.today}" var="today"/>	
																
																	<%
																		if(savetoday == ""){
																	%>
																		<tr class='OnoffList_onoff_date_filter'>
																		<td colspan='6' class='OnoffList_onoff_date'>${onoffdto.today}</td>
																		</tr>
																	<%		
																		}
																		else if(!(savetoday.equals(pageContext.getAttribute("today")))){								
																	%>
																		<tr class='OnoffList_onoff_date_filter'>
																			<td colspan='6' class='OnoffList_onoff_date'>${onoffdto.today}</td>
																		</tr>
																	<%		
																		}
																		savetoday = (String)pageContext.getAttribute("today");
																		 boardCheck = true;
																	%>
																	<tr>
																	<c:choose>
																		<c:when test="${empty onoffdto.kid_pho}">
																			<td rowspan="2" width="140"><img width='50px' height='50px' class='OnoffList_kid_pho' 
																			src='http://13.125.170.255:8080/Spring/Default/image_ujacar_290x290.png'/><c:choose><c:when test="${empty onoffdto.kid_name or onoffdto.kid_name eq ''}">등록안됨</c:when><c:otherwise>${onoffdto.kid_name}</c:otherwise></c:choose></td>
																		</c:when>									
																		<c:otherwise>
																			<td rowspan="2" width="140" ><img width='50px' height='50px' class='OnoffList_kid_pho' src="${onoffdto.kid_pho}"/>${onoffdto.kid_name}</td>
																		</c:otherwise>									
																	</c:choose>
							
																	<td style="border-bottom:1px solid #fff" width="58" >탑승</td><td width="194" style="border-bottom:1px solid #fff">${center_name}</td>
																	<td style="border-bottom:1px solid #fff" width="70" >${onoffdto.on_time}</td>										
																
																	<td rowspan="2" width="100" >
																	도보 
																	</td>
																			
																	<td width="120" style="border-bottom:1px solid #fff">${onoffdto.par_name}</td>  	                																				
																	</tr>
																	<tr>
																	<td>하차</td><td>-</td>
																	<td>${onoffdto.off_time}</td><td>${onoffdto.par_phone}</td>
																	</tr>
																</c:if>
															</c:forEach>
															<%		
															if(!boardCheck){
															%>
																<tr><td>이력이 없습니다.</td></tr>
															<%
					        		    		  	          boardCheck = false;
					        		            			}	
															%>	
														</c:when>
														
														<c:otherwise>
															<c:set value="${onoffdto.today}" var="today"/>	
															<%
																if(savetoday == ""){
															%>
																<tr class='OnoffList_onoff_date_filter'>
																<td colspan='6' class='OnoffList_onoff_date'>${onoffdto.today}</td>
																</tr>
															<%		
																}
																else if(!(savetoday.equals(pageContext.getAttribute("today")))){								
															%>
																<tr class='OnoffList_onoff_date_filter'>
																	<td colspan='6' class='OnoffList_onoff_date'>${onoffdto.today}</td>
																</tr>
															<%		
																}
																savetoday = (String)pageContext.getAttribute("today");								
															%>
															<tr>
															<c:choose>
																<c:when test="${empty onoffdto.kid_pho}">
																	<td rowspan="2" width="140"><img width='50px' height='50px' class='OnoffList_kid_pho' 
																	src='http://13.125.170.255:8080/Spring/Default/image_ujacar_290x290.png'/><c:choose><c:when test="${empty onoffdto.kid_name or onoffdto.kid_name eq ''}">등록안됨</c:when><c:otherwise>${onoffdto.kid_name}</c:otherwise></c:choose></td>
																</c:when>									
																<c:otherwise>
																	<td rowspan="2" width="140" ><img width='50px' height='50px' class='OnoffList_kid_pho' src="${onoffdto.kid_pho}"/>${onoffdto.kid_name}</td>
																</c:otherwise>									
															</c:choose>									
						
															<td style="border-bottom:1px solid #fff" width="58" >탑승</td><td width="194" style="border-bottom:1px solid #fff">${center_name}</td>
															<td style="border-bottom:1px solid #fff" width="70" >${onoffdto.on_time}</td><td rowspan="2" width="100" >-</td><td  width="120" style="border-bottom:1px solid #fff">${onoffdto.par_name}</td>		
															</tr>
															<tr>							
															<td>하차</td><td>${onoffdto.station_name}</td>
															<td>${onoffdto.off_time}</td><td>${onoffdto.par_phone}</td>
															</tr>
														</c:otherwise>
													</c:choose>	
													</c:forEach>
												</c:otherwise>
											</c:choose>
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
	var saveRoute_id="${routeList[0].route_id}";
	var saveRoute_type="${route_type}";
	
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
    
 
    
    var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
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
	            
	        	if(saveRoute_id!=null && $( "#OnoffList_date" ).val()!=""){	
	        		dateFormat = inst.settings.dateFormat || $.datepicker._defaults.dateFormat;
	        		var saveOnoff_date=null;
	        		$.ajax({  
	                    url : 'OnoffList_car_updateTable',
	                    dataType : 'json',
	                    type:'POST',
	                    beforeSend: function(xhr) {
	         	              xhr.setRequestHeader(header, token);
	         	           },
	                    data : {"route_id" : saveRoute_id,
			            		 "route_type" : saveRoute_type,
			            		 "startDate" : $.datepicker.formatDate( dateFormat, startDate, inst.settings ),
			            		 "endDate" : $.datepicker.formatDate( dateFormat, endDate, inst.settings )
	                  		},              
	                    success: function(result) {   	 	       
	        	            	var size_onoffData = result.onoffData; 
	        	            	var size_board_and_kidData = result.board_and_kidList; 
	        	            	
	        	            	if(size_onoffData.length==0){
	        	            		console.log(size_onoffData.length);
	        	            		console.log(size_onoffData.length==0);
	        	            		$('#msgBox').removeClass("msgBox_Success");
	        		            	$('#msgBox').removeClass("msgBox_Error");			  	             
	        	  	             	document.getElementById('msgBox').style.display="none";
	        	  	             	$("#OnoffList_contentRight_Content_table").empty();	   
	        		  	          	$("#OnoffList_contentRight_Content_table")
	          	                	.append("<tr><td>이력이 없습니다.</td></tr>");
//	        	  	            		$("#OnoffList_date").val(null);
//	        	  	            		saveDownCheck=false;
	          	            		return false;
	        	  	            }
	        	            	$('#msgBox').removeClass("msgBox_Success");
	        	            	$('#msgBox').removeClass("msgBox_Error");			  	             
	          	             	document.getElementById('msgBox').style.display="none";
	        	            	
	        	            	var kid_image = null;
	                    		var on_time = null;
	                    		var off_time = null;	
// 	        					var boardcheck = false;
	        					
	                    		$("#OnoffList_contentRight_Content_table").empty();	    
//	        		            	$("#OnoffList_contentRight_Content_table")
//	        	                	.append("<tr><th>원아</th><th>상태</th><th>정류장</th><th>승·하차시간</th><th>사유</th><th>학부모 연락처</th></tr>");
	        	            	if(result.route_type == '등원'){				            		
	        	            		for(var i=0; i < size_onoffData.length; i++){
	        	            			kid_image = null;
	        		            		on_time = null;
	        		            		off_time = null;
	        							
	        		            		if((result.onoffData[i].on_time == '-')&&
	        		            				(result.onoffData[i].off_time == '-')){
	        		            			for(var j=0; j<size_board_and_kidData.length; j++){	
	        		            				if(result.onoffData[i].kid_system_code ==
	        		            					result.board_and_kidList[j].kid_system_code){
//	        			            					console.log(saveOnoff_date + "dd" + result.onoffData[i].today +"ss" + i );
	        		            					if(saveOnoff_date==null||saveOnoff_date!=result.onoffData[i].today){
	        					            			$("#OnoffList_contentRight_Content_table")
	        					  	                	.append("<tr class='OnoffList_onoff_date_filter'><td colspan='6' class='OnoffList_onoff_date'>"+result.onoffData[i].today+"</td></tr>");
	        					            			saveOnoff_date = result.onoffData[i].today;
	        					            		}
	        		            					
	        		            					if(result.onoffData[i].kid_pho == null){
	        		            						if((result.onoffData[i].kid_name=="null")||(result.onoffData[i].kid_name==null)||(result.onoffData[i].kid_name=='')){
	        		            							kid_image = "<tr><td rowspan=\"2\" width=\"140\" ><img width='50px' height='50px' class='OnoffList_kid_pho' src='http://13.125.170.255:8080/Spring/Default/image_ujacar_290x290.png'/>등록안됨</td>"; 
	        		            						}
	        		            						else{
	        		            							kid_image = "<tr><td rowspan=\"2\" width=\"140\" ><img width='50px' height='50px' class='OnoffList_kid_pho' src='http://13.125.170.255:8080/Spring/Default/image_ujacar_290x290.png'/>"
	        					  	                			+result.onoffData[i].kid_name+"</td>"; 	
	        		            						}								            			   			
	        					       			
	        					            		}else{
	        					            			kid_image = "<tr><td rowspan=\"2\" width=\"140\"><img width='50px' height='50px' class='OnoffList_kid_pho' src='"+result.onoffData[i].kid_pho
	        			  	                			+"'/>"+result.onoffData[i].kid_name
	        			  	                			+"</td>";
	        					            		}//프사가 등록되있거나 안되있을경우
	        					            		
	        		            					if(result.onoffData[i].late_date == null){
	        				            				on_time = "<td  width=\"58\" style='border-bottom:1px solid #fff'>탑승</td><td width=\"194\" style='border-bottom:1px solid #fff'>-</td><td width=\"70\" style='border-bottom:1px solid #fff'>"
	        						            			+result.onoffData[i].on_time+"</td><td rowspan=\"2\" width=\"100\">결석 <br>이유: 사유없음</td><td width=\"120\" style='border-bottom:1px solid #fff'>"+result.onoffData[i].par_name+"</td></tr>"
	        				            			}
	        				            			else{
	        				            				on_time = "<td width=\"58\" style='border-bottom:1px solid #fff'>탑승</td><td width=\"194\" style='border-bottom:1px solid #fff'>-</td><td width=\"70\" style='border-bottom:1px solid #fff'>"
	        						            			+result.onoffData[i].on_time+"</td><td rowspan=\"2\" width=\"100\">("
	        						            					+result.onoffData[i].late_abse_type+") <br>이유: "+result.onoffData[i].late_abse_cont+"</td><td width=\"120\" style='border-bottom:1px solid #fff'>"+result.onoffData[i].par_name+"</td></tr>"
	        				            			}//결석 사유가 있을경우							            			
	        		            					off_time = "<tr><td>하차</td><td>"+result.centerList[0].center_name+"</td><td>"+result.onoffData[i].off_time+"</td><td>"
	        				            			+result.onoffData[i].par_phone+"</td></tr>"
	        				            			
	        				            			$("#OnoffList_contentRight_Content_table")
	        				  	                	.append(kid_image + on_time + off_time);
// 	        						            	boardcheck = true;
	        		            				}
	        		            			}
// 	        		            			if(!boardcheck){
// 	        		            				$("#OnoffList_contentRight_Content_table").empty();	   
// 	        		    		  	          	$("#OnoffList_contentRight_Content_table")
// 	        		      	                	.append("<tr><td>이력이 없습니다.</td></tr>");
// 	        		    		  	          boardcheck = false;
// 	        		            			}
	        		            		}//결석
	        		            		else if((result.onoffData[i].on_time == '-')&&
	        		            				(result.onoffData[i].off_time != '-')){
	        		            			for(var j=0; j<size_board_and_kidData.length; j++){
	        		            				if(result.onoffData[i].kid_system_code ==
	        		            					result.board_and_kidList[j].kid_system_code){
	        		            					
	        		            					if(saveOnoff_date==null||saveOnoff_date!=result.onoffData[i].today){
	        					            			$("#OnoffList_contentRight_Content_table")
	        					  	                	.append("<tr class='OnoffList_onoff_date_filter'><td colspan='6' class='OnoffList_onoff_date'>"+result.onoffData[i].today+"</td></tr>");
	        					            			saveOnoff_date = result.onoffData[i].today;
	        					            		}
	        		            					
	        		            					if(result.onoffData[i].kid_pho == null){
	        		            						if((result.onoffData[i].kid_name=="null")||(result.onoffData[i].kid_name==null)||(result.onoffData[i].kid_name=='')){
	        		            							kid_image = "<tr><td rowspan=\"2\" width=\"140\" ><img width='50px' height='50px' class='OnoffList_kid_pho' src='http://13.125.170.255:8080/Spring/Default/image_ujacar_290x290.png'/>등록안됨</td>"; 
	        		            						}
	        		            						else{
	        		            							kid_image = "<tr><td rowspan=\"2\" width=\"140\" ><img width='50px' height='50px' class='OnoffList_kid_pho' src='http://13.125.170.255:8080/Spring/Default/image_ujacar_290x290.png'/>"
	        					  	                			+result.onoffData[i].kid_name+"</td>"; 	
	        		            						}						            			   				
	        					            		}else{
	        					            			kid_image = "<tr><td rowspan=\"2\" width=\"140\"><img width='50px' height='50px' class='OnoffList_kid_pho' src='"+result.onoffData[i].kid_pho
	        			  	                			+"'/>"+result.onoffData[i].kid_name
	        			  	                			+"</td>";
	        					            		}//프사가 등록되있거나 안되있을경우
	        					            		
	        		            					if(result.onoffData[i].late_date == null){
	        				            				on_time = "<td width=\"58\" style='border-bottom:1px solid #fff'>탑승</td><td width=\"194\" style='border-bottom:1px solid #fff'>-</td><td  width=\"70\" style='border-bottom:1px solid #fff'>"
	        						            			+result.onoffData[i].on_time+"</td><td width=\"100\" rowspan=\"2\">지각 <br>이유: 사유없음</td><td width=\"120\" style='border-bottom:1px solid #fff'>"+result.onoffData[i].par_name+"</td></tr>"
	        				            			}
	        				            			else{
	        				            				on_time = "<td width=\"58\" style='border-bottom:1px solid #fff'>탑승</td><td width=\"194\" style='border-bottom:1px solid #fff'>-</td><td width=\"70\" style='border-bottom:1px solid #fff'>"
	        						            			+result.onoffData[i].on_time+"</td><td width=\"100\" rowspan=\"2\">("
	        						            					+result.onoffData[i].late_abse_type+") <br>이유: "+result.onoffData[i].late_abse_cont+"</td><td width=\"120\" style='border-bottom:1px solid #fff'>"+result.onoffData[i].par_name+"</td></tr>"
	        				            			}//지각 사유가 있을경우							            			
	        		            					off_time = "<tr><td>하차</td><td>"+result.centerList[0].center_name+"</td><td>"+result.onoffData[i].off_time+"</td><td>"
	        				            			+result.onoffData[i].par_phone+"</td></tr>"
	        				            			
	        				            			$("#OnoffList_contentRight_Content_table")
	        				  	                	.append(kid_image + on_time + off_time);
// 	        		            					boardcheck = true;
	        		            				}
	        		            			}
// 	        		            			if(!boardcheck){
// 	        		            				$("#OnoffList_contentRight_Content_table").empty();	   
// 	        		    		  	          	$("#OnoffList_contentRight_Content_table")
// 	        		      	                	.append("<tr><td>이력이 없습니다.</td></tr>");
// 	        		    		  	          boardcheck = false;
// 	        		            			}
	        		            		}//지각
	        		            		else{
	                    					if(saveOnoff_date==null||saveOnoff_date!=result.onoffData[i].today){
	        			            			$("#OnoffList_contentRight_Content_table")
	        			  	                	.append("<tr class='OnoffList_onoff_date_filter'><td colspan='6' class='OnoffList_onoff_date'>"+result.onoffData[i].today+"</td></tr>");
	        			            			saveOnoff_date = result.onoffData[i].today;
	        			            		}
	                    					
	                    					if(result.onoffData[i].kid_pho == null){
	                    						if((result.onoffData[i].kid_name=="null")||(result.onoffData[i].kid_name==null)||(result.onoffData[i].kid_name=='')){
	                    							kid_image = "<tr><td rowspan=\"2\" width=\"140\" ><img width='50px' height='50px' class='OnoffList_kid_pho' src='http://13.125.170.255:8080/Spring/Default/image_ujacar_290x290.png'/>등록안됨</td>"; 
	                    						}
	                    						else{
	                    							kid_image = "<tr><td rowspan=\"2\" width=\"140\" ><img width='50px' height='50px' class='OnoffList_kid_pho' src='http://13.125.170.255:8080/Spring/Default/image_ujacar_290x290.png'/>"
	        			  	                			+result.onoffData[i].kid_name+"</td>"; 	
	                    						}    			
	        			       			
	        			            		}else{
	        			            			kid_image = "<tr><td rowspan=\"2\"><img width='50px' height='50px' class='OnoffList_kid_pho' src='"+result.onoffData[i].kid_pho
	        	  	                			+"'/>"+result.onoffData[i].kid_name
	        	  	                			+"</td>";
	        			            		}//프사가 등록되있거나 안되있을경우
	        			            		
	        	            				on_time = "<td width=\"58\" style='border-bottom:1px solid #fff'>탑승</td><td width=\"194\" style='border-bottom:1px solid #fff'>"+result.onoffData[i].station_name+"</td><td style='border-bottom:1px solid #fff' width=\"70\">"
	        			            			+result.onoffData[i].on_time+"</td><td  width=\"100\" rowspan=\"2\">-</td><td width=\"120\" style='border-bottom:1px solid #fff'>"+result.onoffData[i].par_name+"</td></tr>"
	        		            									            			
	                    					off_time = "<tr><td>하차</td><td>"+result.centerList[0].center_name+"</td><td>"+result.onoffData[i].off_time+"</td><td>"
	        		            			+result.onoffData[i].par_phone+"</td></tr>"
	        		            			
	        		            			$("#OnoffList_contentRight_Content_table")
	        		  	                	.append(kid_image + on_time + off_time);
//	        				            		saveDownCheck = true;
	        		            		}//정상					            		
	        	            		}
	        	            	}//등원
	        	            	else{
	        	            		for(var i=0; i < size_onoffData.length; i ++){
	        	            			kid_image = null;
	        		            		on_time = null;
	        		            		off_time = null;
	        		            		
	        		            		if((result.onoffData[i].on_time == '-')&&
	        		            				(result.onoffData[i].off_time == '-')){
	        		            			for(var j=0; j<size_board_and_kidData.length; j++){					            				
	        		            				if(result.onoffData[i].kid_system_code ==
	        		            					result.board_and_kidList[j].kid_system_code){
	        		            					
	        		            					if(saveOnoff_date==null||saveOnoff_date!=result.onoffData[i].today){
	        					            			$("#OnoffList_contentRight_Content_table")
	        					  	                	.append("<tr class='OnoffList_onoff_date_filter'><td colspan='6' class='OnoffList_onoff_date'>"+result.onoffData[i].today+"</td></tr>");
	        					            			saveOnoff_date = result.onoffData[i].today;
	        					            		}
	        		            					
	        		            					if(result.onoffData[i].kid_pho == null){
	        		            						if((result.onoffData[i].kid_name=="null")||(result.onoffData[i].kid_name==null)||(result.onoffData[i].kid_name=='')){
	        		            							kid_image = "<tr><td rowspan=\"2\" width=\"140\" ><img width='50px' height='50px' class='OnoffList_kid_pho' src='http://13.125.170.255:8080/Spring/Default/image_ujacar_290x290.png'/>등록안됨</td>"; 
	        		            						}
	        		            						else{
	        		            							kid_image = "<tr><td rowspan=\"2\" width=\"140\" ><img width='50px' height='50px' class='OnoffList_kid_pho' src='http://13.125.170.255:8080/Spring/Default/image_ujacar_290x290.png'/>"
	        					  	                			+result.onoffData[i].kid_name+"</td>"; 	
	        		            						}	   			
	        					       			
	        					            		}else{
	        					            			kid_image = "<tr><td rowspan=\"2\" width=\"140\"><img width='50px' height='50px' class='OnoffList_kid_pho' src='"+result.onoffData[i].kid_pho
	        			  	                			+"'/>"+result.onoffData[i].kid_name
	        			  	                			+"</td>";
	        					            		}//프사가 등록되있거나 안되있을경우
	        					            		
	        		            					if(result.onoffData[i].late_date == null){
	        				            				on_time = "<td width=\"58\" style='border-bottom:1px solid #fff'>탑승</td><td width=\"194\" style='border-bottom:1px solid #fff'>"+result.centerList[0].center_name+"</td><td width=\"70\" style='border-bottom:1px solid #fff'>"
	        						            			+result.onoffData[i].on_time+"</td><td width=\"100\" rowspan=\"2\">결석 <br>이유: 사유없음</td><td width=\"120\" style='border-bottom:1px solid #fff'>"+result.onoffData[i].par_name+"</td></tr>"
	        				            			}
	        				            			else{
	        				            				on_time = "<td width=\"58\" style='border-bottom:1px solid #fff'>탑승</td><td width=\"194\" style='border-bottom:1px solid #fff'>"+result.centerList[0].center_name+"</td><td width=\"70\" style='border-bottom:1px solid #fff'>"
	        						            			+result.onoffData[i].on_time+"</td><td width=\"100\" rowspan=\"2\">("
	        						            					+result.onoffData[i].late_abse_type+") <br>이유: "+result.onoffData[i].late_abse_cont+"</td><td width=\"120\" style='border-bottom:1px solid #fff'>"+result.onoffData[i].par_name+"</td></tr>"
	        				            			}//결석 사유가 있을경우							            			
	        		            					off_time = "<tr><td>하차</td><td>-</td><td>"+result.onoffData[i].off_time+"</td><td>"
	        				            			+result.onoffData[i].par_phone+"</td></tr>"
	        				            			
	        				            			$("#OnoffList_contentRight_Content_table")
	        				  	                	.append(kid_image + on_time + off_time);
// 	        		            					 boardcheck = true;
	        		            				}
	        		            			}
// 	        		            			if(!boardcheck){
// 	        		            				$("#OnoffList_contentRight_Content_table").empty();	   
// 	        		    		  	          	$("#OnoffList_contentRight_Content_table")
// 	        		      	                	.append("<tr><td>이력이 없습니다.</td></tr>");
// 	        		    		  	          boardcheck = false;
// 	        		            			}
	        		            		}//결석
	        		            		else if((result.onoffData[i].on_time != '-')&&
	        		            				(result.onoffData[i].off_time == '-')){
	        		            			for(var j=0; j<size_board_and_kidData.length; j++){
	        		            				if(result.onoffData[i].kid_system_code ==
	        		            					result.board_and_kidList[j].kid_system_code){
	        		            					
	        		            					if(saveOnoff_date==null||saveOnoff_date!=result.onoffData[i].today){
	        					            			$("#OnoffList_contentRight_Content_table")
	        					  	                	.append("<tr class='OnoffList_onoff_date_filter'><td colspan='6' class='OnoffList_onoff_date'>"+result.onoffData[i].today+"</td></tr>");
	        					            			saveOnoff_date = result.onoffData[i].today;
	        					            		}
	        		            					
	        		            					if(result.onoffData[i].kid_pho == null){
	        		            						if((result.onoffData[i].kid_name=="null")||(result.onoffData[i].kid_name==null)||(result.onoffData[i].kid_name=='')){
	        		            							kid_image = "<tr><td rowspan=\"2\" width=\"140\" ><img width='50px' height='50px' class='OnoffList_kid_pho' src='http://13.125.170.255:8080/Spring/Default/image_ujacar_290x290.png'/>등록안됨</td>"; 
	        		            						}
	        		            						else{
	        		            							kid_image = "<tr><td rowspan=\"2\" width=\"140\" ><img width='50px' height='50px' class='OnoffList_kid_pho' src='http://13.125.170.255:8080/Spring/Default/image_ujacar_290x290.png'/>"
	        					  	                			+result.onoffData[i].kid_name+"</td>"; 	
	        		            						}	   			
	        					       			
	        					            		}else{
	        					            			kid_image = "<tr><td rowspan=\"2\" width=\"140\"><img width='50px' height='50px' class='OnoffList_kid_pho' src='"+result.onoffData[i].kid_pho
	        			  	                			+"'/>"+result.onoffData[i].kid_name
	        			  	                			+"</td>";
	        					            		}//프사가 등록되있거나 안되있을경우
	        					            		
	        		            					
	        			            				on_time = "<td style='border-bottom:1px solid #fff' width=\"58\">탑승</td><td width=\"194\" style='border-bottom:1px solid #fff'>"+result.centerList[0].center_name+"</td><td width=\"70\" style='border-bottom:1px solid #fff'>"
	        					            			+result.onoffData[i].on_time+"</td><td width=\"100\" rowspan=\"2\">도보</td><td width=\"120\" style='border-bottom:1px solid #fff'>"+result.onoffData[i].par_name+"</td></tr>"
	        				            			
	        			            			
	        		            					off_time = "<tr><td>하차</td><td>-</td><td>"+result.onoffData[i].off_time+"</td><td>"
	        				            			+result.onoffData[i].par_phone+"</td></tr>"
	        				            			
	        				            			$("#OnoffList_contentRight_Content_table")
	        				  	                	.append(kid_image + on_time + off_time);
// 	        				    		  	          boardcheck = true;
	        		            				}
	        		            			}
// 	        		            			if(!boardcheck){
// 	        		            				$("#OnoffList_contentRight_Content_table").empty();	   
// 	        		    		  	          	$("#OnoffList_contentRight_Content_table")
// 	        		      	                	.append("<tr><td>이력이 없습니다.</td></tr>");
// 	        		    		  	          boardcheck = false;
// 	        		            			}
	        		            		}//도보
	        		            		else{
	                    					if(saveOnoff_date==null||saveOnoff_date!=result.onoffData[i].today){
	        			            			$("#OnoffList_contentRight_Content_table")
	        			  	                	.append("<tr class='OnoffList_onoff_date_filter'><td colspan='6' class='OnoffList_onoff_date'>"+result.onoffData[i].today+"</td></tr>");
	        			            			saveOnoff_date = result.onoffData[i].today;
	        			            		}
	                    					
	                    					if(result.onoffData[i].kid_pho == null){
	                    						if((result.onoffData[i].kid_name=="null")||(result.onoffData[i].kid_name==null)||(result.onoffData[i].kid_name=='')){
	                    							kid_image = "<tr><td rowspan=\"2\" width=\"140\" ><img width='50px' height='50px' class='OnoffList_kid_pho' src='http://13.125.170.255:8080/Spring/Default/image_ujacar_290x290.png'/>등록안됨</td>"; 
	                    						}
	                    						else{
	                    							kid_image = "<tr><td rowspan=\"2\" width=\"140\" ><img width='50px' height='50px' class='OnoffList_kid_pho' src='http://13.125.170.255:8080/Spring/Default/image_ujacar_290x290.png'/>"
	        			  	                			+result.onoffData[i].kid_name+"</td>"; 	
	                    						}	 			
	        			       			
	        			            		}else{
	        			            			kid_image = "<tr><td rowspan=\"2\" width=\"140\"><img width='50px' height='50px' class='OnoffList_kid_pho' src='"+result.onoffData[i].kid_pho
	        	  	                			+"'/>"+result.onoffData[i].kid_name
	        	  	                			+"</td>";
	        			            		}//프사가 등록되있거나 안되있을경우
	        			            		
	        	            				on_time = "<td style='border-bottom:1px solid #fff' width=\"58\">탑승</td><td width=\"194\" style='border-bottom:1px solid #fff'>"+result.centerList[0].center_name+"</td><td width=\"70\" style='border-bottom:1px solid #fff'>"
	        			            			+result.onoffData[i].on_time+"</td><td rowspan=\"2\" width=\"100\">-</td><td width=\"120\" style='border-bottom:1px solid #fff'>"+result.onoffData[i].par_name+"</td></tr>"
	        			            					            			
	                    					off_time = "<tr><td>하차</td><td>"+result.onoffData[i].station_name+"</td><td>"+result.onoffData[i].off_time+"</td><td>"
	        		            			+result.onoffData[i].par_phone+"</td></tr>"
	        		            			
	        		            			$("#OnoffList_contentRight_Content_table")
	        		  	                	.append(kid_image + on_time + off_time);
	        			            		
	        		            		}//정상					            		
	        	            		}
	        	            	}//하원
	                    },
	                    error:function(request,status,error){                 
	                 	   alert("code:"+request.status+"\n"+"error:"+error);
	                    }		  	              
	                });    			        	
				}
				else{					
					if(saveRoute_id==null){
						$('#msgBox').removeClass("msgBox_Success");
	  	            	$('#msgBox').addClass("msgBox_Error");
	  	            	$('#msgBox').html("<span>노선부터 클릭해주세요.</span>");
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

	
	function routeClick(route_id,route_type,thisObj){
		saveRoute_id = route_id;
		saveRoute_type = route_type;
		var tr = $(thisObj).parent();
	    var td = tr.children();

	    $("#OnoffList_RouteList tr").removeClass("active"); 
		tr.addClass("active");

		var saveOnoff_date=null;
		$.ajax({  
            url : 'OnoffList_car_updateTable',
            dataType : 'json',
            type:'POST',
            beforeSend: function(xhr) {
 	              xhr.setRequestHeader(header, token);
 	           },
            data : { 	"route_id" : saveRoute_id,
			           	 "route_type" : saveRoute_type,
			        	 "startDate" : senStartDate,
			        	 "endDate" : senEndDate
          		},              
            success: function(result) {   	 	       
	            	var size_onoffData = result.onoffData; 
	            	var size_board_and_kidData = result.board_and_kidList; 
	            	
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
            		var on_time = null;
            		var off_time = null;	
// 					var boardcheck = false;
					
            		$("#OnoffList_contentRight_Content_table").empty();	    
//		            	$("#OnoffList_contentRight_Content_table")
//	                	.append("<tr><th>원아</th><th>상태</th><th>정류장</th><th>승·하차시간</th><th>사유</th><th>학부모 연락처</th></tr>");
	            	if(result.route_type == '등원'){				            		
	            		for(var i=0; i < size_onoffData.length; i++){
	            			kid_image = null;
		            		on_time = null;
		            		off_time = null;
							
		            		if((result.onoffData[i].on_time == '-')&&
		            				(result.onoffData[i].off_time == '-')){
		            			for(var j=0; j<size_board_and_kidData.length; j++){	
		            				if(result.onoffData[i].kid_system_code ==
		            					result.board_and_kidList[j].kid_system_code){
//			            					console.log(saveOnoff_date + "dd" + result.onoffData[i].today +"ss" + i );
		            					if(saveOnoff_date==null||saveOnoff_date!=result.onoffData[i].today){
					            			$("#OnoffList_contentRight_Content_table")
					  	                	.append("<tr class='OnoffList_onoff_date_filter'><td colspan='6' class='OnoffList_onoff_date'>"+result.onoffData[i].today+"</td></tr>");
					            			saveOnoff_date = result.onoffData[i].today;
					            		}
		            					
		            					if(result.onoffData[i].kid_pho == null){
		            						if((result.onoffData[i].kid_name=="null")||(result.onoffData[i].kid_name==null)||(result.onoffData[i].kid_name=='')){
		            							kid_image = "<tr><td rowspan=\"2\" width=\"140\" ><img width='50px' height='50px' class='OnoffList_kid_pho' src='http://13.125.170.255:8080/Spring/Default/image_ujacar_290x290.png'/>등록안됨</td>"; 
		            						}
		            						else{
		            							kid_image = "<tr><td rowspan=\"2\" width=\"140\" ><img width='50px' height='50px' class='OnoffList_kid_pho' src='http://13.125.170.255:8080/Spring/Default/image_ujacar_290x290.png'/>"
					  	                			+result.onoffData[i].kid_name+"</td>"; 	
		            						}								            			   			
					       			
					            		}else{
					            			kid_image = "<tr><td rowspan=\"2\" width=\"140\"><img width='50px' height='50px' class='OnoffList_kid_pho' src='"+result.onoffData[i].kid_pho
			  	                			+"'/>"+result.onoffData[i].kid_name
			  	                			+"</td>";
					            		}//프사가 등록되있거나 안되있을경우
					            		
		            					if(result.onoffData[i].late_date == null){
				            				on_time = "<td  width=\"58\" style='border-bottom:1px solid #fff'>탑승</td><td width=\"194\" style='border-bottom:1px solid #fff'>-</td><td width=\"70\" style='border-bottom:1px solid #fff'>"
						            			+result.onoffData[i].on_time+"</td><td rowspan=\"2\" width=\"100\">결석 <br>이유: 사유없음</td><td width=\"120\" style='border-bottom:1px solid #fff'>"+result.onoffData[i].par_name+"</td></tr>"
				            			}
				            			else{
				            				on_time = "<td width=\"58\" style='border-bottom:1px solid #fff'>탑승</td><td width=\"194\" style='border-bottom:1px solid #fff'>-</td><td width=\"70\" style='border-bottom:1px solid #fff'>"
						            			+result.onoffData[i].on_time+"</td><td rowspan=\"2\" width=\"100\">("
						            					+result.onoffData[i].late_abse_type+") <br>이유: "+result.onoffData[i].late_abse_cont+"</td><td width=\"120\" style='border-bottom:1px solid #fff'>"+result.onoffData[i].par_name+"</td></tr>"
				            			}//결석 사유가 있을경우							            			
		            					off_time = "<tr><td>하차</td><td>"+result.centerList[0].center_name+"</td><td>"+result.onoffData[i].off_time+"</td><td>"
				            			+result.onoffData[i].par_phone+"</td></tr>"
				            			
				            			$("#OnoffList_contentRight_Content_table")
				  	                	.append(kid_image + on_time + off_time);
// 						            	boardcheck = true;
		            				}
		            			}
// 		            			if(!boardcheck){
// 		            				$("#OnoffList_contentRight_Content_table").empty();	   
// 		    		  	          	$("#OnoffList_contentRight_Content_table")
// 		      	                	.append("<tr><td>이력이 없습니다.</td></tr>");
// 		    		  	          boardcheck = false;
// 		            			}
		            		}//결석
		            		else if((result.onoffData[i].on_time == '-')&&
		            				(result.onoffData[i].off_time != '-')){
		            			for(var j=0; j<size_board_and_kidData.length; j++){
		            				if(result.onoffData[i].kid_system_code ==
		            					result.board_and_kidList[j].kid_system_code){
		            					
		            					if(saveOnoff_date==null||saveOnoff_date!=result.onoffData[i].today){
					            			$("#OnoffList_contentRight_Content_table")
					  	                	.append("<tr class='OnoffList_onoff_date_filter'><td colspan='6' class='OnoffList_onoff_date'>"+result.onoffData[i].today+"</td></tr>");
					            			saveOnoff_date = result.onoffData[i].today;
					            		}
		            					
		            					if(result.onoffData[i].kid_pho == null){
		            						if((result.onoffData[i].kid_name=="null")||(result.onoffData[i].kid_name==null)||(result.onoffData[i].kid_name=='')){
		            							kid_image = "<tr><td rowspan=\"2\" width=\"140\" ><img width='50px' height='50px' class='OnoffList_kid_pho' src='http://13.125.170.255:8080/Spring/Default/image_ujacar_290x290.png'/>등록안됨</td>"; 
		            						}
		            						else{
		            							kid_image = "<tr><td rowspan=\"2\" width=\"140\" ><img width='50px' height='50px' class='OnoffList_kid_pho' src='http://13.125.170.255:8080/Spring/Default/image_ujacar_290x290.png'/>"
					  	                			+result.onoffData[i].kid_name+"</td>"; 	
		            						}						            			   				
					            		}else{
					            			kid_image = "<tr><td rowspan=\"2\" width=\"140\"><img width='50px' height='50px' class='OnoffList_kid_pho' src='"+result.onoffData[i].kid_pho
			  	                			+"'/>"+result.onoffData[i].kid_name
			  	                			+"</td>";
					            		}//프사가 등록되있거나 안되있을경우
					            		
		            					if(result.onoffData[i].late_date == null){
				            				on_time = "<td width=\"58\" style='border-bottom:1px solid #fff'>탑승</td><td width=\"194\" style='border-bottom:1px solid #fff'>-</td><td  width=\"70\" style='border-bottom:1px solid #fff'>"
						            			+result.onoffData[i].on_time+"</td><td width=\"100\" rowspan=\"2\">지각 <br>이유: 사유없음</td><td width=\"120\" style='border-bottom:1px solid #fff'>"+result.onoffData[i].par_name+"</td></tr>"
				            			}
				            			else{
				            				on_time = "<td width=\"58\" style='border-bottom:1px solid #fff'>탑승</td><td width=\"194\" style='border-bottom:1px solid #fff'>-</td><td width=\"70\" style='border-bottom:1px solid #fff'>"
						            			+result.onoffData[i].on_time+"</td><td width=\"100\" rowspan=\"2\">("
						            					+result.onoffData[i].late_abse_type+") <br>이유: "+result.onoffData[i].late_abse_cont+"</td><td width=\"120\" style='border-bottom:1px solid #fff'>"+result.onoffData[i].par_name+"</td></tr>"
				            			}//지각 사유가 있을경우							            			
		            					off_time = "<tr><td>하차</td><td>"+result.centerList[0].center_name+"</td><td>"+result.onoffData[i].off_time+"</td><td>"
				            			+result.onoffData[i].par_phone+"</td></tr>"
				            			
				            			$("#OnoffList_contentRight_Content_table")
				  	                	.append(kid_image + on_time + off_time);
// 		            					boardcheck = true;
		            				}
		            			}
// 		            			if(!boardcheck){
// 		            				$("#OnoffList_contentRight_Content_table").empty();	   
// 		    		  	          	$("#OnoffList_contentRight_Content_table")
// 		      	                	.append("<tr><td>이력이 없습니다.</td></tr>");
// 		    		  	          boardcheck = false;
// 		            			}
		            		}//지각
		            		else{
            					if(saveOnoff_date==null||saveOnoff_date!=result.onoffData[i].today){
			            			$("#OnoffList_contentRight_Content_table")
			  	                	.append("<tr class='OnoffList_onoff_date_filter'><td colspan='6' class='OnoffList_onoff_date'>"+result.onoffData[i].today+"</td></tr>");
			            			saveOnoff_date = result.onoffData[i].today;
			            		}
            					
            					if(result.onoffData[i].kid_pho == null){
            						if((result.onoffData[i].kid_name=="null")||(result.onoffData[i].kid_name==null)||(result.onoffData[i].kid_name=='')){
            							kid_image = "<tr><td rowspan=\"2\" width=\"140\" ><img width='50px' height='50px' class='OnoffList_kid_pho' src='http://13.125.170.255:8080/Spring/Default/image_ujacar_290x290.png'/>등록안됨</td>"; 
            						}
            						else{
            							kid_image = "<tr><td rowspan=\"2\" width=\"140\" ><img width='50px' height='50px' class='OnoffList_kid_pho' src='http://13.125.170.255:8080/Spring/Default/image_ujacar_290x290.png'/>"
			  	                			+result.onoffData[i].kid_name+"</td>"; 	
            						}    			
			       			
			            		}else{
			            			kid_image = "<tr><td rowspan=\"2\"><img width='50px' height='50px' class='OnoffList_kid_pho' src='"+result.onoffData[i].kid_pho
	  	                			+"'/>"+result.onoffData[i].kid_name
	  	                			+"</td>";
			            		}//프사가 등록되있거나 안되있을경우
			            		
	            				on_time = "<td width=\"58\" style='border-bottom:1px solid #fff'>탑승</td><td width=\"194\" style='border-bottom:1px solid #fff'>"+result.onoffData[i].station_name+"</td><td style='border-bottom:1px solid #fff' width=\"70\">"
			            			+result.onoffData[i].on_time+"</td><td  width=\"100\" rowspan=\"2\">-</td><td width=\"120\" style='border-bottom:1px solid #fff'>"+result.onoffData[i].par_name+"</td></tr>"
		            									            			
            					off_time = "<tr><td>하차</td><td>"+result.centerList[0].center_name+"</td><td>"+result.onoffData[i].off_time+"</td><td>"
		            			+result.onoffData[i].par_phone+"</td></tr>"
		            			
		            			$("#OnoffList_contentRight_Content_table")
		  	                	.append(kid_image + on_time + off_time);
//				            		saveDownCheck = true;
		            		}//정상					            		
	            		}
	            	}//등원
	            	else{
	            		for(var i=0; i < size_onoffData.length; i ++){
	            			kid_image = null;
		            		on_time = null;
		            		off_time = null;
		            		
		            		if((result.onoffData[i].on_time == '-')&&
		            				(result.onoffData[i].off_time == '-')){
		            			for(var j=0; j<size_board_and_kidData.length; j++){					            				
		            				if(result.onoffData[i].kid_system_code ==
		            					result.board_and_kidList[j].kid_system_code){
		            					
		            					if(saveOnoff_date==null||saveOnoff_date!=result.onoffData[i].today){
					            			$("#OnoffList_contentRight_Content_table")
					  	                	.append("<tr class='OnoffList_onoff_date_filter'><td colspan='6' class='OnoffList_onoff_date'>"+result.onoffData[i].today+"</td></tr>");
					            			saveOnoff_date = result.onoffData[i].today;
					            		}
		            					
		            					if(result.onoffData[i].kid_pho == null){
		            						if((result.onoffData[i].kid_name=="null")||(result.onoffData[i].kid_name==null)||(result.onoffData[i].kid_name=='')){
		            							kid_image = "<tr><td rowspan=\"2\" width=\"140\" ><img width='50px' height='50px' class='OnoffList_kid_pho' src='http://13.125.170.255:8080/Spring/Default/image_ujacar_290x290.png'/>등록안됨</td>"; 
		            						}
		            						else{
		            							kid_image = "<tr><td rowspan=\"2\" width=\"140\" ><img width='50px' height='50px' class='OnoffList_kid_pho' src='http://13.125.170.255:8080/Spring/Default/image_ujacar_290x290.png'/>"
					  	                			+result.onoffData[i].kid_name+"</td>"; 	
		            						}	   			
					       			
					            		}else{
					            			kid_image = "<tr><td rowspan=\"2\" width=\"140\"><img width='50px' height='50px' class='OnoffList_kid_pho' src='"+result.onoffData[i].kid_pho
			  	                			+"'/>"+result.onoffData[i].kid_name
			  	                			+"</td>";
					            		}//프사가 등록되있거나 안되있을경우
					            		
		            					if(result.onoffData[i].late_date == null){
				            				on_time = "<td width=\"58\" style='border-bottom:1px solid #fff'>탑승</td><td width=\"194\" style='border-bottom:1px solid #fff'>"+result.centerList[0].center_name+"</td><td width=\"70\" style='border-bottom:1px solid #fff'>"
						            			+result.onoffData[i].on_time+"</td><td width=\"100\" rowspan=\"2\">결석 <br>이유: 사유없음</td><td width=\"120\" style='border-bottom:1px solid #fff'>"+result.onoffData[i].par_name+"</td></tr>"
				            			}
				            			else{
				            				on_time = "<td width=\"58\" style='border-bottom:1px solid #fff'>탑승</td><td width=\"194\" style='border-bottom:1px solid #fff'>"+result.centerList[0].center_name+"</td><td width=\"70\" style='border-bottom:1px solid #fff'>"
						            			+result.onoffData[i].on_time+"</td><td width=\"100\" rowspan=\"2\">("
						            					+result.onoffData[i].late_abse_type+") <br>이유: "+result.onoffData[i].late_abse_cont+"</td><td width=\"120\" style='border-bottom:1px solid #fff'>"+result.onoffData[i].par_name+"</td></tr>"
				            			}//결석 사유가 있을경우							            			
		            					off_time = "<tr><td>하차</td><td>-</td><td>"+result.onoffData[i].off_time+"</td><td>"
				            			+result.onoffData[i].par_phone+"</td></tr>"
				            			
				            			$("#OnoffList_contentRight_Content_table")
				  	                	.append(kid_image + on_time + off_time);
// 		            					 boardcheck = true;
		            				}
		            			}
// 		            			if(!boardcheck){
// 		            				$("#OnoffList_contentRight_Content_table").empty();	   
// 		    		  	          	$("#OnoffList_contentRight_Content_table")
// 		      	                	.append("<tr><td>이력이 없습니다.</td></tr>");
// 		    		  	          boardcheck = false;
// 		            			}
		            		}//결석
		            		else if((result.onoffData[i].on_time != '-')&&
		            				(result.onoffData[i].off_time == '-')){
		            			for(var j=0; j<size_board_and_kidData.length; j++){
		            				if(result.onoffData[i].kid_system_code ==
		            					result.board_and_kidList[j].kid_system_code){
		            					
		            					if(saveOnoff_date==null||saveOnoff_date!=result.onoffData[i].today){
					            			$("#OnoffList_contentRight_Content_table")
					  	                	.append("<tr class='OnoffList_onoff_date_filter'><td colspan='6' class='OnoffList_onoff_date'>"+result.onoffData[i].today+"</td></tr>");
					            			saveOnoff_date = result.onoffData[i].today;
					            		}
		            					
		            					if(result.onoffData[i].kid_pho == null){
		            						if((result.onoffData[i].kid_name=="null")||(result.onoffData[i].kid_name==null)||(result.onoffData[i].kid_name=='')){
		            							kid_image = "<tr><td rowspan=\"2\" width=\"140\" ><img width='50px' height='50px' class='OnoffList_kid_pho' src='http://13.125.170.255:8080/Spring/Default/image_ujacar_290x290.png'/>등록안됨</td>"; 
		            						}
		            						else{
		            							kid_image = "<tr><td rowspan=\"2\" width=\"140\" ><img width='50px' height='50px' class='OnoffList_kid_pho' src='http://13.125.170.255:8080/Spring/Default/image_ujacar_290x290.png'/>"
					  	                			+result.onoffData[i].kid_name+"</td>"; 	
		            						}	   			
					       			
					            		}else{
					            			kid_image = "<tr><td rowspan=\"2\" width=\"140\"><img width='50px' height='50px' class='OnoffList_kid_pho' src='"+result.onoffData[i].kid_pho
			  	                			+"'/>"+result.onoffData[i].kid_name
			  	                			+"</td>";
					            		}//프사가 등록되있거나 안되있을경우
					            		
		            					
			            				on_time = "<td style='border-bottom:1px solid #fff' width=\"58\">탑승</td><td width=\"194\" style='border-bottom:1px solid #fff'>"+result.centerList[0].center_name+"</td><td width=\"70\" style='border-bottom:1px solid #fff'>"
					            			+result.onoffData[i].on_time+"</td><td width=\"100\" rowspan=\"2\">도보</td><td width=\"120\" style='border-bottom:1px solid #fff'>"+result.onoffData[i].par_name+"</td></tr>"
				            			
			            			
		            					off_time = "<tr><td>하차</td><td>-</td><td>"+result.onoffData[i].off_time+"</td><td>"
				            			+result.onoffData[i].par_phone+"</td></tr>"
				            			
				            			$("#OnoffList_contentRight_Content_table")
				  	                	.append(kid_image + on_time + off_time);
// 				    		  	          boardcheck = true;
		            				}
		            			}
// 		            			if(!boardcheck){
// 		            				$("#OnoffList_contentRight_Content_table").empty();	   
// 		    		  	          	$("#OnoffList_contentRight_Content_table")
// 		      	                	.append("<tr><td>이력이 없습니다.</td></tr>");
// 		    		  	          boardcheck = false;
// 		            			}
		            		}//도보
		            		else{
            					if(saveOnoff_date==null||saveOnoff_date!=result.onoffData[i].today){
			            			$("#OnoffList_contentRight_Content_table")
			  	                	.append("<tr class='OnoffList_onoff_date_filter'><td colspan='6' class='OnoffList_onoff_date'>"+result.onoffData[i].today+"</td></tr>");
			            			saveOnoff_date = result.onoffData[i].today;
			            		}
            					
            					if(result.onoffData[i].kid_pho == null){
            						if((result.onoffData[i].kid_name=="null")||(result.onoffData[i].kid_name==null)||(result.onoffData[i].kid_name=='')){
            							kid_image = "<tr><td rowspan=\"2\" width=\"140\" ><img width='50px' height='50px' class='OnoffList_kid_pho' src='http://13.125.170.255:8080/Spring/Default/image_ujacar_290x290.png'/>등록안됨</td>"; 
            						}
            						else{
            							kid_image = "<tr><td rowspan=\"2\" width=\"140\" ><img width='50px' height='50px' class='OnoffList_kid_pho' src='http://13.125.170.255:8080/Spring/Default/image_ujacar_290x290.png'/>"
			  	                			+result.onoffData[i].kid_name+"</td>"; 	
            						}	 			
			       			
			            		}else{
			            			kid_image = "<tr><td rowspan=\"2\" width=\"140\"><img width='50px' height='50px' class='OnoffList_kid_pho' src='"+result.onoffData[i].kid_pho
	  	                			+"'/>"+result.onoffData[i].kid_name
	  	                			+"</td>";
			            		}//프사가 등록되있거나 안되있을경우
			            		
	            				on_time = "<td style='border-bottom:1px solid #fff' width=\"58\">탑승</td><td width=\"194\" style='border-bottom:1px solid #fff'>"+result.centerList[0].center_name+"</td><td width=\"70\" style='border-bottom:1px solid #fff'>"
			            			+result.onoffData[i].on_time+"</td><td rowspan=\"2\" width=\"100\">-</td><td width=\"120\" style='border-bottom:1px solid #fff'>"+result.onoffData[i].par_name+"</td></tr>"
			            					            			
            					off_time = "<tr><td>하차</td><td>"+result.onoffData[i].station_name+"</td><td>"+result.onoffData[i].off_time+"</td><td>"
		            			+result.onoffData[i].par_phone+"</td></tr>"
		            			
		            			$("#OnoffList_contentRight_Content_table")
		  	                	.append(kid_image + on_time + off_time);
			            		
		            		}//정상					            		
	            		}
	            	}//하원
            },
            error:function(request,status,error){                 
         	   alert("code:"+request.status+"\n"+"error:"+error);
            }		  	              
        });  
	}

	function OnoffList_Down() {	 
		var Rtype = "";
		if(saveRoute_type=="등원"){
			Rtype = 'on'
		}
		else{
			Rtype = 'off'
		}
		
		if($("#OnoffList_date").val()!=""){		
			$('#msgBox').removeClass("msgBox_Success");
        	$('#msgBox').removeClass("msgBox_Error");			  	             
           	document.getElementById('msgBox').style.display="none";
			location.href = 'OnoffList_car_Down?route_id=' + encodeURIComponent(saveRoute_id,'UTF-8')
			+'&startDate=' + encodeURIComponent(senStartDate,'UTF-8')
			+'&route_type=' + encodeURIComponent(Rtype,'UTF-8')
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