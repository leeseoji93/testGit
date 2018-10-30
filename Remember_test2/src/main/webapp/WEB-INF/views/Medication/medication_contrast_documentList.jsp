<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style type="text/css">
.ui-datepicker-calendar { 
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
</style>

	<jsp:include page="../include/menu_admin.jsp">
      <jsp:param name="pageInMenu" value="소통"  />
      <jsp:param name="pageCategory" value="투약대조서" />
      <jsp:param name="pageTitle" value=""  /> 
   </jsp:include>

	<div class="page">
		<div class="page-wrapper">
			<div class="pageTitle"><h2>투약대조서</h2></div>
	
			<div class="pageContent medication_contrast_documentList">

				<div class="msgBox" id="msgBox"></div>

				<div class="medication_contrast_document_page-wrapper">
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
							<span><input type="text" id="medication_contrast_documentList_medication_date" name="medication_contrast_documentList_medication_date"
							class="medication_contrast_documentList_input" readonly="readonly"></span>							
							<span style="float: right;"><img src="images/button/button_download_90x25.png"onclick="medication_contrast_documentList_Down()" style="height: 27px; width: 90px;cursor: pointer;"></span>
						 </div>
		
						 <div class="cusListTable_contentRight_box">
						 	<div class="cusListTable_contentRight_box_title">
							 	<table id="medication_contrast_documentList_Title">	
									<tr>
									 	<th width="80"></th>
									 	<th width="140">이름</th>
									 	<th width="160">증상</th>
									 	<th width="160">날짜</th>
								 	</tr>
								 </table>
						 	</div>
						 	<div class="cusListTable_contentRight_box_content">
						 		<table id="medication_contrast_documentList_kidList">
						 		
						 		<c:choose>
									<c:when test="${fn:length(medication_requestList) eq 0}">
									
										<tr id="medication_contrast_documentList_notdata"><td style="width: 558px;">이력이 없습니다.</td></tr>
									</c:when>
									
									<c:otherwise>
										<c:forEach items="${medication_requestList}" var="medication_request" varStatus="vs">
									 		<tr onclick="location.href = 'medication_contrast_document?request_id=' + encodeURIComponent('${medication_request.request_id}','UTF-8')">
										 		<td width="80" onclick="event.cancelBubble = true;">
										 		<input type="checkbox" name="check_medication" value="${medication_request.request_id}">								 		
										 		</td>
										 		<td width="140">${medication_request.kid_name}</td>
										 		<td width="160">${medication_request.symptom}</td>
					  	                		<td width="160">${medication_request.medication_date}</td>	
				  	                		</tr>
								 		</c:forEach>
									</c:otherwise>
								</c:choose>
							 </table>
						 	</div>
						 </div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
	var saveClassId="${classList[0].class_id}";
	
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	var today = "${today}";
	$(document).ready(function(){
		$("#medication_contrast_documentList_medication_date").val(today);
	});
	
	function medication_contrast_documentList_Down() {	
		if($("#medication_contrast_documentList_medication_date").val()!=""){
           	var Arraylist = new Array();
	   		 $('input:checkbox[name="check_medication"]').each(function() {
	
	   		      if(this.checked){//checked 처리된 항목의 값
	   		    	  Arraylist.push(this.value)		          
	   		      }
	   		 });

	   		 if(Arraylist.length==0){
	   			$('#msgBox').removeClass("msgBox_Success");
	          	$('#msgBox').addClass("msgBox_Error");
	          	$('#msgBox').html("<span>선택된 투약대조서가 없습니다.</span>");
	          	document.getElementById('msgBox').style.display="block";
	          	return false;
	   		 }
	   		 else{
	 			$('#msgBox').removeClass("msgBox_Success");
	        	$('#msgBox').removeClass("msgBox_Error");			  	             
	           	document.getElementById('msgBox').style.display="none";
	   			location.href = 'medication_contrast_document_multiDown?request_id=' + encodeURIComponent(Arraylist,'UTF-8');
	   		 }
	   		
		}
		else{
			$('#msgBox').removeClass("msgBox_Success");
          	$('#msgBox').addClass("msgBox_Error");
          	$('#msgBox').html("<span>1개월 단위로 다운로드 가능합니다. 날짜를 선택해주세요.</span>");
          	document.getElementById('msgBox').style.display="block";
			return false;
		}
	}
	
	function classClick(class_id,thisObj) {	
		saveClassId = class_id;
		
		var tr = $(thisObj).parent();
	    var td = tr.children();
	    
		$("#medication_contrast_documentList_ClassList tr").removeClass("active"); 
		tr.addClass("active");
		
		$.ajax({  
              url : 'createTable',
              dataType : 'json',
              type:'POST',
              data : { "class_id" : saveClassId,
            		   "date" : $( "#medication_contrast_documentList_medication_date" ).val()
            		},    
            beforeSend: function(xhr) {
	 	              xhr.setRequestHeader(header, token);
	 	           },		
              success: function(result) {    	 	      
 
              	var size_data=result.medication_requestList;
	             if(size_data.length==0){
	            	$("#medication_contrast_documentList_kidList").empty();
	            	$("#medication_contrast_documentList_kidList")
                	.append("<tr id=\"medication_contrast_documentList_notdata\"><td style=\"width: 558px;\">이력이 없습니다.</td></tr>")
//	            		$("#medication_contrast_documentList_medication_date").val(null);
            		return false;
            	 }
              	
             	 $("#medication_contrast_documentList_kidList").empty();
             	 $("#medication_contrast_documentList_Title").empty();	
             	
             	$('#msgBox').removeClass("msgBox_Success");
          		$('#msgBox').removeClass("msgBox_Error");			  	             
             	document.getElementById('msgBox').style.display="none";
          		  		  	             	 
           	
             	 $("#medication_contrast_documentList_Title")
            	 .append("<tr><th width='80'></th><th width='140'>이름</th><th width='160'>증상</th><th width='160'>날짜</th></tr>")
                for(var i=0; i < size_data.length; i ++){	
                	
                	$("#medication_contrast_documentList_kidList")
                	.append("<tr onclick=\"location.href = \'medication_contrast_document?request_id=\' + encodeURIComponent(\'"
                			+result.medication_requestList[i].request_id
                			+"\',\'UTF-8\')\"><td width='80' onclick=\"event.cancelBubble = true;\"><input type=\"checkbox\" name=\"check_medication\" value=\""
                			+result.medication_requestList[i].request_id
                			+"\"></td><td width='140'>"+result.medication_requestList[i].kid_name
                			+"</td><td width='160'>"
                			+result.medication_requestList[i].symptom
                			+"</td><td width='160'>"+result.medication_requestList[i].medication_date+"</td></tr>");		  	                	
            	
                }	  	        
            	
              },
              error:function(request,status,error){                 
           	   alert("code:"+request.status+"\n"+"error:"+error);
              }		  	              
          });
		
// 		$("#medication_contrast_documentList_medication_date").val(null);
// 		$("#medication_contrast_documentList_kidList").empty();
	}
	
	$(function() {		
		  $( "#medication_contrast_documentList_medication_date" ).datepicker({
			  	changeMonth: true,
		        changeYear: true,
		        showButtonPanel: true,
		        showMonthAfterYear:true,
		        buttonImage : "images/button/button_calender_54x54.png",  // 우측 달력 icon 의 이미지 패스 
	            buttonImageOnly: true, //  inputbox 뒤에 달력icon만 표시한다. ('...' 표시생략)
		        showOn: "button",
		        buttonText: "",
		        dateFormat: 'yy-mm',		       
		        monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
		        onClose: function(dateText, inst) { 
		        	if(saveClassId!=null){		
		        		var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();				
			            var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
			            $(this).datepicker('setDate', new Date(year, month, 1));
			            
		        		$.ajax({  
		  	              url : 'createTable',
		  	              dataType : 'json',
		  	              type:'POST',
		  	              data : { "class_id" : saveClassId,
		  	            		   "date" : $( "#medication_contrast_documentList_medication_date" ).val()
		  	            		},    
		  	            beforeSend: function(xhr) {
		  		 	              xhr.setRequestHeader(header, token);
		  		 	           },		
		  	              success: function(result) {    	 	      
          	 
		  	              	var size_data=result.medication_requestList;
			  	             if(size_data.length==0){
			  	            	$("#medication_contrast_documentList_kidList").empty();
			  	            	$("#medication_contrast_documentList_kidList")
		  	                	.append("<tr id=\"medication_contrast_documentList_notdata\"><td style=\"width: 558px;\">이력이 없습니다.</td></tr>")
// 		  	            		$("#medication_contrast_documentList_medication_date").val(null);
		  	            		return false;
		  	            	 }
		  	              	
		  	             	 $("#medication_contrast_documentList_kidList").empty();
		  	             	 $("#medication_contrast_documentList_Title").empty();	
		  	             	
		  	             	$('#msgBox').removeClass("msgBox_Success");
			            	$('#msgBox').removeClass("msgBox_Error");			  	             
		  	             	document.getElementById('msgBox').style.display="none";
		  	          		  		  	             	 
		  	           	
		  	             	 $("#medication_contrast_documentList_Title")
	  	                	 .append("<tr><th width='80'></th><th width='140'>이름</th><th width='160'>증상</th><th width='160'>날짜</th></tr>")
		  	                for(var i=0; i < size_data.length; i ++){	
		  	                	
		  	                	$("#medication_contrast_documentList_kidList")
		  	                	.append("<tr onclick=\"location.href = \'medication_contrast_document?request_id=\' + encodeURIComponent(\'"
		  	                			+result.medication_requestList[i].request_id
		  	                			+"\',\'UTF-8\')\"><td width='80' onclick=\"event.cancelBubble = true;\"><input type=\"checkbox\" name=\"check_medication\" value=\""
		  	                			+result.medication_requestList[i].request_id
		  	                			+"\"></td><td width='140'>"+result.medication_requestList[i].kid_name
		  	                			+"</td><td width='160'>"
		  	                			+result.medication_requestList[i].symptom
		  	                			+"</td><td width='160'>"+result.medication_requestList[i].medication_date+"</td></tr>");		  	                	
	  	                	
		  	                }	  	        
		  	            	
		  	              },
		  	              error:function(request,status,error){                 
		  	           	   alert("code:"+request.status+"\n"+"error:"+error);
		  	              }		  	              
		  	          });
		        	}
		        	else{
		        		$('#msgBox').removeClass("msgBox_Success");
	  	            	$('#msgBox').addClass("msgBox_Error");
	  	            	$('#msgBox').html("<span>반부터 클릭해주세요.</span>");
	  	            	document.getElementById('msgBox').style.display="block";
		        		return false;
		        	}
		        	
		            var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
		            var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
		            $(this).datepicker('setDate', new Date(year, month, 1));		            
		        }
		  });
		});
	</script>
</body>
</html>