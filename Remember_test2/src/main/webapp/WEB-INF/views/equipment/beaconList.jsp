<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	<jsp:include page="../include/menu_admin.jsp">
		<jsp:param name="pageInMenu" value="기기관리"  />
		<jsp:param name="pageCategory" value="비콘"  />
		<jsp:param name="pageTitle" value="비콘조회"  /> 
	</jsp:include>
	
	<div class="page">
		<div class="page-wrapper">
			<div class="pageTitle"><h2>비콘 조회</h2></div>
	
			<div class="pageContent700">
				<div class="searchBox741">
					<input type="text" name="keyWord" id="keyWord">
					<input type="button" value="" id="searchBtn">
					<div class="contentAddStation">
<!-- 						<input type="button" class="btn_delete_small"> -->
					</div>
					<div class="msgBox" id="msgBox"></div>
				</div>
				<div class="categoryContent borderRadius">
					
					<table id="equiTitle">
						<tr>
							<th width="230">비콘번호</th>
							<th width="150">관리자</th>
							<th width="100">사용여부</th>
							<th width="250">물품상태</th>
						</tr>
					</table>
					<div class="classInput">
						<table id="equiTable">	
<%-- 							 onclick="goDetail()DetailInfo('${dto_b.beacon_id}','${s.count}')"  onmouseenter="DetailInfo('${dto_b.beacon_id}','${s.count}')" --%>
							<c:choose>
								<c:when test="${fn:length(beaconList) eq 0}">
									<tr><td align="center">등록된 비콘이 없습니다.</td></tr>
								</c:when>
								
								<c:otherwise>
									<c:forEach items="${beaconList}" var="dto_b" varStatus="s">
									<tr id="beaconList${s.count}" class="tr_hover" >
										<td width="230">${dto_b.beacon_id}</td>
										<td width="150">${dto_b.staff_name}</td>
										<td width="120">${dto_b.beacon_use}</td>
										<td width="230">${dto_b.beacon_stat}</td>
									</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>	
						</table>
					</div>
					
				</div>
			</div>	
			
			<div class="pageContent300">	
				<div class="categoryList_Equi">
					<div class="categoryList_con" id="categoryList_con">
						<table id="ClassListTable_Equi">
							
						</table>
<!-- 						<div class="pageBtn contentBottomBtn"> -->
<!-- 							<div class="btnLeftBox"> -->
<!-- 	<!-- 							<input type="button" value="" class="btn_back" id="cusInputBtn3" onclick="kidInfo()" id="bottomBtn-Input"> 이전버튼 클릭 --> 
<!-- 							</div> -->
<!-- 							<div class="btnCnterBox"> -->
<!-- 								<input type="button" value="" id="cusInputBtn" class="customD" onclick="goUpdate()"/> -->
<!-- 					  		</div> -->
<!-- 					  		<div class="btnRightBox"> -->
<!-- 					  			<input type="button" value="" id="cusInputBtn2" class="customM" onclick="accountBack()"/>		 -->
<!-- 					  		</div> -->
<!-- 				  		</div> -->
					</div>
				</div>
			</div>
			
		</div>
		
	</div>
	<jsp:include page="../include/footer.jsp"/>	
	
<script>
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

	$(document).ready(function(){	
		$("#beaconList1").trigger("click");
	});
	
	//Tr 클릭 하면 상세 조회 뜨게하기
	$(document).on('click', '#equiTable tr', function(){
		var tr = $(this);
		var td = tr.children();
		
		var beacon_id = td.eq(0).text();			//비콘 값 (첫번째 td)
		var index = $("#equiTable tr").index(this); //몇번째 줄인지 알기 위함
		index +=1;
		var has = $('.tr_hover').hasClass("Listactive");
		var hoverRow = "#beaconList"+index;  		// 클릭 한 table의 row 
		
		if(has){ $('.tr_hover').removeClass("Listactive");}		//가지고 있다면 지워라
		
		$(hoverRow).addClass("Listactive");			//선택 된거 배경 색 넣기
		
		console.log(beacon_id+"/"+index+"/"+has+"hoverRow");
		$.ajax({  
            url : 'beaconDetail',
            type:'POST',
            data : { "beacon_id" : beacon_id},
            beforeSend: function(xhr) {
	            xhr.setRequestHeader(header, token);
	        	},
            success: function(result) {	            	 	      
         		$("#categoryList_con").html(result); //str로 받은 data를 넘긴다.
            },
            error:function(request,status,error){                 
         	   alert("code:"+request.status+"\n"+"error:"+error);
            }
        });
	});
	
	$("#searchBtn").click(function(){		
        
		$.ajax({  
               url : 'BeaconSearch',
               dataType : 'json',
               type:'POST',
               data : { "keyWord" : $("#keyWord").val() ,"equipment_type":$("#equipment_type").val()},
               beforeSend: function(xhr) {
 	              xhr.setRequestHeader(header, token);
 	           },
               // data : $('#msg').serializeArray(),
               success: function(data) {           	   
            	         	
                 $("#equiTable tr").remove(); 
                 var size_data=data.beaconResult;
                 for(var i=0; i < size_data.length; i ++){
                	 $("#equiTable")
                	 .append( 	"<tr id='beaconList"+(i+1)+"' class='tr_hover'>"
								+"<td width='230'>"+data.beaconResult[i].beacon_id+"</td>"
								+"<td width='150'>"+data.beaconResult[i].staff_name+"</td>"
								+"<td width='120'>"+data.beaconResult[i].beacon_use+"</td>"
								+"<td width='230'>"+data.beaconResult[i].beacon_stat+"</td>"
								+"</tr>");
                	 $("#beaconList1").trigger("click");
                 }
                 
               },
               error:function(request,status,error){                 
            	   alert("code:"+request.status+"\n"+"error:"+error);
               }
		 
		});
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
