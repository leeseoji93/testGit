<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
   <jsp:include page="../include/menu_admin.jsp">
      <jsp:param name="pageInMenu" value="기기관리"  />
      <jsp:param name="pageCategory" value="테블릿&게이트웨이"  />
      <jsp:param name="pageTitle" value="설치현황"  /> 
   </jsp:include>
   
<div class="page">
   <div class="page-wrapper">
      <div class="pageTitle"><h2>설치현황</h2></div>
               
      <div class="pageContent installEquipmentList">
         <div id="layerWindow" class="layerWindow">
            <span class="modalWindow"></span>
            <div id="loginLayer" class="loginLayer loginTypeA">
               <div class="layerPopContent">
                  <p><span class="re_question"></span>게이트웨이를 삭제 하시겠습니까?</p> 
                  <input id="classId" type="hidden" name="parId" /> 
                  <input type="button" class="btn_confirming_text" onclick="closeLayer(1)" >
                  <input type="button" class="btn_close_text" onclick="closeLayer(0)" >
               </div>
            </div>
         </div>
         <div id="layerWindow2" class="layerWindow">
            <span class="modalWindow"></span>
            <div id="loginLayer" class="loginLayer loginTypeA">
               <div class="layerPopContent">
                  <p><span class="re_question"></span>테블릿을 삭제 하시겠습니까?</p> 
                  <input id="classId" type="hidden" name="parId" /> 
                  <input type="button" class="btn_confirming_text" onclick="closeLayer(1)" >
                  <input type="button" class="btn_close_text" onclick="closeLayer(0)" >
               </div>
            </div>
         </div>
         
         <div class="msgBox" id="msgBox"></div>
         <div class="equipmentList">
            <div class="eqList_left" id="eqList_left">
               <div class="eqList_top_left" id="eqList_top_left">
                  <h3>게이트웨이<small>(총 ${fn:length(gateway_List)}대) </small> </h3>
               </div>
               <div class="eqList_top_right">
                  <input type="button" class="btn_sub_25" id="noneBorder" onclick="deleteLayer()">
<!--                   <input type="button" class="btn_add_25" id="noneBorder"> -->
               </div>
               <table id="check_table">
                  <tr>
                     <th></th>
                     <th>게이트웨이명</th>
                     <th>설치위치</th>
                     <th>설치일자</th>
                     <th>설치자</th>
                  </tr>
                  <c:choose>
                     <c:when test="${fn:length(gateway_List) eq 0}">
                        <tr><td align="center" colspan="5">등록된 게이트웨이가 없습니다.</td></tr>
                     </c:when>
                     
                     <c:otherwise>
                        <c:forEach items="${gateway_List}" var="dto_b" varStatus="s">
                        <tr >
                           <td><input type="checkbox" name="equipment_id_G" id="check${s.count}" value="${dto_b.equipment_id}"></td>
                           <td onclick="location.href='installEquipmentDetail?equipment_id=${dto_b.equipment_id} &equipment_type=${dto_b.equipment_type}'">${dto_b.equipment_name}</td>
                           <td onclick="location.href='installEquipmentDetail?equipment_id=${dto_b.equipment_id} &equipment_type=${dto_b.equipment_type}'">${dto_b.equipment_install_loc}</td>
                           <td onclick="location.href='installEquipmentDetail?equipment_id=${dto_b.equipment_id} &equipment_type=${dto_b.equipment_type}'">${dto_b.INSTALLDATEFORMAT}</td>
                           <td onclick="location.href='installEquipmentDetail?equipment_id=${dto_b.equipment_id} &equipment_type=${dto_b.equipment_type}'">${dto_b.equipment_install_man}</td>
                        </tr>
                        </c:forEach>
                     </c:otherwise>
                  </c:choose>   
                  
               </table>
            
            </div>
            
            <div class="eqList_right" id="eqList_right">
               <div class="eqList_top_left">
                  <h3>테블릿<small>(총 ${fn:length(tabletList)}대) </small> </h3>
               </div>
               <div class="eqList_top_right">
                  <input type="button" class="btn_sub_25" id="noneBorder" onclick="deleteLayer2()">
<!--                   <input type="button" class="btn_add_25" id="noneBorder"> -->
               </div>
               <table id="check_table2">
                  <tr>
                     <th></th>
                     <th>테블릿명</th>
                     <th>설치위치</th>
                     <th>설치일자</th>
                     <th>설치자</th>
                  </tr>
                  <c:choose>
                     <c:when test="${fn:length(tabletList) eq 0}">
                        <tr><td align="center" colspan="5">등록된 테블릿이 없습니다.</td></tr>
                     </c:when>
                     
                     <c:otherwise>
                        <c:forEach items="${tabletList}" var="dto_b" varStatus="s">
                        <tr >
                           <td><input type="checkbox" name="equipment_id_T" value="${dto_b.equipment_id}" id="checkT${s.count}"></td>
                           <td onclick="location.href='installEquipmentDetail?equipment_id=${dto_b.equipment_id}&equipment_type=${dto_b.equipment_type}'">${dto_b.equipment_name}</td>
                           <td onclick="location.href='installEquipmentDetail?equipment_id=${dto_b.equipment_id}&equipment_type=${dto_b.equipment_type}'">${dto_b.equipment_install_loc}</td>
                           <td onclick="location.href='installEquipmentDetail?equipment_id=${dto_b.equipment_id}&equipment_type=${dto_b.equipment_type}'">${dto_b.INSTALLDATEFORMAT}</td>
                           <td onclick="location.href='installEquipmentDetail?equipment_id=${dto_b.equipment_id}&equipment_type=${dto_b.equipment_type}'">${dto_b.equipment_install_man}</td>
                        </tr>
                        </c:forEach>
                     </c:otherwise>
                  </c:choose>
                  
               </table>
            </div>
         </div>
         <div class="InstallList">
            
         </div>
      </div>
   </div>
</div>   
<jsp:include page="../include/footer.jsp"/>   
<script type="text/javascript">
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

//tr 클릭시 체크박스 선택


//    $('#check_table tr').click(function(event){
//       var index = $("#check_table tr").index(this); //몇번째 줄인지 알기 위함
//       if($("input:checkbox[id='check"+index+"']").is(":checked")){
//          $("input:checkbox[id='check"+index+"']").attr("checked", false);
//       }
//       else{
//          console.log("check_table else");
//          if(event.target.nodeName.toLowerCase() == 'td') {
//             var checkbox = $(this).find('td:first-child :checkbox');
//             checkbox.attr('checked', true);
//             $("input:checkbox[id='check"+index+"']").prop("checked",true);
//          }
//       }
//    });

function deleteLayer(){
   var len = $("input[name=equipment_id_G]:checked").size();
   console.log("deleteLayer:"+len);
   document.getElementById('msgBox').style.display="none";
   if(len>0){
      $('#layerWindow').css('display','block');
   }else{
      $('#msgBox').removeClass("msgBox_Success");   
      $('#msgBox').addClass("msgBox_Error");   
      $('#msgBox').html("<span>삭제 할 기기를 선택 해 주세요.</span>");
      document.getElementById('msgBox').style.display="block";
   }
}
function deleteLayer2(){
   document.getElementById('msgBox').style.display="none";
   
   var len = $("input[name=equipment_id_G]:checked").size();
   console.log("deleteLayer:"+len);
   document.getElementById('msgBox').style.display="none";
   if(len>0){
      $('#layerWindow2').css('display','block');
   }else{
      $('#msgBox').removeClass("msgBox_Success");   
      $('#msgBox').addClass("msgBox_Error");   
      $('#msgBox').html("<span>삭제 할 기기를 선택 해 주세요.</span>");
      document.getElementById('msgBox').style.display="block";
   }
}
function closeLayer(obj){
   document.getElementById('msgBox').style.display="none";
   // 배열 선언
   var arrayParam = new Array();
   var checkList = "";    
   var check = true;
   //children()  parent()
   var len = $("input[name=equipment_id_G]:checked").size();
   console.log("len:"+len);
   if(len>0){
      if(obj==1){   
      $("input[name=equipment_id_G]:checked").each(function() {
          if($(this).parent().parent().children('td').eq(2).text()!='-'){
            $('#msgBox').addClass("msgBox_Error");   
             $('#msgBox').html("<span>사용중 기기는 삭제 할 수 없습니다.</span>");
             document.getElementById('msgBox').style.display="block";
            
             console.log("배치된 노선");
            check = false;
            return false;
          }
       });
      if(!check){
         document.getElementById('layerWindow').style.display='none';
         return false;
         
      }else{
         $("input[name=equipment_id_G]:checked").each(function() {
            arrayParam.push($(this).val());
            console.log("=Gtest:"+$(this).val());   
          });   
          
         var length= arrayParam.length;
          jQuery.ajaxSettings.traditional = true;
            //승인 확인
            $.ajax({
               type : "POST",
               url : "DeleteEquipment",
               data : { "arrayParam" : arrayParam},
               beforeSend: function(xhr) {
                       xhr.setRequestHeader(header, token);
                    },
               success : function(data) {
                  console.log("test");
      //               setInterval('autoRefresh_div()', 3000);
                  $('#eqList_left').load('installEquipmentList #eqList_left');
                  $('#msgBox').removeClass("msgBox_Error");   
                  $('#msgBox').addClass("msgBox_Success");   
                   $('#msgBox').html("<span>삭제 되었습니다.</span>");
                   document.getElementById('msgBox').style.display="block";
               },
               error : function(xhr, txtStatus, errorThrown) {
                  alert("error" + errorThrown);
               }
            });
         }document.getElementById('layerWindow').style.display='none';
      }   
   }else{
      if(obj==1){
         $('#msgBox').removeClass("msgBox_Success");   
         $('#msgBox').addClass("msgBox_Error");   
         $('#msgBox').html("<span>삭제 할 기기를 선택 해 주세요.</span>");
         document.getElementById('msgBox').style.display="block";
      }
   }document.getElementById('layerWindow').style.display='none';
   
}   
function closeLayer2(obj){
   document.getElementById('msgBox').style.display="none";
   // 배열 선언
   var arrayParam = new Array();
   var checkList = "";    
   var check = true;
   //children()  parent()
   var len = $("input[name=equipment_id_T]:checked").size();
   console.log("len:"+len);
   if(len>0){
      if(obj==1){   
      $("input[name=equipment_id_T]:checked").each(function() {
          if($(this).parent().parent().children('td').eq(2).text()!='-'){
            $('#msgBox').addClass("msgBox_Error");   
             $('#msgBox').html("<span>사용중 기기는 삭제 할 수 없습니다.</span>");
             document.getElementById('msgBox').style.display="block";
            
             console.log("배치된 노선");
            check = false;
            return false;
          }
       });
      if(!check){
         document.getElementById('layerWindow2').style.display='none';
         return false;
         
      }else{
         $("input[name=equipment_id_T]:checked").each(function() {
            arrayParam.push($(this).val());
            console.log("=Gtest:"+$(this).val());   
          });   
          
         var length= arrayParam.length;
          jQuery.ajaxSettings.traditional = true;
            //승인 확인
            $.ajax({
               type : "POST",
               url : "DeleteEquipment",
               data : { "arrayParam" : arrayParam},
               beforeSend: function(xhr) {
                       xhr.setRequestHeader(header, token);
                    },
               success : function(data) {
                  console.log("test");
//                     setInterval('autoRefresh_div()', 3000);
                  $('#eqList_right').load('installEquipmentList #eqList_right');
                  $('#msgBox').removeClass("msgBox_Error");
                  $('#msgBox').addClass("msgBox_Success");   
                   $('#msgBox').html("<span>삭제 되었습니다.</span>");
                   document.getElementById('msgBox').style.display="block";
                  
               },
               error : function(xhr, txtStatus, errorThrown) {
                  alert("error" + errorThrown);
               }
            });
         }document.getElementById('layerWindow2').style.display='none';
      }   
   }else{
      if(obj==1){
         $('#msgBox').removeClass("msgBox_Success");   
         $('#msgBox').addClass("msgBox_Error");   
         $('#msgBox').html("<span>삭제 할 기기를 선택 해 주세요.</span>");
         document.getElementById('msgBox').style.display="block";
      }
   }document.getElementById('layerWindow2').style.display='none';
   
}   
</script>         