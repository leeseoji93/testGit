<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style type="text/css">
.ui-datepicker-calendar { 
    display: none;
} 
.ui-datepicker-month { 
    display: none;
} 
.ui-datepicker-trigger{
	width: 27px;
	height: 27px;
	float: left;
	cursor: pointer;
}
.hasDatepicker{
	width: 203px;
    height: 27px;
    float: left;
}
.msgboxDiv{
    width: 825px;
    margin: 0 auto;
}
</style>

	<jsp:include page="../include/menu_admin.jsp">
      <jsp:param name="pageInMenu" value="소통"  /> 
      <jsp:param name="pageCategory" value="투약일지"  />
      <jsp:param name="pageTitle" value=""  />
   </jsp:include>
	<div class="page">
		<div class="page-wrapper">
			<div class="pageTitle"><h2>투약일지 조회</h2></div>
			
			<div class="pageContent">
				<div class="msgboxDiv"><div class="msgBox" id="msgBox"></div></div>
				<div class="cusListTable_Content">				
					<div class="cusListTable_contentLeft cusListTable3">
							<div class="cusListTable_contentLeft_title">
								반목록
							</div>
							<div class="cusListTable_contentLeft_content">
								<table id="medication_contrast_documentList_ClassList">
									<c:forEach var="classdto" items="${classList}" varStatus="s">
									<c:choose>
										<c:when test="${s.index eq 0}">
											<tr class="active">
												<td onclick="classClick('${classdto.class_id}',this)">${classdto.class_name}</td>		
											</tr>
										</c:when>
										
										<c:otherwise>
											<tr>
												<td onclick="classClick('${classdto.class_id}',this)">${classdto.class_name}</td>											
											</tr>
										</c:otherwise>
									</c:choose>		
																
									</c:forEach>
								</table>
							</div>
					</div>
	
					<div class="cusListTable_contentRight cusListTable4">				 
						 <div class="cusListTable_contentRight_title">
							<span><input type="text" id="medication_diaryList_medication_date" name="medication_diaryList_medication_date"
							class="medication_contrast_documentList_input" readonly="readonly"></span>							
							<span style="float: right;"><img src="images/button/button_download_90x25.png"onclick="medication_diaryList_Down()" style="height: 27px; width: 90px;cursor: pointer;"></span>
						 </div>
						 
						<div class="cusListTable_contentRight_box">
							<div class="cusListTable_contentRight_box_title">
							 	<table id="medication_contrast_documentList_Title">	
									<tr>
									 	<th width="60"></th>
									 	<th width="480">월</th>
								 	</tr>
								 </table>
						 	</div>
							 
							 
							 <div class="cusListTable_contentRight_box_content">
							 <table id="medication_contrast_documentList_kidList">
							 <c:set value="${month}" var="month"/>
								<%
									int Imonth = Integer.parseInt((String)pageContext.getAttribute("month"));
									
									for(int i =1; i<=Imonth; i++){
									%>
										<tr onclick="DiaryLListClick(this)">
										<fmt:formatNumber var="month_format" value="<%=i%>" pattern="00"/>
											<td width="60" onclick="event.cancelBubble = true;">
												<input type="checkbox" name="medication_diaryList_DiaryMonthCheck" value="${month_format}">
											</td>
											<td width="480"><%=i%>월 투약일지</td>										
										</tr>	
									<%
									}									
								%>							    
							</table>
						 	</div>	 
						</div>				 
					</div>				
				</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
	var saveClassId = "${classList[0].class_id}";	
	var year_today = "${year}";
	
	$(document).ready(function(){
		$("#medication_diaryList_medication_date").val(year_today);
	});
	
	function DiaryLListClick(thisObj) {
		
		if(($("#medication_diaryList_medication_date").val()==null) || ($("#medication_diaryList_medication_date").val()=="") ){
			$('#msgBox').removeClass("msgBox_Success");
			$('#msgBox').addClass("msgBox_Error");
          	$('#msgBox').html("<span>년도를 먼저 선택해주세요.</span>");
          	document.getElementById('msgBox').style.display="block";
//       		$("#medication_diaryList_medication_date").val(null);
      		return false;
		}
		location.href = 'medication_diary?class_id=' + encodeURIComponent(saveClassId,'UTF-8')
				+'&date=' + encodeURIComponent($("#medication_diaryList_medication_date").val() +"-"+ $(thisObj).children().children("input").val(),'UTF-8');
	}
	
	function medication_diaryList_Down() {	
		if(($("#medication_diaryList_medication_date").val()==null) || ($("#medication_diaryList_medication_date").val()=="") ){
			$('#msgBox').removeClass("msgBox_Success");
			$('#msgBox').addClass("msgBox_Error");
          	$('#msgBox').html("<span>년도를 먼저 선택해주세요.</span>");
          	document.getElementById('msgBox').style.display="block";
//       		$("#medication_diaryList_medication_date").val(null);
      		return false;
		}
		
		var Arraylist = new Array();
		var check = true;
		 $('input:checkbox[name="medication_diaryList_DiaryMonthCheck"]').each(function() {
			 
		      if(this.checked){//checked 처리된 항목의 값
		    	   <%
		    	    Date now = new Date();
		    	    Calendar cal = Calendar.getInstance();
		    	    cal.setTime(now);
		    	    DateFormat sdFormat1 = new SimpleDateFormat("yyyy-MM");
		    		String tempDate1 = sdFormat1.format(cal.getTime());
		    		%>   
		    		var NowTime = "<%=tempDate1 %>"+"-01";
		    	    var NowTimeArr = NowTime.split('-');
		    		
		    		var checkDate = $("#medication_diaryList_medication_date").val() +"-"+ this.value + "-01";
		    	    var checkDateArr = checkDate.split('-');
		    	    
		    	    var NowTimeCompare = new Date(NowTimeArr[0], parseInt(NowTimeArr[1])-1, NowTimeArr[2]);
		            var checkDateCompare = new Date(checkDateArr[0], parseInt(checkDateArr[1])-1, checkDateArr[2]);
		    	    if(NowTimeCompare.getTime() < checkDateCompare.getTime()){
			          	check = false;		    	    	
		    	    }

		    	  Arraylist.push($("#medication_diaryList_medication_date").val() +"-"+ this.value);		          
		      }
		 });
		 if(!check){
			$('#msgBox').removeClass("msgBox_Success");
          	$('#msgBox').addClass("msgBox_Error");
          	$('#msgBox').html("<span>선택된 월 중에 현재 날짜보다 높은 날짜가 있습니다.</span>");
          	document.getElementById('msgBox').style.display="block";
          	return false;
		 }
		 
		 if(Arraylist.length==0){
	   			$('#msgBox').removeClass("msgBox_Success");
	          	$('#msgBox').addClass("msgBox_Error");
	          	$('#msgBox').html("<span>선택된 투약일지가 없습니다.</span>");
	          	document.getElementById('msgBox').style.display="block";
	          	return false;
	   		 }
	   		 else{
	 			$('#msgBox').removeClass("msgBox_Success");
	        	$('#msgBox').removeClass("msgBox_Error");			  	             
	           	document.getElementById('msgBox').style.display="none";
	           	location.href = 'medication_diary_multiDown?date=' + encodeURIComponent(Arraylist,'UTF-8')
				+'&class_id=' + encodeURIComponent(saveClassId,'UTF-8');
	   		 }
		
	}
	
	function classClick(class_id,thisObj) {	
		saveClassId = class_id;
		
		var tr = $(thisObj).parent();
	    var td = tr.children();
	    
		$("#medication_contrast_documentList_ClassList tr").removeClass("active"); 
		tr.addClass("active");
		
// 		$("#medication_diaryList_medication_date").val(null);
// 		$('#medication_diaryList_DiaryLList').css('display','none');
		$("input:checkbox[name='medication_diaryList_DiaryMonthCheck']").prop("checked",false);
	}
	
	$(function() {		
		  $( "#medication_diaryList_medication_date" ).datepicker({
		        changeYear: true,
		        showButtonPanel: true,
		        stepMonths: 12,
		        buttonImage : "images/button/button_calender_54x54.png",  // 우측 달력 icon 의 이미지 패스 
	            buttonImageOnly: true, //  inputbox 뒤에 달력icon만 표시한다. ('...' 표시생략)
		        showOn: "button",
		        buttonText: "",
		        dateFormat: 'yy',		       
		        onClose: function(dateText, inst) { 
		        	if(saveClassId==null){
		        		$('#msgBox').removeClass("msgBox_Success");
		        		$('#msgBox').addClass("msgBox_Error");
	  	            	$('#msgBox').html("<span>반부터 클릭해주세요.</span>");
	  	            	document.getElementById('msgBox').style.display="block";
  	            		$("#medication_contrast_documentList_medication_date").val(null);
		        		return false;
		        	}		        	     	
		          
		            var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
		            $(this).datepicker('setDate', new Date(year, 1));	
		            
		            $("#medication_contrast_documentList_kidList").empty();
		            var month = "${month}"
		            if(year_today==year){
		            	for(var i = 1; i<=month; i++){
		            		$("#medication_contrast_documentList_kidList")
	  	                	.append("<tr onclick=\"DiaryLListClick(this)\"><td width=\"60\" onclick=\"event.cancelBubble = true;\"><input type=\"checkbox\" name=\"medication_diaryList_DiaryMonthCheck\" value='"+pad2(i)+"'></td><td width=\"480\">"+i+"월 투약일지</td></tr>");
		            	}	
		            }
		            else if(year_today<year){
		            	$("#medication_contrast_documentList_kidList")
  	                	.append("<tr id=\"medication_contrast_documentList_notdata\"><td>미래의 이력이 없습니다.</td></tr>")	
		            }
		            else{
		            	for(var i = 1; i<=12; i++){
		            		$("#medication_contrast_documentList_kidList")
	  	                	.append("<tr onclick=\"DiaryLListClick(this)\"><td width=\"60\" onclick=\"event.cancelBubble = true;\"><input type=\"checkbox\" name=\"medication_diaryList_DiaryMonthCheck\" value='"+pad2(i)+"'></td><td width=\"480\">"+i+"월 투약일지</td></tr>");
		            	}
		            }
		            
		            $('#medication_diaryList_DiaryLList').css('display','table');
		        }
		  });
		});
	
      function pad2(number) {
      	   
          return (number < 10 ? '0' : '') + number
        
     }
	</script>
</body>
</html>