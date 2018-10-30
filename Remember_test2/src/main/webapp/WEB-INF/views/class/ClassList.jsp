<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<jsp:include page="../include/menu_admin.jsp">
		<jsp:param name="pageInMenu" value="시설 관리"  />
		<jsp:param name="pageCategory" value="반 관리"  />
		<jsp:param name="pageTitle" value="반 조회"  /> 
	</jsp:include>
	
	<div class="page">
		<div class="page-wrapper">
			<div class="pageTitle"><h2>반 조회 </h2></div>
			
				
			<div class="pageContent classList">
				<div class="msgBox" id="msgBox"></div>
				
				<div class="classListContent" id="classInput">
					<div class="width782 searchBox">
						<input type="text" name="keyWord" id="keyWord">
						<input type="button" value="" id="searchBtn">
						<img class="btn_addClass" src="images/button/button_add_class_160x50.png" onclick="location.href='addClassForm'">
					</div>
					
					<div id="layerWindow" class="layerWindow">
						<span class="modalWindow"></span>
						<div id="loginLayer" class="loginLayer loginTypeA">
							<div class="layerPopContent">
								<p>삭제 하시겠습니까?</p> 
								<input id="classId" type="hidden" name="parId" /> 
								<input type="button" class="btn_confirming_text" onclick="closeLayer(1)" >
								<input type="button" class="btn_close_text" onclick="closeLayer(0)" >
							</div>
						</div>
					</div>
					<div class="classList_Content " id="classList_Content">
						<table id="classList_Content_table">
							<tr>
								<th width="131">반이름</th>
								<th width="131">담임</th>
								<th width="131">부담임</th>
								<th width="131">학기</th>
								<th width="131">원아수</th>
								<th width="131"></th>
							</tr>
						</table>
						<div class="classList_Content_scroll">
							<table id="classListContentTable">
								<c:forEach items="${allClassList}" var="dto" varStatus="s">	
						   			<tr>
						   				<td width="120px" onclick="location.href='detailClassForm?class_id=${dto.class_id}'">${dto.class_name}</td>
						   				<td width="120px" onclick="location.href='detailClassForm?class_id=${dto.class_id}'">${dto.staff_name_1}</td>
						   				<td width="120px" onclick="location.href='detailClassForm?class_id=${dto.class_id}'">${dto.staff_name_2}</td>
						   				<td width="120px" onclick="location.href='detailClassForm?class_id=${dto.class_id}'">${dto.class_sem}</td>
						   				<td width="120px" onclick="location.href='detailClassForm?class_id=${dto.class_id}'">${dto.cnt_kid}명</td>
						   				<td width="120px">
						   					<input type="button" class="btn_correct_40" id="" value="" onclick="location.href='UpdateClassForm?class_id=${dto.class_id}'"> 
											<input type="button" class="btn_delete_40" id="" value="" onclick="deleteLayer('${dto.class_id}')">
						   				</td>
						   			</tr>									   									
								</c:forEach>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../include/footer.jsp"/>
<script>
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
$("#searchBtn").click(function(){		
    console.log("ClassList Search!!!");
    
	$.ajax({  
           url : 'classSearch',
           dataType : 'json',
           type:'POST',
           data : { "keyWord" : $("#keyWord").val() },
           beforeSend: function(xhr) {
	              xhr.setRequestHeader(header, token);
	           },
           // data : $('#msg').serializeArray(),
           success: function(data) {           	   
        	   console.log("ClassList data~~~~");	
             var carList=JSON.stringify(data.searchKey);                 
             var size_data=data.searchKey;
             
             
             for(var i=0; i < size_data.length; i ++){
            	 $("#classListContentTable").empty();
            	 
				 var stationUse = data.searchKey[i].routeExists;
			
            	 $("#classListContentTable")
            	 .append(	"<tr>"
				   				+"<td width='120' onclick=\"location.href='detailClassForm?class_id="+data.searchKey[i].class_id+"'\">"+data.searchKey[i].class_name+"</td>"
				   				+"<td width='120' onclick=\"location.href='detailClassForm?class_id="+data.searchKey[i].class_id+"'\">"+data.searchKey[i].staff_name_1+"</td>"
				   				+"<td width='120' onclick=\"location.href='detailClassForm?class_id="+data.searchKey[i].class_id+"'\">"+data.searchKey[i].staff_name_2+"</td>"
				   				+"<td width='120' onclick=\"location.href='detailClassForm?class_id="+data.searchKey[i].class_id+"'\">"+data.searchKey[i].class_sem+"</td>"
				   				+"<td width='120' onclick=\"location.href='detailClassForm?class_id="+data.searchKey[i].class_id+"'\">"+data.searchKey[i].cnt_kid+"</td>"
				   				+"<td width='120'>"
				   				+	"<input type=\"button\" class=\"btn_correct_40\" id=\"\" value=\"\" onclick=\"updateKids('')\">" 
								+	"<input type=\"button\" class=\"btn_delete_40\" id=\"\" value=\"\" onclick=\"deleteLayer('"+data.searchKey[i].class_id+"')\">"
				   				+"</td>"
				   			+"</tr>"		 	
            	 );
             }
           },
           error:function(request,status,error){                 
        	   alert("code:"+request.status+"\n"+"error:"+error);
           }
	 
	});
});

function deleteLayer(classId){
	console.log("classId:"+classId);
	$('#classId').val(classId);
	$('#layerWindow').css('display','block');
}
function closeLayer(obj){
	var classId = $('#classId').val();
	
	console.log("obj:"+obj);
	if(obj==1){		//승인 확인
		$.ajax({
			type : "POST",
			url : "DeleteClass",
			data : { "classId" : classId},
			beforeSend: function(xhr) {
	              xhr.setRequestHeader(header, token);
	           },
			success : function(data) {
				console.log("test");
//					setInterval('autoRefresh_div()', 3000);
				$('#msgBox').addClass("msgBox_Success");	
	    		$('#msgBox').html("<span>삭제 되었습니다.</span>");
	    		document.getElementById('msgBox').style.display="block";
	    		
				$('#classInput').load('ClassList #classInput');
				
			},
			error : function(xhr, txtStatus, errorThrown) {
				alert("error" + errorThrown);
			}
		});
	}
	document.getElementById('layerWindow').style.display='none';
	
}

</script>	
