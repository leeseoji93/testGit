<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<style>
.validFail{
	font-size: 13px;
}
.cusInsertTable2 label{
	position: absolute;
	padding: 5px
}
</style>
	<jsp:include page="../include/menu_admin.jsp">
		<jsp:param name="pageInMenu" value="차량운행정보"  />
		<jsp:param name="pageCategory" value="노선 관리"  />
		<jsp:param name="pageTitle" value="노선 수정"  /> 
	</jsp:include>
	<div class="page">
		<div class="page-wrapper">
			<div class="pageTitle"><h2>노선 수정</h2></div>		
			
			<!-- multistep form -->
				
		<form action="busRouteUpdate" id="busRouteForm_form" method="post" class="stepForm" onkeydown="if(event.keyCode==13){event.returnValue=false;}">
			<!-- progressbar -->
				<ul id="progressbar" class="progressbar">
					<li class="active" id="LRoute"></li>
					<li class="ready" id="LStation"></li>
					<li class="ready" id="LChild"></li>
					<li class="ready" id="LCar"></li>
					<li class="ready" id="LTeacher"></li>
				</ul>				
			<div class="pageContent">
				<c:set value="${baseRouteList}" var="basedto"/>	
				<!-- fieldsets -->
				<div class="msgBox" id="msgBox"></div>
				<fieldset id="fieldset_1" class="busRouteUpdate">
				
				<input type="hidden" name="${_csrf.parameterName}" id="csrf" value="${_csrf.token}" />
				<div class="cusInsertTable2">
					<table id="busRouteList-C" style="font-size: 13px;">
						<tr>
							<th>노선이름</th>
							<td colspan="4">
								<input type="text" name="route_name" id="route_name" class="BR_input1 big_input1"  value="${basedto[0].route_name }"/>							
							</td>								
						</tr>
						<tr id="Step1_routeStart">
							<th>출발시간</th>
							<td  colspan="4">
								<input type="text" name="route_start" id="route_start" class="BR_input2 big_input1" value="${basedto[0].route_start }" />																			
							</td>							
						</tr>
						<tr id="Step1_routeType">
							<th>등/하원</th>
							<td>
								<input type="radio" name="route_type" value="등원">등원
							</td>	
							<td>
								<input type="radio" name="route_type" value="하원">하원																								  						 							
							</td>							
						</tr>	
						<tr>
							<th>사용여부</th>
							<td colspan="2">
<!-- 								<input type="radio" name="route_use" value="true">사용 -->
<!-- 								<input type="radio" name="route_use" value="false">미사용 -->
								<c:choose>
			                        <c:when test="${basedto[0].route_use eq true }">
			                        	<div class="toggleWrapper toggleleft7">
					                		<input type="checkbox" id="dn" class="dn"  name="route_use" checked="checked" value="${basedto[0].route_use}" onclick="stationUseClick(this.id,'1')"/>
											<label for="dn" class="toggle"><span class="toggle__handler"></span></label>
					                	</div>
			                        </c:when>
			                        <c:otherwise>
			                        	<div class="toggleWrapper toggleleft7">
					                		<input type="checkbox" id="dn" class="dn" name="route_use" value="${basedto[0].route_use}" onclick="stationUseClick(this.id,'0')" />
											<label for="dn" class="toggle" ><span class="toggle__handler"></span></label>
					                	</div>
						                	
			                        </c:otherwise>
			                    </c:choose>																								  						 							
							</td>							
						</tr>				
						<tr>
							<th id="Step1_routeSem">운행학기</th>
							<td>
								<input type="radio" name="route_sem" value="1학기" checked="checked">1학기
							</td>
							<td>
								<input type="radio" name="route_sem" value="여름방학">여름방학
							</td>
							<td>
								<input type="radio" name="route_sem" value="2학기">2학기
							</td>
							<td>
								<input type="radio" name="route_sem" value="겨울방학">겨울방학
							</td>							
						</tr>						
					</table>		
					</div>				
					<input type="hidden" id="route_year" name="route_year">									
					<img src="images/button/button_list_80x25.png" class="action-button route_listBtn" onclick="location.replace('busRouteList')">
					<img src="images/button/button_next_80x25.png" class="next action-button route_nextBtn" name="next" >
	
				</fieldset>
				<fieldset id="fieldset_2">
<!-- 					<h2 class="fs-title">STEP2. 정류장을 배치해주세요.</h2>	 -->				
					
					<div class="routeForm">
						<div class="stepContent" >
							<label>코스이름</label><input type="text" class="big_input" name="course_name" id="course_name" value="${basedto[0].course_name }" />
						</div>
						
						<div class="stepTitle">
							<h3>정류장 선택 - 드래그 하여 배치도 위에 올려 주세요.</h3>
						</div>
						
						<!-- 원아지도 레이어 팝업 -->
						<div id="layerPop">
							<a href="#" onclick="closeLayer('layerPop')" class="close">X</a>
							<div class="layerPopContent">
								<div class="layerPopContent-Title">원아지도</div>
								<div class="layerPopContent-L">
									
								</div>
								<div class="layerPopContent-R">
									<div id="map2" style="width:100%;height:410px;"></div>
								</div>
							</div>
						</div>
						
							<!-- 원아지도 버튼 -->
						<div class="kidsMap">
							<input type="button" onclick="stationReset()" id="btn_reset_text" class="btn_reset_text">
							<input type="button" onclick="openLayer('layerPop',100,200)" id="btn_kisMap_text" class="btn_kisMap_text">
						</div>
						
							<!-- 정류장 도착시간 입력 팝업 -->
						<div>
							<div id="layerWindow" class="layerWindow">
								<span class="modalWindow"></span>
								<div class='miniMsgBox' id='miniMsgBox'></div>
								<div id="loginLayer" class="loginLayer loginTypeA">
			
									<div class="layerPopContent">
										<div class="arriveTitle">도착시간</div>
										<input id="timepicker1" type="text" name="timepicker1" placeholder="도착시간을 입력 해주세요." /> 
										<input id="timepickerStation" type="hidden" name="timepickerStation" /> 
			<!-- 							<a onclick="closeLayer2(timepickerStation.value)" style="cursor: hand">닫기</a>&nbsp; -->
										<script>
											$('#timepicker1').timepicki();
										</script>
			
									</div>
								</div>
							</div>
						</div>
						<div>
							<div id="layerWindow1" class="layerWindow">
								<span class="modalWindow"></span>
								<div class='miniMsgBox' id='miniMsgBox'></div>
								<div id="loginLayer1" class="loginLayer loginTypeA">
			
									<div class="layerPopContent">
										<div class="arriveTitle">도착시간</div>
										<input id="timepicker2" type="text" name="timepicker1" placeholder="도착시간을 입력 해주세요." /> 

										<script>
											$('#timepicker2').timepicki();
										</script>
									</div>
								</div>
							</div>
						</div>
						<%
							int cnt = 1;
						%>
						<div class="stationPart" id="stationPart">
							<div class="hiddenStArray" id="hiddenStArray">
								<div id="firstStation">
									<input type='hidden' name='station_id' id='stnstation0' class="stnstation"> 
									<input type='hidden' name='arrive_time' id='sttstation0'> 
									<input type="hidden" name="route_arrive" id="route_arrive" />
								</div>								
							</div>
							
							<c:set var="length" value="${fn:length(stationList)}" />
							<!-- 정류장 목록   정류장 드래그 할 리스트 -->
							<div class="busRouteForm_stationContent">
								<div class="busRouteForm_stationTitle">
									정류장 목록
								</div>
								<div class="busRouteForm_StationList" id="busRouteForm_StationList">
								<c:forEach var="obj" items="${stationList}" varStatus="s">
									<div id="stationList${s.index}"  class='stationList'>
										<div id="stnstation<%=cnt%>"
											class="stationBox ui-draggable-handle">
											<div id="${obj.station_id}">${obj.station_name}</div>
											<input type="hidden" id="latitude<%=cnt%>" value="${obj.latitude}"> 
											<input type="hidden" id="longitude<%=cnt%>" value="${obj.longitude}">
										</div>
										<span id="stationSpan${s.count}">${obj.station_addr}</span>
									</div>
									<%
										cnt += 1;
									%>
								</c:forEach>
								</div>
							</div>
				
							<!-- 드롭 하는 DIV  정류장 배치 하는 곳 -->
							<div class="stationDropZone_content">
							<div class="TimeViewer">
								<div class="stationSetTime" id="stationSetTime_start"></div>
								<div class="stationSetTime" id="stationSetTime_end">도착시간 : </div>
								<div style="position: relative;display: inline-block;float: right;top: -4px;"><img src="images/button/button_endtime_75x25(x2).png" class="stationSetTime_end_set" onclick="openLayer3()" ></div>
							</div>	
							<div class="stationDropZone" id="stationDropZone">
														
								<div id="" class="stationStartCenter">
									<div class='routeStation_Station'>출발</div>
									<div class='routeStation_Time' id="routeStation_Time"></div>
									<div class='routeStation_dragDot'></div>
									<div class='routeLeftLine'></div>
								</div>
				
								<div class="stationInRouteZone">
									<%
										Object list_Length_o = pageContext.getAttribute("length");
										String list_Length_s = list_Length_o.toString();
										int list_Length_i = Integer.parseInt(list_Length_s);
										int lineCnt = 3; //한 줄에 있는 정류장 수
										boolean leftRight = false;
				
										for (int listCnt = 0; listCnt < list_Length_i; listCnt++) {
											if (!leftRight) {
												if (listCnt % lineCnt == lineCnt - 1 && listCnt < lineCnt) {
									%>
													<div class='stationsort stationsort_LeftTop'
														id="stationsort<%=listCnt%>">
								
														<div id="boards<%=listCnt%>"
															class="station_dropZone station_dropZoneN"></div>
														<div class='routeLeftBottomLine routeLine'></div>
														<!-- 							<div class='routeRightLine'></div> -->
													</div>
									<%
													leftRight = true;
												} 
										else if (listCnt % lineCnt == lineCnt - 1 && listCnt >= lineCnt) {
											if ((list_Length_i - 1) == listCnt) {
									%>
												<div class='stationsort stationsort_LeftTop routeMarginTopM' id="stationsort<%=listCnt%>">
							
													<div id="boards<%=listCnt%>" class="station_dropZone station_dropZoneN"></div>
													<!-- <div class='routeRightLine'></div> -->
												</div>
									<%
											} 
											else {
									%>
												<div class='stationsort stationsort_LeftTop routeMarginTopM' id="stationsort<%=listCnt%>">
							
													<div id="boards<%=listCnt%>" class="station_dropZone station_dropZoneN"></div>
													<div class='routeLeftBottomLine routeLine'></div>
													<!-- 							<div class='routeRightLine'></div> -->
												</div>
									<%
												leftRight = true;
													}
												} else {
													if (listCnt < lineCnt) {
									%>
														<div class='stationsort stationsort_Left '
															id="stationsort<%=listCnt%>">
															<div id="boards<%=listCnt%>" class="station_dropZone station_dropZoneN"></div>
															<div class='routeLeftLine routeLine'></div>
															<!-- 							<div class='routeRightLine'></div> -->
														</div>
									<%
													} 
													else {
									%>
														<div class='stationsort stationsort_Left routeMarginTopM'
															id="stationsort<%=listCnt%>">
															<div id="boards<%=listCnt%>" class="station_dropZone station_dropZoneN"></div>
															<div class='routeLeftLine routeLine'></div>
															<!-- 							<div class='routeRightLine'></div> -->
														</div>
									<%
													}
												}
											} 
											else {
												if (listCnt % lineCnt == lineCnt - 1 && listCnt > 0) {
									%>
													<div class='stationsort stationsort_RightTop routeMarginTopM' id="stationsort<%=listCnt%>">
														<!-- 								<div class='routeLeftLine'></div> -->
														<div id="boards<%=listCnt%>" class="station_dropZone station_dropZoneN"></div>
														<div class='routeRightBottomLine routeLine'></div>
													</div>
									<%
													leftRight = false;
												} 
												else {
									%>
													<div class='stationsort stationsort_Right routeMarginTopM' id="stationsort<%=listCnt%>">
														<!-- 								<div class='routeLeftLine'></div> -->
														<div id="boards<%=listCnt%>" class="station_dropZone station_dropZoneN"></div>
														<div class='routeRightLine routeLine'></div>
													</div>
									<%
												}
											}
										}
									%>
								</div>
							</div>
							</div>
						</div>
					</div>
						<img src="images/button/button_back_80x25.png" class="previous action-button route_preBtn" name="previous" >						
						<img src="images/button/button_next_80x25.png" class="next action-button route_nextBtn" name="next" >
				</fieldset>
				<fieldset id="fieldset_3">
					<div class="kidsList_content">
						<div class="kidsList_Left_subTitle">정류장을 선택-드래그하여 배치도 위에 올려주세요.</div>
						<div class="kidsList_Left_content">
							<div class="kidsList_Left_title">정류장 목록</div>
							
							<div id="kidsCollocate" class="kidsCollocate">
								<div>
									<div class="startStation_Icon" style="display: inline-block;">
										
									</div>
									<div class="kids_startTopContent" style="display: inline-block;">
										출발
									</div>
									<div class="kids_startBottomContent" style="display: inline-block;">
	
									</div>
								</div>																					
							</div>
						</div>
						
						<div class="kidsList_Right_content">
							<div class="kidsList_Right_title">원아 위치</div>
							<div id="map" class="kidsCollocate2"></div>
						</div>						
					</div>										
						<img src="images/button/button_back_80x25.png" class="previous action-button route_preBtn" name="previous" >
						<img src="images/button/button_next_80x25.png" class="next action-button route_nextBtn" name="next" >

						
						<div  id ="kidsList" class="kidsList" style="display: none;"> <!-- 원아 전체목록 div(임시) -->
						<input type="hidden" id="cnterLa" name="centerLa">
						<input type="hidden" id="cnterLo" name="centerLo">
						<div class="kidsList_title">원아목록</div>
						<a href="#" onclick="canclebtn()" style="position: absolute;top: 10px;right: 19px;">X</a>						
						<div class="kidsList_content">			
								<c:forEach items="${kidList}" var="dto" varStatus="status">	

										<div class="kidsList_content_kid">
										
											<div>
											<label for="chk_kids${status.index}">											
											<c:choose>
												<c:when test="${empty dto.kid_pho}">
													<img src="images/image_ujacar_290x290.png" class="kidsList_content_kidImg">
												</c:when>
												
												<c:otherwise>
													<img src="${dto.kid_pho}" class="kidsList_content_kidImg"> 	
												</c:otherwise>
											</c:choose>																			
											${dto.kid_name}</label> </div>																													
											<input type="checkbox" class="kidsList_content_checkBox" id="chk_kids${status.index}" name="chk_kids" value="${dto.kid_system_code}">
											<input type="hidden" id="homeLatitude${status.count}" value="${dto.latitude}"/>
											<input type="hidden" id="homeLongitude${status.count}" value="${dto.longitude}"/>
										</div>			
								</c:forEach>
						</div>	

							<div style="text-align: center; width: 80px;height: 25px;margin: 12px auto;">
							<img src="images/button/button_done_80x25.png" onclick="chooseKids()" style="width: 80px;height: 25px;border-radius: 0%;cursor: pointer;">
							</div>			
						</div>						
				</fieldset>
				<fieldset id="fieldset_4">
					<div class="BusCollocate_subTitle">차량 선택 - 선택 버튼을 클릭 하여  주세요.</div>
						<div class="cusListTable6 cusTableCenter">												
							<div>	
							<table id="BusCollocate_title">
							<tr>
								<th class="BusCollocate_carName">차량명</th>
								<th class="BusCollocate_carNum">차량번호</th>
								<th class="BusCollocate_carDriverPho">&nbsp;</th>	
								<th class="BusCollocate_carDriver">운전자</th>	
								<th class="BusCollocate_carUseCheck">배치여부</th>
								<th class="BusCollocate_carArriveTime">도착예정시각</th>							
								<th class="BusCollocate_carChoosebtn">&nbsp;</th>						
							</tr>
							</table>
							</div>
							<div class="BusCollocate_content">	
							<table id="BusCollocate">
							<c:forEach items="${carList}" var="dto">	
								<tr>
									<td class="BusCollocate_carName">${dto.bus_name}</td>
									<td class="BusCollocate_carNum">${dto.bus_num}</td>
									<c:choose>
											<c:when test="${empty dto.staff_phot}">
												<td class="BusCollocate_carDriverPho"><img class='BusCollocate_pho' src="images/image_ujacar_290x290.png"></td>
											</c:when>
											
											<c:otherwise>
												<td class="BusCollocate_carDriverPho"><img class='BusCollocate_pho' src="${dto.staff_phot}"></td>	
											</c:otherwise>
									</c:choose>										
									<td class="BusCollocate_carDriver">${dto.staff_name}</td>																					
								</tr>
							</c:forEach>																		
							</table>
							</div>							
						</div>
					<input type="hidden" name="bus_id" id="busRouteForm_Bus_Id"/>
					<img src="images/button/button_back_80x25.png" class="previous action-button route_preBtn" name="previous" >
						<img src="images/button/button_next_80x25.png" class="next action-button route_nextBtn" name="next" >
				</fieldset>
				<fieldset id="fieldset_5">
									
					<div class="TeacherCollocate">
						<div class="TeacherCollocate_subTitle">인솔교사를 1명이상 선택해주세요.</div>
						<div class="cusListTable1-L">								
	<!-- 							<div class="mainTeacher">									 -->
	<!-- 							<label>주교사</label> -->
							<input type="hidden" class="big_input" name="main_staff_id" id="main_staff_id" readonly="readonly"/>
	<!-- 							</div> -->
								<div style="width: 463px;height: 27px;">
								<table style="font-size: 13px">
								<tr>	
									<th class="TeacherCollocate_TeacherPho">&nbsp;</th>																
									<th class="TeacherCollocate_TeacherName">주교사</th>																																		
									<th class="TeacherCollocate_route">배치여부</th>
									<th class="TeacherCollocate_ArriveTime">도착 예정시간</th>
									<th class="TeacherCollocate_TeacherChooseBtn">선택</th>						
								</tr>
								</table>
								</div>
								<div style="width: 463px;height: 400px; overflow-Y: auto;overflow-x: hidden;">
								<table id="TeacherCollocate1">
								<c:forEach items="${staffList}" var="dto">	
								<tr>
									<c:choose>
										<c:when test="${empty dto.staff_phot}">													
											<td class="TeacherCollocate_TeacherPho"><img src="images/image_ujacar_290x290.png" class="TeacherCollocate_pho"></td>	
										</c:when>
										
										<c:otherwise>
											<td class="TeacherCollocate_TeacherPho"><img src="${dto.staff_phot}" class="TeacherCollocate_pho"></td>	
										</c:otherwise>
									</c:choose>							
									<td class="TeacherCollocate_TeacherName">${dto.staff_name}</td>																										
								</tr>
							</c:forEach>																			
							</table>
							</div>
						</div>
						<div class="cusListTable1-R">
	<!-- 							<div class="subTeacher">									 -->
	<!-- 							<label>부교사</label> -->
								<input type="hidden" class="big_input" name="sub_staff_id" id="sub_staff_id" readonly="readonly"/>							
	<!-- 							</div> -->							
								<div style="width: 463px;height: 27px;">
								<table style="font-size: 13px">
								<tr>									
									<th class="TeacherCollocate_TeacherPho">&nbsp;</th>																
									<th class="TeacherCollocate_TeacherName">부교사</th>																																		
									<th class="TeacherCollocate_route">배치여부</th>
									<th class="TeacherCollocate_ArriveTime">도착 예정시간</th>
									<th class="TeacherCollocate_TeacherChooseBtn">선택</th>				
								</tr>
								</table>
								</div>
								<div style="width: 463px;height: 400px; overflow-Y: auto;overflow-x: hidden;">
								<table id="TeacherCollocate2">
									<c:forEach items="${staffList}" var="dto">	
									<tr>
										<c:choose>
											<c:when test="${empty dto.staff_phot}">													
												<td class="TeacherCollocate_TeacherPho"><img src="images/image_ujacar_290x290.png" class="TeacherCollocate_pho"></td>	
											</c:when>
											
											<c:otherwise>
												<td class="TeacherCollocate_TeacherPho"><img src="${dto.staff_phot}" class="TeacherCollocate_pho"></td>	
											</c:otherwise>
										</c:choose>	
										<td class="TeacherCollocate_TeacherName">${dto.staff_name}</td>																										
									</tr>	
									</c:forEach>																		
								</table>
								</div>
							</div>
						</div>					
		
					<img src="images/button/button_back_80x25.png" class="previous action-button route_preBtn" name="previous" >					
					<input type="image" src="images/button/button_done_80x25.png"class="submit action-button route_finBtn" name="submit">		
				</fieldset>
				<input type="hidden" name="registrant" id="registrant" value="${registrant}" >
				<input type="hidden" name="affiliation" id="affiliation" value="${center_code}" >
				<input type="hidden" name="route_id" id="route_id" value="${basedto[0].route_id }">
				<input type="hidden" name="course_id" id="course_id" value="${basedto[0].course_id }">	
			</div>
			</form>	
		</div>	
	</div>
	
	<script>
		$(document).ready(function(){	
			var str = "${baseRouteList[0].route_type}";			
			$("input:radio[name='route_type']:radio[value="+str+"]").prop("checked",true);

			var str1 = "${baseRouteList[0].route_use}";		
			$("input:radio[name='route_use']:radio[value="+str1+"]").prop("checked",true);
			
			var str2 = "${baseRouteList[0].route_sem}";			
			$("input:radio[name='route_sem']:radio[value="+str2+"]").prop("checked",true);
		}); //탑승인원 수정전 데이터 체크
	</script><!-- 수정전 데이터 미리표시 -->	

	<script>	 	
	$(document).ready(function(){
		var now = new Date();
	    var year= now.getFullYear(); // 년
	    
      $("#route_year").val(year);  
	    
      $("#stnstation0").val("${center_code}"+"_S0_00"); 
      
		 
	});//년도,시간 저장, 루트/코스 max 값 검색, SO_00 설정
	
	$('#route_start').timepicki();
	var check_Route_type = "";
	
	if("${baseRouteList[0].route_type}"=='등원'){
		$("input[name=chk_kids]").each(function() {
			var kid_id = $(this).val();
			var checkbase = true;
			<c:forEach items="${kidList}" var="dto" varStatus="status">	 				
				if(("${dto.kid_system_code}"==kid_id) && ("${dto.routeOnExists}" == '1')){
					<c:forEach items="${baseKid}" var="baseKid_dto" varStatus="baseKid_status">	
						if("${baseKid_dto}"==kid_id)
							checkbase = false;
					</c:forEach>  
					if(checkbase){
						$(this).attr("disabled", true);
						$(this).parent().children('div').css("background-color", "#c1c1c1");
//							$(this).parent().children('div').append("<img src='images/image_xxx_BK_64x56.png'class='disableImg'>");
						$(this).parent().children('div').children('label').css("cursor","default");
						$(this).parent().children('div').css("padding", "7px 4px");
						$(this).parent().children('div').css("border", "1px solid #f1f1f1");
						$(this).parent().children('div').css("border-radius", "2px");
						$(this).parent().children('div').css("width", "48px");
					}	
					checkbase = true;
				}
				</c:forEach>   		
		})
	}else{
		$("input[name=chk_kids]").each(function() {
			var kid_id = $(this).val();
			var checkbase = true;
			<c:forEach items="${kidList}" var="dto" varStatus="status">	 				
				if(("${dto.kid_system_code}"==kid_id) && ("${dto.routeOffExists}" == '1')){
					<c:forEach items="${baseKid}" var="baseKid_dto" varStatus="baseKid_status">	
						if("${baseKid_dto}"==kid_id)
							checkbase = false;
					</c:forEach>  
					if(checkbase){
						$(this).attr("disabled", true);
						$(this).parent().children('div').css("background-color", "#c1c1c1");
//							$(this).parent().children('div').append("<img src='images/image_xxx_BK_64x56.png'class='disableImg'>");
						$(this).parent().children('div').children('label').css("cursor","default");
						$(this).parent().children('div').css("padding", "7px 4px");
						$(this).parent().children('div').css("border", "1px solid #f1f1f1");
						$(this).parent().children('div').css("border-radius", "2px");
						$(this).parent().children('div').css("width", "48px");
					}	
					checkbase = true;
				}
				</c:forEach>   		
		})
	}
		   $('input[type=radio][name=route_type]').change(function() {
		   $('.cancleKids').remove();
			 $("input[name=chk_kids]").each(function() {				 
				 $(this).parent().css("display", "inline-block");			
				 $(this).parent().children('div').removeAttr( 'style' );				
			 })
		   
	        if (this.value == '등원') {
	        	$("input[name=chk_kids]:disabled").each(function() {
					$(this).parent().children('div').removeAttr( 'style' );
	        		$(this).attr("disabled", false);
	        	})
	        	$("input[name=chk_kids]").each(function() {
	        		var kid_id = $(this).val();		
	        		var checkbase = true;
	        		<c:forEach items="${kidList}" var="dto" varStatus="status">	 				
	 				if(("${dto.kid_system_code}"==kid_id) && "${dto.routeOnExists}" == '1'){
	 					<c:forEach items="${baseKid}" var="baseKid_dto" varStatus="baseKid_status">	
						if("${baseKid_dto}"==kid_id)
							checkbase = false;
						</c:forEach>  
						if(checkbase){
							$(this).attr("disabled", true);
		 					$(this).parent().children('div').css("background-color", "#c1c1c1");
							$(this).parent().children('div').children('label').css("cursor","default");
							$(this).parent().children('div').css("padding", "7px 2px");
							$(this).parent().children('div').css("border", "1px solid #f1f1f1");
							$(this).parent().children('div').css("border-radius", "4px");
							$(this).parent().children('div').css("width", "48px");
						}
						checkbase = true;
	 				}
	 				</c:forEach>
	         		
	        	})
	        }
	        else if (this.value == '하원') {
	        	$("input[name=chk_kids]:disabled").each(function() {
					$(this).parent().children('div').removeAttr( 'style' );
	        		$(this).attr("disabled", false);
	        	})
	        	$("input[name=chk_kids]").each(function() {
	        		var kid_id = $(this).val();
	        		var checkbase = true;
	        		<c:forEach items="${kidList}" var="dto" varStatus="status">	 				
	 				if(("${dto.kid_system_code}"==kid_id) && "${dto.routeOffExists}" == '1'){
	 					<c:forEach items="${baseKid}" var="baseKid_dto" varStatus="baseKid_status">	
						if("${baseKid_dto}"==kid_id)
							checkbase = false;
						</c:forEach>  
						if(checkbase){
							$(this).attr("disabled", true);
		 					$(this).parent().children('div').css("background-color", "#c1c1c1");
							$(this).parent().children('div').children('label').css("cursor","default");
							$(this).parent().children('div').css("padding", "7px 2px");
							$(this).parent().children('div').css("border", "1px solid #f1f1f1");
							$(this).parent().children('div').css("border-radius", "4px");
							$(this).parent().children('div').css("width", "48px");
						}
						checkbase = true;
	 				}
	 				</c:forEach>
	         		
	        	})
	        }
	    });
	
		$(".kidsList_content_checkBox").change(function(){
			 if($(this).is(":checked")){
				 $(this).parent().children('div').css("background-color", "#ebbc27");
					$(this).parent().children('div').children('label').css("cursor","default");
					$(this).parent().children('div').css("padding", "7px 2px");
					$(this).parent().children('div').css("border", "1px solid #f1f1f1");
					$(this).parent().children('div').css("border-radius", "4px");
					$(this).parent().children('div').css("width", "48px");
		        }else{
		        	$(this).parent().children('div').removeAttr( 'style' );
		        }
			
	   });
	</script>
	
	<script>
	$(function() {		
		$.validator.addMethod("regex", function(value, element, regexpr) {          
		     return regexpr.test(value);
		   });
		
		$.validator.addMethod("station", function(value, element, params) {          
		     return params > 2;
		   });
		
		$("#busRouteForm_form").validate({
			errorClass: "validFail",
			validClass: "validSuccess",
			onfocusout: false,
			onkeyup: false,
			onclick : false,
			ignore : "",
			
		    rules: {
		    	route_name : {
		    		required: true,
		    		regex: /^[가-힣\s|a-z|A-Z|0-9]{2,6}$/
		    	},
		    	route_start : {
		    		required: true
		    	},		    	
		    	route_type : {
		    		required: true
		    	},
		    	route_sem : {
		    		required: true
		    	}
		    },
		    messages: {
		    	route_name: {
		    		 required: "노선명을 입력해주세요",
		    		 regex : "노선명은 최소2자 이상 6자 이하만 가능 합니다."		    		
		        },
		    	route_start : {
		    		required: "출발 시간을 입력해주세요"	
		    	},		    	
		    	route_type : {
		    		required: "등/하원을 선택해주세요"
		    	},
		    	route_sem : {
		    		required: "운행 학기를 선택해주세요"
		    	}
		    }, 	
		    success: function(label) {
//              label.addClass("validSuccess").text("정상입니다.");		   		
		    },
		    invalidHandler: function(form, validator){ //입력값이 잘못된 상태에서 submit 할때 호출
				var errors = validator.numberOfInvalids();
				if (errors) {						
					validator.errorList[0].element.focus();
					$('#msgBox').empty();	        	
		        	$('#msgBox').removeClass("msgBox_Success");
		        	$('#msgBox').addClass("msgBox_Error");
		        	$('#msgBox').html(validator.errorList[0].message);
		        	document.getElementById('msgBox').style.display="block";
				} 
			},
			errorPlacement: function(error, element)
		    {	
				if(element.attr("name")=='route_type'){
		        	error.appendTo( element.parents('#Step1_routeType') );
		        }
				else if(element.attr("name")=='route_sem'){
					error.appendTo( element.parents('#Step1_routeSem') );
				}
		        else
		        { // This is the default behavior
//		            error.insertAfter( element );
		        }
		    }
		});	
	});
	</script> <!-- 유효성검사 -->
		
	<script>
	function stationUseClick(thisId,chk_val){
		if(chk_val==1){
			$('#'+thisId).val('false');	
		}else{
			$('#'+thisId).val('true');
		}
	}
	
	function checkRoute(obj,bus_id) {			
		var tr = $(obj).parent().parent();
	    var td = tr.children();
		
		if(td.eq(4).text()=="-"){
			$("#BusCollocate tr").removeClass("active"); 
			tr.addClass("active");
			$("#busRouteForm_Bus_Id").val(bus_id);
		}
		else{			
			event.preventDefault();
  			return false;
		}
								
	}
	</script><!--차량 배치-->
	

	<script>	
	function checkTeacher(obj,staff_id,num) {		
		//main_staff_id,sub_staff_id
		var tr = $(obj).parent().parent();
	    var td = tr.children();
	    
	    $('#msgBox').removeClass("msgBox_Success");	
		$('#msgBox').removeClass("msgBox_Error");
		document.getElementById('msgBox').style.display="none";

	    if(num=="1"){	
	    	if($("#sub_staff_id").val()==staff_id){
	    		$('#msgBox').addClass("msgBox_Error");
	 	        $('#msgBox').html("<span>주교사와 부교사는 중복 선택 될 수 없습니다.</span>");
	 	        document.getElementById('msgBox').style.display="block";
	    		event.preventDefault();
	  			return false;
	    	}
	    	else{
	    		if(td.eq(2).text()=="-"){
					$("#TeacherCollocate1 tr").removeClass("active"); 
					tr.addClass("active");
					$("#main_staff_id").val(staff_id);
					
				}
				else{			
					event.preventDefault();
		  			return false;
				}
	    	}		    	
	    }
	    else{
	    	if($("#main_staff_id").val()==staff_id){
	    		$('#msgBox').addClass("msgBox_Error");
	 	        $('#msgBox').html("<span>주교사와 부교사는 중복 선택 될 수 없습니다.</span>");
	 	        document.getElementById('msgBox').style.display="block";
	    		event.preventDefault();
	  			return false;
	    	}
	    	else{
	    		if(td.eq(2).text()=="-"){
					$("#TeacherCollocate2 tr").removeClass("active"); 
					tr.addClass("active");
					$("#sub_staff_id").val(staff_id);	
				}
				else{			
					event.preventDefault();
		  			return false;
				}
	    	}		    	
	    } 	   
    }
	</script><!--인솔교사  배치-->

<!--스탭관련 스크립트  -->
	<script>
	$(function() {
	var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
	//jQuery time
	var current_fs, next_fs, previous_fs; //fieldsets
	var left, opacity, scale; //fieldset properties which we will animate
	var animating; //flag to prevent quick multi-click glitches
	var step2 = false; //정류장배치 스탭 내용 표시 했는지 여부 파악
	var step3 = false; //원아배치 스탭 내용 표시 했는지 여부 파악
	var step4 = false; //차량배치 스탭 내용 표시 했는지 여부 파악
	var step5 = false; //교사 배치 스탭 내용 표시 했는지 여부 파악
	$(".next").click(function(){
		if($("#busRouteForm_form").valid()){
			if(animating) return false;
			animating = true;
			var resultTime="";
			var resultRoute="";

			$('#msgBox').removeClass("msgBox_Success");	
			$('#msgBox').removeClass("msgBox_Error");
			document.getElementById('msgBox').style.display="none";
			
			current_fs = $(this).parent();
			next_fs = $(this).parent().next();		
		
	 		//activate next step on progressbar using the index of next_fs	 		
	 		if(($(this).parent().next().attr("id")=="fieldset_2")){
	 			if(!step2){
	 				step2 = true;
	 			}	 
	 			
	 			$('#msgBox').removeClass("msgBox_Success");	
				$('#msgBox').removeClass("msgBox_Error");
				document.getElementById('msgBox').style.display="none";
				
				
				$("#sttstation0").val($("#route_start").val());	 
	 			$("#routeStation_Time").html($("#route_start").val());	
	 			$("#stationSetTime_start").text("출발 시간 : "+$("#route_start").val() + " ~ "); 

	 			<c:forEach items="${routeList}" var="dto" varStatus="status">	 
 				if("${dto.route_name}"==$('#route_name').val()){
 					if("${dto.route_name}"=="${baseRouteList[0].route_name}"){
 						console.log("원래꺼랑 같은거");
 					}
 					else{ 						
 						$('#msgBox').addClass("msgBox_Error");
 		 	            $('#msgBox').html("<span>노선 이름이 중복 됩니다.</span>");
 		 	            document.getElementById('msgBox').style.display="block";
	 					animating = false;	 				
		 	  			return false;
 					} 					
 				}
 				</c:forEach>
	 			
	 			$( "#course_name" ).rules( "add", {
	 				  required: true,	
	 				 regex: /^[가-힣\s|a-z|A-Z|0-9]{2,6}$/,
	 				  messages: {
	 				    required: "코스이름을 입력 하세요",
	 				    regex: "코스명은 2글자에서 6자 사이 입력해주세요."
	 				  }
	 			});	
	 			
	 			
			}
	 		else if(($(this).parent().next().attr("id")=="fieldset_3")){
	 			$('#msgBox').removeClass("msgBox_Success");	
				$('#msgBox').removeClass("msgBox_Error");
				document.getElementById('msgBox').style.display="none";
	 			if($('.stnstation').length<3){
	 				$('#msgBox').addClass("msgBox_Error");
	 	            $('#msgBox').html("<span>정류장을 최소 2대이상 배치해주세요.</span>");
	 	            document.getElementById('msgBox').style.display="block";
	 				animating = false;	 				
	 	  			return false;
	 			}	 
	 			else if($("#route_arrive").val()==""){	
	 				$('#msgBox').addClass("msgBox_Error");
	 	            $('#msgBox').html("<span>도착시간을 설정해주세요.</span>");
	 	            document.getElementById('msgBox').style.display="block";	
	 				animating = false;	 				
	 	  			return false;
	 			}
	 			
	 			<c:forEach items="${routeList}" var="dto" varStatus="status">	 
 				if("${dto.course_name}"==$('#course_name').val()){
 					if("${dto.course_name}"=="${baseRouteList[0].course_name}"){
 					}
 					else{ 						
 						$('#msgBox').addClass("msgBox_Error");
 		 	            $('#msgBox').html("<span>코스이름이 중복됩니다.</span>");
 		 	            document.getElementById('msgBox').style.display="block";
	 					animating = false;	 				
		 	  			return false;
 					} 					
 				}
 				</c:forEach>
	 		
	 			if(!step3){
	 				$.ajax({  
	      	              url : 'checkCenter_position',
	      	              dataType : 'json',
	      	              type:'POST',
	      	              data : { "center_code" : 	$('#affiliation').val() }, 
	      	          	  beforeSend: function(xhr) {
		      		         xhr.setRequestHeader(header, token);
		      		   		},
	      	              success: function(result) {	            	 	      
	      	           	 
	      	           	   var size_data=result.positionList;  
	      	           
	      	          		for(var i=0; i < size_data.length; i ++){
	      	          			$('#cnterLa').val(result.positionList[i].latitude);	
	      	          			$('#cnterLo').val(result.positionList[i].longitude);
	      	          		}
	      	          		
	      		 			var centerLa = $('#cnterLa').val();				//유치원 위도
	      		 			var centerLo = $('#cnterLo').val();				//유치원 경도
//	      		 			 	console.log("centerLa :"+centerLa+"centerLo"+centerLo);

	      		 			var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
	      		 			    mapOption = { 
	      		 			        center: new daum.maps.LatLng(centerLa, centerLo), // 지도의 중심좌표
	      		 			        level: 4 // 지도의 확대 레벨
	      		 			    };

	      		 				var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	      		 				
	      		 				
	      		 				//유치원 마커
	      		 				// 마커가 표시될 위치입니다 
	      		 				var markerPosition  = new daum.maps.LatLng(centerLa, centerLo); 
	      		 				
	      		 				var imageSrc = 'images/marker/image_maker_U2_110x190.png', // 마커이미지의 주소입니다    
		      		 			imageSize = new daum.maps.Size(28, 48), // 마커이미지의 크기입니다
		      				    imageOption = {offset: new daum.maps.Point(14, 24)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
	      		 			    
	      		 			    var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imageOption);
	      		 			    
	      		 				// 마커를 생성합니다
	      		 				var marker = new daum.maps.Marker({
	      		 				    position: markerPosition,
	      		 				    image: markerImage
	      		 				});
	      		 				
	      		 				// 마커가 지도 위에 표시되도록 설정합니다
	      		 				marker.setMap(map);
	      		 				
	      		 			 	var positions = new Array();
	      		 			 	<c:forEach items="${kidList}" var="dto" varStatus="status">	
		 							
	  		 					var indexLa= "${dto.latitude}";			//원아 위도
	  		 					var indexLo="${dto.longitude}";			//원아 경도
	  		 					var str = "${dto.kid_name}";					//원아 이름
	  		 					
	  		 					var overCnt=0;
	  		 					
	  		 					var imageSrc = 'images/marker/image_maker_I2_110x190.png', // 마커이미지의 주소입니다    
	  						    imageSize = new daum.maps.Size(28, 48), // 마커이미지의 크기입니다
	  						    imageOption = {offset: new daum.maps.Point(14, 24)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
	  						    
	  		 				    
	  		 				    var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imageOption);
	  		 					positions["${status.count}"] ={
	  		 							content:'<div>'+str+'</div>', 
	  		 					        latlng: new daum.maps.LatLng(indexLa, indexLo)
	  		 					};
	  		 					
//	  		 			 		var j=7;
//	  		 			 		var posi2 = positions[7].latlng;
	  		 					
	  		 					var posi = positions["${status.count}"].latlng;
	  		 					var con = positions["${status.count}"].content;	
	  		 					
	  		 					for(var j=1;j<="${status.count}";j++){			//배열 중복 검사
	  		 						var posi2 = positions[j].latlng;
	  		 						
	  		 						if("${status.count}"!=j){
	  		 							if(posi.ib==posi2.ib&&posi.jb==posi2.jb){				
	  		 								var con =positions["${status.count}"].content +positions[j].content;	
	  		 							}
	  		 						}			
	  		 					}
	  		 					
	  		 					var marker = new daum.maps.Marker({
	  		 				        map: map, // 마커를 표시할 지도
	  		 				        position: posi, // 마커의 위치
	  		 				        image: markerImage
	  		 				    });
	  		 					// 마커에 표시할 인포윈도우를 생성합니다 
	  		 				    var infowindow = new daum.maps.InfoWindow({
	  		 				        content: con // 인포윈도우에 표시할 내용
	  		 				    });
	  		 					
	  		 				    daum.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
	  		 				    daum.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));	
	      		 			 	</c:forEach>
	      	              },
	      	              error:function(request,status,error){                 
	      	           	   alert("code:"+request.status+"\n"+"error:"+error);
	      	              }
	      	              
	      	          });	      			
		 			step3 = true;		 				 			
	 			}
	 			
			}//원아배치
	 		else if(($(this).parent().next().attr("id")=="fieldset_4")){
	 			var result="";
	 			var check=false;
	 			var count=0;
	 			$(".kidsCollocate_content").each(function() {	
	 				count += $(this).children(".kids_bottomContent").children("div").length;
	 				if($(this).children(".kids_bottomContent").children("div").length==0){
	 					result += $(this).children(".kids_topContent").text()+"\n";	
	 					check=true;
	 				}
	 				else{
	 					check=false;
	 				}
	 			});
	 			
	 			$('#msgBox').removeClass("msgBox_Success");	
				$('#msgBox').removeClass("msgBox_Error");
				document.getElementById('msgBox').style.display="none";
				
	 			if(check){
	 				$('#msgBox').addClass("msgBox_Error");
	 	            $('#msgBox').html("<span>"+result+"에 배치된 원아가 없습니다.</span>");
	 	            document.getElementById('msgBox').style.display="block";
	 				animating = false;		 				
	 	  			return false;
	 			}
	 			
	 			if(!step4){
	 				<c:forEach items="${carList}" var="dto" varStatus="status">
	 				$("#BusCollocate tr:eq('${status.index}')").children().eq(6).remove();
				 	$("#BusCollocate tr:eq('${status.index}')").children().eq(5).remove();
				 	$("#BusCollocate tr:eq('${status.index}')").children().eq(4).remove();	
	 				$.ajax({  
			            url : 'checkRoute',
			            dataType : 'json',
			            type:'POST',			            
			            
			            data : { "bus_id" : "${dto.bus_id}",
					            	 "route_start" : $("#route_start").val(),
					            	 "route_arrive" : $("#route_arrive").val()},
		            	 beforeSend: function(xhr) {
			     	            xhr.setRequestHeader(header, token);
			     	   		  },
			            success: function(result) { 
			            	 var size_data=result.routeList;

							 	if(size_data.length==0||"${dto.bus_id}"=="${baseRouteList[0].bus_id}")
				     	    	{							 		
							 		resultTime = "-";	
						 			resultRoute = "-";
						 			if(count>"${dto.bus_borad}"){
						 				$("#BusCollocate tr:eq('${status.index}')")
								 		.append("<td class='BusCollocate_carUseCheck'>"+resultRoute+"</td><td class='BusCollocate_carArriveTime'>"+resultTime+"</td><td class='BusCollocate_carChoosebtn'><img class='BusCollocate_choose' disabled=\"true\" src ='images/button/button_full_G_50x20.png' onclick=\"checkRoute(this,'${dto.bus_id}')\"/></td>");
						 			}																
						 			else{
						 				$("#BusCollocate tr:eq('${status.index}')")
								 		.append("<td class='BusCollocate_carUseCheck'>"+resultRoute+"</td><td class='BusCollocate_carArriveTime'>"+resultTime+"</td><td class='BusCollocate_carChoosebtn'><img class='BusCollocate_choose' src ='images/button/button_choice_50x20.png' onclick=\"checkRoute(this,'${dto.bus_id}')\"/></td>");
						 			}			
				     	    	}
							 	else
						 		{
							 		for(var i=0; i < size_data.length; i ++){
							 			resultTime = result.routeList[i].route_arrive;	
							 			resultRoute += result.routeList[i].route_name+" ";							 			
					          		}
							 		$("#BusCollocate tr:eq('${status.index}')")
							 		.append("<td class='BusCollocate_carUseCheck'>"+resultRoute+"</td><td class='BusCollocate_carArriveTime'>"+resultTime+"</td><td class='BusCollocate_carChoosebtn'><img class='BusCollocate_choose' disabled=\"true\" src ='images/button/button_notchoice_G_50x20.png' onclick=\"checkRoute(this,'${dto.bus_id}')\"/></td>");
						 		}
							 	
								resultTime="";
								resultRoute="";	
			            },
			            error:function(request,status,error){                 
			         	   alert("code:"+request.status+"\n"+"error:"+error);
			            }	            
			        });//<!--차량 노선배치여부-->
		 			</c:forEach>	 					 		
		 			step4 = false;//계속 갱신 해줘야 하기 때문에 계속 반복
	 			}
	 			$( "#busRouteForm_Bus_Id" ).rules( "add", {
	 				  required: true,	 			
	 				  messages: {
	 				    required: "차량을 선택하세요"	 				   
	 				  }
	 			});	 			
	 			
			}
	 		else if($(this).parent().next().attr("id")=="fieldset_5"){
	 			if(!step5){
	 				<c:forEach items="${staffList}" var="dto" varStatus="status">		
	 				$("#TeacherCollocate1 tr:eq('${status.index}')").children().eq(4).remove();
				 	$("#TeacherCollocate1 tr:eq('${status.index}')").children().eq(3).remove();
				 	$("#TeacherCollocate1 tr:eq('${status.index}')").children().eq(2).remove();	
				 	$("#TeacherCollocate2 tr:eq('${status.index}')").children().eq(4).remove();
				 	$("#TeacherCollocate2 tr:eq('${status.index}')").children().eq(3).remove();
				 	$("#TeacherCollocate2 tr:eq('${status.index}')").children().eq(2).remove();	
	 				$.ajax({  
		 	              url : 'checkTeacher',
		 	              dataType : 'json',
		 	              type:'POST', 
		 	              data : { "staff_id" : "${dto.staff_id}",
		 			            	 "route_start" : $("#route_start").val(),
		 			            	 "route_arrive" : $("#route_arrive").val()},              
		            	 beforeSend: function(xhr) {
 		     	            xhr.setRequestHeader(header, token);
 		     	   		  },
		            	 success: function(result) {         	 	      
		 	            	  
		 						var size_data=result.routeList;  
			 					if(size_data.length==0||"${dto.staff_id}"=="${baseRouteList[0].main_staff_id}"||"${dto.staff_id}"=="${baseRouteList[0].sub_staff_id}")
				     	    	{
							 		resultTime = "-";	
						 			resultRoute = "-";
						 			$("#TeacherCollocate1  tr:eq('${status.index}')")
							 		.append("<td class='TeacherCollocate_route'>"+resultRoute+"</td><td class='TeacherCollocate_ArriveTime'>"+resultTime+"</td><td class='TeacherCollocate_TeacherChooseBtn'><img class='TeacherCollocate_choose' src ='images/button/button_choice_50x20.png' onclick=\"checkTeacher(this,'${dto.staff_id}',1)\"/></td></tr>");
						 			
						 			$("#TeacherCollocate2  tr:eq('${status.index}')")
							 		.append("<td class='TeacherCollocate_route'>"+resultRoute+"</td><td class='TeacherCollocate_ArriveTime'>"+resultTime+"</td><td class='TeacherCollocate_TeacherChooseBtn'><img class='TeacherCollocate_choose' src ='images/button/button_choice_50x20.png' onclick=\"checkTeacher(this,'${dto.staff_id}',2)\"/></td>");
				     	    	
				     	    	}
							 	else
						 		{
							 		for(var i=0; i < size_data.length; i ++){
							 			resultTime = result.routeList[i].route_arrive;	
							 			resultRoute += result.routeList[i].route_name+" ";							 			
					          		}
							 		$("#TeacherCollocate1 tr:eq('${status.index}')")
							 		.append("<td class='TeacherCollocate_route'>"+resultRoute+"</td><td class='TeacherCollocate_ArriveTime'>"+resultTime+"</td><td class='TeacherCollocate_TeacherChooseBtn'><img class='TeacherCollocate_choose' disabled=\"true\" src ='images/button/button_notchoice_G_50x20.png' onclick=\"checkTeacher(this,'${dto.staff_id}',1)\"/></td>");
					          		
					          		$("#TeacherCollocate2  tr:eq('${status.index}')")
							 		.append("<td class='TeacherCollocate_route'>"+resultRoute+"</td><td class='TeacherCollocate_ArriveTime'>"+resultTime+"</td><td class='TeacherCollocate_TeacherChooseBtn'><img class='TeacherCollocate_choose' disabled=\"true\" src ='images/button/button_notchoice_G_50x20.png' onclick=\"checkTeacher(this,'${dto.staff_id}',2)\"/></td>");
						 		}							 	
								resultTime="";
								resultRoute="";		          		
		 	              },
		 	              error:function(request,status,error){                 
		 	           	   alert("code:"+request.status+"\n"+"error:"+error);
		 	              }
		 	              
		 	           });		 			
	 			</c:forEach>  					 			
	 			step5 = false;	 	
	 			}
	 			$( "#main_staff_id" ).rules( "add", {	 				 
	 				  required: true,	 			
	 				  messages: {
	 				    required: "메인교사를을 선택하세요"	 				   
	 				  }
	 				});	 					
	 		}
	 		$("#progressbar li").eq($("fieldset").index(current_fs)).removeClass("ready");
	 		$("#progressbar li").eq($("fieldset").index(current_fs)).removeClass("active");
	 		$("#progressbar li").eq($("fieldset").index(current_fs)).addClass("last");
	 		
	 		$("#progressbar li").eq($("fieldset").index(next_fs)).removeClass("ready");
	 		$("#progressbar li").eq($("fieldset").index(next_fs)).addClass("active");
	 		//show the next fieldset
	 		next_fs.show(); 
			//hide the current fieldset with style
			current_fs.animate({opacity: 0}, {
				step: function(now, mx) {
					//as the opacity of current_fs reduces to 0 - stored in "now"
					//1. scale current_fs down to 80%
					scale = 1 - (1 - now) * 0.2;
					//2. bring next_fs from the right(50%)
					left = (now * 50)+"%";
					//3. increase opacity of next_fs to 1 as it moves in
					opacity = 1 - now;
					current_fs.css({'transform': 'scale('+scale+')'});
					next_fs.css({'left': left, 'opacity': opacity});
				}, 
				duration: 800, 
				complete: function(){
					current_fs.hide();
					animating = false;
				}, 
				//this comes from the custom easing plugin
				easing: 'easeInOutBack'
			});
		}		
	});
	
	$(".previous").click(function(){
		if(animating) return false;
		animating = true;
		
		current_fs = $(this).parent();
		previous_fs = $(this).parent().prev();
		$('#msgBox').removeClass("msgBox_Success");	
		$('#msgBox').removeClass("msgBox_Error");
		document.getElementById('msgBox').style.display="none";
		
		//de-activate current step on progressbar
$("#progressbar li").eq($("fieldset").index(previous_fs)).removeClass("last");
	 	$("#progressbar li").eq($("fieldset").index(previous_fs)).addClass("active");
		$("#progressbar li").eq($("fieldset").index(current_fs)).removeClass("active");
		$("#progressbar li").eq($("fieldset").index(current_fs)).addClass("ready");
		if($(this).parent().prev().attr("id")=="fieldset_1"){
 			$( "#course_name" ).rules( "remove" ); 	
 			$("#route_arrive").val(""); 			
			$("#stationSetTime_end").text("도착시간 : ");
		}
		else if($(this).parent().prev().attr("id")=="fieldset_2"){
			$("#route_arrive").val("");		
			$("#stationSetTime_end").text("도착시간 : ");
		}
		else if($(this).parent().prev().attr("id")=="fieldset_3"){
 			$( "#busRouteForm_Bus_Id" ).rules( "remove" ); 			
		}
		else if($(this).parent().prev().attr("id")=="fieldset_4"){
			$( "#main_staff_id" ).rules( "remove" ); 	
		}
		
		//show the previous fieldset
		previous_fs.show(); 
		//hide the current fieldset with style
		current_fs.animate({opacity: 0}, {
			step: function(now, mx) {
				//as the opacity of current_fs reduces to 0 - stored in "now"
				//1. scale previous_fs from 80% to 100%
				scale = 0.8 + (1 - now) * 0.2;
				//2. take current_fs to the right(50%) - from 0%
				left = ((1-now) * 50)+"%";
				//3. increase opacity of previous_fs to 1 as it moves in
				opacity = 1 - now;
				current_fs.css({'left': left});
				previous_fs.css({'transform': 'scale('+scale+')', 'opacity': opacity});
			}, 
			duration: 800, 
			complete: function(){
				current_fs.hide();
				animating = false;
			}, 
			//this comes from the custom easing plugin
			easing: 'easeInOutBack'
		});
	});	
	});
	</script>
	<script type="text/javascript">	
	  var _gaq = _gaq || [];
	  _gaq.push(['_setAccount', 'UA-36251023-1']);
	  _gaq.push(['_setDomainName', 'jqueryscript.net']);
	  _gaq.push(['_trackPageview']);
	
	  (function() {
	    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
	    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
	    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
	  })();	
	</script>
<!--스탭관련 스크립트  -->

<!--정류장 배치 스크립트  -->
<script type="text/javascript">
	var map_check = false;
//레이어 팝업 열기
function openLayer(IdName, tpos, lpos){
	var pop = document.getElementById(IdName);	
	pop.style.display = "block";
	pop.style.top = tpos + "px";
	pop.style.left = lpos + "px";
	
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	
	if(!map_check){
		map_check = true;
		$.ajax({  
	          url : 'checkCenter_position',
	          dataType : 'json',
	          type:'POST',
	          data : { "center_code" : 	$('#affiliation').val() },              
	          beforeSend: function(xhr) {
		 	         xhr.setRequestHeader(header, token);
	 	   		},
	          success: function(result) {	            	 	      

	       	   var size_data=result.positionList;  
	       
	      		for(var i=0; i < size_data.length; i ++){
	      			$('#cnterLa').val(result.positionList[i].latitude);	
	      			$('#cnterLo').val(result.positionList[i].longitude);
	      		}
	      		
	 			var centerLa = $('#cnterLa').val();				//유치원 위도
	 			var centerLo = $('#cnterLo').val();				//유치원 경도
//	 			 	console.log("centerLa :"+centerLa+"centerLo"+centerLo);

	 			var mapContainer = document.getElementById('map2'), // 지도를 표시할 div  
	 			    mapOption = { 
	 			        center: new daum.maps.LatLng(centerLa, centerLo), // 지도의 중심좌표
	 			        level: 4 // 지도의 확대 레벨
	 			    };

	 				var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	 				
	 				
	 				//유치원 마커
	 				// 마커가 표시될 위치입니다 
	 				var markerPosition  = new daum.maps.LatLng(centerLa, centerLo); 
	 				
	 				var imageSrc = 'images/marker/image_maker_U2_110x190.png', // 마커이미지의 주소입니다    
	 			    imageSize = new daum.maps.Size(28, 48), // 마커이미지의 크기입니다
	 			    imageOption = {offset: new daum.maps.Point(14, 24)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
	 			    
	 			    var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imageOption);
	 			    
	 				// 마커를 생성합니다
	 				var marker = new daum.maps.Marker({
	 				    position: markerPosition,
	 				    image: markerImage
	 				});
	 				
	 				// 마커가 지도 위에 표시되도록 설정합니다
	 				marker.setMap(map);
	 				
	 			 	var positions = new Array();
	 			 	<c:forEach items="${kidList}" var="dto" varStatus="status">	
						
						var indexLa= "${dto.latitude}";			//원아 위도
						var indexLo="${dto.longitude}";			//원아 경도
						var str = "${dto.kid_name}";					//원아 이름
						
						var overCnt=0;
						
						var imageSrc = 'images/marker/image_maker_I2_110x190.png', // 마커이미지의 주소입니다    
					    imageSize = new daum.maps.Size(28, 48), // 마커이미지의 크기입니다
					    imageOption = {offset: new daum.maps.Point(14, 24)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
					    
					    
					    var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imageOption);
						positions["${status.count}"] ={
								content:'<div>'+str+'</div>', 
						        latlng: new daum.maps.LatLng(indexLa, indexLo)
						};
						
//				 		var j=7;
//				 		var posi2 = positions[7].latlng;
						
						var posi = positions["${status.count}"].latlng;
						var con = positions["${status.count}"].content;	
						
						for(var j=1;j<="${status.count}";j++){			//배열 중복 검사
							var posi2 = positions[j].latlng;
							
							if("${status.count}"!=j){
								if(posi.ib==posi2.ib&&posi.jb==posi2.jb){				
									var con =positions["${status.count}"].content +positions[j].content;	
								}
							}			
						}
						
						var marker = new daum.maps.Marker({
					        map: map, // 마커를 표시할 지도
					        position: posi, // 마커의 위치
					        image: markerImage
					    });
						// 마커에 표시할 인포윈도우를 생성합니다 
					    var infowindow = new daum.maps.InfoWindow({
					        content: con // 인포윈도우에 표시할 내용
					    });
						
					    daum.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
					    daum.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));	
	 			 	</c:forEach>
	          },
	          error:function(request,status,error){                 
	       	   alert("code:"+request.status+"\n"+"error:"+error);
	          }
	          
	      });
	}
}

//레이어 팝업 닫기 
function closeLayer(IdName){
	var idval = $('#timepicker1').val();
	var pop = document.getElementById(IdName);
	pop.style.display = "none";
}

function openLayer3(){	
	$('#layerWindow1').css('display','block');
    $(location).attr('href',"#layerWindow1");
}

function closeLayer3(){	
	
	var idval = $('#timepicker2').val();
	
	if(idval==""){
		alert("도착시간을 입력하세요");
		return false;
	}
	else{	
		$("#route_arrive").val(idval);
		document.getElementById('layerWindow1').style.display='none';
		$("#stationSetTime_end").text("도착시간 : " + idval)
	}   
}

function deleteRoute(stationName,cN,index,station_id){
	console.log("deleteRoute시작"+stationName+"////cn"+cN);

	console.log("index:"+stationName);
	console.log("cN :"+ cN);
	
	$(".ui-droppable #"+cN).remove();
	var plusli = document.createElement('li');

	plusli.innerHTML =  "<div class='stName' id='"+station_id+"'>"+stationName+"</div><span>"+index+"</span>";   

	document.getElementById('u').appendChild(plusli);
    plusli.className="dragNdrop ui-draggable-dragging draggable";
    plusli.id=cN;
	routeFx();
	$('#stn'+cN).parent().remove();
	var str="";
	
	$('#kidsCollocate_content'+station_id).children('div').eq(2).children('div').each(function(){
		str = $(this).children('input').eq(1).val();
		
		 $("input[name=chk_kids]").each(function() {
			 if($(this).val()==str){
				 $(this).parent().css("display", "inline-block");
			 }		
		 })
		
	});
	$('#kidsCollocate_content'+station_id).remove();
}
</script>

<!--원아 배치 스크립트  -->
<script>
var row_id;//추가버튼 클릭한 행 파악

function chooseKids() {		
	$("input[name=chk_kids]:checked").each(function() {
		 if($(this).parent().css("display") != "none"){
				var kid_id = $(this).val();	
				var kid_name = $('label[for='+this.id+']').text();
				var index = $(".kidsCollocate_content").index($("#kidsCollocate_content"+row_id+""));
				var kid_pho = $(this).parent().children('div').children('label').children('img').attr("src");
				
				$("#kids_bottomContent"+row_id+"")
			 	.append("<div class='cancleKids'><img src='"+kid_pho+"' class='cancleKids_img' />"+kid_name+"<input type=\"button\" value='×'onclick=\"cancleKids(this,\'"
			 			+kid_id+"\')\"/><input type='hidden' value='"+kid_id+"' name='board_and_kidDto["+index+"].kid_system_code'></div>");

				$(this).parent().css("display", "none");//checkbox 숨기기	
//		  		$(this).attr("checked", false);	
		 }
	})
	 document.getElementById("kidsList").style.display = "none";	
}//전체 원아 선택버튼

function addKids(id) {
	row_id = id; 
 	document.getElementById("kidsList").style.display = "";
}//정류장 원아 선택 선택버튼

function canclebtn() {
// 	$("input[name=chk_kids]").prop("checked",false);
// 	document.getElementById("kidsList").style.display = "none";
	
	$("input[name=chk_kids]:checked").each(function() {
		 if($(this).parent().css("display") != "none"){
			 $(this).parent().css("display", "inline-block");			
			 $(this).parent().children('div').removeAttr( 'style' );
			 $(this).attr("checked", false);
		 }		
	 });
	document.getElementById("kidsList").style.display = "none";
}//

function cancleKids(obj,id) {

	var kid_id = id;	
// 	var kid_name = $(obj).attr("name");	
	 $("input[name=chk_kids]").each(function() {
		 if($(this).val()==kid_id){
			 $(this).parent().css("display", "inline-block");			
			 $(this).parent().children('div').removeAttr( 'style' );
			 $(this).attr("checked", false);
		 }		
	 })
	$(obj).parent().remove();
}//정류장 원아 취소 선택버튼 
</script><!--전체 원아 선택버튼-->

<script>
// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
function makeOverListener(map, marker, infowindow) {
    return function() {
        infowindow.open(map, marker);
    };
}

// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
function makeOutListener(infowindow) {
    return function() {
        infowindow.close();
    };
}

</script>
<!--원아 배치 스크립트  -->

<script>	//드래그앤 드롭 정류장 배치
	$(function() {
		stationDragNDrop();
	});
	function stationDragNDrop(){
// 		console.log("stationDragNDrop 시작!!!!!!!!!!!!");
		$(".stationBox").draggable({
			revert : "invalid",
			refreshPositions : true,
			helper : 'clone',
			start : function(event, ui) {
				var dragId = $(this).attr("id");
				$(this).draggable("option", "revert", true);
				$("#beaconList .beaconBox").css("zIndex", 10);
				$(this).css("zIndex", 100);
			},
			stop : function(event, ui) {
				ui.helper.removeClass("draggable");
			}
		});

		$("#stationDropZone .station_dropZone")
			.droppable({
				drop : function(event, ui) {
					var droptitle = $(this).attr("title");
					var drophtml = $(this).html();
					var dropId = "#" + $(this).attr("id"); //dropZone안에 div
					var p_dropId = $(this).closest('div').attr("id");
					var dragid = "#" + ui.draggable.attr("id"); //옮기는 divId
					var p_dragid = ui.draggable.closest('div').attr('id'); //옳기는 div 위에 div
					var station_id = ui.draggable.children().attr("id");
					var station_name = $.trim(ui.draggable.children().text());
					
					console.log("dropId:"+dropId);
					console.log("p_dropId:"+p_dropId);
					console.log("dragid:"+dragid);
					console.log("station_id:"+station_id);
					console.log("station_name:"+station_name);
					
					var inDiv = $(dropId).hasClass('img').toString();
					var hasdrop = $(dropId).hasClass('uiDropped').toString();
					var dropzoneCnt = $('.stationDropZone .uiDropped').length; //dropzone 개수 

					var divIndex = dragid.substring(11);
					divIndex--;
					
					if (hasdrop == "false") {
						$(".busRouteForm_StationList #stationList"+divIndex).css("border-bottom","0");
						$("#stationList"+divIndex+" span").appendTo(dropId);						
						$('#layerWindow').css('display', 'block');
						$(location).attr('href', "#layerWindow");

						$(dragid).clone().appendTo(dropId); //
						$("#beacon_id" + divIndex).val(p_dragid);

						$(dropId + " " + dragid).css("position","static");
						ui.draggable.draggable("option", "revert",false);
						var droppableOffset = $(this).offset();
						var x = droppableOffset.left + 1;
						var y = droppableOffset.top + 1;
						ui.draggable.offset({
							top : "0",
							left : x
						});
						//    					$(dragid).css( "position","static" );
						//    					$(dragid).css( "top",y);
						$(dragid).css("left", x);
						$(dragid).css("left", x);
						$(dragid).css("margin-top", "-100px");
						$(dropId).addClass("uiDropped");

						document.getElementById("timepickerStation").value = dropId;
						var sttId = dragid.substring(1);
						var stbId = dropId.substring(1);
						var plusli = document.createElement('div');
						plusli.innerHTML = "<input type='hidden' class=\"stnstation\" value='"+station_id						+"' name='station_id' id='stn"+stbId
						+"'> <input type='hidden' name='arrive_time' id='stt"+stbId+"'>";
						document.getElementById('hiddenStArray').appendChild(plusli);

						$(dropId).append("<div class='routeStation_Time'></div>");
						$(dropId).append("<div class='routeStation_dragDot'></div>");
						
						//정류장 배치 시 x 버튼 (하나씩 삭제 하는 버튼)
// 						$(dropId).append("<a onclick=\"deleteStation('"
// 										+ p_dragid + "','"
// 										+ ui.draggable.attr('id')
// 										+ "','"
// 										+ $(this).attr("id")
// 										+ "','" + divIndex
// 										+ "');\">X</a>");
						
						//원아 배치 정류장 리스트
		            	var plusli0 = document.createElement('div');
		            	plusli0.setAttribute("id", "kidsCollocate_content"+station_id);
		            	plusli0.setAttribute("class", "kidsCollocate_content kidsCollocate_content_c");
		            	document.getElementById('kidsCollocate').appendChild(plusli0);
		            	
		            	var plusli1 = document.createElement('div');
		            	plusli1.setAttribute("class", "station_Icon");
		            	plusli1.innerHTML =  "";   
		            	document.getElementById('kidsCollocate_content'+station_id).appendChild(plusli1);
		            	            	           
		            	var plusli2 = document.createElement('div');
		            	plusli2.setAttribute("class", "kids_topContent");
		            	plusli2.setAttribute("id", "kids_topContent"+station_id);            	
		            	plusli2.innerHTML =  station_name;
		            	plusli2.innerHTML += "<img src='images/button/button_add_kids_60x15.png' onclick=\"addKids(\'"+station_id+"\')\"/>"
		//             	plusli2.innerHTML += "<input type=\"button\" value=\"원아 추가\" onclick=\"addKids(\'"+station_id+"\')\" />";
		            	document.getElementById('kidsCollocate_content'+station_id).appendChild(plusli2);
		            	
		            	var list_index =$(".kidsCollocate_content").index($("#kidsCollocate_content"+station_id+""));            	
		            	var plusli3 = document.createElement('div');
		            	plusli3.setAttribute("class", "kids_bottomContent");
		            	plusli3.setAttribute("id", "kids_bottomContent"+station_id); 
		            	plusli3.innerHTML = "<input type=\'hidden\' value=\'"+station_id+"\' name=\'board_and_kidDto["+list_index+"].station_id\'>";   	           	
		            	document.getElementById('kidsCollocate_content'+station_id).appendChild(plusli3);
						
						$("#stationList" + divIndex + " span").css('display', 'none');
						$("#stationList" + divIndex + " .routeRightLine").css('display', 'inline');
						$("#stationsort" + dropzoneCnt+ " .routeLine").css('display', 'inline');
						dropzoneCnt++;
						$("#boards" + dropzoneCnt).addClass("station_dropZoneN2");
						console.log("#stationsort" + dropzoneCnt+ " .routeLine");

					}
				}
			});
	}
	function deleteStation(dragId, dropId, dropZone, dropindex) {

		dragId = "#" + dragId;
		dropId = "#" + dropId;
		dropZone = "#" + dropZone;
		$(dropZone).removeClass("uiDropped");
		$(dropZone + " " + dragId).remove();
		dropZone = dropZone + " a";
		$(dropId).appendTo(dragId);

		$(dropZone).css("display", "none");
		$(dropId).css("margin-top", "0");
		$(dropId).css("top", "0");
		$(dropId).css("left", "0");
		$(dropId).css("position", "relative");

		$("#boards" + dropindex).empty();
		$("#boards" + dropindex).removeClass("station_dropZoneN2");
		$("#boards" + dropindex).addClass("station_dropZoneN");
		$("#stationList" + dropindex + " span").css('display', 'inline');

		var jbSplit = dropZone.split(' ');
		var temp = jbSplit[0].substring(1);
		$('#stn' + temp).parent().remove();

		if (dropindex == 0) {
			$("#boards" + dropindex).addClass("station_dropZoneN2");
			$("#boards" + dropindex).removeClass("station_dropZoneN");
		}
	}
	
	function closeLayer2(timepickerStation) {	// 정류장 배치 시 뜨는 타임피커 팝업 닫는 함수
		var check =true;
		
// 		console.log("idval:" + idval);
// 		console.log("timepickerStation:" + timepickerStation);
// 		if (idval == "") {
// 			alert("도착시간을 입력하세요");
// 			return false;
// 		} else {
// 			console.log("idval : " + idval + "/timepickerStation :"
// 					+ timepickerStation);
// 			var temp = timepickerStation.substring(1);
// 			$(timepickerStation + " .routeStation_Time").append(idval);
// 			$('#stt' + temp).val(idval);
// 			document.getElementById('layerWindow').style.display = 'none';
// 		}
		var temp = timepickerStation.substring(1);
		var checkTime = $(timepickerStation + " .routeStation_Time").val();
		if(check){
// 			console.log("checkTime:"+checkTime);
			
			var idval = $('#timepicker1').val();
			if(idval==""){
				alert("도착시간을 입력하세요");
				return false;
			}
// 			console.log("idval:"+idval);
			$(timepickerStation + " .routeStation_Time").html(idval);
			$('#stt' + temp).val(idval);
			document.getElementById('layerWindow').style.display = 'none';
			check = false;
		}
		
	}
	
	function stationReset(){					// 정류장 배치 초기화  함수
// 		$("#stationPart").load("busRouteForm #stationPart");
// 		stationDragNDrop();
// 		document.getElementById('stationPart').reload();

		var dropZoneCnt = $('.uiDropped').length;
		console.log("dropZoneCnt:"+dropZoneCnt);
		var i=1;
		var childIdArr = new Array();
		
		for(var i=0;i<dropZoneCnt;i++){
			childIdArr[i] = $("#boards"+i+" .stationBox").attr("id");			//ex) stnstation2
		}
// 		var childId = $("#boards0 .stationBox").attr("id");			//ex) stnstation2
		
		console.log("childIdl:"+childIdArr.length);
// 		$(dropId).appendTo(dragId);
		
// 		$(dropZone).css("display", "none");
																	
		
		var stationListCnt = $("busRouteForm_StationList .stationList").legnth;
		stationListCnt++;
    	
		
//     	console.log("addt : "+addr);
		
		for(var j=0;j<dropZoneCnt;j++){
			var stationListIndex =childIdArr[j].substring(10);
			var addr = $("#stationSpan"+stationListIndex).text();			// 주소 가져 옴
			stationListIndex--;
			console.log("stationListIndex:"+stationListIndex);
			
			
			$("#"+childIdArr[j]).css("margin-top", "0");
			$("#"+childIdArr[j]).css("top", "0");
			$("#"+childIdArr[j]).css("left", "0");
			$("#"+childIdArr[j]).css("z-index", "0");
			$("#"+childIdArr[j]).css("position", "relative");
			
			$("#"+childIdArr[j]).appendTo("#busRouteForm_StationList #stationList"+stationListCnt);
			
			$("#boards"+j).removeClass("uiDropped");
			$("#boards"+j).empty();
// 			$("#boards"+j).css('display','none');
			
			$("#stationsort"+j+" .routeLine").css("display", "none");
			
			$("#stationList"+stationListIndex).css("border-bottom","1px solid #c2c1c1");
			$("#stationList"+stationListIndex).append("<span id='stationSpan1'>"+addr+"</span>");
			
			if(j>0){		//dropzone 숨기기
				$("#boards"+j).addClass('station_dropZoneN');
				$("#boards"+j).removeClass('station_dropZoneN2');
			}
			if(j==(childIdArr.length-1)){
				$("#boards"+(j+1)).addClass('station_dropZoneN');
				$("#boards"+(j+1)).removeClass('station_dropZoneN2');
			}
				
		}
		
		 $("input[name=chk_kids]:checked").each(function() {
			 console.log("check : " +  $(this).parent());			 
		 	 $(this).parent().children('div').removeAttr( 'style' );	
			 $(this).parent().css("display", "inline-block");		
			 $(this).attr("checked", false);
		});
		
		$(".kidsCollocate_content").remove();	 
		
    	$("#route_arrive").val(""); 			
		$("#stationSetTime_end").text("도착시간 : ");

		$('#hiddenStArray div:not(:first)').remove();
    	
//     	$("#boards0 span").appendTo("#busRouteForm_StationList #stationList"+stationListCnt);
		
	}
</script>
</body>
</html>