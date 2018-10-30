<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set value="${damegeDetail}" var="dto_c"/>
<h3>상세 정보</h3>
<div class="categoryList_con" id="categoryList_con">
	<table id="ClassListTable_As">
		<tr>
			<td colspan="2">
				<div class="thumbnail-wrapper">
					<div class="thumbnail">
						<div class="centered">
							<img src="${dto_c[0].damege_photo}" class="equiptment_BigImg">
						</div>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<th width="40">구분</th>
			<td id="beacon_id"><span>
			<c:set var="damegeCate" value = "${fn:substring(dto_c[0].damege_type, 11,13)}" />
				<c:choose>
					<c:when test="${damegeCate eq 'B_'}">
				       	비콘 	
					</c:when>
				    <c:when test="${damegeCate eq 'T0'}">
				    	테블릿
				    </c:when>
				    <c:otherwise>
				    	 게이트웨이
				    </c:otherwise>
				</c:choose></span>
			</td>
		</tr>
		<tr>
			<th>기기번호</th><td id="beacon_use">${dto_c[0].damege_type}</td>
		</tr>
		<tr>
			<th>신청자</th><td id="beacon_stat">${dto_c[0].staff_name}</td>
		</tr>
		<tr>
			<th>신청일</th><td id="beacon_com">${dto_c[0].createtime}</td>
		</tr>
		<tr>
			<th width="80" style="border: 0px solid #c2c1c1;">
				신청내용
			</th>
			<td colspan="2" style="border: 0px solid #c2c1c1;"><div id="damege_reason_text">${dto_c[0].damege_reason}</div></td>
		</tr>
	</table>
	
</div>

<script type="text/javascript">

var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
$(document).ready(function(){
	var damege = "${dto_c[0].damege_id}";
	var type = damege.substring(11, 13);
	console.log("type:"+type);
	if(type=="BC"){$("#ClassListTable span").text("비콘");}
	else if(type=="T0"){$("#ClassListTable span").text("테블릿");}
	else{$("#ClassListTable span").text("게이트웨이");}
});


function goUpdate(){
	var beacon_id = $("#beacon_id").text();
	console.log("beacon_id:"+beacon_id);
	$.ajax({  
        url : 'beaconUpdate',
        type:'POST',
        data : { "beacon_id" : beacon_id},
        beforeSend: function(xhr) {
            xhr.setRequestHeader(header, token);
        	},
        success: function(result) {	            	 	      
     		console.log("success!!!");
     		$("#categoryList_con").html(result); //str로 받은 data를 넘긴다. 
        },
        error:function(request,status,error){                 
     	   alert("code:"+request.status+"\n"+"error:"+error);
        }
        
    }); //ajax 버스 id 몇개 있는지 파악
    
	
}
</script>