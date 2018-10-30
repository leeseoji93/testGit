
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

   <jsp:include page="../include/menu_admin.jsp">
      <jsp:param name="pageInMenu" value="차량운행정보"  />
      <jsp:param name="pageCategory" value="정류장 관리"  />
      <jsp:param name="pageTitle" value="정류장 조회"  /> 
   </jsp:include>
   <div class="page">
      <div class="page-wrapper">
         <div class="pageTitle"><h2>정류장 조회</h2></div>
         
         <div class="pageContent textAlign-C stationListPage">
            <div class="msgBox" id="msgBox"></div>
            <div class="width1006 searchBox">
               <input type="text" name="keyWord" id="keyWord">
               <input type="button" value="" id="searchBtn">
               
               <div class="contentAddStation"><a href="stationForm"><img src="images/button/button_add_station_100x25.png"></a></div>
               
            </div>
            
            <div id="layerWindow_p" class="layerWindow">
               <span class="modalWindow"></span>
               <div id="loginLayer" class="loginLayer loginTypeA">
                  <div class="layerPopContent">
                     <p>삭제 하시겠습니까?</p> 
                     <input id="stationId" type="hidden" name="stationId" />
                     <input id="station_use" type="hidden" name="station_use" /> 
                     <input type="button" class="btn_confirming_text" onclick="closeLayer2(1)" >
                     <input type="button" class="btn_close_text" onclick="closeLayer2(0)" >
                  </div>
               </div>
            </div>

            <div class="contentCenter" id="contentCenter">
               
               <div class="contentLeft4 cusListTable cusWidth491">
               <div class="stationListTitle"><span>정류장 목록</span></div>
               <table id="stationSearchResult">
                  <c:forEach var="obj" items="${stationList}" varStatus="s">
                  <tr class="tr_hover" id="cusListTableTr${s.index}" onclick="location.href='stationDetail?station_id=${obj.station_id}'" onmouseover="onmouseover_event('${obj.station_id}','${obj.latitude}','${obj.longitude}','${obj.station_addr}','${s.index}');">
                     <td width="400px"
                     >${obj.station_name}</td>
                 
                        <c:choose>
                           <c:when test="${obj.routeExists eq 1}">
                              <td width="50px">
                              <div class="station-use"><img src="images/button/button_useee_Y_50x20(x2).png" onmouseover="onmouseover_event('${obj.station_id}','${obj.latitude}','${obj.longitude}','${obj.station_addr}','${s.index}');"></div>
                              </td>
                           </c:when>
                           <c:otherwise>
                            <td width="50px" onclick="event.cancelBubble = true;">
                              <div class="station-use"><input type="button" id="CarinfoView_Table_tr_del" value="" onclick="Delbtt_click('${obj.station_id}','${obj.routeExists}','${obj.station_use}')"onmouseover="onmouseover_event('${obj.station_id}','${obj.latitude}','${obj.longitude}','${obj.station_addr}','${s.index}');"></div>
                           </td>
                           </c:otherwise>
                        </c:choose>
                  
                  </tr>
                  </c:forEach>
               </table>
               
               
            </div>
            
            <div class="contentRight498">
               <div class="text-basic" id="text-basic"> 정류장 목록에 마우스를 올려 주세요</div>
               <div class="stationMap" id="stationMap">
                  <div id="staticMap" style="width:498px;height:412px;"></div>
               </div>
               
            </div>
            </div>
         </div>
      </div>
   </div>
   <jsp:include page="../include/footer.jsp"/>
<script type="text/javascript">
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

   function Delbtt_click(stationid,obj,station_use) {         //정류장 삭제 팝업
//       console.log("obj:"+obj);
//       console.log("station_use:"+station_use);
      
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
   }
   function closeLayer2(obj){                     //정류장 삭제 
      var stationId = $("#stationId").val();
      var station_use =$("#station_use").val();
      if(obj==1){
         if(station_use!=1){
            $.ajax({  
                  url : 'stationDelete',
                  dataType : 'json',
                  type:'POST',
                  data : { "station_id" : stationId},
                  beforeSend: function(xhr) {
                        xhr.setRequestHeader(header, token);
                     },
                  success: function(result) { 
                     if(result.delcheck=="true"){
                        var hasCheck = $( "#msgBox" ).hasClass( "msgBox_Error" );
                        if(hasCheck){$('#msgBox').removeClass("msgBox_Error");}
                        
//                          window.setTimeout(function(){location.reload()},100);
                     $('#msgBox').addClass("msgBox_Success");   
                      $('#msgBox').html("<span>정류장을 삭제 했습니다.</span>");
                      document.getElementById('msgBox').style.display="block";
                        $('#contentCenter').load('stationList #contentCenter');
                        document.getElementById('layerWindow_p').style.display='none';
                      }
                      else{
                         $('#resultMessage').html('<p>삭제 실패했습니다.</p>');
                         document.getElementById('layerWindow_p').style.display='none';
                      }   
                  },
                  error:function(request,status,error){     
                     $('#resultMessage').html("code:"+request.status+"\n"+"error:"+error);
                     
                  }
              });   
         }else{
            var hasCheck = $( "#msgBox" ).hasClass( "msgBox_Success" );
             if(hasCheck){$('#msgBox').removeClass("msgBox_Success");}
            $('#msgBox').addClass("msgBox_Error");   
             $('#msgBox').html("<span>사용중인 정류장은 삭제 할 수 없습니다.</span>");
             document.getElementById('msgBox').style.display="block";   
             document.getElementById('layerWindow_p').style.display='none';
         }
      }else{
         document.getElementById('layerWindow_p').style.display='none';
      }
   }
   
   $(document).ready(function(){
      
      $("#searchBtn").click(function(){      
           
         $.ajax({  
                  url : 'stationSearch',
                  dataType : 'json',
                  type:'POST',
                  data : { "keyWord" : $("#keyWord").val() },
                  beforeSend: function(xhr) {
                     xhr.setRequestHeader(header, token);
                  },
                  // data : $('#msg').serializeArray(),
                  success: function(data) {                 
                              
                    var carList=JSON.stringify(data.searchKey);                 
                    $("#stationSearchResult tr").remove(); 
                    var size_data=data.searchKey;
                    for(var i=0; i < size_data.length; i ++){
//                        console.log("for i :"+i);
                   var stationUse = data.searchKey[i].routeExists;
                   var stationUse_Con ="";
                   if(stationUse=="1"){
                           
                      stationUse_Con="<td width='50px'  onclick=\"location.href=\'stationDetail?station_id="+data.searchKey[i].station_id+" \' \"  onmouseover=\"onmouseover_event('"+data.searchKey[i].station_id+"','"+data.searchKey[i].latitude+"','"+data.searchKey[i].longitude+"','"+data.searchKey[i].station_addr+"','"+data.searchKey[i].index+"');\">"
                         +"<div class='station-use'><img src='images/button/button_useee_Y_50x20(x2).png'></div>";
                   }else{
                      stationUse_Con="<td width='50px'  onclick=\"event.cancelBubble = true;\" onmouseover=\"onmouseover_event('"+data.searchKey[i].station_id+"','"+data.searchKey[i].latitude+"','"+data.searchKey[i].longitude+"','"+data.searchKey[i].station_addr+"','"+data.searchKey[i].index+"');\">"
                         +"<div class='station-use'><input type='button' id='CarinfoView_Table_tr_del' value='' onclick=\"Delbtt_click('"+data.searchKey[i].station_id+"','"+data.searchKey[i].routeExists+"')\"></div>";
                   }
               
                   $('#staticMap').empty();
                       $("#stationSearchResult")
                       .append("<tr class=\"tr_hover\" id=\"cusListTableTr"+i+"\" onmouseover=\"onmouseover_event('"+data.searchKey[i].station_id+"','"+data.searchKey[i].latitude+"','"+data.searchKey[i].longitude+"','"+data.searchKey[i].station_addr+"','"+i+"');\" >"
                                +"<td width='400px'  onclick=\"location.href=\'stationDetail?station_id="+data.searchKey[i].station_id+" \' \" >"
                                   +data.searchKey[i].station_name
                                +"</td>"
                               +stationUse_Con
                            +"</td>"
                                +"</td></tr>");
//                        console.log("----------------");
                     
                    }
                    
                  },
                  error:function(request,status,error){                 
                     alert("code:"+request.status+"\n"+"error:"+error);
                  }
          
         });
       });
   });
</script>
   
   
   
   
   <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=976c390ffb0cfa7e527d182e55644f4f"></script>
   

   <script type="text/javascript">
      function onmouseover_event(cnt,latitude,longitude,station_addr,index){
      var st = "#cusListTableTr"+index;
      var has = $('.tr_hover').hasClass("Listactive");      //busRouteList-Tr에 active 클래스 가지고 있는가
      
//       console.log("station_id:"+cnt);
//       console.log("latitude:"+latitude);
//       console.log("longitude:"+longitude);
//       console.log("station_addr:"+station_addr);
//       console.log("index:"+index);
      
      document.getElementById("text-basic").style.display="none";//기본 텍스트 뜨는 div 숨기기
      document.getElementById("stationMap").style.display="inline";//지도띄우기
//       $('#cusListTableTr0 ').addClass("active");
      if(has){
         $('.tr_hover').removeClass("Listactive");      //가지고 있다면 지워라
         $('#staticMap').empty();
      }
//       $(st).addClass("active");
      $(st).addClass("Listactive");   
      var str = ""
        // 현재 클릭된 Row(<tr>)
        var tr = $(this);
        var td = tr.children();
        // 지도 시작!
        // 이미지 지도에서 마커가 표시될 위치입니다 
        var markerPosition  = new daum.maps.LatLng(latitude, longitude); 
        // 이미지 지도에 표시할 마커입니다
        // 이미지 지도에 표시할 마커는 Object 형태입니다
        var marker = {
            position: markerPosition,
            text:station_addr
        };
        var staticMapContainer  = document.getElementById('staticMap'), // 이미지 지도를 표시할 div  
            staticMapOption = { 
                center: new daum.maps.LatLng(latitude, longitude), // 이미지 지도의 중심좌표
                level: 3, // 이미지 지도의 확대 레벨
                marker: marker // 이미지 지도에 표시할 마커 
            };    
        // 이미지 지도를 생성합니다
        var staticMap = new daum.maps.StaticMap(staticMapContainer, staticMapOption);
    }
   </script>
   
</body>

</html>