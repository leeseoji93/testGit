<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style type="text/css">
.msgboxDiv{
    width: 862px;
    margin: 0 auto;
}
</style>

   <jsp:include page="../include/menu_admin.jsp">
   		<jsp:param name="pageInMenu" value="차량운행정보"  />
		<jsp:param name="pageCategory" value="차량 관리"  />
		<jsp:param name="pageTitle" value="차량 정보 조회"  /> 
	</jsp:include>
  	 <div class="page">
		<div class="page-wrapper">
			<div class="pageTitle">
				<h2>차량 정보 조회</h2>
			</div>		
			
			<div class="pageContent textAlign-C CarInfoView">	
			<div class="msgboxDiv"><div class="msgBox" id="msgBox"></div></div>				
				<div class="searchBox">						
					<input type="text" id="keyWord">
					<input type="submit" value="" id="searchBtn">
				
					<div class="contentAddCar"><a href="DataInputForm"><img src="images/button/button_add_car_90x25.png"> </a></div>
				</div> <!-- searchBox div -->
				
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
										
				<div class="cusListTable cusTableCenter cusWidth860">
					<table id="CarinfoView_Table">
						<tr class="CarinfoView_Table_nothover">
							<th width="70px">번호</th>
							<th width="140px">차량명</th>
							<th width="100px">노선</th>
							<th width="100px">차량번호</th>
							<th width="100px">차량기사</th>
							<th width="140px">연락처</th>
							<th width="140px">작성일</th>
							<th width="40px"></th>
						</tr>
						
						<c:choose>
							<c:when test="${fn:length(list) eq 0}">
								<tr class="CarinfoView_Table_nothover"><td colspan="8">등록된 차량이 없습니다.</td></tr>
							</c:when>
							
							<c:otherwise>
								<c:forEach items="${list}" var="dto" varStatus="status">													
									<tr onclick="location.href = 'CarDetailInfo?num=' + encodeURIComponent('${dto.bus_id}','UTF-8')"> <!-- 테이블 행클릭 이벤트 -->
										<td>${status.count}</td>
										<td>${dto.bus_name}</td>								
										<td>${dto.routeExists}</td>							
										<td>${dto.bus_num}</td>
										<td>${dto.staff_name}</td>
										<td>${dto.staff_phone}</td>
										<td>${dto.updateDateFormat}</td>	
										<td onclick="event.cancelBubble = true;"><input  type="button" id="CarinfoView_Table_tr_del" value=""
										onclick="Delbtt_click('${dto.bus_id}','${dto.routeExists}')"></td>																
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</table>	
				</div>	<!-- table div -->		
			</div><!-- pageContent div -->	
		</div><!-- page-wrapper div -->	
	</div><!-- page div -->	
	<jsp:include page="../include/footer.jsp"/>
	<script>	 	
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	
	$(document).ready(function(){
        $("#searchBtn").click(function(){    
      $.ajax({  
               url : 'keyWordSearch',
               dataType : 'json',
               type:'POST',
               data : { "keyWord" : $("#keyWord").val() },
               beforeSend: function(xhr) {
	 	              xhr.setRequestHeader(header, token);
	 	           },
               success: function(result) {           	   
            	         	
                 var carList=JSON.stringify(result.data);                 
                 
                 $("#CarinfoView_Table tr:not(:first)").remove(); 
            		
                 var size_data=result.data;
                 
                 if(size_data.length==0){
                	 $("#CarinfoView_Table")
                	 .append("<tr class='CarinfoView_Table_nothover'><td colspan='8'>등록된 차량이 없습니다.</td></tr>");
                 }
                 else{
                	 for(var i=0; i < size_data.length; i ++){

                    	 $("#CarinfoView_Table")
                    	 .append("<tr onclick=\"location.href = \'CarDetailInfo?num=\' + encodeURIComponent(\'"+result.data[i].bus_id+"\',\'UTF-8\')\"><td>"
                    			 +(i+1)+"</td><td>"
                    			 +result.data[i].bus_name+"</td><td>"
                    			 +result.data[i].routeExists+"</td><td>"
                    			 +result.data[i].bus_num+"</td><td>"
                    			 +result.data[i].staff_name+"</td><td>"                			 
                    			 +result.data[i].staff_phone+"</td><td>"
                    			 +result.data[i].updateDateFormat
                    			 +"</td><td onclick=\"event.cancelBubble = true;\"><input  type=\"button\" id=\"CarinfoView_Table_tr_del\"  value=\"\" onclick=\"Delbtt_click(\'"+result.data[i].bus_id+"\',\'"+result.data[i].routeExists+"\')\"</td></tr>");
                    	              	
                     }       
                 }                                    
               },
               error:function(request,status,error){                 
            	   alert("code:"+request.status+"\n"+"error:"+error);
               }
            
           });
         });       
     });
	
	</script> <!-- 찾기 버튼 클릭시 ajax비동기 검색  -->	
	
	<script>	 	
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	
	 /*  function Delbtt_click(stationid,obj,station_use) {         //정류장 삭제 팝업
//	       console.log("obj:"+obj);
//	       console.log("station_use:"+station_use);
	      
	      document.getElementById('msgBox').style.display="none";
	      if(obj==0){
	         $('#layerWindow_p').css('display','block');
	         $("#stationId").val(stationid);
	         $("#station_use").val(station_use);
	      }else{
	          $('#msgBox').addClass("msgBox_Error");   
	          $('#msgBox').html("<span>사용중인 정류장은 삭제가 불가능 합니다.</span>");
	          document.getElementById('msgBox').style.display="block";
	       }
	   }*/ //삭제 팝업 참고 자료
	
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
   	            		$(".cusListTable").load('CarInfoView .cusListTable');
   	            		
   	            		$('#msgBox').removeClass("msgBox_Error");
   	                   	$('#msgBox').addClass("msgBox_Success");
   	                 	$('#msgBox').html("<span>삭제 성공했습니다.</span>");
   	                 	document.getElementById('msgBox').style.display="block";
   	                 	document.getElementById('layerWindow_p').style.display='none';
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