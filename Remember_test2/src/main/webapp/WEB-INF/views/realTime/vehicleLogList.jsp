<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<jsp:include page="../include/menu_admin.jsp">
	<jsp:param name="pageInMenu" value="차량운행정보"  />
	<jsp:param name="pageCategory" value="운행이력관리"  />
	<jsp:param name="pageTitle" value="운행일지"  /> 
</jsp:include>

<div class="page">
	<div class="page-wrapper">
		<div class="pageTitle"><h2>차량 운행일지 조회</h2></div>
		
		<div class="pageContent">
			<div class="pageContentR300">
				<div class="vehicleLogTitle">노선목록</div>
				<div class="vehicleLogList_Route">
					<table id="vehicleLogList_LT">
						<c:forEach items="${routeList}" var="dto_rl" varStatus="s">
						<tr class="tr_hover" id="routeList${s.count}">
							<td id="${dto_rl.route_id}">
							<c:choose>
								<c:when test="${dto_rl.route_type eq '등원'}">
									<img class="routeList_img" src="images/button/button_goschool_O_30x18(x2).png">
									<div class="routeList_text">${dto_rl.route_name} </div>
								</c:when>												
								<c:otherwise>
									<img class="routeList_img" src="images/button/button_gohome_O_30x18(x2).png">
									<div class="routeList_text">${dto_rl.route_name} </div>
								</c:otherwise>
							</c:choose>	
							</td>
						</tr>
						</c:forEach>
					</table>			
				</div>
			</div>
			<div class="pageContentL700">
				<div class="vehicleLogList_Content_bottom" id="vehicleLogList_Content_bottom">
					
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="../include/footer.jsp"/>

<script type="text/javascript">
	
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

$(document).ready(function(){
	$("#routeList1").trigger("click");	
});

//Tr 클릭 하면 상세 조회 뜨게하기
$(document).on('click', '#vehicleLogList_LT tr', function(){
	var tr = $(this);
	var td = tr.children();
	
	var route_id = td.eq(0).attr("id");			//비콘 값 (첫번째 td)
	var index = $("#vehicleLogList_LT tr").index(this); //몇번째 줄인지 알기 위함
	index +=1;
	var has = $('.tr_hover').hasClass("Listactive");
	var hoverRow = "#routeList"+index;  		// 클릭 한 table의 row 
	
	if(has){ $('.tr_hover').removeClass("Listactive");}		//가지고 있다면 지워라
	
	$(hoverRow).addClass("Listactive");		
	
	console.log("route_id:"+route_id);
	$.ajax({  
        url : 'vehicleLogList_sub',
        data : { "route_id" : route_id,
        		  "date" : $("#cal_Month").val(), 	
        },
        beforeSend: function(xhr) {
            xhr.setRequestHeader(header, token);
        	},
        success: function(result) {	            	 	      
     		console.log("success!!!");
     		$("#vehicleLogList_Content_bottom").html(result); //str로 받은 data를 넘긴다. 
        },
        error:function(request,status,error){                 
     	   alert("code:"+request.status+"\n"+"error:"+error);
        }
    });
});
	
</script>
<style type="text/css">.ui-datepicker-calendar { display: none; }</style>
<script type="text/javascript">
$(function() {
	$('#cal_Month').datepicker( {
		changeMonth: true,
		changeYear: true,
		showButtonPanel: true,
		minDate:'m', // restrict to show month greater than current month
		onClose: function(dateText, inst) {
			// set the date accordingly
			var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
			var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
			$(this).datepicker('setDate', new Date(year, month, 1));
		},
		beforeShow : function(input, inst) {
			if ((datestr = $(this).val()).length > 0) {
				year = datestr.substring(datestr.length-4, datestr.length);
				month = jQuery.inArray(datestr.substring(0, datestr.length-5), $(this).datepicker('option', 'monthNames'));
				$(this).datepicker('option', 'defaultDate', new Date(year, month, 1));
				$(this).datepicker('setDate', new Date(year, month, 1));
			}
		},
	    showMonthAfterYear:true,
	    dateFormat : "yy-mm",
	    monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12']
		
	});
});

</script>
