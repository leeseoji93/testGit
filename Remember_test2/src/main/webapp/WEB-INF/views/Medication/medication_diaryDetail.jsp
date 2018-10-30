<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

	<jsp:include page="../include/menu_admin.jsp">
      <jsp:param name="pageInMenu" value="소통"  />
      <jsp:param name="pageCategory" value="투약대조서"  />
      <jsp:param name="pageTitle" value="투약대조서 상세정보"  />
   </jsp:include>
	<div class="page">
		<div class="page-wrapper">
			<div class="pageTitle"><h2>투약일지 상세정보</h2></div>		
<!-- 			td colspan="3" td rowspan="2" -->
		<div class="pageContent">
			<div class="medication_diaryDetail_pageContent" id="medication_diaryDetail_pageContent">
				
			</div>
			<div class="medication_diaryDetail_btn" id="medication_diaryDetail_NPbtn">
			
			</div>
			<div class="contentBottomBtn" id="medication_diaryDetail_DownLoadbtn">
				<div class="btnLeftBox"><img src="images/button/button_back_80x25.png" onclick="history.back();"></div>
				<div class="btnCnterBox centerDownBtn"><img src="images/button/button_download_90x25.png" onclick="medication_diaryList_Down()"></div>
				<div class="btnRightBox"></div>								
			</div>
			
			
		</div>
	</div>
	</div>
	<script type="text/javascript">
	var current_cursor;
	$(document).ready(function(){
		var defult_table="";
		var size = ${medication_requestList_size};
		current_cursor = 0;
// 		var size = 0;
		for(var i = 0; i<12; i++){
			defult_table +="<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>"
		}
		
		if(size==0){
			var plusli1 = document.createElement('table');
	    	plusli1.setAttribute("id", "medication_diaryDetail_Table0");
	    	plusli1.setAttribute("class", "medication_diaryDetail_Table");
	    	plusli1.innerHTML =  "<tr><td rowspan=\"2\" colspan=\"6\" class=\"td_titleCell\" >양호 업무 및 투약 일지</td><th>담당</th><th>시설장</th></tr>"
	    	+"<tr><td class=\"td_signCell\">&nbsp</td><td class=\"td_signCell\">&nbsp</td></tr>"
	    	+"<tr><td colspan=\"8\">투&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;약&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;사&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;항</td></tr>"
	    	+"<tr><th>날&nbsp;&nbsp;&nbsp;짜</th><th>영유아명</th><th>증상</th><th>투약시간</th><th>투약명</th><th>용량</th><th>투약자</th><th>비고</th></tr>"
	    	+ defult_table
	    	+"<tr><td colspan=\"8\" class=\"td_uniquenessCell\">※기타(특이사항)</td></tr>"
	    	+"</table>"; 
	    	document.getElementById('medication_diaryDetail_pageContent').appendChild(plusli1);   	       	
		}	
		else if(size%12==0){
			for(var i = 0;i<parseInt(size/12);i++){		
				var plusli1 = document.createElement('table');
		    	plusli1.setAttribute("id", "medication_diaryDetail_Table"+i);
		    	plusli1.setAttribute("class", "medication_diaryDetail_Table");
		    	plusli1.innerHTML =  "<tr><tr><td rowspan=\"2\" colspan=\"6\" class=\"td_titleCell\" >양호 업무 및 투약 일지</td><th>담당</th><th>시설장</th></tr></tr>"
		    	+"<tr><td class=\"td_signCell\">&nbsp</td><td class=\"td_signCell\">&nbsp</td></tr>"
		    	+"<tr><td colspan=\"8\">투&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;약&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;사&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;항</td></tr>"
		    	+"<tr><th>날&nbsp;&nbsp;&nbsp;짜</th><th>영유아명</th><th>증상</th><th>투약시간</th><th>투약명</th><th>용량</th><th>투약자</th><th>비고</th></tr>"
		    	+ defult_table
		    	+"<tr><td colspan=\"8\" class=\"td_uniquenessCell\">※기타(특이사항)</td></tr>"
		    	+"</table>"; 
		    	document.getElementById('medication_diaryDetail_pageContent').appendChild(plusli1);
		    	if(i!=0){
		    		document.getElementById("medication_diaryDetail_Table"+i).style.display = "none";
		    	}
			}
		}
		else{
			for(var i = 0;i<=parseInt(size/12);i++){	
				var plusli1 = document.createElement('table');				
		    	plusli1.setAttribute("id", "medication_diaryDetail_Table"+i);
		    	plusli1.setAttribute("class", "medication_diaryDetail_Table");
		    	plusli1.innerHTML =  "<tr><tr><td rowspan=\"2\" colspan=\"6\" class=\"td_titleCell\" >양호 업무 및 투약 일지</td><th>담당</th><th>시설장</th></tr></tr>"
		    	+"<tr><td class=\"td_signCell\">&nbsp</td><td class=\"td_signCell\">&nbsp</td></tr>"
		    	+"<tr><td colspan=\"8\">투&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;약&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;사&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;항</td></tr>"
		    	+"<tr><th>날&nbsp;&nbsp;&nbsp;짜</th><th>영유아명</th><th>증상</th><th>투약시간</th><th>투약명</th><th>용량</th><th>투약자</th><th>비고</th></tr>"
		    	+ defult_table
		    	+"<tr><td colspan=\"8\" class=\"td_uniquenessCell\">※기타(특이사항)</td></tr>"
		    	+"</table>"; 
		    	document.getElementById('medication_diaryDetail_pageContent').appendChild(plusli1);
		    	if(i!=0){
		    		document.getElementById("medication_diaryDetail_Table"+i).style.display = "none";
		    	}
			}
		}
		var tableCount = $('.medication_diaryDetail_Table').length;
		var plusli2 = document.createElement('span');
    	plusli2.innerHTML =  "<img src=\"images/button/button_L_23x23(x2).png\" id=\"medication_diaryDetail_pre_btn\" onclick=\"pre()\">";
    	document.getElementById('medication_diaryDetail_NPbtn').appendChild(plusli2);
    	
    	var plusli4 = document.createElement('span');
    	plusli4.setAttribute("id", "medication_diaryDetail_pageCount")
    	plusli4.innerHTML =  ""+(current_cursor+1)+"/"+tableCount+"";
    	document.getElementById('medication_diaryDetail_NPbtn').appendChild(plusli4);
    	
    	var plusli3 = document.createElement('span');
    	plusli3.innerHTML = "<img src=\"images/button/button_R_23x23(x2).png\" id=\"medication_diaryDetail_next_btn\" onclick=\"next("+tableCount+")\">";  						
    	document.getElementById('medication_diaryDetail_NPbtn').appendChild(plusli3);	    
    	
		if(size!=0){
			var table_check_index=0;
			var count = 5;
			<c:forEach items="${medication_requestList}" var="medication_diaryDetailDto">				
				if(count==17){
					count=5;
					table_check_index++;
				}
		    	$("#medication_diaryDetail_Table"+table_check_index+" tr:eq("+count+")").children().eq(0).text("${medication_diaryDetailDto.medication_date}");
		    	$("#medication_diaryDetail_Table"+table_check_index+" tr:eq("+count+")").children().eq(1).text("${medication_diaryDetailDto.kid_name}");
		    	$("#medication_diaryDetail_Table"+table_check_index+" tr:eq("+count+")").children().eq(2).text("${medication_diaryDetailDto.symptom}");
		    	$("#medication_diaryDetail_Table"+table_check_index+" tr:eq("+count+")").children().eq(3).text("${medication_diaryDetailDto.dosing_time}");
		    	$("#medication_diaryDetail_Table"+table_check_index+" tr:eq("+count+")").children().eq(4).text("${medication_diaryDetailDto.medication_kind}");
		    	$("#medication_diaryDetail_Table"+table_check_index+" tr:eq("+count+")").children().eq(5).text("${medication_diaryDetailDto.volume}");
		    	$("#medication_diaryDetail_Table"+table_check_index+" tr:eq("+count+")").children().eq(6).text("${medication_diaryDetailDto.staff_name}");
		    	count++;
			</c:forEach>
		}
    	

	});	
	
	function next(size) {	
		current_cursor++;
		
		if(current_cursor>=size){
			current_cursor=size-1;
		}
		var tableCount = $('.medication_diaryDetail_Table').length;
		$("#medication_diaryDetail_pageCount").text(""+(current_cursor+1)+"/"+tableCount+"")
		$(".medication_diaryDetail_Table").css("display", "none");		
		$("#medication_diaryDetail_Table"+current_cursor).css("display", "table");		
	}
	
	function pre() {	
		current_cursor--;
		if(current_cursor<0){
			current_cursor = 0;
		}
		var tableCount = $('.medication_diaryDetail_Table').length;
		$("#medication_diaryDetail_pageCount").text(""+(current_cursor+1)+"/"+tableCount+"")
		$(".medication_diaryDetail_Table").css("display", "none");		
		$("#medication_diaryDetail_Table"+current_cursor).css("display", "table");		
	}
	
	function medication_diaryList_Down() {
		var Arraylist = new Array();
		 
		Arraylist.push("${date}");		          
		
		location.href = 'medication_diary_multiDown?date=' + encodeURIComponent(Arraylist,'UTF-8')
				+'&class_id=' + encodeURIComponent("${class_id}",'UTF-8');
	}
	</script>
</body>
</html>

