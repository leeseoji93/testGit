<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ page import="java.util.*" %>
<%@ page import = "java.util.Calendar" %>
<jsp:include page="../include/menu_admin.jsp">
	<jsp:param name="pageInMenu" value="차량운행정보"  />
	<jsp:param name="pageCategory" value="운행이력관리"  />
	<jsp:param name="pageTitle" value="차량일일점검표"  /> 
</jsp:include>
<c:set value="${lastDay}" var="lastDay"/>
<%
int year, yearMin, yearMax;
int yearResult, yearCount;
int month ,monMin, monMax, monCount, monResult;
int date;
List<String> yearList = new ArrayList<String>();
Calendar now = Calendar.getInstance();

year = now.get(Calendar.YEAR);
month = now.get(Calendar.MONTH)+1;
date = now.get(Calendar.DATE);

yearMin = 2015; // 최소 연도는 '2015'
yearMax = now.get(Calendar.YEAR); // 최대 연도는 '현재연도 + 1'
yearCount = yearMax - yearMin;

monMin = 1;
monMax = 12;
monCount = monMax - monMin;

Calendar cal = Calendar.getInstance();

//입력받은 날짜의 그달의 마지막일을 구한다.
	String endDay_S = pageContext.getAttribute("lastDay").toString();
	int endDay = Integer.parseInt(endDay_S);
	//int 값을 String으로 형변환
// 	String endOfMonth = String.valueOf(endDay);
%>
	<div class="page">
		<div class="page-wrapper">
			<div class="pageTitle"><h2>차량운행일지 일일점검표 수정</h2></div>
			
			<div class="pageContent carCheckManagement_Update">
				<div class="checkManagement-SelectBox">
					<c:set value="${routeList}" var="dto_r"/>
					<c:set value="${re_Year}" var="dto_y"/>
					<c:set value="${re_Mon}" var="dto_m"/>
					<c:set value="${today}" var="today"/>
					<h3>${dto_y}년 ${dto_m}월 </h3>
				</div>		
				<c:set value="${dailycheckInfo}" var="dto_c"/>
				<form action="saveCheckManagement" name="checkManagement" id="checkManagement" method="post">
				<div class="checkManagement-Text">
					<table>
						<tr>
							<th width="80">노선명</th>
<%-- 							<td><span id="checkYear">${re_Year}</span>년 <span id="checkMonth">${re_Mon}</span>월</td> --%>
							<td width="140" id="carNum">${dto_r[0].route_name}</td>
							<th width="80">차량번호</th>
							<td width="140" id="carNum">${dto_c[0].bus_num}</td>
							<th width="80">운전자</th>
							<td width="140" id="carStaff">${dto_c[0].staff_name}</td>
						</tr>
						<tr>
							<th width="80">보험기간</th>
							<td id="carInsur">${dto_c[0].insurformat}</td>
							<th width="80">운행시간</th>
							<td id="carRunTime">${dto_c[0].route_start} ~ ${dto_c[0].route_arrive}</td>
							<th width="80">점검 일</th>
							<td id="carCheckDay"><input type="text" name="teach_check_date" id="teach_check_date" value="${today}"></td>
						</tr>
					</table>
				</div>	
				<%
					int maxDay;
					int day;
					int loopCnt;
					String checkListCnt ="";
				%>
				<div class="checkManagement-Btn">
					<div class="checkManagement-Btn_L">
<!-- 						<input type="button" onclick="location.href='#'" class="btn_correct_text" value="">	 -->
					</div>
					<div class="checkManagement-Btn_R">
						<input type="button" onclick="checkboxSelectQue(${dto_y}, ${dto_m},'<%=endDay %>')" class="btn_allCheck_text" value="">
						<input type="button" onclick="unCheckbox()" value="" class="btn_unCheck_text">
						<input type="button" onclick="window.location.reload()" value="" class="btn_reload_text">	
					</div>
				</div>
				
				<div class="checkManagement-Table" id="checkManagement-Table">
					
					<input type="hidden" name="nowYear" id="nowYear" value="${dto_y}">
					<input type="hidden" name="nowMon" id="nowMon" value="${dto_m}">
					<input type="hidden" name="route_id" id="route_id" value="${dto_c[0].route_id} ">
						<%
							for(int cnt=1;cnt<3;cnt++){
								%>
								<table id="teach_check_Table<%=cnt%>">
									<thead>
										<tr>
									<%
									if(cnt==1){maxDay=15; day=1;}
									else{  	   maxDay=endDay;day=16;}
									%>
										<td>구분</td>
										<td>점검내역</td>
									<%
									for(;day<maxDay+1;day++){
									%>
										<td><%=day %>일</td>
									<%
									}
									%>
									</tr>
									</thead>
									
									<tbody>
									<!-- 운행 전 -->
									<c:forEach items="${teach_bus_ckecklistB}" var="dto_b" varStatus="s">
									<%
									if(cnt==1){maxDay=16; day=1;}
									else{  	   maxDay=endDay+1;day=16;}
									%>
										<c:choose>
					   			 			<c:when test="${s.count == 1}">
					   			 				<tr>	
													<th rowspan="${fn:length(teach_bus_ckecklistB)} ">${dto_b.teach_buslist_type}</th>
													<th>${dto_b.teach_buslist_cont}</th>
													<%
													for(;day<maxDay;day++){
													%>	
														<td><input type="checkbox" name="teach_check" id="teach_check_${dto_b.teach_buslist_type_order}${s.count}<%=day%>" value="${dto_b.teach_buslist_type_order}_${s.count}_<%=day%>_1">
														<label for="teach_check_${dto_b.teach_buslist_type_order}${s.count}<%=day%>"><span></span></label> </td>
													<%		
														}
													%>
												</tr>
											</c:when>
											<c:otherwise>
												<tr>
													<th>${dto_b.teach_buslist_cont}</th>
												<%
												for(;day<maxDay;day++){
												%>
													<td><input type="checkbox" name="teach_check" id="teach_check_${dto_b.teach_buslist_type_order}${s.count}<%=day%>" value="${dto_b.teach_buslist_type_order}_${s.count}_<%=day%>_1">
													<label for="teach_check_${dto_b.teach_buslist_type_order}${s.count}<%=day%>"><span></span></label> </td>
												<%		
													}
												%>
											</c:otherwise>
										</c:choose>
									</c:forEach>
									
									<!-- 운행 중 -->
									<c:forEach items="${teach_bus_ckecklistI}" var="dto_b" varStatus="s">
									<%
									if(cnt==1){maxDay=16; day=1;}
									else{  	   maxDay=endDay+1;day=16;}
									%>
										<c:choose>
					   			 			<c:when test="${s.count == 1}">
					   			 				<tr>	
													<th rowspan="${fn:length(teach_bus_ckecklistI)} ">${dto_b.teach_buslist_type}</th>
													<th>${dto_b.teach_buslist_cont}</th>
													<%
													for(;day<maxDay;day++){
													%>	
														<td><input type="checkbox" name="teach_check" id="teach_check_${dto_b.teach_buslist_type_order}${s.count}<%=day%>" value="${dto_b.teach_buslist_type_order}_${s.count}_<%=day%>_1">
														<label for="teach_check_${dto_b.teach_buslist_type_order}${s.count}<%=day%>"><span></span></label> </td>
													<%		
														}
													%>
												</tr>
											</c:when>
											<c:otherwise>
												<tr>
													<th>${dto_b.teach_buslist_cont}</th>
												<%
												for(;day<maxDay;day++){
												%>
													<td><input type="checkbox" name="teach_check" id="teach_check_${dto_b.teach_buslist_type_order}${s.count}<%=day%>" value="${dto_b.teach_buslist_type_order}_${s.count}_<%=day%>_1">
													<label for="teach_check_${dto_b.teach_buslist_type_order}${s.count}<%=day%>"><span></span></label> </td>
												<%		
													}
												%>
											</c:otherwise>
										</c:choose>
									</c:forEach>
									
									<!-- 운행 후 -->
									<c:forEach items="${teach_bus_ckecklistA}" var="dto_b" varStatus="s">
									<%
									if(cnt==1){maxDay=16; day=1;}
									else{  	   maxDay=endDay+1;day=16;}
									%>
										<c:choose>
					   			 			<c:when test="${s.count == 1}">
					   			 				<tr>	
													<th rowspan="${fn:length(teach_bus_ckecklistA)} ">${dto_b.teach_buslist_type}</th>
													<th>${dto_b.teach_buslist_cont}</th>
													<%
													for(;day<maxDay;day++){
													%>	
														<td><input type="checkbox" name="teach_check" id="teach_check_${dto_b.teach_buslist_type_order}${s.count}<%=day%>" value="${dto_b.teach_buslist_type_order}_${s.count}_<%=day%>_1">
														<label for="teach_check_${dto_b.teach_buslist_type_order}${s.count}<%=day%>"><span></span></label> </td>
													<%		
														}
													%>
												</tr>
											</c:when>
											<c:otherwise>
												<tr>
													<th>${dto_b.teach_buslist_cont}</th>
												<%
												for(;day<maxDay;day++){
												%>
													<td><input type="checkbox" name="teach_check" id="teach_check_${dto_b.teach_buslist_type_order}${s.count}<%=day%>" value="${dto_b.teach_buslist_type_order}_${s.count}_<%=day%>_1">
													<label for="teach_check_${dto_b.teach_buslist_type_order}${s.count}<%=day%>"><span></span></label> </td>
												<%		
													}
												%>
											</c:otherwise>
										</c:choose>
									</c:forEach>
									</tbody>
								</table>
							<%
							}
						%>
						<input type="hidden" name="${_csrf.parameterName}" id="csrf" value="${_csrf.token}" />
						<div class="pageBtn contentBottomBtn">
							<div class="btnLeftBox">
								<input type="button" class="btn_back" value="" onclick="history.back();" id="bottomBtn-Input">
							</div>
							<div class="btnCnterBox">
								<input type="submit" value="" id="cusInputBtn" class="customD"/>
					  		</div>
					  		<div class="btnRightBox">
<!-- 					  			<input type="button" value="" id="cusInputBtn2" class="customM" onclick="accountBack()"/>		 -->
					  		</div>
				  		</div>
					
					
				</div>
				</form>
<%-- 			<%= cal.get(Calendar.YEAR) %>년 --%>
<%-- 			<%= cal.get(Calendar.MONTH)+1 %>월 --%>
<%-- 			<%= cal.get(Calendar.DATE) %>일 --%>
				
			</div>
		</div>
	</div>
<script type="text/javascript">
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

var check ;
var day;
var contNum;
var typeNum;
var chkId;
$(document).ready(function(){	
	
	$("#car_Select option:eq(1)").prop("selected", true);

	<c:forEach items="${checkList}" var="dto_b" varStatus="s">
// 	 console.log("${dto_b.teach_check}test");
	 check = "${dto_b.teach_check}";
	 day = "${dto_b.checkDateD}";
	 day = Number(day);
	 contNum ="${dto_b.teach_buslist_cont_order}";
	 typeNum ="${dto_b.teach_buslist_type_order}";
	 today = "${today}";
		console.log("today:"+today);
		
	if(today==null){
		today="2018-01-29";
	}console.log("today:"+today);
	 chkId = "teach_check_"+typeNum+contNum+day;
	 if(check==1){
		 $("input:checkbox[id='"+chkId+"']").attr("checked", true);
	 }
	</c:forEach>
});

function checkboxSelectQue(year,month,endDay){
// 	console.log("클릭"+date);
	var checkYear = year;
	var checkMonth = month;
	
	var dt = new Date();

	var nowmonth = dt.getMonth()+1;
	var date = dt.getDate();
	var nowyear = dt.getFullYear();

	var trCnt = $('#teach_check_Table1 tbody tr').length;

	if(nowyear >checkYear || nowmonth>month){
		date = endDay;
	}

	for(var k=1;k<4;k++){			// k = 구분
		for(var trLine=1;trLine<=10;trLine++){	// 점검내역
			for(var cnt=1;cnt<=date;cnt++){		//날짜
// 				console.log("#teach_check_"+k+"///"+trLine+"///"+cnt);
				$("#teach_check_"+k+trLine+cnt).prop("checked", "checked");
			}
		}
	}
	
	
}
function unCheckbox(){
	$("input[name=teach_check]:checkbox").removeProp("checked");
}


  $( "#teach_check_date" ).datepicker({
		changeMonth : true,
	    changeYear : true,
	    showMonthAfterYear:true,
	    dateFormat : "yy-mm-dd",
	    dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
        dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], 
	    monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
	    monthNames : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
});	  
</script>	
<script>
$(function() {				
	 $.validator.addMethod("regex", function(value, element, regexpr) {          
	     return regexpr.test(value);
	   });	 
	 var token = $("meta[name='_csrf']").attr("content");
	 var header = $("meta[name='_csrf_header']").attr("content");
	    
	$("#checkManagement").validate({
		errorClass: "validFail",
		validClass: "validSuccess",
		ignore : "",
	    rules: {
	    	teach_check_date: {
	    		required: true,
	    	}
	    },			    
	    messages: {
	    	teach_check_date: {
	            required: "점검일을 입력해 주세요."
	        }
	    },		    
	    success: function(label) {
//                  label.addClass("validSuccess").text("사용가능합니다.");
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

</body>
</html>