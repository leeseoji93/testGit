<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<style type="text/css">
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
    width: 1015px;
    margin: 0 auto;
}
</style>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/Home_communication.css">

	<jsp:include page="../include/menu_admin.jsp">
      <jsp:param name="pageInMenu" value="소통"  />
      <jsp:param name="pageCategory" value="가정통신문" />
      <jsp:param name="pageTitle" value="가정통신문 조회" /> 
   </jsp:include>

	<div class="page">
		<div class="page-wrapper">
			<div class="pageTitle"><h2>가정통신문 조회</h2></div>
			
			<div class="pageContent Home_communicationListC">
			<div class="msgboxDiv"><div class="msgBox" id="msgBox"></div></div>

			<div id="layerWindow_p" class="layerWindow">
               <span class="modalWindow"></span>
               <div id="loginLayer" class="loginLayer loginTypeA">
                  <div class="layerPopContent">
                     <p>삭제 하시겠습니까?</p> 
                     <input id="Home_communicationListId" type="hidden"/>
                     <input type="button" class="btn_confirming_text" onclick="closeLayer2(1)" >
                     <input type="button" class="btn_close_text" onclick="closeLayer2(0)" >
                  </div>
               </div>
            </div>	
				<div class="Home_communicationList_page-wrapper">
					<div class="cusListTable_Content">
						<div class="cusListTable_contentLeft cusListTable3">
							<div class="cusListTable_contentLeft_title">
								반목록
							</div>
							<div class="cusListTable_contentLeft_content">
								<table id="Home_communicationList_ClassList">								
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
						
						<div class="cusListTable_contentRight1 cusListTable5">
							<div class="cusListTable_contentRight_title">
								<span><input type="text" id="Home_communicationList_date" name="Home_communicationList_date"
								class="Home_communicationList_input"readonly="readonly"></span>							
							</div>
						 
							  <div class="cusListTable_contentRight_box1">
							  	<div class="cusListTable_contentRight_box2">
							 	<div class="cusListTable_contentRight_box_title">
								 	<table id="Home_communicationList_communicationTitle" style="table-layout: fixed;">	
										<tr>
											<th width="110px">종류</th>
											<th width="130px">제목</th>
											<th width="40px">작성자</th>
											<th width="90px">등록일</th>
											<th width="90px">수정일</th>
											<sec:authorize access="hasAnyRole('ROLE_ADMIN')">	<!-- 원장 -->
												<th width="50px">삭제</th>
											</sec:authorize>											
										</tr>
									 </table>
							 	</div>
							 	<div class="cusListTable_contentRight_box_content">
							 		<table id="Home_communicationList_communicationList" style="table-layout: fixed;">
							 			<c:choose>
											<c:when test="${fn:length(Home_communicationList) eq 0}">
												<tr id="Home_communicationList_notdata"><td>이력이 없습니다.</td></tr>
											</c:when>
											
											<c:otherwise>
												<c:forEach items="${Home_communicationList}" var="Home_communication" varStatus="vs">
									 				<tr onclick="location.href ='Home_communicationDetail?communication_id=' + encodeURIComponent('${Home_communication.communication_id}','UTF-8')">
									 					<td width="110px">${Home_communication.tag_name}</td>
									 					<td width="130px" style="text-overflow: ellipsis; overflow: hidden;white-space: nowrap;">${Home_communication.title}</td>
									 					<td width="40px">${Home_communication.staff_name}</td>
									 					<td width="90px">${Home_communication.create_time}</td>
									 					<td width="90px">${Home_communication.update_time}</td>
									 					<sec:authorize access="hasAnyRole('ROLE_ADMIN')">	<!-- 원장 -->
									 						<td width="50px" onclick="event.cancelBubble = true;">
										 						<img src="images/button/button_delete_G_50x20.png" onclick="DeleteClick('${Home_communication.communication_id}')">
						  	                				</td>
									 					</sec:authorize>							 					
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
	</div>
	 <jsp:include page="../include/footer.jsp"/>
	<script type="text/javascript">	
	var saveClassId="${classList[0].class_id}";
	var today = "${today}";
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	
	$(document).ready(function(){
		$("#Home_communicationList_date").val(today);
	});
	
	function classClick(class_id,thisObj) {	
		saveClassId = class_id;
		
		var tr = $(thisObj).parent();
	    var td = tr.children();
	    
		$("#Home_communicationList_ClassList tr").removeClass("active"); 
		tr.addClass("active");
		
		$.ajax({  
              url : 'home_communication_createTable',
              dataType : 'json',
              type:'POST',
            	beforeSend: function(xhr) {
	              xhr.setRequestHeader(header, token);
	           },
              data : { "class_id" : saveClassId,
            			"date" : $("#Home_communicationList_date").datepicker().val()
            		},              
              success: function(result) {  
            	  
            	var size_data=result.Home_communicationList;

             	 $("#Home_communicationList_communicationList").empty();
	        	 $("#Home_communicationList_communicationTitle").empty();
	        	 
	        	$('#msgBox').removeClass("msgBox_Error");			               	
	        	document.getElementById('msgBox').style.display="none";
	        	
	        	<sec:authorize access = "hasAnyRole('ROLE_ADMIN')">
	        	 $("#Home_communicationList_communicationTitle")																							
            	 .append("<th width='110px'>종류</th><th width='130px'>제목</th><th width='40px'>작성자</th><th width='90px'>등록일</th><th width='90px'>수정일</th><th width='50px'>삭제</th>")			  	        
                   	if(size_data.length==0){
	                   	$("#Home_communicationList_communicationList")
	                	.append("<tr id=\"Home_communicationList_notdata\"><td>이력이 없습니다.</td></tr>");
                   	}
                   	else{
	                   	for(var i=0; i < size_data.length; i ++){	
	  	                	$("#Home_communicationList_communicationList")
	  	                	.append("<tr onclick=\"location.href =\'Home_communicationDetail?communication_id=\' + encodeURIComponent(\'"
	  	                			+result.Home_communicationList[i].communication_id
	  	                			+"\',\'UTF-8\')\"><td width='110px'>"+result.Home_communicationList[i].tag_name
	  	                			+"</td><td width='130px'style=\"text-overflow: ellipsis; overflow: hidden;white-space: nowrap;\">"+result.Home_communicationList[i].title
	  	                			+"</td><td width='40px'>"+result.Home_communicationList[i].staff_name
	  	                			+"</td><td width='90px'>"+result.Home_communicationList[i].create_time
	  	                			+"</td><td width='90px'>"+result.Home_communicationList[i].update_time
	  	                			+"</td><td width='50px' onclick=\"event.cancelBubble = true;\"><img src=\"images/button/button_delete_G_50x20.png\" onclick='DeleteClick("+result.Home_communicationList[i].communication_id+")'></td></tr>");
	  	                	
						}
                   	}
            	</sec:authorize>
	        	 
	        	<sec:authorize access = "hasAnyRole('ROLE_MEMBER')">
	        	 $("#Home_communicationList_communicationTitle")																							
            	 .append("<th width='110px'>종류</th><th width='130px'>제목</th><th width='40px'>작성자</th><th width='90px'>등록일</th><th width='90px'>수정일</th>")			  	        
	               	if(size_data.length==0){
	                   	$("#Home_communicationList_communicationList")
	                	.append("<tr id=\"Home_communicationList_notdata\"><td>이력이 없습니다.</td></tr>");
                   	}
	               	else{
	               	 for(var i=0; i < size_data.length; i ++){	
	  	                	$("#Home_communicationList_communicationList")
	  	                	.append("<tr onclick=\"location.href =\'Home_communicationDetail?communication_id=\' + encodeURIComponent(\'"
	  	                			+result.Home_communicationList[i].communication_id
	  	                			+"\',\'UTF-8\')\"><td width='110px'>"+result.Home_communicationList[i].tag_name
	  	                			+"</td><td width='130px'style=\"text-overflow: ellipsis; overflow: hidden;white-space: nowrap;\">"+result.Home_communicationList[i].title
	  	                			+"</td><td width='40px'>"+result.Home_communicationList[i].staff_name
	  	                			+"</td><td width='90px'>"+result.Home_communicationList[i].create_time
	  	                			+"</td><td width='90px'>"+result.Home_communicationList[i].update_time
	  	                			+"</td></tr>");
	  	                	
						}
	               	}
            	 </sec:authorize>		  	             
              },
              error:function(request,status,error){                 
           	   alert("code:"+request.status+"\n"+"error:"+error);
              }		  	              
          });
		
// 		$("#Home_communicationList_date").val(null);
// 		$("#Home_communicationList_communicationList").empty();
	}
	
	function DeleteClick(communication_id) {	
		document.getElementById('msgBox').style.display="none";
		$('#layerWindow_p').css('display','block');
		$("#Home_communicationListId").val(communication_id);
	}
	
	
	   function closeLayer2(obj){ 
		  var Home_communicationListId = $("#Home_communicationListId").val();   
	      if(obj==1){	
	  		$.ajax({  
	            url : 'home_communication_Delete',
	            dataType : 'json',
	            type:'POST',
	            data : { "communication_id" : Home_communicationListId},              
	            success: function(result) { 
//	              location.load();
//	              var currentLocation = window.location;
//	 				$('#contentCenter').load('stationList #contentCenter');
	        		$(".cusListTable_contentRight_box1").load('Home_communicationList .cusListTable_contentRight_box2');
	        		
	        		$('#msgBox').removeClass("msgBox_Error");
	               	$('#msgBox').addClass("msgBox_Success");
	             	$('#msgBox').html("<span>삭제 성공했습니다.</span>");
	             	document.getElementById('msgBox').style.display="block";
// 	             	$("#Home_communicationList_date").val(null);
	             	document.getElementById('layerWindow_p').style.display='none';
	            },
	            beforeSend: function(xhr) {
		              xhr.setRequestHeader(header, token);
		           },
	            error:function(request,status,error){  
	            	$('#msgBox').removeClass("msgBox_Success");
		           	$('#msgBox').addClass("msgBox_Error");
	            	$('#msgBox').html("<span>삭제 실패 했습니다.</span>");
	            	document.getElementById('msgBox').style.display="block";
	            	document.getElementById('layerWindow_p').style.display='none';
// 	            	$("#Home_communicationList_date").val(null);
	            }
	         
	        });	
	      }
	      else{
	    	  document.getElementById('layerWindow_p').style.display='none';
	      }
	   }
	   
	$(function() {		
		  $( "#Home_communicationList_date" ).datepicker({
			  	changeMonth: true,
		        changeYear: true,
		        showButtonPanel: true,
		        showMonthAfterYear:true,
		        buttonImage : "images/button/button_calender_54x54.png",  // 우측 달력 icon 의 이미지 패스 
	            buttonImageOnly: true, //  inputbox 뒤에 달력icon만 표시한다. ('...' 표시생략)
		        showOn: "button",
		        buttonText: "달력",
		        dateFormat: 'yy-mm-dd',
		        dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
		        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
			    monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
			    monthNames : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		        onClose: function(dateText, inst) { 
		        	if(saveClassId!=null){		        		
		        		$.ajax({  
		  	              url : 'home_communication_createTable',
		  	              dataType : 'json',
		  	              type:'POST',
		  	            	beforeSend: function(xhr) {
			 	              xhr.setRequestHeader(header, token);
			 	           },
		  	              data : { "class_id" : saveClassId,
		  	            			"date" : $("#Home_communicationList_date").datepicker().val()
		  	            		},              
		  	              success: function(result) {  
		  	            	  
		  	            	var size_data=result.Home_communicationList;

		  	             	 $("#Home_communicationList_communicationList").empty();
			  	        	 $("#Home_communicationList_communicationTitle").empty();
			  	        	 
			  	        	$('#msgBox').removeClass("msgBox_Error");			               	
			  	        	document.getElementById('msgBox').style.display="none";
			  	        	
			  	        	<sec:authorize access = "hasAnyRole('ROLE_ADMIN')">
			  	        	 $("#Home_communicationList_communicationTitle")																							
	  	                	 .append("<th width='110px'>종류</th><th width='130px'>제목</th><th width='40px'>작성자</th><th width='90px'>등록일</th><th width='90px'>수정일</th><th width='50px'>삭제</th>")			  	        
		  	                   	if(size_data.length==0){
			  	                   	$("#Home_communicationList_communicationList")
			  	                	.append("<tr id=\"Home_communicationList_notdata\"><td>이력이 없습니다.</td></tr>");
		  	                   	}
		  	                   	else{
			  	                   	for(var i=0; i < size_data.length; i ++){	
				  	                	$("#Home_communicationList_communicationList")
				  	                	.append("<tr onclick=\"location.href =\'Home_communicationDetail?communication_id=\' + encodeURIComponent(\'"
				  	                			+result.Home_communicationList[i].communication_id
				  	                			+"\',\'UTF-8\')\"><td width='110px'>"+result.Home_communicationList[i].tag_name
				  	                			+"</td><td width='130px'style=\"text-overflow: ellipsis; overflow: hidden;white-space: nowrap;\">"+result.Home_communicationList[i].title
				  	                			+"</td><td width='40px'>"+result.Home_communicationList[i].staff_name
				  	                			+"</td><td width='90px'>"+result.Home_communicationList[i].create_time
				  	                			+"</td><td width='90px'>"+result.Home_communicationList[i].update_time
				  	                			+"</td><td width='50px' onclick=\"event.cancelBubble = true;\"><img src=\"images/button/button_delete_G_50x20.png\" onclick='DeleteClick("+result.Home_communicationList[i].communication_id+")'></td></tr>");
				  	                	
		 							}
		  	                   	}
	  	                	</sec:authorize>
			  	        	 
			  	        	<sec:authorize access = "hasAnyRole('ROLE_MEMBER')">
			  	        	 $("#Home_communicationList_communicationTitle")																							
	  	                	 .append("<th width='110px'>종류</th><th width='130px'>제목</th><th width='40px'>작성자</th><th width='90px'>등록일</th><th width='90px'>수정일</th>")			  	        
			  	               	if(size_data.length==0){
			  	                   	$("#Home_communicationList_communicationList")
			  	                	.append("<tr id=\"Home_communicationList_notdata\"><td>이력이 없습니다.</td></tr>");
		  	                   	}
			  	               	else{
			  	               	 for(var i=0; i < size_data.length; i ++){	
				  	                	$("#Home_communicationList_communicationList")
				  	                	.append("<tr onclick=\"location.href =\'Home_communicationDetail?communication_id=\' + encodeURIComponent(\'"
				  	                			+result.Home_communicationList[i].communication_id
				  	                			+"\',\'UTF-8\')\"><td width='110px'>"+result.Home_communicationList[i].tag_name
				  	                			+"</td><td width='130px'style=\"text-overflow: ellipsis; overflow: hidden;white-space: nowrap;\">"+result.Home_communicationList[i].title
				  	                			+"</td><td width='40px'>"+result.Home_communicationList[i].staff_name
				  	                			+"</td><td width='90px'>"+result.Home_communicationList[i].create_time
				  	                			+"</td><td width='90px'>"+result.Home_communicationList[i].update_time
				  	                			+"</td></tr>");
				  	                	
		 							}
			  	               	}
	  	                	 </sec:authorize>		  	             
		  	              },
		  	              error:function(request,status,error){                 
		  	           	   alert("code:"+request.status+"\n"+"error:"+error);
		  	              }		  	              
		  	          });
		        	}
		        	else{
		        		$('#msgBox').removeClass("msgBox_Success");
		        		$('#msgBox').addClass("msgBox_Error");
	  	            	$('#msgBox').html("<span>반 부터 선택해주세요.</span>");
	  	            	document.getElementById('msgBox').style.display="block";
// 	  	            	$("#Home_communicationList_date").val(null);
		        		return false;
		        	}
		        		            
		        }
		  });
		});
	</script>
