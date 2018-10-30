<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<style>


.progress-percentage, .progress-text {
    position: absolute;
    width: 100%;
    top: 50%;
    left:160@;
    transform: translate(-50%, -50%);
    text-align: center;
    padding: 0px 60px;
}

.progress-percentage {
	font-size: 60px;
    transform: translate(-50%, -85%);
}

.progress-text {
    transform: translate(-50%, 0%);
    color: #585858;
    font-size: 21px;
}




</style>
	<jsp:include page="../include/menu_admin.jsp">
		<jsp:param name="pageInMenu" value="기기관리"  />
		<jsp:param name="pageCategory" value="비콘"  />
		<jsp:param name="pageTitle" value="원아배정"  /> 
	</jsp:include>
<c:set value="${kindOfClass}" var="dto_c"/>	

<div class="page">
	<div class="page-wrapper">
		<div class="pageTitle"><h2>비콘 배정</h2></div>

		<div class="pageContent250 beaconMatchingpage2" id="beaconMatching">
			<div class="beaconMatching">
				<div class="beaconListTitle" id="beaconListTitle">
					미배정 비콘 목록
				</div>
				<div class="beaconList" id="beaconList">
					<c:set value="${allOfBeacon}" var="dto_c"/>
					<c:if test="${fn:length(dto_c) eq '0'}">
						배정되지 않은 비콘이 없습니다.
					</c:if>
					<c:forEach items="${allOfBeacon}" var="dto_b" varStatus="s">
						
						<c:set var="length" value="${fn:length(dto_b.beacon_id)}"/>
						<c:set var = "beaconName" value = "${fn:substring(dto_b.beacon_id, 11,length)}" />
						<div class="beaconBox" id="${dto_b.beacon_id}">
							<div class="beaconBox_L">
						 		<div class="beaconImg"><img src="${dto_b.beacon_phot}"></div>${beaconName}</div>
							<div class="beaconBox_R">
								<span>${dto_b.beacon_id}</span>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
			
		</div>	
		<div class="pageContent780 beaconMatchingpage" >
			<div id="layerWindow" class="layerWindow">
				<span class="modalWindow"></span>
		        
				<div id="loginLayer" class="loginLayer loginTypeA">
					<div class="layerPopContent">
						<span class="re_question">자동 매칭 중입니다.<br>매칭이 끝나면 배정현황 페이지로 이동하게 됩니다.</span>
					</div>
				</div>
			</div>
			<div class="beaconContent" id="beaconContent">
				<form action="searchKid" name="searchKid" id="searchKid">
					<div class="beaconContent_top" id="beaconContent_top">
						<table>
							<tr id="searchClass">
								<th width="70">반</th>
								<td width="480">
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
						</div>						
					</div>
				</form>
				
<!-- 				<div id="layerWindow" class="layerWindow"> -->
<!-- 					<span class="modalWindow"></span> -->
<!-- 					<div id="loginLayer" class="loginLayer loginTypeA"> -->
<!-- 						<div class="layerPopContent"> -->
<!-- 							<span class="re_question"></span>하시겠습니까?  -->
<!-- 							<input type="button" class="btn_confirming_text" onclick="closeLayer(1)" > -->
<!-- 							<input type="button" class="btn_close_text" onclick="closeLayer(0)" > -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</div> -->
				
				<div class="beaconContent_bottom" id="beaconContent_bottom">
					<form action="matchingSave" method="post" name="matchingSave" id="matchingSave">
					<input type="hidden" name="${_csrf.parameterName}" id="csrf" value="${_csrf.token}" />
						<div class="beaconContent_bottom_Line">
							<div class="beaconContent_bottom_title">
								미배정 원아 목록
							</div>
							<div class="beaconContent_bottom_c" id="beaconContent_bottom_c">
								<center>반을 선택 해 주세요.</center>
							</div>
						</div>
						<div class="pageBtn contentBottomBtn">						
							<div class="btnLeftBox">
							</div>
							<div class="btnCnterBox">
								<input type="button" onclick="goSubmit()" value="" class="btn_done" id="cusInputBtn"/>
							</div>
							<div class="btnRightBox">			
			<!-- 					<input type="button" value="" id="cusInputBtn" class="customM" onclick="accountList()"/>	  				 -->
					  		</div> 
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="../include/footer.jsp"/>
<c:set value="${notMatchingKids}" var="dto_n"/>	
<script>
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");


window.onload = function () {
	
	var mathchingFirst = "${dto_n[0].beaconCnt}";
	if(mathchingFirst=="0"){
		$('#layerWindow').css('display','block');
		$.ajax({
			type : "POST",
			url : "autoMatching",
			data : { "mathchingFirst" : mathchingFirst},
			beforeSend: function(xhr) {
	              xhr.setRequestHeader(header, token);
	           },
			success : function(data) {
				setTimeout(function() {
					document.getElementById('layerWindow').style.display='none';
					$(location).attr('href','matchingPresentCondition');
				}, 5000);
				
			},
			error : function(xhr, txtStatus, errorThrown) {
				alert("error" + errorThrown);
			}
		});
	}
}

	function goSubmit(){
		
		console.log("test");
		matchingSave.submit();
	}
	function deleteMatching(dragId,dropId,dropZone,beaconId,sysId){
		
		dragId = "#"+dragId;
		dropId = "#"+dropId;
		dropZone = "#"+dropZone;
		$(dropZone).removeClass( "uiDropped" );
		
		$(dropZone+" "+dragId).remove();
		
		dropZone = dropZone+" a";
		
		console.log("///"+dropId+" "+dropZone);
		$(dropZone).remove();
		
		$(dropId).appendTo(dragId);	
		console.log("dragId:"+dragId+"///dropId:"+dropId+"//dropZone:"+dropZone);
// 		$(dropZone).css("display","none");
		
		$("#"+beaconId).val("");		//input 비콘 값 초기화
// 		$("#"+sysId).val("");			//input 시스템 코드 값 초기화
		
		
		$(dropId).css( "margin-top","5");
		$(dropId).css( "top","0");
		$(dropId).css( "left","0");
		$(dropId).css( "position","relative");
		
		
	}


function closeLayer(obj,dragId,dropId,dropZone){
	
// 	console.log("obj:"+obj);
	if(obj==1){		//승인 확인
		
	}
	document.getElementById('layerWindow').style.display='none';
}


function searchKids(){
// 	console.log("test");
	var search_Keyword = $("#keyWord").val();
	var search_ClassId =  $('input:radio[name="class_id"]:checked').val();
	var search_ClassYear =  $('input:radio[name="class_year"]:checked').val();
	
// 	console.log("search_Keyword:"+search_Keyword);
// 	console.log("search_ClassId:"+search_ClassId);
// 	console.log("search_ClassYear:"+search_ClassYear);
	
	
	
	
	$("#dozenCheck").css('display','inline-block');// 다중선택 할 수있게 하는 버튼 만들기
	$("#beaconContent_bottom_c").empty();
	$.ajax({
		type : "POST",
		url : "matchingKidsNBeacon",
		data : { "search_Keyword" : search_Keyword,"search_ClassId" : search_ClassId,"search_ClassYear" : search_ClassYear},
		beforeSend: function(xhr) {
              xhr.setRequestHeader(header, token);
           },
		success : function(data) {
			$("#beaconList .beaconBox").css("cursor","pointer");
			$("#beaconList .beaconBox").hover(function(){ $(this).css("background-color", "#F5C21C"); },
					  function(){$(this).css('background-color','#fff');});
			
//				setInterval('autoRefresh_div()', 3000);
//     		$("#tabs-2").html(data); //str로 받은 data를 넘긴다.  
//				$('#tabs-1').load('kidInfo #tabs-3');
// 			$("#beaconContent_bottom").html();
			var size_data=data.matchingKids;
// 			console.log("test:"+size_data.length);
			
			if(size_data.length==0){
				$("#beaconContent_bottom_c").append("<center>원아가 없습니다.</center>");
			}
			else{
				for(var i=0; i < size_data.length; i ++){
//	             	console.log("test:"+data.matchingKids[i].kid_name);
	            	$("#beaconContent_bottom_c").append(
	            			"<div class='mc_Box'><div class='mc_Kids'>"
	            			+"<div class='mc_Kids_Img'>"
	            			+"<img src='"+data.matchingKids[i].kid_pho+"'>"
	            			+"</div>"
	            			+"<div class='mc_Kids_Name'>"
	            			+data.matchingKids[i].kid_name
	            			+"</div>"
	            			+"</div>"
	            			+"<div class='mc_gori'>"
	            			+"</div>"
	            			+"<div class='mc_dropZone' id='boards"+i+"'>"
	            			+"</div>"
	            			+"<input type='hidden' name='beacon_id' id='beacon_id"+i+"' value=''>"
	            			+"<input type='hidden' name='kid_system_code' id='kid_system_code"+i+"' value='"+data.matchingKids[i].kid_system_code+"'>"
	            			+"</div>");
	            	$("#beaconList .beaconBox").draggable({
	            		revert: "invalid",
	                    refreshPositions: true,
	            		start: function(event,ui) {
// 	            			console.log("3");
//	            				var dragid = "#"+ui.draggable.attr("id");
//	            				var p_dragid = "#"+$(dragid).closest('div').attr('id');
	            			var dragId = $(this).attr("id");
// 	            			console.log("dragId :"+dragId);
	            			$(this).draggable( "option", "revert", true );
	            			$("#beaconList .beaconBox").css("zIndex",10);
	            			$(this).css("zIndex",100);
	            		},
	                    stop: function (event, ui) {
	                        ui.helper.removeClass("draggable");
	                    }
	            	});
	            	$("#beaconContent_bottom .mc_dropZone").droppable({
	            		
	            		drop: function(event,ui) {
// 	            			console.log("===mc_dropZone===");
	            			var droptitle = $(this).attr("title");
	            			var drophtml = $(this).html();
	            			var dropId = "#"+$(this).attr("id");	//dropZone안에 div
	            			var p_dropId = $(this).closest('div').attr("id");
	            			var dragid = "#"+ui.draggable.attr("id");		//옮기는 divId
	            			var p_dragid = ui.draggable.closest('div').attr('id');  //옳기는 div 위에 div
// 	            			console.log("droptitle:"+droptitle);
// 	            			console.log("dropId:"+dropId);
// 	            			console.log("dragid:"+dragid);
// 	            			console.log("p_dragid:"+p_dragid);
	            			
// 	            			console.log("p_dragid:"+dropId+dragid);
	            			
	            			var ind = $(".mc_Box").index("#beaconContent_bottom ");
// 	            			console.log("ind :"+ind );
	            			
	            			var inDiv = $(dropId).hasClass('img').toString();
	            			var hasdrop = $(dropId).hasClass('uiDropped').toString();	
//	            				var s = $('#boards #boards1').has('img').length; 

							var divIndex = $(this).attr("id").substring(6);
	            			
// 	            			console.log("inDiv:"+divIndex);
	            			
	            			if(hasdrop=="false"){
	            				$(dragid).clone().appendTo(dropId);					//
	            				$("#beacon_id"+divIndex).val(p_dragid);
	            				
	            				$(dropId+" "+dragid).css( "position","static");
	            				ui.draggable.draggable( "option", "revert", false );
	            				var droppableOffset = $(this).offset();
	            				var x = droppableOffset.left + 1;
	            				var y = droppableOffset.top + 1;
	            				ui.draggable.offset({ top: "0", left: x });
//	            					$(dragid).css( "position","static" );
//	            					$(dragid).css( "top",y);
								$(dragid).css( "left",x);
	            				$(dragid).css( "left",x);
	            				$(dragid).css( "margin-top","-100px");
	            				$(dropId).addClass( "uiDropped" );
	            				$(dropId).append("<a href='#' onclick=\"deleteMatching('"
	            						+p_dragid+"','"+ui.draggable.attr('id')
	            						+"','"+$(this).attr("id")
	            						+"','beacon_id"+divIndex
	            						+"','kid_system_code"+divIndex
	            						+"');\">X</a>");
	            				
	            			}	
	            			
//	            					inDiv = $(dropId).addClass("mc_dropZone");
//	            				if( dragid == droptitle ) {
	            				
//	            					$(".test").css("position","static");
//	            					$(".test").css("top",y);
//	            					$(".test").css("left",x);
//	            				}
	            		}
	            	});
	            }
			}
            
		},
		error : function(xhr, txtStatus, errorThrown) {
			alert("error" + errorThrown);
		}
	});
}
</script>
