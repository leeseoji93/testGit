<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<jsp:include page="../include/menu_admin.jsp">
	<jsp:param name="pageInMenu" value="차량운행정보"  />
	<jsp:param name="pageCategory" value="운행이력관리"  />
	<jsp:param name="pageTitle" value="운행일지"  /> 
</jsp:include>
<c:set value="${detailRecordList}" var="title"/>
<div class="page">
	<div class="page-wrapper">
		<div class="pageTitle"><h2>차량 운행일지 상세조회</h2></div>
		
		<div class="pageContent700">
			<div class="logDetail_Title">
				<h3>${title[0].route_name}</h3>
			</div>
			<div class="logDetail_Content">
				<table id="logDetail_Title_table">
					<tr>
						<th width="80"></th>
						<th width="250">정류장명</th>
						<th width="195">도착시간</th>
						<th width="195">소요시간</th>
					</tr>
				</table>
				<table id="detailRecordT"> 
					<c:forEach items="${detailRecordList}" var="dto_rl" varStatus="s">
					<tr  id="routeList${s.count}">
						<td width="80" id="${dto_rl.real_time_id}">${s.count}</td>
						<td width="250" id="${dto_rl.real_time_id}">${dto_rl.station_name}</td>
						<td width="195" id="beforeTime${s.count}">${dto_rl.time}</td>
						<td width="195" id="leadTime${s.count}"></td>
					</tr>
					</c:forEach>
				</table>	
			</div>
			<div class="contentBottomBtn">
				<div class="btnLeftBox">
					<input type="button" class="btn_down_text" onclick="location.href='vehicleListDown?downType=\'hwp\'&route_id=${title[0].route_id}&driv_doc=${title[0].driv_doc}'">
				</div>
				<div class="btnCnterBox">
				</div>
				<div class="btnRightBox">
					<input type="button" class="btn_list" value="" onclick="location.href='vehicleLogList'" id="bottomBtn-Input"> <!-- 이전버튼 클릭 -->
				</div>
			</div>
		</div>
		<div class="pageContent300 ">
			<div class="vehicleDayLogList">
				<table id="vehicleDayLogList1">
					<tr>
						<th width="296">운행이력목록</th>
					</tr>
				</table>
				<table id="vehicleDayLogList2">
					<c:forEach items="${routeList}" var="dto_rl" varStatus="s">
					<tr class="tr_hover" id="routeList${s.count}" onclick="location.href='vehicleLogDetail?r=${dto_rl.route_id}&cdf=${dto_rl.createDateFormat}'">
						<td width="296">${dto_rl.createDateFormat}</td>
					</tr>
					</c:forEach>
				</table>
			</div>
		</div>
	</div>
</div>
<jsp:include page="../include/footer.jsp"/>

<script type="text/javascript">
	var listLength = "${fn:length(detailRecordList)}";
$(document).ready(function(){
	var listLength = "${fn:length(detailRecordList)}";
	
// 	var realTimeArrive = data.realTimeRoute[0].route_arrive;
// 	var resultTotalTime = TimeFunc(realTimeStart,realTimeArrive);
	console.log("listLength :"+listLength);
	for(var i=2;i<=listLength;i++){
		var beforeTime= $("#beforeTime"+(i-1)).text();
		var leadTime = $("#beforeTime"+i).text();
// 		var route_id = td.eq(0).text();
		
// 		console.log("beforeTime :"+beforeTime);
// 		console.log("leadTime :"+leadTime);
		nowTime(beforeTime,leadTime,i);
	}
	
	//출발시간과 도착시간 출력

	

// 	$('#realTimeViewerBox-Time').append("<span>출발시간 -"+realTimeStart+" </span><span>도착시간 -"+realTimeArrive+" </span><span>걸리는시간 :"+resultTotalTime+" </span>");
		
});
function documentList_Down(downType){
	location.href = 'vehicleListDown?downType='+downType+'&route_id='+route_id+'&driv_doc=' + encodeURIComponent(Arraylist,'UTF-8');
}
function nowTime(startTime,endTime,cnt){
	
	var splitTime1= startTime.split(':');
    var splitTime2= endTime.split(':');
    
    var firstTimeSec =  (((+splitTime1[0]) * 60)*60)  + ((+splitTime1[1])*60) +(+splitTime1[2]); 
	var secondTimeSec = (((+splitTime2[0]) * 60)*60)  + ((+splitTime2[1])*60) +(+splitTime2[2]); 
// 		console.log("firstTimeSec :"+firstTimeSec);
	var leadTimeSec =  secondTimeSec - firstTimeSec ; 
// 	var leadTimeSec =  63642;
	var leadTimeSec_S;
	var leadTimeSec_M;
	var leadTimeSec_H;
	
	if(leadTimeSec>60){
		leadTimeSec_H = ((leadTimeSec/60)/60);
		leadTimeSec_H = parseInt(leadTimeSec_H);
		
		leadTimeSec = leadTimeSec-((leadTimeSec_H*60)*60);
// 		63612 /60 /60 = 17 // 63612-(60*60*17) = 2412
//		2412 / 60 = 40.2  // 2412 - (60*40) =12
		
		leadTimeSec_M = (leadTimeSec/60);
		leadTimeSec_M = parseInt(leadTimeSec_M);
		leadTimeSec = leadTimeSec-(leadTimeSec_M*60);
		
		leadTimeSec_S = leadTimeSec;
	}
	else{
		leadTimeSec_S=leadTimeSec;
		leadTimeSec_M=0;
		leadTimeSec_H=0;
	}
	if(leadTimeSec_S<10){
		leadTimeSec_S = String(leadTimeSec_S);
		leadTimeSec_S = "0"+leadTimeSec_S;
	}
	if(leadTimeSec_M<10){
		leadTimeSec_M = String(leadTimeSec_M);
		leadTimeSec_M = "0"+leadTimeSec_M;
	}
	if(leadTimeSec_H<10){
// 		console.log("leadTimeSec_H :"+leadTimeSec_H);
		leadTimeSec_H = "00";
	}
	$("#leadTime"+cnt).html(leadTimeSec_H+":"+leadTimeSec_M+":"+leadTimeSec_S);
// 	console.log("/Time:"+leadTimeSec_M+":"+leadTimeSec_S );

}
</script>

