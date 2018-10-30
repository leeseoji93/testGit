<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

	<jsp:include page="../include/menu_admin.jsp">
		<jsp:param name="pageInMenu" value="차량운행정보"  />
		<jsp:param name="pageCategory" value="정류장 관리"  />
		<jsp:param name="pageTitle" value="정류장 상세 조회"  /> 
	</jsp:include>
	<div class="page">
		<div class="page-wrapper">
			<div class="pageTitle"><h2>정류장 상세 조회</h2></div>
			
			<div class="pageContent conentStDetail textAlign-C">
				<div class="contentWDate width996">
				<div class="msgBox" id="msgBox"></div>
					<span>등록일 </span>${sessionStation.createtime} / 수정일 ${sessionStation.updatetime}
				</div>
				<table>
					<tr>
						<th>정류장명</th>
						<td>${sessionStation.station_name}</td>
					</tr>
					<tr>
						<th>주소</th>
						<td>${sessionStation.station_addr}</td>
					</tr>
					<tr>
						<th>사용여부</th>
						<td>
						<c:choose>
                        <c:when test="${sessionStation.station_use eq 1}">사용중</c:when>                        
                        <c:otherwise>-</c:otherwise>
                     	</c:choose>
						</td>
					</tr>
					<tr>
						<th>배치여부</th>
						<td>
						<c:choose>
							<c:when test="${sessionStation.routeExists eq 1}">
								<c:forEach items="${routeNameList}" var="Rdto" varStatus="status">
									<c:choose>
										<c:when test="${status.last}">
											${Rdto.route_name}
										</c:when>
										<c:otherwise>
											${Rdto.route_name}, 
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</c:when>
							<c:otherwise>
								-
							</c:otherwise>
						</c:choose>
						
						
						</td>
					</tr>
					<tr>
						<td colspan="2" style="padding:0px;">
							<div id="staticMap" style="width:996px;height:410px;"></div>
		
							<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=976c390ffb0cfa7e527d182e55644f4f"></script>
							<script>
							
							var latitude =${sessionStation.latitude};
							var longitude=${sessionStation.longitude};
							var markerPosition  = new daum.maps.LatLng(latitude, longitude); 
		
							// 이미지 지도에 표시할 마커입니다
							// 이미지 지도에 표시할 마커는 Object 형태입니다
							var marker = {
							    position: markerPosition
							};
		
							var staticMapContainer  = document.getElementById('staticMap'), // 이미지 지도를 표시할 div  
							    staticMapOption = { 
							        center: new daum.maps.LatLng(latitude, longitude), // 이미지 지도의 중심좌표
							        level: 2, // 이미지 지도의 확대 레벨
							        marker: marker // 이미지 지도에 표시할 마커 
							    };    
		
							// 이미지 지도를 생성합니다
							var staticMap = new daum.maps.StaticMap(staticMapContainer, staticMapOption);
							</script>
						
						</td>
					</tr>
					
				</table>
				
				<div class="contentBottomBtn">
					<div class="btnLeftBox">
						<input type="button" class="btn_back" value="" onclick="history.back();" id="bottomBtn-Input"> <!-- 이전버튼 클릭 -->
					</div>
					<div class="btnCnterBox">
						<input type="button" class="btn_update" value="" onclick="location.href='stationUpdate?station_id=${sessionStation.station_id}'" id="bottomBtn-Input">
						<input type="button" class="btn_delete" value="" onclick="Delbtt_click('${sessionStation.station_id}','${sessionStation.routeExists}','${sessionStation.station_use}')" id="bottomBtn-Input"> <!-- 삭제버튼 클릭 -->
					</div>
						
					<div class="btnRightBox">
						
					</div>
					
				</div>
			
			</div>
		</div>
	</div>
	<jsp:include page="../include/footer.jsp"/>
	<script>	 	
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	
	function Delbtt_click(data,routeExists,station_use) {
		console.log("station_use:"+station_use);
		if(routeExists==0 && station_use!=1){
			$.ajax({  
	            url : 'stationDelete',
	            dataType : 'json',
	            type:'POST',
	            data : { "station_id" : data},
	            beforeSend: function(xhr) {
	 	              xhr.setRequestHeader(header, token);
	 	           },
	            success: function(result) { 
	            
	            		if(result.delcheck=="true"){
	                		window.setTimeout(function(){location.href='stationList'});
	                	}
	                	else{
	                		$('#resultMessage').html('<p>삭제 실패했습니다.</p>');
	                	}	
	            },
	            error:function(request,status,error){     
	            	$('#resultMessage').html("code:"+request.status+"\n"+"error:"+error);
	            	
	            }
	        });	
		}
    	else{
    		$('#msgBox').addClass("msgBox_Error");	
    		$('#msgBox').html("<span>사용중인 정류장은 삭제가 불가능 합니다.</span>");
    		document.getElementById('msgBox').style.display="block";
    	}
     }
	</script> <!-- 삭제 버튼 클릭시 ajax비동기 삭제  -->	
</body>
</html>