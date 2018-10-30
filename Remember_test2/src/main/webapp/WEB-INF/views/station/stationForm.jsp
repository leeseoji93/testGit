<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*, java.text.*"  %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import="org.springframework.security.core.Authentication" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/daumMap.css">
<%
	Authentication  auth = SecurityContextHolder.getContext().getAuthentication();
	Object princial = auth.getName();
%>

	<jsp:include page="../include/menu_admin.jsp">
		<jsp:param name="pageInMenu" value="차량운행정보"  /> 
		<jsp:param name="pageCategory" value="정류장 관리"  />
		<jsp:param name="pageTitle" value="정류장 등록"  /> 
	</jsp:include>
	<div class="page">
		<div class="page-wrapper">
	
			<div class="pageTitle"><h2>정류장 등록</h2></div>
			
			<div class="pageContent700">
				<!-- STEP2. 정류장명 입력 -->
				<div class="stepTitle">
					<span>정류장 키워드를 검색 후 지도에 승하차 정확한 위치를 클릭 해주세요.</span>
				</div>

				<!-- 원아지도 -->
				
				<div class="moreBox">
					<label for="KidMapcheck"  onclick="openLayer('moreBoxMap',100,200)"></label>
					
					<input id="KidMapcheck" type="checkbox">
					
					<div class="moreBoxMap" id="moreBoxMap">
						<div id="map2" style="width:100%;height:400px;"></div>
					</div>
				</div>
				

						
				<div class="stepContent">
					<div class="map_wrap" style="height:400px;">
					    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
					
					    <div id="menu_wrap" class="bg_white">
					        <div class="option">
					            <div>
					                <form onsubmit="searchPlaces(); return false;">
					                	<c:set value="${centerAddr}" var="dto"/>	
					                 	   키워드 : <input type="text" value="${dto[0].center_name }" id="keyword" size="15"> 
					                    <button type="submit">검색하기</button> 
					                </form>
					            </div>
					        </div>
					        <hr>
					        <ul id="placesList"></ul>
					        <div id="pagination"></div>
					    </div>
					    <div id="clickLatlng"></div>
					</div>
				
					
				</div>
				
				<c:set value="${centerAddr}" var="dto"/>	
				<!-- STEP1. 정류장명 입력 -->
				<form:form action="stationInsert" id="STForm" commandName="STForm" method="POST" onkeydown="if(event.keyCode==13){event.returnValue=false;}">
					<form:hidden path="latitude" />
					<form:hidden path="longitude" />
				
				
				<div class="stepContent">
					<label>정류장 이름</label><form:input path="station_name" id="station_name" cssClass="station_name big_input" />
<%-- 					<form:hidden path="registrant" value="<%=princial %>"/> --%>
					<form:hidden path="station_use" value="1" />
					<form:hidden path="center_code" id="center_code" value="${dto[0].center_code}"/>
					<form:hidden path="station_id" id="station_id"/>
					<form:hidden path="station_type" id="station_type" value="정류장"/>
					<form:hidden path="registrant" id="registrant" value="${name}"/>

					<form:hidden path="station_addr" />
					 <input type="hidden" name="${_csrf.parameterName}" id="csrf" value="${_csrf.token}" />
				</div>
				<div id="chk_stName"></div>
				
				<div class="pageBtn contentBottomBtn">
					<div class="btnLeftBox">
						<input type="button" value="" class="btn_back" id="cusInputBtn" onclick="history.back();" id="bottomBtn-Input" />
					</div>
					<div class="btnCnterBox">
						<input type="submit" value="" id="cusInputBtn" class="btn_add">
					</div>
					<div class="btnRightBox">
						<input type="button" value="" class="btn_list" id="cusInputBtn" onclick="location.replace('stationList')"/>
					</div>
				</div>
				</form:form>
			</div>	
			
			<div class="pageContent300">	
				<div class="stationList_inForm">
					<h3>정류장 목록</h3>
					<div class="stationList_inForm_con" id="stationList_inForm_con">
						<table id="stationList_inForm_table">
						
						<c:choose>
							<c:when test="${fn:length(stationList) eq 0}">
								<tr><td align="center">등록된 정류장이 없습니다.</td></tr>
							</c:when>
							
							<c:otherwise>
								<c:forEach var="obj" items="${stationList}" varStatus="s">
								<tr class="tr_hover" id="cusListTableTr${s.index}">
									<td width="400px" onclick="location.href='stationDetail?station_id=${obj.station_id}'">${obj.station_name}</td>
									<td width="50px" align="center">
										<c:choose>
											<c:when test="${obj.routeExists eq 1}">
												<div class="station-use"><img src="images/button/button_useee_Y_50x20(x2).png"></div>
											</c:when>
											<c:otherwise>
												-
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>			
						
						</table>
					</div>
				</div>
			</div>
					
		</div>
	</div>
<script type="text/javascript">


//레이어 팝업 열기
function openLayer(IdName, tpos, lpos){
	var pop = document.getElementById(IdName);
	pop.style.display = "block";
	pop.style.top = tpos + "px";
	pop.style.left = lpos + "px";

		

	var centerLa = ${dto[0].latitude};				//유치원 위도
	var centerLo = ${dto[0].longitude};				//유치원 경도


		console.log("centerLa :"+centerLa+"centerLo"+centerLo);

		var mapContainer = document.getElementById('map2'), // 지도를 표시할 div  
		    mapOption = { 
		        center: new daum.maps.LatLng(centerLa, centerLo), // 지도의 중심좌표
		        level: 4 // 지도의 확대 레벨
		    };

			var map2 = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
			
			//유치원 마커
			// 마커가 표시될 위치입니다 
			var markerPosition  = new daum.maps.LatLng(centerLa, centerLo); 
			
			var imageSrc = 'images/marker/image_maker_U2_110x190.png', // 마커이미지의 주소입니다    
		    imageSize = new daum.maps.Size(28, 48), // 마커이미지의 크기입니다
		    imageOption = {offset: new daum.maps.Point(14, 48)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
		    
		    var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imageOption);
		    
			// 마커를 생성합니다
			var marker = new daum.maps.Marker({
			    position: markerPosition,
			    image: markerImage
			});
			
			// 마커가 지도 위에 표시되도록 설정합니다
			marker.setMap(map2);
			
			var positions = new Array();
		 	<c:forEach items="${kidList}" var="dto2" varStatus="status">	
				
				var indexLa= "${dto2.latitude}";			//원아 위도
				var indexLo="${dto2.longitude}";			//원아 경도
				var str = "${dto2.kid_name}";					//원아 이름
				console.log("indexLa:"+indexLa+"//indexLo:"+indexLo+"//str:"+str);
				var overCnt=0;
				
				var imageSrc = 'images/marker/image_maker_I2_110x190.png', // 마커이미지의 주소입니다    
			    imageSize = new daum.maps.Size(28, 48), // 마커이미지의 크기입니다
			    imageOption = {offset: new daum.maps.Point(14, 24)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
			    
			    var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imageOption);
				positions["${status.count}"] ={
						content:'<div>'+str+'</div>', 
				        latlng: new daum.maps.LatLng(indexLa, indexLo)
				};
				
//		 		var j=7;
//		 		var posi2 = positions[7].latlng;
				
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
			        map2: map2, // 마커를 표시할 지도
			        position: posi, // 마커의 위치
			        image: markerImage
			    });
				// 마커에 표시할 인포윈도우를 생성합니다 
			    var infowindow2 = new daum.maps.InfoWindow({
			        content: con // 인포윈도우에 표시할 내용
			    });
			    marker.setMap(map2);
			    daum.maps.event.addListener(marker, 'mouseover', makeOverListener(map2, marker, infowindow2));
			    daum.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow2));	
			 </c:forEach>
			
			
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
}
//레이어 팝업 닫기
function closeLayer(IdName){
	var idval = $('#timepicker1').val();
    console.log("idval : "+idval);
	var pop = document.getElementById(IdName);
	pop.style.display = "none";
}
</script>
<script>

<c:set value="${centerAddr}" var="dto"/>		

	var centerLa = ${dto[0].latitude};				//유치원 위도
	var centerLo = ${dto[0].longitude};				//유치원 경도
	
// 마커를 담을 배열입니다
var markers = [];

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new daum.maps.LatLng(centerLa, centerLo), // 지도의 중심좌표
        level: 4  // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new daum.maps.Map(mapContainer, mapOption); 

// 장소 검색 객체를 생성합니다
var ps = new daum.maps.services.Places();  

// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
var infowindow = new daum.maps.InfoWindow({zIndex:1});

// 키워드로 장소를 검색합니다
searchPlaces();

// 키워드 검색을 요청하는 함수입니다
function searchPlaces() {

    var keyword = document.getElementById('keyword').value;

    if (!keyword.replace(/^\s+|\s+$/g, '')) {
        alert('키워드를 입력해주세요!');
        return false;
    }

    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
    ps.keywordSearch( keyword, placesSearchCB); 
}

// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
function placesSearchCB(data, status, pagination) {
    if (status === daum.maps.services.Status.OK) {

        // 정상적으로 검색이 완료됐으면
        // 검색 목록과 마커를 표출합니다
        displayPlaces(data);

        // 페이지 번호를 표출합니다
        displayPagination(pagination);

    } else if (status === daum.maps.services.Status.ZERO_RESULT) {

        alert('검색 결과가 존재하지 않습니다.');
        return;

    } else if (status === daum.maps.services.Status.ERROR) {

        alert('검색 결과 중 오류가 발생했습니다.');
        return;

    }
}

// 검색 결과 목록과 마커를 표출하는 함수입니다
function displayPlaces(places) {

    var listEl = document.getElementById('placesList'), 
    menuEl = document.getElementById('menu_wrap'),
    fragment = document.createDocumentFragment(), 
    bounds = new daum.maps.LatLngBounds(), 
    listStr = '';
    
    // 검색 결과 목록에 추가된 항목들을 제거합니다
    removeAllChildNods(listEl);

    // 지도에 표시되고 있는 마커를 제거합니다
    removeMarker();
    
    for ( var i=0; i<places.length; i++ ) {

        // 마커를 생성하고 지도에 표시합니다
        var placePosition = new daum.maps.LatLng(places[i].y, places[i].x),
            marker = addMarker(placePosition, i), 
            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        bounds.extend(placePosition);

        // 마커와 검색결과 항목에 mouseover 했을때
        // 해당 장소에 인포윈도우에 장소명을 표시합니다
        // mouseout 했을 때는 인포윈도우를 닫습니다
        (function(marker, title) {
            daum.maps.event.addListener(marker, 'mouseover', function() {
                displayInfowindow(marker, title);
            });

            daum.maps.event.addListener(marker, 'mouseout', function() {
                infowindow.close();
            });

            itemEl.onmouseover =  function () {
                displayInfowindow(marker, title);
            };

            itemEl.onmouseout =  function () {
                infowindow.close();
            };
        })(marker, places[i].place_name);

        fragment.appendChild(itemEl);
    }

    // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
    listEl.appendChild(fragment);
    menuEl.scrollTop = 0;

    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
    map.setBounds(bounds);
}

// 검색결과 항목을 Element로 반환하는 함수입니다
function getListItem(index, places) {

    var el = document.createElement('li'),
    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                '<div class="info">' +
                '   <h5>' + places.place_name + '</h5>';

    if (places.road_address_name) {
        itemStr += '    <span>' + places.road_address_name + '</span>' +
                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
    } else {
        itemStr += '    <span>' +  places.address_name  + '</span>'; 
    }
                 
      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
                '</div>';           

    el.innerHTML = itemStr;
    el.className = 'item';

    return el;
}

// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
function addMarker(position, idx, title) {
    var imageSrc = 'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
        imageSize = new daum.maps.Size(36, 37),  // 마커 이미지의 크기
        imgOptions =  {
            spriteSize : new daum.maps.Size(36, 691), // 스프라이트 이미지의 크기
            spriteOrigin : new daum.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
            offset: new daum.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
        },
        markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new daum.maps.Marker({
            position: position, // 마커의 위치
            image: markerImage 
        });
  
    marker.setMap(map); // 지도 위에 마커를 표출합니다
    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

    return marker;
}

// 지도 위에 표시되고 있는 마커를 모두 제거합니다
function removeMarker() {
    for ( var i = 0; i < markers.length; i++ ) {
        markers[i].setMap(null);
    }   
    markers = [];
}

// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
function displayPagination(pagination) {
    var paginationEl = document.getElementById('pagination'),
        fragment = document.createDocumentFragment(),
        i; 

    // 기존에 추가된 페이지번호를 삭제합니다
    while (paginationEl.hasChildNodes()) {
        paginationEl.removeChild (paginationEl.lastChild);
    }

    for (i=1; i<=pagination.last; i++) {
        var el = document.createElement('a');
        el.href = "#";
        el.innerHTML = i;

        if (i===pagination.current) {
            el.className = 'on';
        } else {
            el.onclick = (function(i) {
                return function() {
                    pagination.gotoPage(i);
                }
            })(i);
        }

        fragment.appendChild(el);
    }
    paginationEl.appendChild(fragment);
}

// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
// 인포윈도우에 장소명을 표시합니다
function displayInfowindow(marker, title) {
    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

    infowindow.setContent(content);
    infowindow.open(map, marker);
}

 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
function removeAllChildNods(el) {   
    while (el.hasChildNodes()) {
        el.removeChild (el.lastChild);
    }
}
 
//주소-좌표 변환 객체를 생성합니다
	var geocoder = new daum.maps.services.Geocoder();
	
	var imageSrc = 'images/marker/image_maker_bus2_110x190.png', // 마커이미지의 주소입니다    
    imageSize = new daum.maps.Size(28, 48), // 마커이미지의 크기입니다
    imageOption = {offset: new daum.maps.Point(14,48)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
    
    var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imageOption);
	
    
	// 지도를 클릭한 위치에 표출할 마커입니다
	var marker = new daum.maps.Marker({ 
	    // 지도 중심좌표에 마커를 생성합니다 
	    position: map.getCenter() ,
	    image: markerImage
	}); 
	// 지도에 마커를 표시합니다
	marker.setMap(map);
	
	searchAddrFromCoords(map.getCenter(), displayCenterInfo);
	
	// 지도에 클릭 이벤트를 등록합니다
	// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
	daum.maps.event.addListener(map, 'click', function(mouseEvent) {    
		 searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
		if (status === daum.maps.services.Status.OK) {
			var detailAddr = result[0].address.address_name ;
	           
	           var content = '<div class="bAddr">' +
	                           detailAddr + 
	                         '</div>';
	    // 클릭한 위도, 경도 정보를 가져옵니다 
	    var latlng = mouseEvent.latLng; 
	    
	    // 마커 위치를 클릭한 위치로 옮깁니다
	    marker.setPosition(latlng);
	    marker.setMap(map);
	    
	    var message1 = latlng.getLat();
	    var message2 = latlng.getLng();
	    
	    var resultDiv1 = document.getElementById('latitude'); 
	    var resultDiv2 = document.getElementById('longitude'); 
	    var resultDiv3 = document.getElementById('station_addr');
	    resultDiv1.setAttribute("value",message1);
	    resultDiv2.setAttribute("value",message2);
	    resultDiv3.setAttribute("value",detailAddr);
	    
	 // 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
	          infowindow.setContent(content);
	          infowindow.open(map, marker);
	      }   
		 });
	});
	// 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
	daum.maps.event.addListener(map, 'idle', function() {
	    searchAddrFromCoords(map.getCenter(), displayCenterInfo);
	});
	
	function searchAddrFromCoords(coords, callback) {
	    // 좌표로 행정동 주소 정보를 요청합니다
	    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
	}
	
	function searchDetailAddrFromCoords(coords, callback) {
	    // 좌표로 법정동 상세 주소 정보를 요청합니다
	    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
	}
	
	// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
	function displayCenterInfo(result, status) {
	    if (status === daum.maps.services.Status.OK) {
	        var infoDiv = document.getElementById('station_addr');
	        infoDiv.innerHTML = result[0].address_name;
	    }    
	}
	
	
</script>
	<script>
	var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
    <c:set value="${centerAddr}" var="dto"/>
		$(document).ready(function(){
			$.ajax({  
	              url : 'station_id_Check',
	              dataType : 'json',
	              type:'POST',
	              data : { "center_code" : '${dto[0].center_code}' },   
	              beforeSend: function(xhr) {
	  	            xhr.setRequestHeader(header, token);
	  	        	},
	              success: function(result) {	            	 	      
	           	  
	           	   var size_data=result.station_id_count;  
// 	           		console.log(result.station_id_count[i].maxcount);
	          		for(var i=0; i < size_data.length; i ++){
	          			$('#station_id').val('${dto[0].center_code}' + "_S0_"+result.station_id_count[i].maxcount);	      	          			
	          		}
	              },
	              error:function(request,status,error){                 
	           	   alert("code:"+request.status+"\n"+"error:"+error);
	              }
	              
	          }); //ajax 버스 id 몇개 있는지 파악
		});
	</script> <!-- 버스 id, 센터 코드 히든값 셀렉 -->
	
	<script>
	$(function() {				
		 $.validator.addMethod("regex", function(value, element, regexpr) {          
		     return regexpr.test(value);
		   });	 
		 var token = $("meta[name='_csrf']").attr("content");
		 var header = $("meta[name='_csrf_header']").attr("content");
		    
		$("#STForm").validate({
			errorClass: "validFail",
			validClass: "validSuccess",
			ignore : "",
		    rules: {
		    	station_name : {
		    		required: true,
		    		remote: {
	    				url:  "checkName_station",
	    				type: "post",
	    				beforeSend: function(xhr) {
	    		            xhr.setRequestHeader(header, token);
	    		        },
	    				data: {
	    					formData: function() {
	    						return $("#station_name").val();
	    						}
	    				}
	    			},		
		    		regex: /^[\s|ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|\*]{2,10}$/			    		
		    	},
		    	latitude: {
		    		required: true,
		    	}
		    },			    

		    messages: {

		    	station_name: {
		            required: "정류장명을 입력해주세요.",
		            remote : "이미 사용되고 있는 정류장명입니다.",
		            regex : "10자 이내로 입력해주세요."
		        },
		        latitude: {
		            required: "정류장 위치를 클릭해주세요."		        }
		    },		    
		    success: function(label) {
//                   label.addClass("validSuccess").text("사용가능합니다.");
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