<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  

<jsp:include page="../include/menu_admin.jsp">
	<jsp:param name="pageInMenu" value="차량운행정보"  />
	<jsp:param name="pageCategory" value="노선 관리"  />
	<jsp:param name="pageTitle" value="노선 정보조회"  /> 
</jsp:include>
	<div class="page">
		<div class="page-wrapper">
			<div class="pageTitle"><h2>노선 정보조회</h2></div>
			
			<div class="pageContent700 busRouteList">
				<div class="searchBox741">
					<input type="text" name="keyWord" id="keyWord">
					<input type="button" value="" id="searchBtn" class="searchBtn">
					
					<div class="smallBtn">
						<input type="button" value="" onclick="location.href='busRouteForm'" class="btn_addRoute_text">
					</div>
				</div>
				
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
					<table id="busRouteList-T">
						<tr>
							<th width="50px">번호</th>
							<th width="70px">등·하원</th>
							<th width="145px">코스</th>
							<th width="152px">운행시간</th>
							<th width="123px">작성일</th>
							<th width="123px">수정일</th>
							<th width="92px"></th>
							<th width="41px"></th>
						</tr>
					</table>
					<div class="busRouteListContent" id="busRouteListContent">
						<table id="busRouteList-B">	
							<c:forEach var="obj" items="${routeList}" varStatus="s">
								
		                        <tr class="busRouteList-Tr" id="busRouteList-Tr${s.count}" onmouseenter="over(this.id,'${obj.route_id}')" >
									<td width="50px" onclick="location.href='busRouteDetail?route_id=${obj.route_id}'">${s.count}</td>
									<td width="70px" onclick="location.href='busRouteDetail?route_id=${obj.route_id}'">${obj.route_type}</td>
									<td width="180px" onclick="location.href='busRouteDetail?route_id=${obj.route_id}'">${obj.route_name}</td>
									<td width="150px" onclick="location.href='busRouteDetail?route_id=${obj.route_id}'">${obj.route_start}</td>
									<td width="120px" onclick="location.href='busRouteDetail?route_id=${obj.route_id}'">${obj.createtime}</td>
									<td width="120px" onclick="location.href='busRouteDetail?route_id=${obj.route_id}'">${obj.updatetime}</td>
									<c:choose>
		                        	<c:when test="${obj.route_use eq true}">
									<td width="82px"><%-- ${obj.route_use }--%>
					                	<div class="toggleWrapper">
					                		<input type="checkbox" id="dn${s.count}" class="dn" name="routeUseChk" checked="checked">
											<label for="dn${s.count}" class="toggle" onclick="routeClick('${obj.route_id}','false')"><span class="toggle__handler"></span></label>
					                	</div>
									</td>
									</c:when>     
			                        <c:otherwise>
			                        	<td width="82px"><%-- ${obj.route_use }--%>
						                	<div class="toggleWrapper">
				                        		<input type="checkbox" id="dn${s.count}" class="dn" name="routeUseChk">
												<label for="dn${s.count}" class="toggle" onclick="routeClick('${obj.route_id}','true')"><span class="toggle__handler"></span></label>
				                        	</div>
										</td>
			                        </c:otherwise>
		                     		</c:choose>
		                     		<td><input type="button" value="" class="btn_delete_40" id="busRouteDel" onclick="busRouteDelete('${obj.route_id}','${obj.course_id}','${obj.route_use}')"></td>
								</tr>
							</c:forEach>
						</table>
					</div>
				</div>
			<div class="pageContent300 busRouteRight">	
				<div class="contentRight3" id="contentRight3">
					<div id="contentRight3-1"></div>
					<div id="contentRight3-2"></div>
				</div>
				
			</div>
		</div>
	</div>

	<script type="text/javascript">
		var save_routeId;
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
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
//	 	            	alert("삭제되었습니다.");
		            	var hasCheck = $( "#msgBox" ).hasClass( "msgBox_Error" );
	            		if(hasCheck){$('#msgBox').removeClass("msgBox_Error");}
	            		
		            	$('#msgBox').addClass("msgBox_Success");	
			    		$('#msgBox').html("<span>노선을 삭제 했습니다.</span>");
			    		document.getElementById('msgBox').style.display="block";
	        			$('#busRouteListContent').load('busRouteList #busRouteList-B');
//	 	            	location.reload();
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
			console.log("busRouteDelete 시작");
			console.log("route_use:"+route_use);
			console.log("couse_id:"+course_id);
			
			var check;
			document.getElementById('msgBox').style.display="none";
			
// 			$('#layerWindow').css('display','block');
			document.getElementById('layerWindow').style.display='block';
			$("#routeId").val(route_id);
			$("#courseId").val(course_id);
			$("#route_use").val(route_use);
			
		}	//삭제
		function routeClick(route_id,route_use){
			$.ajax({  
	            url : 'routeUseChk',
	            dataType : 'json',
	            type:'POST',
	            data : { "route_id" : route_id,"route_use" : route_use},
	            beforeSend: function(xhr) {
	 	              xhr.setRequestHeader(header, token);
	 	           },
	            success: function(data) {
	            	
	            	console.log("route_use:"+route_use);
	            		var hasCheck = $( "#msgBox" ).hasClass( "msgBox_Error" );
	            		if(hasCheck){$('#msgBox').removeClass("msgBox_Error");}
	            		
	            		$('#msgBox').addClass("msgBox_Success");
	            		$('#msgBox').html("<span>노선 사용여부가 변경 되었습니다.</span>");
	            		document.getElementById('msgBox').style.display="block";
	            		$('#busRouteListContent').load('busRouteList #busRouteList-B');
	            	if(route_use=="true"){
// 	            		$(".busRouteList-Td").click(function(){ 
// 	            			var dynamicTag = '<input type="button" id="btn" value="경고"/>'; $("body").html(dynamicTag); 
// 	            			});
	            		$(".busRouteList-Td").attr("onclick","location.href='busRouteDetail?route_id="+route_id+"'");
	            	}
	            },
	            error:function(request,status,error){                 
	         	   alert("code:"+request.status+"\n"+"error:"+error);
	            }
	    	});
		}
		function over(this_id,route_id){
			console.log("over시작");
			if(save_routeId!=route_id){
				save_routeId=route_id;
				$('#contentRight3-2').empty();
				var has = $('.busRouteList-Tr').hasClass("Listactive");		//busRouteList-Tr에 active 클래스 가지고 있는가
				var has2 = $('.contentRight3').hasClass("Listinline");	
				if(has==true){
					$('.busRouteList-Tr').removeClass("Listactive");		//가지고 있다면 지워라

					$('#'+this_id).addClass("Listactive");	
					$('#'+this_id+"-a").addClass("Listinline");	//tr에 active를 줘라
				}
				
				document.getElementById("contentRight3").style.display="inline";	//우측에 div 띄우기
	         	
				var kidCnt=0;
				
				<c:forEach var="obj" items="${routeKidsAll}" varStatus="s">		//hover 했을 때 원아 뜨게
					var hover_RouteId="${obj.route_id}";
					
					if(hover_RouteId==route_id){
						$("#contentRight3-2").append("<div class='contentRight3-child'>"
			   		 			+"<img src='${obj.kid_pho}'>"
			   		 			+"${obj.kid_name}</div>");	
						kidCnt++;
					}
					
				</c:forEach>
			
				<c:forEach var="dto" items="${routeInfoAll}" varStatus="s2">		//hover 했을 때 원아 뜨게
					var hover_RouteId="${dto.route_id}";
// 					console.log("kidCnt: "+kidCnt);
					if(hover_RouteId==route_id){
						$("#contentRight3-1").html(
								"<h3>상세정보</h3>"
								+"<div class='kiki'>"
		   	  	     			+"<table>"
		   	  	     			+"<tr><th width='75'>차량명</th><td width='160'>${dto.bus_name}</td></tr>"
		   	  	     			+"<tr><th>차량번호</th><td>${dto.bus_num}</td></tr>"
		   	  	     			+"<tr><th>운전자</th><td>${dto.staff_name}(${dto.staff_phone})</td></tr>"
		   	  	     			+"<tr><th>인솔교사</th><td>${dto.mainStaff_name}(${dto.mainStaff_phone})</td></tr>"
		   	  	     			+"</table>"
		   	  	     			+"<div class='miriKidsCnt'>"
		   	  	     			+"</p><p><span>배치된인원 <small>(탑승인원/총)</small>:</span>"+kidCnt+"/${dto.bus_borad}명"	   	  	     			
		   	  	     			+"</p></div>");		
// 						console.log("==>${s2.end}");
					}
					
				</c:forEach>
// 				console.log("==${s2.end}");
				
				
				
			
			
				if(has2==true){
					$('#'+st+"-a").removeClass("Listinline");
				}
			}
			else{
				return false;
			}
			
// 			var st = $(this).attr("id") ;										//hover 했을 때 tr의 id값
		}
	
	</script>
		<script type="text/javascript">
		
		$(document).ready(function(){
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			
			$('#busRouteList-Tr1').addClass("Listactive");
			$('#busRouteList-Tr1-a').addClass("Listinline");
			
			$("#searchBtn").click(function(){		
		        
				$.ajax({  
		               url : 'routeSearch',
		               dataType : 'json',
		               type:'POST',
		               data : { "keyWord" : $("#keyWord").val() },
		               beforeSend: function(xhr) {
			 	              xhr.setRequestHeader(header, token);
			 	           },
		               // data : $('#msg').serializeArray(),
		               success: function(data) {           	   
		            	 $("#busRouteList-B").empty();        	
		                 var routeList=JSON.stringify(data.searchKey);                 
		                 $("#busRouteList-T tr:not(:first)").remove(); 
		                 var size_data=data.searchKey;
		                 console.log("size_data:"+size_data);
		                 for(var i=0; i < size_data.length; i ++){
		                	 
		                	 var routeChk =data.searchKey[i].route_use;
		                	 var routeChk_Con ="";
		                	 if(routeChk==true){
		                		 routeChk_Con ="<div class='toggleWrapper'>"
			                		+"<input type='checkbox' id='dn"+i+"' class='dn' name='routeUseChk' checked='checked'>"
									+"<label for='dn"+i+"' class='toggle' onclick=\"routeClick('"+data.searchKey[i].route_id+"','false')\"><span class='toggle__handler'></span></label>"
				                	+"</div>";
		                	 }
		                	 else{
		                		 routeChk_Con ="<div class='toggleWrapper'>"
				                		+"<input type='checkbox' id='dn"+i+"' class='dn' name='routeUseChk' >"
										+"<label for='dn"+i+"' class='toggle' onclick=\"routeClick('"+data.searchKey[i].route_id+"','true')\"><span class='toggle__handler'></span></label>"
					                	+"</div>";
		                	 }
		                	 
		                	 
		                	 $("#busRouteList-B")
		                	 .append(" <tr class='busRouteList-Tr' id='busRouteList-Tr"+i+"' onmouseover=\"over('busRouteList-Tr"+i+"','"+data.searchKey[i].route_id+"');\">"+
		                			 
								"<td width='37px' onclick=\"location.href='busRouteDetail?route_id="+data.searchKey[i].route_id+" '\">"+(i+1)+"</td>"+
								"<td width='53px' onclick=\"location.href='busRouteDetail?route_id="+data.searchKey[i].route_id+" '\">"+data.searchKey[i].route_type+"</td>"+
								"<td width='131px' onclick=\"location.href='busRouteDetail?route_id="+data.searchKey[i].route_id+" '\">"+data.searchKey[i].route_name+"</td>"+
								"<td width='121px' onclick=\"location.href='busRouteDetail?route_id="+data.searchKey[i].route_id+" '\">"+data.searchKey[i].route_start+"</td>"+
								"<td width='121px' onclick=\"location.href='busRouteDetail?route_id="+data.searchKey[i].route_id+" '\">"+data.searchKey[i].createtime+"</td>"+
								"<td width='95px' onclick=\"location.href='busRouteDetail?route_id="+data.searchKey[i].route_id+" '\">"+data.searchKey[i].updatetime+"</td>"+
								"<td width='80px'>"+routeChk_Con+"</td>"+			
								"<td width='40px'><input type='button' value='' class='btn_delete_40' id='busRouteDel' onclick='busRouteDelete(\""+data.searchKey[i].route_id+"\",\""+data.searchKey[i].course_id+"\",\""+data.searchKey[i].route_use+"\")'></td>"+
							"</tr>");
		                 }
		                 
		               },
		               error:function(request,status,error){                 
		            	   alert("code:"+request.status+"\n"+"error:"+error);
		               }
				 
				});
		    });
		});
	</script>
</body>
</html>