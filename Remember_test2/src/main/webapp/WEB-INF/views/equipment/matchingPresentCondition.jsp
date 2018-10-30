<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/menu_admin.jsp">
	<jsp:param name="pageInMenu" value="기기관리"  />
	<jsp:param name="pageCategory" value="비콘"  />
	<jsp:param name="pageTitle" value="배정현황"  /> 
</jsp:include>
<div class="page">
	<div class="page-wrapper">
		<div class="pageTitle"><h2>배정 현황</h2></div>

		<div class="pageContent matchingPresentCondition" id="pageContent">
			<div class="condition_part1">
				<table>
					<tr>
						<th><img src="images/equipment/button_BC1.png"></th>
						<th><img src="images/equipment/button_BC2.png"></th>
						<th><img src="images/equipment/button_BC3.png"></th>
					</tr>
					<c:set value="${notMatchingKids}" var="dto_c"/>
					<tr>
						<td class="timer count-title count-number" data-to="${dto_c[0].beaconCnt}" data-speed="1500"></td>
						<td class="timer count-title count-number" data-to="${dto_c[0].totalBeaconCnt - dto_c[0].beaconCnt}" data-speed="1500"></td>
						<td class="timer count-title count-number" data-to="${dto_c[0].totalKidsCnt - dto_c[0].beaconCnt}" data-speed="1500"></td>
					</tr>
					<tr>
						<td><span>전체 매칭현황</span></td>
						<td><span>전체 비매칭 비콘</span></td>
						<td><span>전체 비매칭 원아</span></td>
					</tr>
					
				</table>
			</div>
			<div class="condition_part2">
				<div class="beaconContent_top beaconMatching" id="beaconContent_top">
					<table>
						<tr id="searchClass">
							<th width="70">반</th>
							<td>
								<c:forEach items="${kindOfClass}" var="dto" varStatus="s">
									<div class="searchList"><input type="radio" id="class_id${s.count}" name="class_id" value="${dto.class_id}" > 
										<div class="check"></div><label for="class_id${s.count}">${dto.class_name}</label>
									</div>
								</c:forEach>
							</td>
						</tr>
						<tr id="search_InputBox">
							<th><label>검색</label></th>
							<td><input type="text" name="keyWord" class="input245_25" id="keyWord"></td>
						</tr>
					</table>
					<div id="search_Btn">
						<input type="button" value="" id="searchBtn_Text" class="searchBtn_Text" onclick="searchKids()">
<!-- 						<input type="button" value="초기화" id="resetBtn" onclick="resetBtn()"> -->
						<div id="choiceBtn" class="choiceBtn"></div>
					</div>				
				</div>
				
			</div>
			<div class="condition_part3" id="condition_part3">
				<form action="matchingCut" name="matchingCut" id="matchingCut" method="post">
					<div class="matchingCut_content" id="matchingCut_content">
						<center>반을 선택 해 주세요.</center>
					</div>
					<input type="hidden" name='${_csrf.parameterName}' id='csrf' value='${_csrf.token}' />
				</form>
			</div>
			<div class="pageBtn contentBottomBtn">
				<div class="btnLeftBox">
					<input type="button" value="" class="btn_back" id="cusInputBtn3" onclick="history.back();" id="bottomBtn-Input">
				</div>
				<div class="btnCnterBox" id="btnCnterBox">
					
		  		</div>
		  		<div class="btnRightBox">
<!-- 		  			<input type="button" value="" id="cusInputBtn2" class="customM" onclick="accountBack()"/>		 -->
		  		</div>
	  		</div>
		</div>
	</div>
</div>
<jsp:include page="../include/footer.jsp"/>	
<script type="text/javascript">
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

function goUpdate(){
// 	var beacon_id = $("form[name=beacon_id]").serialize();
	var beacon_id = [];
    $("input[name='beacon_id']").each(function(i) {
    	beacon_id.push($(this).val());
    });
    
	var chk =[];
	$("input[name='chkMatch']").each(function(i) {
		var s = $('#chkMatch'+i).is(':checked');
		console.log("S:"+s);
		chk.push(s);
    });
	

// 	if(!$(':input:radio[name=chkMatch]:checked').val()){
		
// 	}

	

// 	$("input[name=chkMatch]:checked").each(function() {
// 		chk.push("1");		
//  	});
//  	$("input[name=chkMatch]:not(:checked)").each(function() {
// 		chk.push("0");		
//  	});
	
	
	for(var i=0;i<chk.length;i++){
		console.log(i+":"+chk[i]);
	}
	
    var kid_system_code = [];
    $("input[name='kid_system_code']").each(function(i) {
    	kid_system_code.push($(this).val());
    });
    
    console.log("beacon_id:"+beacon_id.length);

// // 	console.log("param:"+s);
	$.ajaxSettings.traditional = true;
	$.ajax({
		type : "POST",
		url : "updateMatchingCut",
		data : {"chk":chk,"beacon_id":beacon_id,"kid_system_code":kid_system_code},
		beforeSend: function(xhr) {
              xhr.setRequestHeader(header, token);
           },
		success : function(result) {
// 			$('#pageContent').load('matchingPresentCondition #pageContent');
			location.reload();
		},
		error : function(xhr, beacon_id, kid_system_code) {
// 			alert("//error" + errorThrown);
		}
	});
	
// 	matchingCut.submit();
}

function resetBtn(){
	$('.class_year').removeAttr('checked');
	$('.class_id').removeAttr('checked');
	$("#keyWord").val('');
}
function selectMatching(){
	
	var cntBox = $('.mc_Box').length;
	console.log("cntBox:"+cntBox);
	$("#btnCnterBox").append("");
	
	
	var hasInput = $(".mc_Box input").hasClass("chkMatch");
	if(!hasInput){
		for(var i=0;i<cntBox;i++){
			console.log("#mc_Box:"+i);
			$("#mc_Box"+i).append("<input type='checkbox' value='' id='chkMatch"+i+"' class='chkMatch' name='chkMatch'>");
		}
		$("#btnCnterBox").append("<input type='button' value='' id='cusInputBtn' class='btn_update' onclick='goUpdate()'/>");
	}
	
	
	
}
function searchKids(){
	console.log("test");
	var search_Keyword = $("#keyWord").val();
	var search_ClassId =  $('input:radio[name="class_id"]:checked').val();
	var search_ClassYear =  $('input:radio[name="class_year"]:checked').val();
	
	var hasBtn = $('#choiceBtn input').hasClass('matchingCut');
	console.log("hasBtn:"+hasBtn);
	if(!hasBtn){
		$("#choiceBtn").append("<input type='button' value='' id='multiplex_selectBtn' class='matchingCut ' onclick='selectMatching()'>");
		$("#matchingCut").append("");
	}
	
	
	console.log("search_Keyword:"+search_Keyword);
	console.log("search_ClassId:"+search_ClassId);
	console.log("search_ClassYear:"+search_ClassYear);
	

	
	$.ajax({
		type : "POST",
		url : "beaconCondition",
		data : { "search_Keyword" : search_Keyword,"search_ClassId" : search_ClassId,"search_ClassYear" : search_ClassYear},
		beforeSend: function(xhr) {
              xhr.setRequestHeader(header, token);
           },
		success : function(result) {
			$("#matchingCut_content").empty();
// 			$("#beaconList .beaconBox").css("cursor","pointer");
// 			$("#beaconList .beaconBox").hover(function(){ $(this).css("background-color", "#F5C21C"); },
// 					  function(){$(this).css('background-color','#fff');});
			
			
			var size_data=result.data;
			console.log("aa:"+size_data.length);
			if(size_data.length==0){
				$("#matchingCut_content").append("<center>비콘에 배정 되어있는 원아가 없습니다.</center>");
			}
			else{
				for(var i=0; i < size_data.length; i ++){
					var beaconName = result.data[i].beacon_id;
					beaconName = beaconName.substring(11);
					
	            	$("#matchingCut_content").append(
	            			"<div class='mc_Box' id='mc_Box"+i+"'><div class='mc_Kids'>"
	            			+"<div class='mc_Kids_Img'>"
	            			+"<img src='"+result.data[i].kid_pho+"'>"
	            			+"</div>"
	            			+"<div class='mc_Kids_Name'>"
	            			+result.data[i].kid_name
	            			+"</div>"
	            			+"</div>"
	            			+"<div class='mc_gori'>"
	            			+"</div>"
	            			+"<div class='mc_dropZone' id='beaconMatch"+i+"'>"
	            			+"<div class='beaconImg'><img src='"+result.data[i].beacon_phot+"'></div>"
	            			+beaconName
	            			+"</div>"
	            			+"<input type='hidden' name='beacon_id' id='beacon_id"+i+"' value='"+result.data[i].beacon_id+"'>"
	            			+"<input type='hidden' name='kid_system_code' id='kid_system_code"+i+"' value='"+result.data[i].kid_system_code+"'>"
	            			+"</div>");
	            }
			}
			
			
		},
		error : function(xhr, txtStatus, errorThrown) {
			alert("/error" + errorThrown);
		}
	});
}

(function ($) {
	$.fn.countTo = function (options) {
		options = options || {};
		
		return $(this).each(function () {
			// set options for current element
			var settings = $.extend({}, $.fn.countTo.defaults, {
				from:            $(this).data('from'),
				to:              $(this).data('to'),
				speed:           $(this).data('speed'),
				refreshInterval: $(this).data('refresh-interval'),
				decimals:        $(this).data('decimals')
			}, options);
			
			// how many times to update the value, and how much to increment the value on each update
			var loops = Math.ceil(settings.speed / settings.refreshInterval),
				increment = (settings.to - settings.from) / loops;
			
			// references & variables that will change with each update
			var self = this,
				$self = $(this),
				loopCount = 0,
				value = settings.from,
				data = $self.data('countTo') || {};
			
			$self.data('countTo', data);
			
			// if an existing interval can be found, clear it first
			if (data.interval) {
				clearInterval(data.interval);
			}
			data.interval = setInterval(updateTimer, settings.refreshInterval);
			
			// initialize the element with the starting value
			render(value);
			
			function updateTimer() {
				value += increment;
				loopCount++;
				
				render(value);
				
				if (typeof(settings.onUpdate) == 'function') {
					settings.onUpdate.call(self, value);
				}
				
				if (loopCount >= loops) {
					// remove the interval
					$self.removeData('countTo');
					clearInterval(data.interval);
					value = settings.to;
					
					if (typeof(settings.onComplete) == 'function') {
						settings.onComplete.call(self, value);
					}
				}
			}
			
			function render(value) {
				var formattedValue = settings.formatter.call(self, value, settings);
				$self.html(formattedValue);
			}
		});
	};
	
	$.fn.countTo.defaults = {
		from: 0,               // the number the element should start at
		to: 0,                 // the number the element should end at
		speed: 1000,           // how long it should take to count between the target numbers
		refreshInterval: 100,  // how often the element should be updated
		decimals: 0,           // the number of decimal places to show
		formatter: formatter,  // handler for formatting the value before rendering
		onUpdate: null,        // callback method for every time the element is updated
		onComplete: null       // callback method for when the element finishes updating
	};
	
	function formatter(value, settings) {
		return value.toFixed(settings.decimals);
	}
}(jQuery));

jQuery(function ($) {
  // custom formatting example
  $('.count-number').data('countToOptions', {
	formatter: function (value, options) {
	  return value.toFixed(options.decimals).replace(/\B(?=(?:\d{3})+(?!\d))/g, ',');
	}
  });
  
  // start all the timers
  $('.timer').each(count);  
  
  function count(options) {
	var $this = $(this);
	options = $.extend({}, options || {}, $this.data('countToOptions') || {});
	$this.countTo(options);
  }
});

</script>

