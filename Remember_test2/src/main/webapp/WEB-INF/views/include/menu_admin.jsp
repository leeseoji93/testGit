<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="js/jquery.validate.min.js"></script><!-- 유효성 검사 -->
<script type="text/javascript" src="js/additional-methods.min.js"></script><!-- 유효성 검사 -->	
<script src="js/jquery.easing.min.js" type="text/javascript"></script> <!-- jQuery easing plugin (step) --> 
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script><!-- 날짜 입력 --> 
<script src="js/timepicki.js"></script><!-- 시간 입력 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=976c390ffb0cfa7e527d182e55644f4f&libraries=services"></script>
<!-- <script type="text/javascript" src="jquery.battatech.excelexport.js"></script>excel로 다운 -->

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/footer.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/realTime.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/busRouteStyle.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/includeStyle.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/accountStyle.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/dashboard.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"><!-- 날짜 입력 -->
<link rel="stylesheet" type="text/css" href="css/timepicki.css"><!-- 시간 입력 -->

<!-- K_Style -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/medicationStyle.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/Home_communication.css">

<script type="text/javascript">
( function( $ ) {

		  
		 
	$( document ).ready(function() {
// 	$('#mainMenu li.has-sub #mailForm').parent().parent().addClass('open');

	//현재 주소를 decoding
	var url = unescape(location.href); 
// 	console.log("url:"+url);
	console.log("url:"+url);
	var temp = url.split("/"); //파라미터 변수명을 담음
// 	console.log("temp[4]:"+temp[4]);

	var nowPage = temp[3].split("?");
	var nowPageName = nowPage[0].split("#");
	if(temp[3] !=""){
		
	 	console.log("nowPage:"+nowPageName[0]);
	 	
		$('#mainMenu #'+nowPageName[0]).parent().slideDown();
		$('#mainMenu #'+nowPageName[0]).parent().parent().parent().slideDown();
		$('#mainMenu #'+nowPageName[0]).addClass('open');
	}
	
	
	$('#mainMenu li.has-sub>a').on('click', function(){
			$(this).removeAttr('href');
			var element = $(this).parent('li');
			if (element.hasClass('open')) {
				element.removeClass('open');
// 				element.find('li').removeClass('open');
				element.find('ul').slideUp();
			}
			else {
				element.addClass('open');
				element.children('ul').slideDown();
				element.siblings('li').children('ul').slideUp();
// 				element.siblings('li').removeClass('open');
// 				element.siblings('li').find('li').removeClass('open');
				element.siblings('li').find('ul').slideUp();
			}
		});
	});
	} )( jQuery );
</script>
	
	<jsp:include page="header.jsp"/>
	<div class="mainSideLeft">		
		<div id="mainMenu">
			<ul>
				<li class='has-sub '><a href="#"><span><img src="images/sidebar/sidebar_1.png"></span>차량운행정보</a>
					<ul class="mainMenuSub6">
<!-- 						<li class='has-sub'><a href="#">실시간 조회</a> -->
<!-- 							<ul> -->
<!-- 								<li id="realTimeViewer"><a href="realTimeViewer">- 차량위치조회</a></li> -->
<!-- 								<li id=""><a href="#">- 지각/결석조회</a></li> -->
<!-- 							</ul> -->
<!-- 						</li> -->
						<li class='has-sub'><a href="#">노선관리</a>
							<ul>
								<li id="busRouteForm"><a href="busRouteForm">- 노선등록</a></li>
								<li id="busRouteList" class='last'><a href="busRouteList">- 노선조회</a></li>
							</ul>
						</li>
						<li class='has-sub'><a href="#">정류장관리</a>
							<ul>
								<li id="stationForm"><a href="stationForm">- 정류장등록</a></li>
								<li id="stationList" class='last'><a href="stationList">- 정류장조회</a></li>
							</ul>
						</li>
						<li class='has-sub'><a href="#">차량관리</a>
							<ul>
								<li id=""><a href="DataInputForm">- 차량등록</a></li>
								<li id="CarInfoView" class='last'><a href="CarInfoView">- 차량정보조회</a></li>
							</ul>
						</li>
						<li class='has-sub last'><a href="#">운행이력관리</a>
							<ul>
								<li id="vehicleLogList"><a href="vehicleLogList">- 운행 이력 조회</a></li>
								<li id="carCheckManagement" class='last'><a href="carCheckManagement">- 차량일일점검표</a></li>
							</ul>
						</li>
					</ul>
				</li>
				<li class='has-sub'><a href="#"><span><img src="images/sidebar/sidebar_2.png"></span>자동이력</a>
					<ul class="mainMenuSub2">
						<li class='has-sub'><a href="#">승하차이력</a>
							<ul>
								<li id="OnoffList_car"><a href="OnoffList_car">- 승하차 이력</a></li>
								<li id="OnoffList" class='last'><a href="OnoffList">- 등하원일지</a></li>
							</ul>
						</li>
						<li class='has-sub last'><a href="#">출석이력</a>
							<ul>
								<li id="AttendanceList" class='last'><a href="AttendanceList">- 출석부조회</a></li>
							</ul>
						</li>
					</ul>
				</li>
				<li class='has-sub'><a href="#"><span><img src="images/sidebar/sidebar_3.png"></span>소통</a>
					<ul class="mainMenuSub3">
						<li class='has-sub'><a href="#">가정통신문</a>
							<ul>
								<li id="Home_communicationForm"><a href="Home_communicationForm">- 가정통신문작성</a></li>
								<li id="Home_communicationList" class='last'><a href="Home_communicationList">- 가정통신문조회</a></li>
							</ul>
						</li>
						<li id="medication_contrast_documentList"><a href="medication_contrast_documentList">투약대조서</a></li>
						<li id="medication_diaryList" class='last'><a href="medication_diaryList">투약일지</a></li>
					</ul>
				</li>
				<li class='has-sub'><a href="#"><span><img src="images/sidebar/sidebar_4.png"></span>계정관리</a>
					<ul class="mainMenuSub2">
						<li class='has-sub'><a href="#">계정등록</a>
							<ul>
								<li id="accountForm"><a href="accountForm">- 교직원</a></li>
								<li id="accountForm_kids" class='last'><a href="accountForm_kids">- 원아</a></li>
							</ul>
						</li>
						<li id="accountList" class='last'><a href="accountList">계정조회</a></li>
					</ul>
				</li>
				<li class='has-sub'><a href="#"><span><img src="images/sidebar/sidebar_6.png"></span>기기관리</a>
					<ul class="mainMenuSub2">
						<li class='has-sub'><a href="#">비콘</a>
							<ul>
<!-- 								<li><a href="beaconAddForm">- 비콘등록</a></li> -->
								<li id="beaconList"><a href="beaconList">- 비콘조회</a></li>
								<li id="beaconMatching"><a href="beaconMatching">- 원아배정</a></li>
								<li id="matchingPresentCondition" class='last'><a href="matchingPresentCondition">- 배정현황</a></li>
							</ul>
						</li>
						<li class='has-sub'><a href="#">테블릿&게이트웨이</a>
							<ul>
<!-- 								<li><a href="#">- 테블릿등록</a></li> -->
								<li id="tabletList"><a href="tabletList">- 테블릿조회</a></li>
								<li id="gatewayList"><a href="gatewayList">- 게이트웨이조회</a></li>
								<li id="installEquipmentList" class='last'><a href="installEquipmentList">- 설치현황</a></li>
							</ul>
						</li>
						<li class='last has-sub'><a href="#">A/S 신청</a>
							<ul>
<!-- 								<li><a href="#">- 테블릿등록</a></li> -->
								<li id="mailForm"><a href="mailForm">- 신청하기</a></li>
								<li id="asList" class='last'><a href="asList">- 신청내역</a></li>
							</ul>
						</li>
					</ul>
				</li>
				<li class='has-sub last'><a href="#"><span><img src="images/sidebar/sidebar_5.png"></span>시설관리</a>
					<ul class="mainMenuSub2">
						<li class='has-sub'><a href="ClassList">반관리</a>
							<ul>
								<li id="addClassForm"><a href="addClassForm">- 반등록</a></li>
								<li id="ClassList" class='last'><a href="ClassList">- 반조회</a></li>
							</ul>
						</li>
						<li id="centerInfo" class='last'><a href="centerInfo">원정보</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</div>

<script type="text/javascript">
var didScroll; 
var lastScrollLeft = 0; 
var delta = 5; 
var navbarWidth = $('.mainSideLeft').innerWidth(); 
$(window).scroll(function(event){ didScroll = true; }); 
setInterval(function() { 
	if (didScroll) { 
		hasScrolled(); 
		didScroll = false; 
		} 
	}, 230); 
		
	function hasScrolled() { 
		var st = $(this).scrollLeft();  
		if (lastScrollLeft>30 && st>40){
			$('.mainSideLeft').removeClass('menu-visi').addClass('menu-hidden'); 
		} else {
			var ww = $(window).width();
			var dw = $(document).width();
			if(st + $(window).width() < $(document).width() || st>20) { 
				$('.mainSideLeft').removeClass('menu-hidden').addClass('menu-visi'); 
			} 
		} 
		
			lastScrollLeft = st; 
			
			if(Math.abs(lastScrollLeft - st) <= delta)
				var result = lastScrollLeft;
				return; 
		}

</script>
