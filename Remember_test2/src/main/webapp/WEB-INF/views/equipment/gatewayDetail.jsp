<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set value="${data}" var="dto_c"/>
<h3>상세 정보</h3>
<div class="categoryList_con" id="categoryList_con">
	<table id="ClassListTable_Equi">
		<tr>
			<td colspan="2">
				<div class="thumbnail-wrapper">
					<div class="thumbnail">
						<div class="centered">
							<img src="${dto_c[0].equipment_install}" class="equiptment_BigImg">
						</div>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<th>기기명</th>
			<td id="equipment_id">${dto_c[0].equipment_id}</td>
		</tr>
		<tr>
			<th>사용여부</th>
			<td id="equipment_use">${dto_c[0].equipment_use}</td>
		</tr>
		<tr>
			<th>물품상태</th>
			<td id="equipment_stat">${fn:trim(dto_c[0].equipment_stat)}</td>
		</tr>
		<tr>
			<th>관리자</th>
			<td id="staff_name">${dto_c[0].staff_name}</td>
		</tr>
		<tr>
			<th>제조사</th>
			<td id="equipment_com">${dto_c[0].equipment_com}</td>
		</tr>
	</table>
	<div class="pageBtn contentBottomBtn">
		<div class="btnLeftBox">
	<!-- 	<input type="button" value="" class="btn_back" id="cusInputBtn3" onclick="kidInfo()" id="bottomBtn-Input"> 이전버튼 클릭 -->
		</div>
		<div class="btnCnterBox">
			<input type="button" value="" id="cusInputBtn" class="btn_update" onclick="goUpdate()"/>
	 	</div>
	 	<div class="btnRightBox">
<!-- 	 		<input type="button" value="" id="cusInputBtn2" class="customM" onclick="accountBack()"/>		 -->
	 	</div>
	</div>
</div>

<script type="text/javascript">
function goUpdate(){
	var equipment_id = $("#equipment_id").text();
	console.log("equipment_id:"+equipment_id);
	$.ajax({  
        url : 'gatewayUpdate',
        type:'POST',
        data : { "equipment_id" : equipment_id},
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
$(document).ready(function(e) {
	 
    $(".thumbnail .centered img").each(function() {
 
       $(this).load(function(){ //이미지를 다 불러온후 확인하기 위해
     	var imgWidth = this.naturalWidth; //이미지 크키가 정해져 있지 않을때
     	var imgHeight = this.naturalHeight;
		var imgWidth2 = $(this).width(); //이미지 크키가 정해져 있을때
		
		if(imgWidth>imgHeight){$(".thumbnail .centered img").addClass("landscape");}
		else{$(".thumbnail .centered img").addClass("portrait");}
		console.log("imgWidth:"+imgWidth);
		console.log("imgHeight:"+imgHeight);
		console.log("imgWidth2:"+imgWidth2);
	
       });
    });
});
</script>
</body>
</html>