<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ page import="java.util.*" %>
<%@ page import = "java.util.Calendar" %>
<jsp:include page="../include/menu_admin.jsp">
	<jsp:param name="pageInMenu" value="차량운행정보"  />
	<jsp:param name="pageCategory" value="운행이력관리"  />
	<jsp:param name="pageTitle" value="차량일일점검표"  /> 
</jsp:include>
 <style type="text/css" media="print">
  @media print {
    .headerBar ,#footer{
    	display: none;
    }

    .msgBox,.contentBottomBtn,.mainSideLeft,.pageTitle,.checkManagement-SelectBox {
        display: none;
    }
    .pageContent{margin-left:-120px;margin-top: -100px;}
    .checkManagement-Text table th{background-color:#f1f1f1}
}
    </style>
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
int endDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
int selectMonI ;
%>
	<div class="page">
		<div class="page-wrapper">
			<div class="pageTitle"><h2>차량 일일점검표</h2></div>
			
			<div class="pageContent carCheckManagement" id="pageContent ">
				<div class="msgBox" id="msgBox"></div>
				
				<div class="checkManagement-SelectBox">
					<select class="car_Select" id="car_Select" name="car_Select">
						<option value="">차량 선택</option>
						<c:forEach items="${routeList}" var="k" varStatus="s">	
				   			<option value="${k.route_id}">${k.route_name}</option>							   									
						</c:forEach>	
					</select>
					<select id="Sel-01-Year" title="연도 선택">
						<option value="">연도선택</option>
						<%-- // 연도선택을 위한 연도출력을 동적으로 변경 --%>
						<%yearResult = yearMin;
						for(int i=0; yearResult<=yearMax; i++) { %>
						<option value=<%=yearResult%> <% if(year == yearResult){%>selected="selected"<%} %> ><%=yearResult%></option>
						<%String.valueOf(yearResult++); } %>
					</select>
					
					<select id="Sel-01-Mon" title="월 선택">
						<option value="">월 선택</option>
						<%-- // 연도선택을 위한 연도출력을 동적으로 변경 --%>
						<%monResult = monMin;
						for(int i=0; monResult<=monMax; i++) { %>
						<option value=<%=monResult%> <% if(month == monResult){%>selected="selected"<%} %> ><%=monResult%></option>
						<%String.valueOf(monResult++); } %>
					</select>
					
					<input type="button" value="" onclick="changeMonth()" class="btn_search_text" id="searchBtn">
					<input type="button" value="" onclick="checkPrint()" class="btn_print" alt="출력">
<!-- 					<input type="button" value="" onclick="documentList_Down_Excel()" class="btn_down_excel" alt="엑셀"> -->
				</div>		
				<c:set value="${dailycheckInfo}" var="dto_c"/>
				
				<div class="checkManagement" id="checkManagement">
					<div class="checkManagement-Text">
					<%
						Object carInfoLength = pageContext.getAttribute("dto_c"); 
						String carInfoLengthT = carInfoLength.toString();
						
						
						if(carInfoLengthT.equals("[]")){ 
					%>	
						<table>
							<tr>
								<th width="90">노선명</th>
								<td width="140" id="route_name">-</td>
								<th width="90">차량번호</th>
								<td width="140" id="carNum">-</td>
								<th width="90">운전자</th>
								<td width="140" id="carStaff">-</td>
							</tr>
							<tr>
								<th>보험만료</th>
								<td id="carInsur">-</td>
								<th>운행시간</th>
								<td id="carRunTime">-</td>
								<th width="90">마지막 점검일</th>
								<td width="140" id="carCheckDay">-</td>
							</tr>
						</table>
					<%
						}else{
					%>	
						<table>
							<tr>
								<th width="90">노선명</th>
								<td width="140" id="route_name">${dto_c[0].route_name}</td>
								<th width="90">차량번호</th>
								<td width="140" id="carNum">${dto_c[0].bus_num}</td>
								<th width="90">운전자</th>
								<td width="140" id="carStaff">${dto_c[0].staff_name}</td>
							</tr>
							<tr>
								<th>보험만료</th>
								<td id="carInsur">${dto_c[0].insurformat}</td>
								<th>운행시간</th>
								<td id="carRunTime">${dto_c[0].route_start} ~ ${dto_c[0].route_arrive}</td>
								<th width="90">마지막 점검일</th>
								<td width="140" id="carCheckDay">${today}</td>
							</tr>
						</table>
					</div>	
					
					<%
						}
						
						int maxDay;
						int day;
						int loopCnt;
						String checkListCnt ="";
					%>
					<div class="checkManagement-Table">
						<%
							for(int cnt=1;cnt<3;cnt++){
								%>
								<table id="teach_check_Table<%=cnt%>" class="teach_check_Table<%=cnt%>">
									<thead>
										<tr>
									<%
									if(cnt==1){maxDay=16; day=1;}
									else{  	   maxDay=endDay+1;day=16;}
									%>
										<td>구분</td>
										<td>점검내역</td>
									<%
									for(;day<maxDay;day++){
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
													<th rowspan="${fn:length(teach_bus_ckecklistB)} ">운행전<br>점검</th>
													<th>${dto_b.teach_buslist_cont}</th>
													<%
													for(;day<maxDay;day++){
													%>	
														<td><input type="checkbox" disabled="disabled" name="teach_check" id="teach_check_${dto_b.teach_buslist_type_order}${s.count}<%=day%>" value="${dto_b.teach_buslist_type_order}_${s.count}_<%=day%>_1">
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
													<td><input type="checkbox" disabled="disabled" name="teach_check" id="teach_check_${dto_b.teach_buslist_type_order}${s.count}<%=day%>" value="${dto_b.teach_buslist_type_order}_${s.count}_<%=day%>_1">
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
													<th rowspan="${fn:length(teach_bus_ckecklistI)} ">운행중<br>점검</th>
													<th>${dto_b.teach_buslist_cont}</th>
													<%
													for(;day<maxDay;day++){
													%>	
														<td><input type="checkbox" disabled="disabled" name="teach_check" id="teach_check_${dto_b.teach_buslist_type_order}${s.count}<%=day%>" value="${dto_b.teach_buslist_type_order}_${s.count}_<%=day%>_1">
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
													<td><input type="checkbox" disabled="disabled" name="teach_check" id="teach_check_${dto_b.teach_buslist_type_order}${s.count}<%=day%>" value="${dto_b.teach_buslist_type_order}_${s.count}_<%=day%>_1">
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
													<th rowspan="${fn:length(teach_bus_ckecklistA)} ">운행후<br>점검</th>
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
					</div>
				</div>
				<div class="pageBtn contentBottomBtn">
					<div class="btnLeftBox">
<!-- 							<input type="button" value="" class="btn_back" id="cusInputBtn3" onclick="kidInfo()" id="bottomBtn-Input"> 이전버튼 클릭 -->
					</div>
					<div class="btnCnterBox">
						<input type="button" value="" id="cusInputBtn" class="btn_update" onclick="locationUpdate()"/>
			  		</div>
			  		<div class="btnRightBox">
<!-- 			  			<input type="button" value="" id="cusInputBtn2" class="customM" onclick="accountBack()"/>		 -->
			  		</div>
		  		</div>
			</div>
		</div>
		
	</div>

<script type="text/javascript">
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
	
function documentList_Down_Excel(){
	var driveYear = $("#Sel-01-Year option:selected").val();
	var driveMon = $("#Sel-01-Mon option:selected").val();
	var route_id = $("#car_Select option:selected").val();
// 	var routeName = $("#car_Select option:selected").text();
	
	console.log("routeSelect:"+route_id);
	console.log("routeName:"+routeName);
	location.href = 'carCheckManagementDown_Excel?'
			+'route_id='+route_id
// 			+'&route_name='+routeName
			+'&year=' + driveYear
			+'&month='+driveMon;
}

var check ;
var day;
var contNum;
var typeNum;
var chkId;
$(document).ready(function(){
	
	
	var check = "${check}";	
	if(check=="false"){
		$("#car_Select option:eq(1)").prop("selected", true);
		$("#checkYear").html($("#Sel-01-Year option:selected").val());
		$("#checkMonth").html($("#Sel-01-Mon option:selected").val());
	}
	else{		
		$("#car_Select").val("${route_id}").prop("selected", true);
		$("#Sel-01-Year").val("${main_year_i}").prop("selected", true);
		$("#Sel-01-Mon").val("${main_mon_i}").prop("selected", true);
	}
	
	
	
	$( "#searchBtn" ).trigger( "click" );
	
	<c:forEach items="${checkList}" var="dto_b" varStatus="s">
// 	 console.log("${dto_b.teach_check}test");
	 check = "${dto_b.teach_check}";
	 day = "${dto_b.checkDateD}";
	 day = Number(day);
	 contNum ="${dto_b.teach_buslist_cont_order}";
	 typeNum ="${dto_b.teach_buslist_type_order}";
	 
	 chkId = "chkManage_"+typeNum+contNum+day;
	 if(check==1){
// 		 console.log(chkId);
		 $("input:checkbox[id='"+chkId+"']").attr("checked", true);
	 }
	</c:forEach>
});
function checkPrint(printArea){
	window.print();
}
function locationUpdate(){
	var y =$("#Sel-01-Year option:selected").val();
	var m =$("#Sel-01-Mon option:selected").val();
	var r = $("#car_Select option:selected").val();
	location.href='carCheckManagement_Update?y='+y+'&m='+m+'&route='+r;
}

function changeMonth(){
	
	var driveYear = $("#Sel-01-Year option:selected").val();
	var driveMon = $("#Sel-01-Mon option:selected").val();
	var routeSelect = $("#car_Select option:selected").val();
	var routeName = $("#car_Select option:selected").text();
	
	//체크 해제
	$("input[name=chkManage]:checkbox").removeProp("checked");
	$.ajax({  
        url : 'dailyCarCheck',
        type:'POST',
        data : { "routeSelect" : routeSelect,"driveYear":driveYear,"driveMon":driveMon,"routeName":routeName},
        beforeSend: function(xhr) {
            xhr.setRequestHeader(header, token);
        	},
        success: function(result) {	            	 	      
     		
     	$("#teach_check_Table1").empty();
     	$("#teach_check_Table2").empty();
     	
     	var td_Text_open ="";
     	var td_Text_close ="";
     	var td_Text_title= "";
     	var td_Text_content= "";
     	var td_day = "";
     	
     	var size_checkB = result.teach_bus_ckecklistB.length;			//운행전 질문 개수
		var size_checkI = result.teach_bus_ckecklistI.length;			//운행중 질문 개수
		var size_checkA = result.teach_bus_ckecklistA.length;			//운행후 질문 개수
		
		var start;
		var endDay;
		var tableID ="";
		for(var cnt=1;cnt<3;cnt++){
			if(cnt==1){
				start=1;
				endDay=15;
				tableID ="#teach_check_Table1";
			}else{
				start=16;
				endDay=result.lastDay;
				tableID ="#teach_check_Table2";
			}
			
			td_Text_open = "<tr><td>구분</td><td>점검내역</td>";
			td_Text2 = td_Text_open;
			
			for(var i = start; i<=endDay; i++){
				td_day =td_day+"<td>"+i+"일</td>";
			}
			
			td_Text_close = "</tr>";
			$(tableID).append(td_Text_open+td_day+td_Text_close);
			
			td_Text_open="";
			td_day="";
			td_Text_close="";
			
			for(var b=0;b<size_checkB;b++){		//운행전
				td_Text_title = result.teach_bus_ckecklistB[b].teach_buslist_cont;
				
				td_Text_open = "<tr>";
				
				if(b==0){
					td_Text_content ="<th rowspan='"+size_checkB+"'>운행전<br>점검</th>";
				}
				
				td_Text_content = td_Text_content +"<th>"+result.teach_bus_ckecklistB[b].teach_buslist_cont+"</th>";
				
				for(var i=start; i<=endDay; i++){
					td_Text_content =td_Text_content
						+"<td>"
						+"<input type='checkbox' disabled='disabled' name='teach_check' id='teach_check_"+result.teach_bus_ckecklistB[b].teach_buslist_type_order+(b+1)+i+"' value='"+result.teach_bus_ckecklistB[b].teach_buslist_type_order+"_"+(b+1)+"_"+i+"_1'>"
						+"<label for='teach_check_"+result.teach_bus_ckecklistB[b].teach_buslist_type_order+(b+1)+i+"'><span></span></label>" 
						"</td>";
				}
				
				td_Text_close = "</tr>";
				$(tableID).append(td_Text_open+td_Text_content+td_Text_close);
				td_Text_open="";
				td_Text_content="";
				td_Text_close="";
			}
			
			for(var b=0;b<size_checkI;b++){		//운행중
				td_Text_title = result.teach_bus_ckecklistI[b].teach_buslist_cont;
				
				td_Text_open = "<tr>";
				
				if(b==0){
					td_Text_content ="<th rowspan='"+size_checkI+"'>운행중<br>점검</th>";
				}
				
				td_Text_content = td_Text_content +"<th>"+result.teach_bus_ckecklistI[b].teach_buslist_cont+"</th>";
				
				for(var i = start; i<=endDay; i++){
					td_Text_content =td_Text_content
					+"<td>"
					+"<input type='checkbox' disabled='disabled' name='teach_check' id='teach_check_"+result.teach_bus_ckecklistI[b].teach_buslist_type_order+(b+1)+i+"' value='"+result.teach_bus_ckecklistI[b].teach_buslist_type_order+"_"+(b+1)+"_"+i+"_1'>"
					+"<label for='teach_check_"+result.teach_bus_ckecklistI[b].teach_buslist_type_order+(b+1)+i+"'><span></span></label>" 
					"</td>";
				}
				
				td_Text_close = "</tr>";
				$(tableID).append(td_Text_open+td_Text_content+td_Text_close);
				td_Text_open="";
				td_Text_content="";
				td_Text_close="";
			}
			for(var b=0;b<size_checkA;b++){		//운행후
				td_Text_title = result.teach_bus_ckecklistA[b].teach_buslist_cont;
				
				td_Text_open = "<tr>";
				
				if(b==0){
					td_Text_content ="<th rowspan='"+size_checkA+"'>은헹후<br>점검</th>";
				}
				
				td_Text_content = td_Text_content +"<th>"+result.teach_bus_ckecklistA[b].teach_buslist_cont+"</th>";
				
				for(var i = start; i<=endDay; i++){
					td_Text_content =td_Text_content
					+"<td>"
					+"<input type='checkbox' disabled='disabled' name='teach_check' id='teach_check_"+result.teach_bus_ckecklistA[b].teach_buslist_type_order+(b+1)+i+"' value='"+result.teach_bus_ckecklistA[b].teach_buslist_type_order+"_"+(b+1)+"_"+i+"_1'>"
					+"<label for='teach_check_"+result.teach_bus_ckecklistA[b].teach_buslist_type_order+(b+1)+i+"'><span></span></label>" 
					"</td>";
				}
				
				td_Text_close = "</tr>";
				$(tableID).append(td_Text_open+td_Text_content+td_Text_close);
				td_Text_open="";
				td_Text_content="";
				td_Text_close="";
			}
			
		}
		var size_data=result.data;
		console.log("selectTeachCheckList:"+size_data.length);
			if(size_data.length>0){
				var has = $('#msgBox').hasClass("inlieClass");
				if(has){ $('#msgBox').removeClass("inlieClass");$('#msgBox').addClass("noneClass");}		
				for(var i=0; i < size_data.length; i ++){
	    			
	     			if(result.data[i].teach_check==1){
	     				check = result.data[i].teach_check;
	         			day = result.data[i].checkDateD;
	         			day = Number(day);
	         			contNum =result.data[i].teach_buslist_cont_order;
	         			typeNum =result.data[i].teach_buslist_type_order;
	        			 
	         			chkId = "teach_check_"+typeNum+contNum+day;
	     				$("input:checkbox[id='"+chkId+"']").prop("checked", true);
	    				
	     				$("#carCheckDay").text(result.data[0].checkDateAll);
	     				$("#checkYear").text(result.dailycheckInfo[0].drive_year);
	     	     		$("#checkMonth").text(result.dailycheckInfo[0].drive_mon);
	     	     		$("#carNum").text(result.dailycheckInfo[0].bus_num);
	     	     		$("#carStaff").text(result.dailycheckInfo[0].bus_staff);
	     	     		$("#carInsur").text(result.dailycheckInfo[0].insurformat);
	     	     		$("#carRunTime").text(result.dailycheckInfo[0].route_start+" ~ "+result.dailycheckInfo[0].route_arrive);
	     	     		$("#route_name").text(result.dailycheckInfo[0].route_name+" ("+result.dailycheckInfo[0].route_type+")");
	     			}
	     		}	
			}else{
				var has = $('#msgBox').hasClass("noneClass");
				if(has){ $('#msgBox').removeClass("noneClass");$('#msgBox').addClass("inlieClass");}
				$("input[name=teach_check]:checkbox").removeProp("checked");
			
				$("#checkYear").text("-");
	     		$("#checkMonth").text("-");
	     		$("#carNum").text("-");
	     		$("#carStaff").text("-");
	     		$("#carInsur").text("-");
	     		$("#carRunTime").text("-");
	     		$("#route_name").text("-");
	     		
	     		$('#msgBox').addClass("msgBox_Error");	
	    		$('#msgBox').html("<span>이 달의 점검 내역이 없습니다. 점검 해 주세요.</span>");
	    		$('#msgBox').addClass("inlieClass");
			}
			

		},
        error:function(request,status,error){                 
     	   alert("code:"+request.status+"\n"+"error:"+error);
        }
    });
	
}
</script>	
<jsp:include page="../include/footer.jsp"/>