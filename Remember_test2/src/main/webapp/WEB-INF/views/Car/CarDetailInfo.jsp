<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<style type="text/css">
.msgboxDiv{
    width: 802px;
    margin: 0 auto;
}
</style>

	<jsp:include page="../include/menu_admin.jsp">
		<jsp:param name="pageInMenu" value="차량운행정보"  />
		<jsp:param name="pageCategory" value="차량 관리"  />
		<jsp:param name="pageTitle" value="차량 상세 정보"  /> 
	</jsp:include>
	<div class="page">
		<div class="page-wrapper">
			<div class="pageTitle">
				<h2>차량 상세 정보</h2>
			</div>
			
			<div class="pageContent conentCarDetail textAlign-C CarDetailInfo">
			<div class="msgboxDiv"><div class="msgBox" id="msgBox"></div></div>
				<c:set value="${list}" var="dto"/>							
					<div class="contentWDate width802">
					<span>등록일 </span>
					${dto[0].createDateFormat}
					<span>/ 수정일 </span>
					${dto[0].updateDateFormat}				 
					</div>
						
			<div id="layerWindow_p" class="layerWindow">
               <span class="modalWindow"></span>
               <div id="loginLayer" class="loginLayer loginTypeA">
                  <div class="layerPopContent">
                     <p>삭제 하시겠습니까?</p> 
                     <input id="busId" type="hidden"/>
                     <input id="bus_use" type="hidden"/> 
                     <input type="button" class="btn_confirming_text" onclick="closeLayer2(1)" >
                     <input type="button" class="btn_close_text" onclick="closeLayer2(0)" >
                  </div>
               </div>
	        </div>	
	        
			<div id="CarInfo">									
				<table>				
					<tr>
						<th width="85px">차량이름</th> <td width="133px">${dto[0].bus_name}</td>
						<th width="85px">차량번호</th> <td width="133px">${dto[0].bus_num}</td>
						<th width="85px">탑승인원</th> <td width="133px">${dto[0].bus_borad}</td>				
					</tr>
					
					<tr>
						<th width="85px">차량기사</th> <td width="275px" colspan="2">${dto[0].staff_name}</td>
						<th width="85px">연락처</th> <td width="275px" colspan="2">${dto[0].staff_phone}</td>							
					</tr>
				</table>
				
				<table>				
					<tr>
						<th width="85px">차량사용여부</th> 
						<td width="316px">
							<c:choose>
								<c:when test="${dto[0].bus_use eq 'true'}">
									사용중
								</c:when>								
								<c:otherwise>
									-
								</c:otherwise>							
							</c:choose>					
						</td> 
						<th width="85px">노선명</th>
						<td width="316px">
						<c:forEach items="${routeNameList}" var="Rdto" varStatus="status">
							<c:choose>
								<c:when test="${status.last}">
								<a href="busRouteDetail?route_id=${Rdto.route_id}">${Rdto.route_name}</a>									
								</c:when>
								<c:otherwise>
								<a href="busRouteDetail?route_id=${Rdto.route_id}">${Rdto.route_name},</a>									
								</c:otherwise>
							</c:choose>							
						</c:forEach>
						</td>					 						
					</tr>
					<tr>
						<th>운행사</th> <td>${dto[0].bus_com}</td>									
						<th>종합보험 유효기간</th> <td>${dto[0].insurFormat}</td>									
					</tr>	
					<tr>
						<th>게이트웨이</th> <td>${dto[0].equipment_gate_name}</td>									
						<th>태블릿</th> <td>${dto[0].equipment_tablet_name}</td>									
					</tr>
					
									
				</table>
				</div>
				<div class="contentBottomBtn">			
					<div class="btnLeftBox"><input type="button" class="btn_back" value="" onclick="history.back();" id="bottomBtn-Input"> <!-- 이전버튼 클릭 --></div>
					
					<div class="btnCnterBox">
						<input type="button" class="btn_update" value="" onclick="location.href = 'DataUpdateForm?num=' + encodeURIComponent('${dto[0].bus_id}','UTF-8')" id="bottomBtn-Input"> <!-- 수정버튼 클릭 -->
						<input type="button" class="btn_delete" value="" onclick="Delbtt_click('${dto[0].bus_id}','${dto[0].routeExists}')" id="bottomBtn-Input"> <!-- 삭제버튼 클릭 -->
					</div>
						
					<div class="btnRightBox">
						
					</div>
				</div>	
			</div><!-- content -->
		</div><!-- page-wrapper -->	
	</div><!-- page -->	
	<jsp:include page="../include/footer.jsp"/>
	<script>	
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	function Delbtt_click(data,data1) {	
		document.getElementById('msgBox').style.display="none";
		if(data1=="-")
		{
			 $('#layerWindow_p').css('display','block');
			  $("#busId").val(data);
		      $("#bus_use").val(data1);
		}
		else
		{
			$('#msgBox').removeClass("msgBox_Success");
			$('#msgBox').addClass("msgBox_Error");   
			$('#msgBox').html("<span>노선에 배치중인 차량은 삭제가 불가능 합니다.</span>");
			document.getElementById('msgBox').style.display="block";
			document.getElementById('layerWindow_p').style.display='none';
			event.preventDefault();
  			return false;
		}
     }	

   function closeLayer2(obj){ 
	   var bus_Id = $("#busId").val();
	   var bus_use =$("#bus_use").val();
	   
      if(obj==1){	
    	  if(bus_use=="-"){
   			$.ajax({  
   	            url : 'DataDelete',
   	            dataType : 'json',
   	            type:'POST',
   	            data : { "del" : bus_Id},    
   	            beforeSend: function(xhr) {
   	 	              xhr.setRequestHeader(header, token);
   	 	           },
   	            success: function(result) { 
   	            	if(result.delcheck=="true"){
   	            		document.getElementById('layerWindow_p').style.display='none';
   	            		location.replace("CarInfoView");	                 	
   	            	}
   	            	else{
   	            		$('#msgBox').removeClass("msgBox_Success");
   	        			$('#msgBox').addClass("msgBox_Error");   
   	        			$('#msgBox').html("<span>삭제에 실패 하였습니다.</span>");
   	        			document.getElementById('msgBox').style.display="block";
   	        			document.getElementById('layerWindow_p').style.display='none';
   	            	}
   	         	  
   	            },
   	            error:function(request,status,error){ 
   	            	$('#msgBox').removeClass("msgBox_Success");
           			$('#msgBox').addClass("msgBox_Error");   
           			$('#msgBox').html("<span>"+"code:"+request.status+"\n"+"error:"+error+"</span>");
           			document.getElementById('msgBox').style.display="block";
           			document.getElementById('layerWindow_p').style.display='none';
   	            }
   	         
   	        });  
    	  }
    	  else{
    		$('#msgBox').removeClass("msgBox_Success");
  			$('#msgBox').addClass("msgBox_Error");   
  			$('#msgBox').html("<span>노선에 배치중인 차량은 삭제가 불가능 합니다.</span>");
  			document.getElementById('msgBox').style.display="block";
  			document.getElementById('layerWindow_p').style.display='none';
  			event.preventDefault();
    		return false;  
    	  }
      }
      else{
    	  document.getElementById('layerWindow_p').style.display='none';
      }
   }
	</script> <!-- 삭제 버튼 클릭시 ajax비동기 삭제  -->	
		 
</body>
</html>
