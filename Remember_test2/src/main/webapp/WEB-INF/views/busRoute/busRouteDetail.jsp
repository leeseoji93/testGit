<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:include page="../include/menu_admin.jsp">
	<jsp:param name="pageInMenu" value="차량운행정보"  />
	<jsp:param name="pageCategory" value="노선 관리"  />
	<jsp:param name="pageTitle" value="노선 상세정보조회"  /> 
</jsp:include>
	<div class="page">
		<div class="page-wrapper">
			<div class="pageTitle"><h2>노선 상세정보조회</h2></div>
			
			<div class="pageContent busRouteDetail">
			
				<div id="layerWindow" class="layerWindow">
					<span class="modalWindow"></span>
					<div id="loginLayer" class="loginLayer loginTypeA">
						<div class="layerPopContent">
							<p>삭제 하시겠습니까?</p> 
							<input id="routeId" type="hidden" name="routeId" />
							<input id="courseId" type="hidden" name="courseId" /> 
							<input id="route_use" type="hidden" name="route_use" /> 
							<input type="button" class="btn_confirming_text" onclick="closeLayer2(1)" >
							<input type="button" class="btn_close_text" onclick="closeLayer2(0)" >
						</div>
					</div>
				</div>
				<div class="msgBox" id="msgBox"></div>
				<c:set value="${routeDetail}" var="dto_basic"/>		
				<div class="pageContentBox">
					<div class="pageContentBox-Title">기본정보</div>
					<div class="pageContentBox-Content routeId" id="${dto_basic[0].route_id}">
						<table>
							<tr>
								<th width="180">노선이름</th>
								<td width="340">${dto_basic[0].route_name} (${dto_basic[0].route_type})</td>
							
								<th width="180">등록일/수정일</th>
								<td width="340">${dto_basic[0].CREATEDATEFORMAT}/${dto_basic[0].UPDATEDATEFORMAT}</td>
							</tr>
							<tr>
								<th>차량명</th>
								<td>${dto_basic[0].bus_name}</td>
							
								<th>차량번호</th>
								<td>${dto_basic[0].bus_num}</td>
							</tr>
							<tr>
								<th>출발시간</th>
								<td>${dto_basic[0].route_start}</td>
							
								<th>도착예정시간</th>
								<td>${dto_basic[0].route_arrive}</td>
							</tr>
						</table>
					
					</div>
				</div>
				<div class="pageContentBox busRouteDetail_teacher">
					<div class="pageContentBox-Title">교사정보</div>
					<div class="">
						<table>
							<%
								String num=null;
								String stationInRoute="";
								int stationInRouteInt;
							%>
							<c:forEach var="obj" items="${routeDetail}" varStatus="s">
								<tr>
									<th rowspan="2"><img src="${obj.staff_phot}"></th>
									<td>${obj.staff_name}</td>
								</tr>
								<tr>
									<td>${obj.staff_phone}</td>
								</tr>
								<c:if test="${s.last}">
									<c:set value="${obj.bus_borad}" var="last" />	
									<%
										num = (String)pageContext.getAttribute("last");										
									%>
								</c:if>
							</c:forEach>
						</table>
					</div>
				</div>
				
				<div class="pageContentBox busRouteDetail_kids">
					<div class="pageContentBox-Title">배치인원 ${fn:length(kidsInStaion)}/<%=num %></div>
					<div class="routeDetailKids-Box">
						<c:forEach var="obj" items="${kidsInStaion}" varStatus="s">		
						<div class='routeDetailKids-Box-All'>
							<div class='routeDetailKids-Img'><img src='${obj.kid_pho}'></div>
				            <div class='routeDetailKids-Name'>${obj.kid_name}</div></div>
						</c:forEach>
					</div>
				</div>
				
				<div class="pageContentBox pageContentBox-h">
					<div class="pageContentBox-Title">노선도</div>
					<div class="pageContentBox-Content">
						
						<div class='route-St-Box route-St-Box_L route-St-start'>
      							<div class='route-St-Title'>유치원</div>
      							<div class='route-St-Time'>${dto_basic[0].route_start}</div>
      							<div class='route-St-center' >
								<div class='route-St-dot' id=''></div>
							</div>
							<div class="routeDetailLine routeDetailLine_c_Left"></div>
      					</div>
						
						<c:forEach var="dto" items="${stationInRoute}" varStatus="s">
							
							<div id="route-St-Box${s.index}" class='route-St-Box route-St-station' onmouseenter="over(this.id,'${dto.station_id}','${dto.latitude}','${dto.longitude}','${dto.station_name}')">
<%-- 										<div class='route-St-L route-St${s.index}' id='route-St-L${s.index}'>${dto.sch_time}분</div> --%>
								<div class='route-St-Full'>
									<div class='route-St-Title'>${dto.station_name}</div>
									<div class='route-St-Time'>${dto.arrive_time}</div>
								</div>
								<div class='route-St-R route-St' id=''>
									<div class='route-St-dot' id='${dto.station_id}'></div>
								</div>
								<div class="routeDetailLine " id='route-St-station${s.index}'></div>
							</div>
							
							<c:if test="${s.last}">
								<div id="route-St-Box${s.count}" class='route-St-Box route-St-station route-St-end'>
	      							<div class='route-St-Title'>유치원</div>
	      							<div class='route-St-Time'>${dto_basic[0].route_arrive}</div>
	      							<div class='route-St-R route-St' >
										<div class='route-St-dot' id=''></div>
									</div>
									<div class="routeDetailLine_End" id="route-St-station${s.count}"></div>
		      					</div>
							</c:if>								
						</c:forEach>
					</div>
				</div>

				<div id="map" style="width:100%;height:350px;"></div>
				
				<div class="contentBottomBtn bottom_900">
					<div class="btnLeftBox">
						<input type="button"  onclick="history.back()" class="btn_back">
					</div>
					<div class="btnCnterBox">
						<input type="button"  onclick="location.href='busRouteUpdate?route_id=${dto_basic[0].route_id}'" class="btn_update">
					</div>
					<div class="btnRightBox">
<!-- 						<a href="#"class="bottomBtn bottomBtn-R">삭제</a>	 -->
						<input type="button" class="btn_delete" id="busRouteDel"  onclick="busRouteDelete('${dto_basic[0].route_id}','${dto_basic[0].course_id}','${dto_basic[0].route_use}')">
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../include/footer.jsp"/>
	
	<script type="text/javascript">
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	
	var save_station_id;
	
	function closeLayer2(obj){							//정류장 삭제
		
		console.log("closeLayer2 시작");
		var route_id = $("#routeId").val();
		var course_id = $("#courseId").val();
		var route_use = $("#route_use").val()
		
		if(obj==1 && route_use=="false"){		//승인 확인
			$.ajax({  
	            url : 'routeDelete',
	            dataType : 'json',
	            type:'POST',
	            data : { "route_id" : route_id,"course_id" : course_id},
	            beforeSend: function(xhr) {
		              xhr.setRequestHeader(header, token);
		        },
	            success: function(data) {
	            	location.replace("busRouteList");
	            },
	            error:function(request,status,error){                 
	         	   alert("code:"+request.status+"\n"+"error:"+error);
	            }
	    	});
		}else if(route_use=="true"){
			var hasCheck = $( "#msgBox" ).hasClass( "msgBox_Success" );
    		if(hasCheck){$('#msgBox').removeClass("msgBox_Success");}
    		
			$('#msgBox').addClass("msgBox_Error");	
    		$('#msgBox').html("<span>사용중인 노선은 삭제 할 수 없습니다.</span>");
    		document.getElementById('msgBox').style.display="block";
		}
		document.getElementById('layerWindow').style.display='none';
	}
	
	
	function busRouteDelete(route_id,course_id,route_use){
		console.log("route_id:"+route_id);
		console.log("course_id:"+course_id);
		
		document.getElementById('msgBox').style.display="none";
		
//			$('#layerWindow').css('display','block');
		document.getElementById('layerWindow').style.display='block';
		$("#routeId").val(route_id);
		$("#courseId").val(course_id);
		$("#route_use").val(route_use);
		
		
		
	}	//삭제
	
	$(document).ready(
		function insertBus(){
			
			var stationCnt = $('.route-St-station').length;		//정류장 개수
// 			$(".route-St-end").attr("id","route-St-Box"+stationCnt);
// 			$(".routeDetailLine_End").attr("id","route-St-station"+stationCnt);
			var lineCnt = 6;									//한줄에 나타낼 정류장 수
			var leftRight = false;
			
			console.log("stationCnt:"+stationCnt);
			
			for(var j=0;j<=stationCnt;j++){
// 				var line = parseInt(j/lineCnt);
// 				console.log("//j"+j+"//lineCnt:"+lineCnt);	
				var parentsBox=$('#route-St-station'+j).parents("div").attr("id");		//부모 ID 가져오기
				console.log("parentsBox:"+parentsBox);
				
				if(!leftRight){
					if(j<lineCnt-1){
						$('#route-St-station'+j).addClass('routeDetailLine_Left route-width2');
						$("#"+parentsBox).addClass('route-St-Box_L');
					}
				    else if(j==lineCnt-1){
						$('.route-St'+j).addClass('route-Float-BB');
						$('#route-St-station'+j).addClass('routeDetailLine_Right_B');
						$("#"+parentsBox).addClass('route-St-Box_R');
						leftRight = true;
					}
					else{
						if(j%lineCnt==lineCnt-1 && j>0){
							$('.route-St'+j).addClass('route-Float-BB');
							$('#route-St-station'+j).addClass('routeDetailLine_Right');
							$("#"+parentsBox).addClass('route-St-Box_R');
							leftRight = true;
						}
						else{
							$('#route-St-station'+j).addClass('routeDetailLine_Left');
							$("#"+parentsBox).addClass('route-St-Box_L');
						}
					}				
				}
				else{
					if(j%lineCnt==lineCnt-1 && j>0){
						$('.route-St'+j).addClass('route-Float-B');
						$('#route-St-station'+j).addClass('routeDetailLine_Left');
						$("#"+parentsBox).addClass('route-St-Box_L');
						leftRight = false;
					}
					else{
						$('#route-St-station'+j).addClass('routeDetailLine_Right');
						$("#"+parentsBox).addClass('route-St-Box_R route-St-Box_MT');
					}
				}
				
				
			}

			
		});
	function over(this_id,station_id,s_latitude,s_longitude,s_name){
		$("#map").empty();
		if(save_station_id!=station_id){
			save_station_id=station_id;
// 			console.log("s_latitude:"+s_latitude);
// 			console.log("s_longitude:"+s_longitude);
// 			console.log("this_id,station_id:"+this_id+station_id);
			$('#staticMap').empty();
			$('#routeDetailKids').empty();
			$('#routeDetailAllKids').empty();
			
			var route_id =$('.routeId').attr('id');
			
			var stationCnt = $('.stationRouteBox').length;
			
// 			document.getElementById("contentRight3").style.display="inline";
				
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
	    mapOption = { 
	        center: new daum.maps.LatLng(s_latitude, s_longitude), // 지도의 중심좌표
	        level: 2 // 지도의 확대 레벨
	    };

		var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		 
// 		var size = "${kidsInStaion_size}";
// 		var content = '<div class ="labelInMap"><span class="left"></span><span class="center">'+s_name+'</span><span class="right"></span></div>';
		var content;
		var positions = new Array();
// 		positions[0] = {
// 				 title: s_name, 
// 				 latlng: new daum.maps.LatLng(s_latitude, s_longitude),
// 				 content : '<div class ="labelInMap"><span class="left"></span><span class="center">'+s_name+'</span><span class="right"></span></div>'
// 		}
		positions.push({
			 title: s_name, 
			 latlng: new daum.maps.LatLng(s_latitude, s_longitude),
			 imageSrc : "images/marker/image_maker_bus2_110x190.png",
			 content : s_name
	})

		<c:forEach var="obj" items="${kidsInStaion}" varStatus="s">		//hover 했을 때 원아 뜨게
		var hover_StationId="${obj.station_id}";
		var imageSrc ;
		if(hover_StationId==save_station_id){
			positions.push({title: "${obj.kid_name}",  
				content : '${obj.kid_name}',
				imageSrc : "images/marker/image_maker_I2_110x190.png",
				latlng: new daum.maps.LatLng("${obj.kid_latitude}", "${obj.kid_longitude}"),
				kidscode:'${obj.kid_system_code}'})
				
		}
		</c:forEach>
	
		// 마커 이미지의 이미지 크기 입니다
	    var imageSize = new daum.maps.Size(36, 63); 

		var kidsName="";
		var check = true;
// 		console.log("positions"+positions[1].latlng);
		for (var i = 0; i < positions.length; i ++) {
			if(i==0){
				kidsName=s_name;
			}else{
				kidsName=positions[i].content;
				for(var j =i+1; j<positions.length; j++){
					if(j!=0){
						if(positions[i].latlng.equals(positions[j].latlng)){
								kidsName +=", "+positions[j].content;
								check = false;
								positions[i].title +=positions[j].title;
								positions.splice(i,1);
								
// 							kidsName += positions[j].content;
						}else{
							kidsName = positions[i].content;
						}	
					}					
				}
			}
			content = '<div class ="labelInMap"><span class="left"></span><span class="center">'+kidsName+'</span><span class="right"></span></div>';		
			
		    
		    
		    // 마커 이미지를 생성합니다    
		    var markerImage = new daum.maps.MarkerImage(positions[i].imageSrc, imageSize); 
		    
		    // 마커를 생성합니다
		    var marker = new daum.maps.Marker({
		        map: map, // 마커를 표시할 지도
		        position: positions[i].latlng, // 마커를 표시할 위치
		        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
		        image : markerImage // 마커 이미지 
		    });
		    
			 // 커스텀 오버레이를 생성합니다
		    var customOverlay = new daum.maps.CustomOverlay({
		        position: positions[i].latlng,
		        content: content
// 		        content: positions[i].content   
		    });
			 
			// 커스텀 오버레이를 지도에 표시합니다
		    customOverlay.setMap(map,marker);
		}
		
		}
		else{
			return false;
		}
	
	}
	
	</script>
