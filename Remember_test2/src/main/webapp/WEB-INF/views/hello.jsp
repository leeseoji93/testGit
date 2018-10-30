<%@page import="com.test.rememberTest.Dto.MemberInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*, java.text.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%
	Calendar cal = Calendar.getInstance();
	
	int year = cal.get(Calendar.YEAR);
	int secondyear = cal.get(Calendar.YEAR);
	int thirdyear = cal.get(Calendar.YEAR);
	int tempYear = year;
	
	Date now = new Date();
	cal.setTime(now); 
	cal.add(Calendar.MONTH, -1);
	DateFormat sdFormat1 = new SimpleDateFormat("yyyy-MM");
	String firstMon = sdFormat1.format(cal.getTime());
	
	cal.add(Calendar.MONTH, -1);
	String secondMon = sdFormat1.format(cal.getTime());
	
	cal.add(Calendar.MONTH, -1);
	String thirdMon = sdFormat1.format(cal.getTime());
	
	cal.add(Calendar.MONTH, -1);
	String fourMon = sdFormat1.format(cal.getTime());
	
	cal.add(Calendar.MONTH, -1);
	String fiveMon = sdFormat1.format(cal.getTime());
	
	cal.add(Calendar.MONTH, -1);
	String sixMon = sdFormat1.format(cal.getTime());
	
	
// 	int firstMon = cal.get(Calendar.MONTH)  ;
// 	cal.add(Calendar.MONTH, -1);
// 	int secondMon = cal.get(Calendar.MONTH);
// 	cal.add(Calendar.MONTH, -1);
// 	int thirdMon = cal.get(Calendar.MONTH);
	
// 	String firstMon_S = Integer.toString(firstMon);
// 	String secondMon_S = Integer.toString(secondMon);
// 	String thirdMon_S = Integer.toString(thirdMon);
%>
	<jsp:include page="include/menu_admin.jsp"/>
	<div class="page mainpage">
	
	<div id="layerWindow_p" class="layerWindow">
		<span class="modalWindow"></span>
	
		<div id="loginLayer" class="loginLayer loginTypeA">
			<div class="layerPopContent">
				<p><span class="re_question"></span></p> 
				<input id="chkVal" type="hidden" name="chkVal" />
				<input id="pageName" type="hidden" name="pageName" /> 
				<input id="obj1" type="hidden" name="obj1" /> 
				<input id="obj2" type="hidden" name="obj2" /> 
				<input id="obj3" type="hidden" name="obj3" /> 
				<input type="button" class="btn_confirming_text" onclick="closeLayer2(1)" >
				<input type="button" class="btn_close_text" onclick="closeLayer2(0)" >
			</div>
		</div>
	</div>
	
		<div class="page-wrapper">
			<div class="pageContent_main">
				<sec:authorize access="hasAnyRole('ROLE_ADMIN')">	<!-- 원장 -->
				<div class="dashboard_row">
					<div class="dashboard_half marginRight4">
						<!-- 계정관리 -->
						<div class="dashboard_title bg_color_red">
							<div class="dashboard_title_icon">
								<img src="images/dashboard/a_x2.png">
							</div>
							<div class="dashboard_title_text">
								계정관리
								<span><a href="accountList"><img src="images/dashboard/add_x2.png"></a></span>
							</div>
						</div>
						<c:set value="${accountCountList}" var="dto_c"/>
						<div class="dashboard_content dashboard_content_Tablebox">
							<table>
								<tr>
									<th width="70"></th>
									<th width="150">원&nbsp&nbsp&nbsp&nbsp아</th>
									<th width="150">교직원</th>
									<th width="150">학부모</th>
								</tr>
								<tr>
									<td>전&nbsp&nbsp체</td>
									<td>${dto_c[0].kid_AllCount}명</td>
									<td>${dto_c[0].staff_AllCount}명</td>
									<td>${dto_c[0].parent_and_kid_AllCount_a + dto_c[0].parent_and_kid_AllCount_d}명</td>
								</tr>
								<tr>
									<td>등&nbsp&nbsp록</td>
									<td>${dto_c[0].kid_AllCount}명</td>
									<td>${dto_c[0].staff_AllCount}명</td>
									<td>${dto_c[0].parent_and_kid_AllCount_a}명</td>
								</tr>
								<tr>
									<td>승인대기</td>
									<td>-</td>
									<td>-</td>
									<td>${dto_c[0].parent_and_kid_AllCount_d}명</td>
								</tr>
							</table>
						</div>
					</div>
					<!-- 기기관리 -->
					<c:set value="${equipAllCount}" var="dto_e"/>
					<div class="dashboard_half">
						<div class="dashboard_title bg_color_green">
							<div class="dashboard_title_icon">
								<img src="images/dashboard/e_x2.png">
							</div>
							<div class="dashboard_title_text">
								기기관리
								<span><a href="beaconList"><img src="images/dashboard/add_x2.png"></a></span>
							</div>
						</div>
						<div class="dashboard_content dashboard_content_Tablebox">
							<table>
								<tr>
									<th width="70"></th>
									<th width="150">비&nbsp&nbsp콘</th>
									<th width="150">게이트웨이</th>
									<th width="150">테블릿</th>
								</tr>
								<tr>
									<td>전&nbsp&nbsp&nbsp&nbsp체</td>
									<td>${dto_e[0].beacon_AllCount}</td>
									<td>${dto_e[0].gateway_AllCount}</td>
									<td>${dto_e[0].tablet_AllCount}</td>
								</tr>
								<tr>
									<td>사&nbsp&nbsp&nbsp&nbsp용</td>
									<td>${dto_e[0].beacon_Use_AllCount}</td>
									<td>${dto_e[0].gateway_Use_AllCount}</td>
									<td>${dto_e[0].tablet_Use_AllCount}</td>
								</tr>
								<tr>
									<td>미사용</td>
									<td>${dto_e[0].beacon_AllCount - dto_e[0].beacon_Use_AllCount}</td>
									<td>${dto_e[0].gateway_AllCount - dto_e[0].gateway_Use_AllCount}</td>
									<td>${dto_e[0].tablet_AllCount - dto_e[0].tablet_Use_AllCount}</td>
								</tr>
								<tr>
									<td>A/S신청</td>
									<td>${dto_e[0].damage_beacon_AllCount}</td>
									<td>${dto_e[0].damage_gateway_AllCount}</td>
									<td>${dto_e[0].damage_tablet_AllCount}</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
				</sec:authorize>
			  	<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')">
				<div class="dashboard_row dashboard_full">
					<div class="dashboard_title bg_color_yellow">
						<div class="dashboard_title_icon">
							<img src="images/dashboard/b_x2.png">
						</div>
						<div class="dashboard_title_text">
							차량정보관리
							<span><a href="busRouteList"><img src="images/dashboard/add_x2.png"></a></span>
						</div>
					</div>
					<div class="dashboard_content">
						<c:set value="${carNStationCount}" var="dto_cs"/>
						<div class="dashboard_content_Tablebox dashboard_content_Tablebox_s marginRight10">
							<table>
								<tr>
									<th width="60"></th>
									<th width="110">차량</th>
									<th width="110">정류장</th>
								</tr>
								<tr>
									<td>전&nbsp&nbsp&nbsp&nbsp체</td>
									<td>${dto_cs[0].bus_AllCount}</td>
									<td>${dto_cs[0].station_AllCount}</td>
								</tr>
								<tr>
									<td>사&nbsp&nbsp&nbsp&nbsp용</td>
									<td>${dto_cs[0].bus_Use_AllCount}</td>
									<td>${dto_cs[0].station_Use_AllCount}</td>
								</tr>
								<tr>
									<td>미사용</td>
									<td>${dto_cs[0].bus_AllCount - dto_cs[0].bus_Use_AllCount}</td>
									<td>${dto_cs[0].station_AllCount - dto_cs[0].station_Use_AllCount}</td>
								</tr>
							</table>
						</div><div class="dashboard_content_Tablebox dashboard_content_Tablebox_l">
							<table>
							<tr>
								<th width="127">노선</th>
								<th width="130">탑승인원</th>
								<th width="130">등원/하원</th>
								<th width="130">출발시간</th>
								<th width="130">도착시간</th>
							</tr>
							<c:choose>
								<c:when test="${fn:length(routeLatestList) eq 0}">
									<%
										for(int i=0;i<3;i++){
									%>
									<tr>
										<td align="center">-</td>
										<td align="center">-</td>
										<td align="center">-</td>
										<td align="center">-</td>
										<td align="center">-</td>
									</tr>
									<%		
										}
									%>
								</c:when>
								
								<c:otherwise>
									<c:forEach var="route_latest" items="${routeLatestList}" varStatus="s">
									<tr>
										<td onclick="location.href='busRouteDetail?route_id=${route_latest.route_id}'" class="cu_pointer">${route_latest.route_name}</td>
										<td>${route_latest.kid_count}</td>
										<td>${route_latest.route_type}</td>
										<td>${route_latest.route_start}</td>
										<td>${route_latest.route_arrive}</td>
									</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>	
						
							
						</table>
						</div>
					</div>
				</div>
				</sec:authorize>
				<sec:authorize access="hasAnyRole('ROLE_ADMIN')">	<!-- 원장 -->
		
				<c:forEach var="classList" items="${classList}" varStatus="s">
				<div class="dashboard_row dashboard_full">
					<div class="dashboard_title bg_color_blue">
						<div class="dashboard_title_icon">
							<img src="images/dashboard/c_x2.png">
						</div>
						<div class="dashboard_title_text">
							${classList.class_name}
							<span><a href="detailClassForm?class_id=${classList.class_id}"><img src="images/dashboard/add_x2.png"></a></span>
						</div>
					</div>
					<div class="dashboard_content">
						<div class="dashboard_content_box marginRight10">
							<table>
								<tr>
									<th width="253" colspan="3">가정통신문</th>
								</tr>
								<tr>
		<%-- 							<td><c:out value="${hcList}"></c:out> </td> --%>
								</tr>
								
								<c:forEach items="${hcList}" var="hcTemp" varStatus="hcIndex">
								
									<c:if test="${hcIndex.count eq s.count}">
										<c:choose>
											<c:when test="${fn:length(hcTemp) eq 0}">
												<c:set var="listLength" value="0" />
											</c:when>
											<c:otherwise>
												<c:forEach items="${hcTemp}" var="hc_s" begin="0" end="2" varStatus="hc_index">
												<tr>						
													<td width="85" onclick="location.href='Home_communicationDetail?communication_id=${hc_s.communication_id}'">${hc_s.update_time}</td>
													<td width="100" onclick="location.href='Home_communicationDetail?communication_id=${hc_s.communication_id}'"><div class="hcTitle">${hc_s.title}</div></td>
													<td width="58"><a onclick="openLayer(1,'${hc_s.file_url}')"><img src="images/dashboard/d_x2.png"></a></td>
												</tr>
												<c:set var="listLength" value="${fn:length(hcTemp)}" />
												</c:forEach>
											</c:otherwise>
										</c:choose>
										
										<%
											Object length = pageContext.getAttribute("listLength");
											int length_i = Integer.parseInt(length.toString());
											int listRow = 3;
											
											if(length_i<listRow){
												for(int i=length_i;i<listRow;i++){
												%>
												<tr>
													<td colspan="3"><span>-</span></td>
												</tr>
												<%	
												}
											}
										%>
										
									</c:if>
								</c:forEach>
			
							</table>
							
						</div>
						<% year=tempYear;%>
						<div class="dashboard_content_box marginRight10">
							<table>
								<tr>
									<th width="253" colspan="3">출석부</th>
								</tr>
								<tr>
									<td width="180" onclick="location.href='AttendanceList?date=<%=firstMon %>&class_id=${classList.class_id}'"><%=firstMon%> </td>
									<td width="155" onclick="location.href='AttendanceList?date=<%=firstMon %>&class_id=${classList.class_id}'">출석부</td>
									<td width="39"><a onclick="openLayer(1,'AttendanceList_Down','${classList.class_id}','<%=firstMon %>')"><img src="images/dashboard/d_x2.png"></a></td>
								</tr>
								<tr>
									<td onclick="location.href='AttendanceList?date=<%=firstMon %>&class_id=${classList.class_id}'"><%=secondMon%></td>
									<td onclick="location.href='AttendanceList?date=<%=secondMon %>&class_id=${classList.class_id}'">출석부</td>
									<td width="39"><a onclick="openLayer(2,'AttendanceList_Down','${classList.class_id}','<%=secondMon %>')"><img src="images/dashboard/d_x2.png"></a></td>
								</tr>
								<tr>
									<td onclick="location.href='AttendanceList?date=<%=thirdMon %>&class_id=${classList.class_id}'"><%=thirdMon%></td>
									<td onclick="location.href='AttendanceList?date=<%=thirdMon%>&class_id=${classList.class_id}'">출석부</td>
									<td width="39"><a onclick="openLayer(2,'AttendanceList_Down','${classList.class_id}','<%=thirdMon %>')"><img src="images/dashboard/d_x2.png"></a></td>
								</tr>
							</table>
						</div>
						<div class="dashboard_content_box marginRight10">
							<table>
								<c:set value="${s.index}" var="index"/>
								<%
									Object index = pageContext.getAttribute("index"); 
									String text = "medi_req_LatestList" + index;
									pageContext.setAttribute("text", text);
								%>
								<c:set var="text" value="${pageScope.text}"/>
								<tr>
									<th width="253" colspan="3">투약대조서<c:out value="${medi_req_LatestList[tempClassList]}" /> </th>
								</tr>
								<c:forEach items="${mdList}" var="list" varStatus="mdIndex">
									<c:if test="${mdIndex.count eq s.count}">
										<c:forEach items="${list}" var="mr_s" begin="0" end="2" >
										<tr>
											<td width="138" onclick="location.href='medication_contrast_document?request_id=${mr_s.request_id}'">${mr_s.medication_date}</td>
											<td width="115" onclick="location.href='medication_contrast_document?request_id=${mr_s.request_id}'">${mr_s.kid_name}</td>
											<td width="39"><a onclick="openLayer(3,'medication_contrast_document_multiDown','${mr_s.request_id}')"><img src="images/dashboard/d_x2.png"></a></td>
										</tr>
										</c:forEach>
										<c:set var="listLength_m" value="${fn:length(list)}" />
									</c:if>
									
								</c:forEach>
								<%
									Object length_m = pageContext.getAttribute("listLength_m");
									int length_mi = Integer.parseInt(length_m.toString());
									int listRow = 3;
									
									if(length_mi<listRow){
										for(int i=length_mi;i<listRow;i++){
										%>
										<tr>
											<td colspan="3"><span>-</span></td>
										</tr>
										<%	
										}
									}
								%>
							</table>
						</div>
						<% year=tempYear;%>
						<div class="dashboard_content_box">
							<table>
								<tr>
									<th width="253" colspan="3">투약일지</th>
								</tr>
								
								<tr>
									<td width="106" onclick="location.href='medication_diary?class_id=${classList.class_id}&date=<%=firstMon%>'" ><%=firstMon %></td>
									<td width="86" onclick="location.href='medication_diary?class_id=${classList.class_id}&date=<%=firstMon%>'" > 투약일지</td>
									<td><a onclick="openLayer(4,'medication_diary_multiDown','${classList.class_id}','<%=firstMon%>')"><img src="images/dashboard/d_x2.png"></a></td>
								</tr>
								<tr>
									<td onclick="location.href='medication_diary?class_id=${classList.class_id}&date=<%=secondMon%>'" ><%=secondMon %></td>
									<td onclick="location.href='medication_diary?class_id=${classList.class_id}&date=<%=secondMon%>'" >투약일지</td>
									<td><a onclick="openLayer(4,'medication_diary_multiDown','${classList.class_id}','<%=secondMon%>')"><img src="images/dashboard/d_x2.png"></a></td>
								</tr>
								<tr>
									<td onclick="location.href='medication_diary?class_id=${classList.class_id}&date=<%=thirdMon%>'" ><%=thirdMon%></td>
									<td onclick="location.href='medication_diary?class_id=${classList.class_id}&date=<%=thirdMon%>'" >투약일지</td>
									<td><a onclick="openLayer(4,'medication_diary_multiDown','${classList.class_id}','<%=thirdMon%>')"><img src="images/dashboard/d_x2.png"></a></td>
								</tr>
							</table>
						</div>
					</div>
				</div>
				</c:forEach>
				</sec:authorize>
				
				
				<sec:authorize access="hasAnyRole('ROLE_MEMBER')">	<!-- 교사 -->
		        	<c:forEach var="myClass" items="${myClass}" varStatus="s">
					<div class="dashboard_row dashboard_full">
						<div class="dashboard_title bg_color_blue">
							<div class="dashboard_title_icon">
								<img src="images/dashboard/c_x2.png">
							</div>
							<div class="dashboard_title_text">
								${myClass.class_name}
								<span><a href="detailClassForm?class_id=${myClass.class_id}"><img src="images/dashboard/add_x2.png"></a></span>
							</div>
						</div>
						<div class="dashboard_content">
		<!-- 					<table> -->
		<!-- 						<tr> -->
		<!-- 							<th>원아</th> -->
		<%-- 							<td>${myClass.totalKidsCnt}</td> --%>
		<!-- 						</tr> -->
		<!-- 					</table> -->
			
						<div class="dashboard_content_box marginRight10">
							<table>
								<tr>
									<th width="253" colspan="3">가정통신문</th>
								</tr>
								<tr>
		<%-- 							<td><c:out value="${hcList}"></c:out> </td> --%>
								</tr>
								<c:forEach items="${hc_List_MyClass}" var="hcTemp" varStatus="hcIndex">
									<c:if test="${hcIndex.count eq s.count}">
										<c:choose>
											<c:when test="${fn:length(hcTemp) eq 0}">
												<c:set var="listLength" value="0" />
											</c:when>
											<c:otherwise>
												<c:forEach items="${hcTemp}" var="hc_s" varStatus="hc_index">
												<tr>
													<td width="85" onclick="location.href='Home_communicationDetail?communication_id=${hc_s.communication_id}'">${hc_s.update_time}</td>
													<td width="100" onclick="location.href='Home_communicationDetail?communication_id=${hc_s.communication_id}'"><div class="hcTitle">${hc_s.title}</div></td>
													<td width="58"><a onclick="openLayer(1,'${hc_s.file_url}')"><img src="images/dashboard/d_x2.png"></a></td>
												</tr>
												<c:set var="listLength" value="${fn:length(hcTemp)}" />
												</c:forEach>
											</c:otherwise>
										</c:choose>
										
										<%
											Object length = pageContext.getAttribute("listLength");
											int length_i = Integer.parseInt(length.toString());
											int listRow = 6;
											
											if(length_i<listRow){
												for(int i=length_i;i<listRow;i++){
												%>
												<tr>
													<td colspan="3"><span>-</span></td>
												</tr>
												<%	
												}
											}
										%>
										
									</c:if>
								</c:forEach>
			
							</table>
						</div>
						
						<!-- 반 출석부 -->
						<% year=tempYear;%>
						<div class="dashboard_content_box marginRight10">
							<table>
								<tr>
									<th width="253" colspan="3">출석부</th>
								</tr>
								<tr>
									<td width="180" onclick="location.href='AttendanceList?date=<%=firstMon%>&class_id=${myClass.class_id}'"><%=firstMon%> </td>
									<td width="155" onclick="location.href='AttendanceList?date=<%=firstMon%>&class_id=${myClass.class_id}'">출석부</td>
									<td width="39"><a onclick="openLayer(2,'AttendanceList_Down','${myClass.class_id}','<%=firstMon%>')"><img src="images/dashboard/d_x2.png"></a></td>
								</tr>
								<tr>
									<td onclick="location.href='AttendanceList?date=<%=secondMon%>&class_id=${myClass.class_id}'"><%=secondMon%></td>
									<td onclick="location.href='AttendanceList?date=<%=secondMon%>&class_id=${myClass.class_id}'">출석부</td>
									<td width="39"><a onclick="openLayer(2,'AttendanceList_Down','${myClass.class_id}','<%=secondMon %>')"><img src="images/dashboard/d_x2.png"></a></td>
								</tr>
								<tr>
									<td onclick="location.href='AttendanceList?date=<%=thirdMon%>&class_id=${myClass.class_id}'"><%=thirdMon%></td>
									<td onclick="location.href='AttendanceList?date=<%=thirdMon%>&class_id=${myClass.class_id}'">출석부</td>
									<td width="39"><a onclick="openLayer(2,'AttendanceList_Down','${myClass.class_id}','<%=thirdMon %>')"><img src="images/dashboard/d_x2.png"></a></td>
								</tr>
								<tr>
									<td onclick="location.href='AttendanceList?date=<%=fourMon%>&class_id=${myClass.class_id}'"><%=fourMon%></td>
									<td onclick="location.href='AttendanceList?date=<%=fourMon%>&class_id=${myClass.class_id}'">출석부</td>
									<td width="39"><a onclick="openLayer(2,'AttendanceList_Down','${myClass.class_id}','<%=fourMon%>')"><img src="images/dashboard/d_x2.png"></a></td>
								</tr>
								<tr>
									<td onclick="location.href='AttendanceList?date=<%=fiveMon%>&class_id=${myClass.class_id}'"><%=fiveMon%></td>
									<td onclick="location.href='AttendanceList?date=<%=fiveMon%>&class_id=${myClass.class_id}'">출석부</td>
									<td width="39"><a onclick="openLayer(2,'AttendanceList_Down','${myClass.class_id}','<%=fiveMon %>')"><img src="images/dashboard/d_x2.png"></a></td>
								</tr>
								<tr>
									<td onclick="location.href='AttendanceList?date=<%=sixMon%>&class_id=${myClass.class_id}'"><%=sixMon%></td>
									<td onclick="location.href='AttendanceList?date=<%=sixMon%>&class_id=${myClass.class_id}'">출석부</td>
									<td width="39"><a onclick="openLayer(2,'AttendanceList_Down','${myClass.class_id}','<%=sixMon %>')"><img src="images/dashboard/d_x2.png"></a></td>
								</tr>
							</table>
						</div>
						
						
						<!-- 투약대조서 -->
						<div class="dashboard_content_box marginRight10">
							<table>
								<c:set value="${s.index}" var="index"/>
								<%
									Object index = pageContext.getAttribute("index"); 
									String text = "medi_req_LatestList" + index;
									pageContext.setAttribute("text", text);
								%>
								<c:set var="text" value="${pageScope.text}"/>
								<tr>
									<th width="253" colspan="3">투약대조서<c:out value="${medi_req_LatestList[tempClassList]}" /> </th>
								</tr>
								<c:forEach items="${mdList_MyClass}" var="list" varStatus="mdIndex">
									<c:if test="${mdIndex.count eq s.count}">
										<c:forEach items="${list}" var="mr_s">
										<tr>
											<td width="138" onclick="location.href='medication_contrast_document?request_id=${mr_s.request_id}'">${mr_s.medication_date}</td>
											<td width="115" onclick="location.href='medication_contrast_document?request_id=${mr_s.request_id}'">${mr_s.kid_name}</td>
											<td width="39"><a onclick="openLayer(3,'medication_contrast_document_multiDown','${mr_s.request_id}')"><img src="images/dashboard/d_x2.png"></a></td>
										</tr>
										</c:forEach>
										<c:set var="listLength_m" value="${fn:length(list)}" />
									</c:if>
								</c:forEach>
								<%
									Object length_m = pageContext.getAttribute("listLength_m");
									int length_mi = Integer.parseInt(length_m.toString());
									int listRow = 6;
									
									if(length_mi<listRow){
										for(int i=length_mi;i<listRow;i++){
										%>
										<tr>
											<td colspan="3"><span>-</span></td>
										</tr>
										<%	
										}
									}
								%>
							</table>
						</div>
						
						<!-- 투약일지 -->
						<% year=tempYear;%>
						<div class="dashboard_content_box">
							<table>
								<tr>
									<th width="253" colspan="3">투약일지</th>
								</tr>
								
								<tr>
									<td width="106" onclick="location.href='medication_diary?class_id=${myClass.class_id}&date=<%=firstMon%>'" ><%=firstMon%></td>
									<td width="86" onclick="location.href='medication_diary?class_id=${myClass.class_id}&date=<%=firstMon%>'" > 투약일지</td>
									<td><a onclick="openLayer(4,'medication_diary_multiDown','${myClass.class_id}','<%=firstMon%>')"><img src="images/dashboard/d_x2.png"></a></td>
								</tr>
								<tr>
									<td onclick="location.href='medication_diary?class_id=${myClass.class_id}&date=<%=secondMon%>'" ><%=secondMon%></td>
									<td onclick="location.href='medication_diary?class_id=${myClass.class_id}&date=<%=secondMon%>'" >투약일지</td>
									<td><a onclick="openLayer(4,'medication_diary_multiDown','${myClass.class_id}','<%=secondMon%>')"><img src="images/dashboard/d_x2.png"></a></td>
								</tr>
								<tr>
									<td onclick="location.href='medication_diary?class_id=${myClass.class_id}&date=<%=thirdMon%>'" ><%=thirdMon%></td>
									<td onclick="location.href='medication_diary?class_id=${myClass.class_id}&date=<%=thirdMon%>'" >투약일지</td>
									<td><a onclick="openLayer(4,'medication_diary_multiDown','${myClass.class_id}','<%=thirdMon%>')"><img src="images/dashboard/d_x2.png"></a></td>
								</tr>
								<tr>
									<td onclick="location.href='medication_diary?class_id=${myClass.class_id}&date=<%=fourMon%>'" ><%=fourMon%></td>
									<td onclick="location.href='medication_diary?class_id=${myClass.class_id}&date=<%=fourMon%>'" >투약일지</td>
									<td><a onclick="openLayer(4,'medication_diary_multiDown','${myClass.class_id}','<%=fourMon%>')"><img src="images/dashboard/d_x2.png"></a></td>
								</tr>
								<tr>
									<td onclick="location.href='medication_diary?class_id=${myClass.class_id}&date=<%=fiveMon%>'" ><%=fiveMon%></td>
									<td onclick="location.href='medication_diary?class_id=${myClass.class_id}&date=<%=fiveMon%>'" >투약일지</td>
									<td><a onclick="openLayer(4,'medication_diary_multiDown','${myClass.class_id}','<%=fiveMon%>')"><img src="images/dashboard/d_x2.png"></a></td>
								</tr>
								<tr>
									<td onclick="location.href='medication_diary?class_id=${myClass.class_id}&date=<%=sixMon%>'" ><%=sixMon%></td>
									<td onclick="location.href='medication_diary?class_id=${myClass.class_id}&date=<%=sixMon%>'" >투약일지</td>
									<td><a onclick="openLayer(4,'medication_diary_multiDown','${myClass.class_id}','<%=sixMon%>')" ><img src="images/dashboard/d_x2.png"></a></td>
								</tr>
							</table>
						</div>
					</div>
					
				</div>
				
				
					</c:forEach>
				<div class="dashboard_row dashboard_full">
					<div class="dashboard_title bg_color_green">
						<div class="dashboard_title_icon">
							<img src="images/dashboard/c_x2.png">
						</div>
						<div class="dashboard_title_text">
							차량이력관리
							<span><a href="busRouteList"><img src="images/dashboard/add_x2.png"></a></span>
						</div>
					</div>	
					<!-- 차량 운행일지 -->
					<div class="dashboard_content">
						<div class=" dashboard_content_box_half marginRight10">
							<table>
								<tr>
									<th width="521" colspan="5">차량운행일지</th>
								</tr>
								<c:forEach items="${recordDriv_Doc}" var="list" varStatus="recordDriv">
								<tr>
									<td width="138" onclick="location.href='vehicleLogDetail?r=${list.route_id}&cdf=${list.createDateFormat}'">${list.createDateFormat}</td>
									<td width="115" onclick="location.href='vehicleLogDetail?r=${list.route_id}&cdf=${list.createDateFormat}'">${list.route_name}</td>
									<td width="115" onclick="location.href='vehicleLogDetail?r=${list.route_id}&cdf=${list.createDateFormat}'">${list.bus_name}</td>
									<td width="138" onclick="location.href='vehicleLogDetail?r=${list.route_id}&cdf=${list.createDateFormat}'">${list.route_type}</td>
									<td width="39"><a onclick="openLayer(5,'vehicleListDown','${list.route_type}','${list.route_id}','${list.driv_doc}')"><img src="images/dashboard/d_x2.png"></a></td>
								</tr>
								<c:set var="listLength" value="${fn:length(recordDriv_Doc)}" />
								</c:forEach>
								<%
									Object length_m = pageContext.getAttribute("listLength");
									int length_mi = Integer.parseInt(length_m.toString());
									int listRow = 6;
									
									if(length_mi<listRow){
										for(int i=length_mi;i<listRow;i++){
										%>
										<tr>
											<td colspan="5"><span>-</span></td>
										</tr>
										<%	
										}
									}
								%>
							</table>
						</div>
						<!-- 차량 점검표관리 -->
						<div class=" dashboard_content_box_half ">
							<table>
								<tr>
									<th width="520" colspan="5">차량점검표</th>
								</tr>
								<c:forEach items="${teach_bus_ckecklist}" var="ckecklist" varStatus="teach_bus">
								<tr>
									<td width="138" onclick="location.href='carCheckManagement_main?rm=${ckecklist.route_name}&ri=${ckecklist.route_id}&my=${ckecklist.checkDateYear}&mm=${ckecklist.checkDateMon}'">${ckecklist.checkDateYear}.${ckecklist.checkDateMon}</td>
									<td width="115" onclick="location.href='carCheckManagement_main?rm=${ckecklist.route_name}&ri=${ckecklist.route_id}&my=${ckecklist.checkDateYear}&mm=${ckecklist.checkDateMon}'">${ckecklist.route_name}</td>
									<td width="138" onclick="location.href='carCheckManagement_main?rm=${ckecklist.route_name}&ri=${ckecklist.route_id}&my=${ckecklist.checkDateYear}&mm=${ckecklist.checkDateMon}'">${ckecklist.bus_num}</td>
									<td width="138" onclick="location.href='carCheckManagement_main?rm=${ckecklist.route_name}&ri=${ckecklist.route_id}&my=${ckecklist.checkDateYear}&mm=${ckecklist.checkDateMon}'">${ckecklist.bus_staff}</td>
									<td width="39"><a href="#"><img src="images/dashboard/d_x2.png"></a></td>
								</tr>
								<c:set var="listLength" value="${fn:length(teach_bus_ckecklist)}" />
								</c:forEach>
								<%
									Object length_m2 = pageContext.getAttribute("listLength");
									int length_mi2 = Integer.parseInt(length_m2.toString());
									int listRow2 = 6;
									
									if(length_mi2<listRow2){
										for(int i=length_mi2;i<listRow2;i++){
										%>
										<tr>
											<td colspan="5"><span>-</span></td>
										</tr>
										<%	
										}
									}
								%>
							</table>
						</div>
						
					</div>
					
					
					
				</div>	
			    </sec:authorize>
			</div>
		</div>
	</div>
	<jsp:include page="include/footer.jsp"/>
<script type="text/javascript">
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

function openLayer(chk,pageName,obj1,obj2,obj3){
// 	console.log("openLayer:"+openLayer);
	$('#layerWindow_p').css('display','block');
	$("#chkVal").val(chk);
	$(".btn_confirming_text").css("display","inline");
	if(chk==1){
		if(pageName==""){
			$(".re_question").html("첨부파일이 없습니다. ");	
			$(".btn_confirming_text").css("display","none");
		}else{
			$("#pageName").val(pageName);
			$(".re_question").html("가정통신문을 내려 받으시겠습니까?");	
		}
// 		location.href=pageName;
	}
	else if(chk==2){
		
		$("#pageName").val(pageName);
		$("#obj1").val(obj1);
		$("#obj2").val(obj2);
		$(".re_question").html("출석부를  내려 받으시겠습니까?");
	}
	else if(chk==3){
		$("#pageName").val(pageName);
		$("#obj1").val(obj1);
		$("#obj2").val(obj2);
		$(".re_question").html("투약대조서를 내려 받으시겠습니까?");
	}
	else if(chk==4){
		$("#pageName").val(pageName);
		$("#obj1").val(obj1);
		$("#obj2").val(obj2);
		$(".re_question").html("투약일지를 내려 받으시겠습니까?");
	}
	else if(chk==5){
		$("#pageName").val(pageName);
		$("#obj1").val(obj1);
		$("#obj2").val(obj2);
		$("#obj3").val(obj3);
		$(".re_question").html("운행일지를 내려 받으시겠습니까?");
	}
	
}
function closeLayer2(obj){
	var chk = $("#chkVal").val();
	var pageName = $("#pageName").val();
	var obj1 =  $("#obj1").val();
	var obj2 =  $("#obj2").val();
	var obj3 =  $("#obj3").val();
	
	if(obj==1){
		if(chk==1){			//가정통신문
			location.href=pageName;
		}else if(chk==2){		//출석부
			location.href=pageName+"?class_id="+obj1+"&month="+obj2;
		}else if(chk==3){		// 투약대조서
			location.href=pageName+"?request_id="+obj1;
		}else if(chk==4){		// 투약일지
			location.href=pageName+"?date="+obj2+"&class_id="+obj1;
		}else if(chk==5){		// 운행일지
			location.href=pageName+"?downType="+obj1+"&route_id="+obj2+"&driv_doc="+obj3;
		}
	}
	document.getElementById('layerWindow_p').style.display='none';
}

$(document).ready(function(){	
// 	$.ajax({  
//         url : 'medi_req_LatestList',
//         type:'POST',
// //         data : { "beacon_id" : beacon_id},
//         beforeSend: function(xhr) {
//             xhr.setRequestHeader(header, token);
//         	},
//         success: function(result) {	            	 	      
//      		$("#categoryList_con").html(result); //str로 받은 data를 넘긴다.
//         },
//         error:function(request,status,error){                 
//      	   alert("code:"+request.status+"\n"+"error:"+error);
//         }
//     });
	
});
</script>
