<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/realTime.css">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="../include/menu_admin.jsp"/>
	<div class="page">
		<div class="page-wrapper">
			<div class="pageTitle"><h2>노선도 뷰어</h2></div>
			
			<div class="pageContent">
				<div class="realTimeBox">
					<div class="realTimeList">
						<h3>노선도 목록</h3>
						<div class="searchBox">
							<input type="text" name="keyWord" id="keyWord">
							<input type="button" value="검색" id="searchBtn"><br>
						</div>
						
						<div class="realTimeList-Content" id="realTimeList-Content">
							<ul>
								<c:forEach var="dto" items="${routeUse}" varStatus="s">
									<li class="realTimeList-Route" id="realTimeList-Route${s.count}" onclick="onClick(this.id,'${dto.route_id}')" ><span>${dto.route_name}</span></li>
								</c:forEach>								
							</ul>
						</div>
					</div>
					<div class="realTimeContent">
						<div class="AllRouteBtn" id="AllRouteBtn"><a href="#layerAllRoute" onclick="$('#layerAllRoute').css('display','block');">전체 실시간 노선</a></div>
						
						<span class="modalWindow"></span>
		                  <!-- 원아지도 레이어 팝업 -->
		                  
		                  <div id="layerAllRoute" class="layerAllRoute">
		                     <span class="modalWindow"></span>
		                   
		                     <div id="loginLayer" class="loginLayer loginTypeA">
		                        <a onclick="document.getElementById('layerAllRoute').style.display='none'" style="cursor:hand">닫기</a>&nbsp;</td>
		                        <div class="layerPopContent">
		                           <div class="layerPopContent-Title">전체노선</div>
		                           <div class="layerPopContent-R">
		                              	전체 노선
		                           </div>
		                        </div>
		                     </div>
		                  </div>
						
						
						
						
						
						<div class="realTimeViewerBox-L">
							<div class="realTimeViewerBox-Title">▶기본정보</div>
							<div class="realTimeViewerBox-Content">
								<div class="realTimeViewerBox-Content-L">
									<table>
										<tr>
											<th width="150px">노선이름</th>
											<td id="real-RouteName">연제구방면</td>
										</tr>
										<tr>
											<th>인솔교사</th>
											<td id="real-MainStaffName">김장미</td>
										</tr>
										<tr>
											<th>인솔교사 전화번호</th>
											<td id="real-MainStaffPhone">010.1234.5678</td>
										</tr>
										<tr>
											<th>작성일</th>
											<td>2017.10.23</td>
										</tr>
									</table>
								</div>
								<div class="realTimeViewerBox-Content-R">
									<table>
										<tr>
											<th>탑승예정 <br>원아 수</th>
											<th>전체 탑승 <br>원아 수</th>
										</tr>
										<tr>
											<td id="real-CarNow"><span>19</span></td>
											<td id="real-CarMax">25</td>
										</tr>
									</table>
								</div>
							</div>
						</div>
						<div class="realTimeViewerBox-R">
							<div class="realTimeViewerBox-Title">▶셔틀버스 정보</div>
							<div class="realTimeViewerBox-Content">
								<table>
									<tr>
										<th>차량명</th>
										<td id="real-RouteCarName">개나리호</td>
									</tr>
									<tr>
										<th>차량번호</th>
										<td id="real-RouteCarNum">부산12바3456</td>
									</tr>
									<tr>
										<th>운전기사</th>
										<td id="real-RouteStaffName">김기사</td>
									</tr>
									<tr>
										<th>운전기사 전화번호</th>
										<td id="real-RouteStaffPhone">010.1234.5678</td>
									</tr>
								</table>
							
							</div>
						</div>
						<div id="test"></div>
						<div class="realTimeViewerBox realTimeViewerBox-h">
							<div class="realTimeViewerBox-Title">▶실시간 버스 위치 노선도</div>
							<div class="realTimeViewerBox-Time" id="realTimeViewerBox-Time">
							</div>
							<div class="realTimeViewerBox-Content"  id="stationRouteBox-st">
								<div class="realTimeView-Box-L" id="realTimeView-Box-L">
								</div>
								<div class="realTimeView-Box-R" id="realTimeView-Box-R">
								</div>
							</div>
						</div>
					</div>
				</div>	
			</div>
		</div>
	</div>
	
	
	<script type="text/javascript">
	$(document).ready(function(){
		$('#realTimeList-Route1').addClass("Listactive");		//노선 목록에 초록배경
		$("#realTimeList-Route1").trigger("click");				//페이지 로드 될때 강제 클릭 이벤트
	});
	function onClick(thisLi,route_id){
		var thisLi_Class = document.getElementById(thisLi).className;
		console.log("thisLi : "+thisLi+"//thisLi_Class"+thisLi_Class);
		console.log("route_id : "+route_id);
		
		var token = $("meta[name='_csrf']").attr("content");
	    var header = $("meta[name='_csrf_header']").attr("content");
	    
		$.ajax({  
            url : 'realTimeView_Data',
            dataType : 'json',
            type:'POST',
            data : { "route_id" : route_id},
            beforeSend: function(xhr) {
	            xhr.setRequestHeader(header, token);
	        },
            success: function(data) {
            	console.log("시작");
            	var size_data = data.realTimeInfo;
            	
            	var size_data_BK = data.routeBoardKid.length;
//             	console.log("size_data :"+size_data_BK);
            	for(var i=0; i<size_data.length;i++){
              		$('#real-RouteName').text(data.realTimeInfo[i].route_name);
//               		console.log("c:"+data.realTimeInfo[i].mainStaff_name);
              		if(data.realTimeInfo[i].mainStaff_name==""){
              			$('#real-MainStaffName').text("-");
              		}
              		$('#real-MainStaffName').text(data.realTimeInfo[i].mainStaff_name);
              		$('#real-MainStaffPhone').text(data.realTimeInfo[i].mainStaff_phone);
              		
              		$('#real-CarMax').text(data.realTimeInfo[i].bus_borad);
              		$('#real-CarNow span').text(size_data_BK);
              		
              		$('#real-RouteCarName').text(data.realTimeInfo[i].bus_name);
              		$('#real-RouteCarNum').text(data.realTimeInfo[i].bus_num);
              		$('#real-RouteStaffName').text(data.realTimeInfo[i].staff_name);
              		$('#real-RouteStaffPhone').text(data.realTimeInfo[i].staff_phone);
            	}
				
            	var size_routeST = data.realTimeRoute;
//             	console.log("size_routeST:"+size_routeST.length);
            	$('#stationRouteBox-st').empty();
            	$('#realTimeViewerBox-Time').empty();
            	
            	//출발시간과 도착시간 출력
            	var realTimeStart = data.realTimeRoute[0].route_start;
                var realTimeArrive = data.realTimeRoute[0].route_arrive;
                var resultTotalTime = TimeFunc(realTimeStart,realTimeArrive);
            	
                nowTime(realTimeStart,realTimeArrive);
                
            	$('#realTimeViewerBox-Time').append("<span>출발시간 -"+realTimeStart+" </span><span>도착시간 -"+realTimeArrive+" </span><span>걸리는시간 :"+resultTotalTime+" </span>");
            	
            			
            	//출발하는 유치원 
            	$('#stationRouteBox-st').append(
            				"<div class='realTime-St-Box realTime-St-start'>"+
        						"<div class='realTime-St-img'></div>"+
        						"<div class='realTime-St-Title'>유치원</div></div>"
            	);
            	
            	//정류장들
         	 	for(var j=0;j<size_routeST.length;j++){
	                var stationAft  = data.realTimeRoute[j].sch_time;
	                
	                if(j==0){var stationBef  = realTimeStart;}
	                else{var stationBef  = data.realTimeRoute[j-1].sch_time;}
                	
                	var resultStationTime = TimeFunc(stationBef,stationAft);
    				
         	 		$('#stationRouteBox-st').append(
         	 				"<div class='realTime-St-Box realTime-St-station' id='realTime-St-station"+j+"'>"+
								"<div class='realTime-St-L realTime-St"+j+"' id='realTime-St-L"+j+"'>"+resultStationTime+"분</div>"+
								"<div class='realTime-St-R realTime-St' id='realTime-St-R"+j+"'>"+
									"<div class='realTime-St-img' id='"+data.realTimeRoute[j].station_id+"'></div></div>"+
								"<div class='realTime-St-Full'>"+
								"<div class='realTime-St-Title'>"+data.realTimeRoute[j].station_name+"</div>"+
								"<div class='realTime-St-Time'>"+data.realTimeRoute[j].sch_time+"</div>"+
							"</div>"
         	 		);
         	 	}
            	
         	 	var stationAft  = data.realTimeRoute[size_routeST.length-1].sch_time;
         	 	var LastStationTime = TimeFunc(stationAft,realTimeArrive);
         	 	
         	 	//도착하는 유치원 
         	 	$('#stationRouteBox-st').append(
         	 			"<div class='realTime-St-Box realTime-St-station' id='realTime-St-station"+size_routeST.length+"'>"+
	         	 			"<div class='realTime-St-L realTime-St"+size_routeST.length+"' id='realTime-St-L"+size_routeST.length+"'>"+LastStationTime+"분</div>"+
							"<div class='realTime-St-R realTime-St-last' id='realTime-St-R"+size_routeST.length+"'>"+
								"<div class='realTime-St-img'></div></div>"+
							"<div class='realTime-St-Full-Last'>"+
							"<div class='realTime-St-Title'>도착</div>"+
							"<div class='realTime-St-Time'>"+realTimeArrive+"</div>"+
         	 			"</div></div>");
         	 	
         	 	var stationCnt = $('.realTime-St-station').length;		//정류장 개수
    			var lineCnt = 4;									//한줄에 나타낼 정류장 수
    			var leftRight = false;
//     			console.log("stationCnt:"+stationCnt);
    			
    			
    			//정류장들 배치
    			for(var j=0;j<=stationCnt;j++){
//     				var line = parseInt(j/lineCnt);
//     				console.log("line:"+line+"//j"+j+"//lineCnt:"+lineCnt);	
    				if(!leftRight){
    					if(j<lineCnt-1){
    						$('#realTime-St-station'+j).addClass('realTime-Float-L realTime-width2');
    					}
    				    else if(j==lineCnt-1){
    						$('.realTime-St'+j).addClass('realTime-Float-BB');
    						$('#realTime-St-station'+j).addClass('realTime-Float-R realTime-width');
    						leftRight = true;
    					}
    					else{
    						if(j%lineCnt==lineCnt-1 && j>0){
    							$('.realTime-St'+j).addClass('realTime-Float-BB');
    							$('#realTime-St-station'+j).addClass('realTime-Float-R realTime-width');
    							leftRight = true;
    						}
    						else{
    							$('#realTime-St-station'+j).addClass('realTime-Float-L realTime-marginT');
    						}
    					}				
    				}
    				else{
    					if(j%lineCnt==lineCnt-1 && j>0){
    						$('.realTime-St'+j).addClass('realTime-Float-B');
    						$('#realTime-St-station'+j).addClass('realTime-Float-L realTime-width');
    						leftRight = false;
    					}
    					else{
    						$('#realTime-St-station'+j).addClass('realTime-Float-R realTime-marginT');
    					}
    				}	
    			}
    			
    			
            },
            error:function(request,status,error){                 
         	   alert("code:"+request.status+"\n"+"error:"+error);
            }
		});
		
		
		$.ajax({  
            url : 'realTimeCar',
            dataType : 'json',
            type:'POST',
            data : { "route_id" : route_id},
            beforeSend: function(xhr) {
	            xhr.setRequestHeader(header, token);
	        },
            success: function(data) {
            	

            	var nowStation = data.realTimeCar_data[0].station_id;
            	
//             	var realTimeStart = data.realTimeRoute.station_id;
            	console.log("realTimeStart시작:"+nowStation);
            	$('#'+nowStation).css({"background":"url('https://image.flaticon.com/icons/png/512/183/183756.png')", 'background-repeat' : 'no-repeat', 'background-position':'center center','background-size': '90px'});
            },
            error:function(request,status,error){                 
          	   alert("code:"+request.status+"\n"+"error:"+error);
            }   	
        });
		
		var has = $('.realTimeList-Route').hasClass("Listactive");		//busRouteList-Tr에 active 클래스 가지고 있는가
		if(has==true){
			$('.realTimeList-Route').removeClass("Listactive");		//가지고 있다면 지워라
		}
		var st = $(this).attr("id") ;										//hover 했을 때 tr의 id값
		
		$('#'+thisLi).addClass("Listactive");	
		
	}

	</script>
	
	<script type="text/javascript">
		function TimeFunc( Time1, Time2) {
			var splitTime1= Time1.split(':');
            var splitTime2= Time2.split(':');
            
      		var firstTimeSec =  ((+splitTime1[0]) * 60)  + (+splitTime1[1]); 
      		var secondTimeSec =  ((+splitTime2[0]) * 60)  + (+splitTime2[1]); 
      		
/*       		console.log("splitTime1:"+splitTime1);
      		console.log("splitTime2:"+splitTime2);
      		
			console.log("firstTimeSec:"+firstTimeSec);
			console.log("secondTimeSec:"+secondTimeSec); */
			
			var resultTotalTime = secondTimeSec - firstTimeSec;		//노선 경유 시간
// 			console.log("resultTotalTime:"+resultTotalTime);
			
			return resultTotalTime;
	    }
	
	</script>
	
	<script type="text/javascript">			//특정시간마다 새로고침 
	
	function nowTime(startTime,endTime){
		var d = new Date();
		console.log('현재 시: ' + d.getHours());
		console.log('현재 분: ' + d.getMinutes());
		console.log('현재 초: ' + d.getSeconds());
		
		var splitTime1= startTime.split(':');
        var splitTime2= endTime.split(':');
        
        var firstTimeSec =  ((+splitTime1[0]) * 60)  + (+splitTime1[1]); 
  		var secondTimeSec =  ((+splitTime2[0]) * 60)  + (+splitTime2[1]); 
  		
  		var NowTimeSec =  (d.getHours() * 60 ) +d.getMinutes(); 
		
  		
  		if(firstTimeSec <= NowTimeSec && NowTimeSec <= secondTimeSec){
  			
  			window.setInterval("refreshDiv()", 10000);
  			
  			
  		}
  		else{
  			document.getElementById("test").innerHTML="조회시간이 아닙니다.";
  		}
  		console.log('NowTimeSec:'+NowTimeSec);
		console.log('startTime: ' + firstTimeSec + 'endTime: ' + secondTimeSec + 'NowTimeSec: ' + NowTimeSec );
	}
	var counter = 0;
	function refreshDiv(){
		counter = counter + 1;
		document.getElementById("test").innerHTML = "Testing " + counter;
	}
	
	
</script>
</body>
</html>