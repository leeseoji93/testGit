<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<jsp:include page="../include/menu_admin.jsp">
	<jsp:param name="pageInMenu" value="기기관리" />
	<jsp:param name="pageCategory" value="A/S신청" />
	<jsp:param name="pageTitle" value="A/S신청이력" />
</jsp:include>
	
	<div class="page">
		<div class="page-wrapper">
			<div class="pageTitle"><h2>A/S신청 이력</h2></div>
	
			<div class="pageContent700 asListPage">
				<div class="searchBox741">
					<input type="text" name="keyWord" id="keyWord">
					<input type="button" value="" id="searchBtn">
					<div class="contentAddStation">
<!-- 						<input type="button" class="btn_delete_small"> -->
					</div>
					<div class="msgBox" id="msgBox"></div>
				</div>
				<div class="categoryContent">
					
					<table id="equiTitle">
						<tr>
							<th width="169">분류</th>
							<th width="233">파손기기</th>
							<th width="149">신청자</th>
							<th width="179">신청일</th>
						</tr>
					</table>
					<div class="classInput">
						<table id="equiTable">	
<%-- 							 onclick="goDetail()DetailInfo('${dto_b.beacon_id}','${s.count}')"  onmouseenter="DetailInfo('${dto_b.beacon_id}','${s.count}')" --%>
							<c:forEach items="${allDamegeList}" var="dto_b" varStatus="s">
							<c:set var="damegeCate" value = "${fn:substring(dto_b.damege_type, 11,13)}" />
								<tr id="damegeList${s.count}" class="tr_hover" >
									<td width="169">
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
										</c:choose>
									</td>
									<td width="233">${dto_b.damege_type}</td>
<%-- 									<td width="300"><div class="shortText">${dto_b.damege_reason}</div></td> --%>
									<td width="149">${dto_b.staff_name}</td>
									<td width="179">${dto_b.createtime}</td>
								</tr>
							</c:forEach>
						</table>
					</div>
					
				</div>
			</div>	
				
			<div class="pageContent300">	
				<div class="categoryList_As">
					<div class="categoryList_con" id="categoryList_con">
						<div id="categoryList_con2">
							
						</div>
						<div class="pageBtn contentBottomBtn">
							<div class="btnLeftBox">
	<!-- 							<input type="button" value="" class="btn_back" id="cusInputBtn3" onclick="kidInfo()" id="bottomBtn-Input"> 이전버튼 클릭 -->
							</div>
							<div class="btnCnterBox">
<!-- 								<input type="button" value="" id="cusInputBtn" class="customD" onclick="goUpdate()"/> -->
					  		</div>
					  		<div class="btnRightBox">
<!-- 					  			<input type="button" value="" id="cusInputBtn2" class="customM" onclick="accountBack()"/>		 -->
					  		</div>
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

	$(document).ready(function(){	
		$("#damegeList1").trigger("click");
	});
	

	$("#searchBtn").click(function(){		
		$.ajax({  
	           url : 'damageSearch',
	           dataType : 'json',
	           type:'POST',
	           data : { "keyWord" : $("#keyWord").val()},
	           beforeSend: function(xhr) {
		              xhr.setRequestHeader(header, token);
		           },
	           success: function(data) {           	   
	        	         	
	             $("#equiTable tr").remove(); 
	             var size_data=data.damageSearch;
	             for(var i=0; i < size_data.length; i ++){
	            	 var damegeCate = data.damageSearch[i].damege_type
	            	 damegeCate =  damegeCate.substring(11, 13);
	            	 var damegeCate_R="";
	            	 if(damegeCate=="BC"){damegeCate_R="비콘";}
	            	 else if(damegeCate=="T0"){damegeCate_R="테블릿";}
	            	 else {damegeCate_R="게이트웨이";}
	            	 
	            	 $("#equiTable")
	            	 .append( 	"<tr id='damegeList"+(i+1)+"' class='tr_hover'>"
								+"<td width='169'>"+damegeCate+"</td>"
								+"<td width='233'>"+data.damageSearch[i].damege_type+"</td>"
								+"<td width='149'>"+data.damageSearch[i].staff_name+"</td>"
								+"<td width='179'>"+data.damageSearch[i].createtime+"</td>"
								+"</tr>"			
	            	 );
	            	 $("#damegeList1").trigger("click");
	             }
	             
	           },
	           error:function(request,status,error){                 
	        	   alert("code:"+request.status+"\n"+"error:"+error);
	           }
		 
		});
	});
	
	//Tr 클릭 하면 상세 조회 뜨게하기
	$(document).on('click', '#equiTable tr', function(){
		var tr = $(this);
		var td = tr.children();
		
		var damege_type = td.eq(1).text();			//비콘 값 (첫번째 td)
		var index = $("#equiTable tr").index(this); //몇번째 줄인지 알기 위함
		index += 1;
		var has = $('.tr_hover').hasClass("Listactive");
		var hoverRow = "#damegeList"+index;  		// 클릭 한 table의 row 
		
		if(has){ $('.tr_hover').removeClass("Listactive");}		//가지고 있다면 지워라
		
		$(hoverRow).addClass("Listactive");			//선택 된거 배경 색 넣기
		
		$.ajax({  
            url : 'damegeDetail',
            type:'POST',
            data : { "damege_type" : damege_type},
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
        });
	});
</script>	
</body>

</html>