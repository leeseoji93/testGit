<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 

<style type="text/css">
.ui-datepicker-calendar { 
    display: none;
} 
.ui-datepicker-trigger{
   width: 25px;
   height: 25px;
   float: left;border:0;
}
.hasDatepicker{
   width: 100px;
   height: 30px;
   float: left;
}
</style>

<div class="vehicleLogList_Content_top">
   <div class="searchBox741">
      <input name="cc_cal_Month" id="cal_Month" class="date-picker"/>
      <div class="contentAddStation">   
         <img src="images/button/button_download_90x25.png" onclick="documentList_Down('hwp')" class="downImgBtn">
<!--          <input type="button" class="btn_down_hwp" onclick="documentList_Down('hwp')"> -->
<!--          <input type="button" class="btn_down_excel" onclick="documentList_Down_Excel('xls')"> -->
      </div>
      <div class="msgBox" id="msgBox"></div>
   </div>
</div>
            
<div class="vehicleLogList_Content_bottom_n" id="vehicleLogList_Content_bottom_n">
   <table id="detailRecordLink">
      <tr>
         <th width="30"></th>
         <th width="280">운행일자</th>
         <th width="230">운행차량</th>
         <th width="150">등/하원</th>
      </tr>
      <c:choose>
          <c:when test="${fn:length(routeList)>0}">
               <c:forEach items="${routeList}" var="dto_rl" varStatus="s">
            <tr >
               <td id="${dto_rl.createDateFormat}"><input type="checkbox" name="driv_doc" id="driv_doc" value="${dto_rl.driv_doc}"></td>
               <td id="routeList${s.count}" onclick="location.href='vehicleLogDetail?r=${dto_rl.route_id}&cdf=${dto_rl.createDateFormat}'">${dto_rl.createDateFormat}</td>
               <td id="routeList${s.count}" onclick="location.href='vehicleLogDetail?r=${dto_rl.route_id}&cdf=${dto_rl.createDateFormat}'">${dto_rl.bus_name}</td>
               <td id="routeList${s.count}" onclick="location.href='vehicleLogDetail?r=${dto_rl.route_id}&cdf=${dto_rl.createDateFormat}'">${dto_rl.route_type}</td>
            </tr>
            </c:forEach>
           </c:when>
         <c:otherwise>
             <tr >
                <td colspan="4">등록된 이력이 없습니다.</td>
             </tr>
           </c:otherwise>
      </c:choose>  
   </table>
</div>

<script type="text/javascript">
$(document).ready(function(){
	var today = "${selectYM}";
	$("#cal_Month").val(today);
});

<c:set value="${route_id}" var="route_id"/>
    var route_id = "${route_id}";
    
function documentList_Down_Excel(downType){
   var Arraylist = new Array();
    $('input:checkbox[name="driv_doc"]').each(function() {
      console.log("value : "+this.value);
         if(this.checked){//checked 처리된 항목의 값
            Arraylist.push(this.value)                
       }
    });
       
   console.log("length:"+Arraylist.length);
   location.href = 'vehicleListDown_Excel?downType='+downType+'&route_id='+route_id+'&driv_doc=' + encodeURIComponent(Arraylist,'UTF-8');
}    
function documentList_Down(downType){
   var Arraylist = new Array();
    $('input:checkbox[name="driv_doc"]').each(function() {
      console.log("value : "+this.value);
         if(this.checked){//checked 처리된 항목의 값
            Arraylist.push(this.value)                
         }
    });
    
   console.log("length:"+Arraylist.length);
   location.href = 'vehicleListDown?downType='+downType+'&route_id='+route_id+'&driv_doc=' + encodeURIComponent(Arraylist,'UTF-8');
}

$(function() {      
   var token = $("meta[name='_csrf']").attr("content");
   var header = $("meta[name='_csrf_header']").attr("content");

    $( "#cal_Month" ).datepicker({
          changeMonth: true,
          changeYear: true,
          showButtonPanel: true,
          showMonthAfterYear:true,
//           , buttonImage: '/images/Icon_calendar.gif'  // 우측 달력 icon 의 이미지 패스 
//            , buttonImageOnly: true //  inputbox 뒤에 달력icon만 표시한다. ('...' 표시생략)
          showOn: "button",
          buttonImage : "images/button/button_calender_54x54.png",
          buttonText : '',
          dateFormat: 'yy-mm',             
          
          monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
          onClose: function(dateText, inst) { 
              
               var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();            
                var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
                $(this).datepicker('setDate', new Date(year, month, 1));
                
                $.ajax({  
                    url : 'vehicleLogList_select',
                    data : { "route_id" : route_id,
                           "date" : $( "#cal_Month" ).val()
                        },        
                    beforeSend: function(xhr) {
                           xhr.setRequestHeader(header, token);
                        },
                    success: function(result) {        
                       console.log("tetettetetet");
                          $("#vehicleLogList_Content_bottom").html(result); //str로 받은 data를 넘긴다.   
                         
                    
//                        $("#medication_contrast_documentList_kidList")
//                        .append("<th>선택</th><th>이름</th><th>증상</th><th>날짜</th>")
//                       for(var i=0; i < size_data.length; i ++){   
                         
//                          $("#medication_contrast_documentList_kidList")
//                          .append("<tr onclick=\"location.href = \'medication_contrast_document?request_id=\' + encodeURIComponent(\'"
//                                +result.medication_requestList[i].request_id
//                                +"\',\'UTF-8\')\"><td onclick=\"event.cancelBubble = true;\"><input type=\"checkbox\" name=\"check_medication\" value=\""
//                                +result.medication_requestList[i].request_id
//                                +"\"></td><td>"+result.medication_requestList[i].kid_name
//                                +"</td><td>"
//                                +result.medication_requestList[i].symptom
//                                +"</td><td>"+result.medication_requestList[i].medication_date+"</td></tr>");
                      
//                       }                
                     
                    },
                    error:function(request,status,error){                 
                       alert("code:"+request.status+"\n"+"error:"+error);
                    }                         
                });
             
              var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
              var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
              $(this).datepicker('setDate', new Date(year, month, 1));                  
          }
    });
  });
</script>
