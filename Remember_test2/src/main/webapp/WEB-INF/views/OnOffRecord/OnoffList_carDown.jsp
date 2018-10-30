<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<c:set value="${GcdcList[0].go_doc_rname}" var="go_doc_rname_title"/>
<c:set value="${GcdcList[0].go_doc_start}" var="go_doc_start_tile"/>
<%
	String name = (String)pageContext.getAttribute("go_doc_rname_title");
	name += ((String)pageContext.getAttribute("go_doc_start_tile")).substring(5,7) + "월";
	name += "등하원차량일지";
	name = java.net.URLEncoder.encode(name, "UTF-8");
	String ext = ".hwp";
	//한글(HWP)로 다운로드/실행, filename에 저장될 파일명 지정.
	response.setHeader("Content-Type", "aapplication/hwp");
	
	response.setContentType("application/octer-stream");	
	response.setHeader("Content-Transper-Encoding", "binary");
	
	response.setHeader("Content-Disposition", "attachment;filename="+name+ext);
	response.setHeader("Content-Description", "JSP Generated Data");
		 
	%>
<style type="text/css">	

/* 	.title{text-align: center;font-size:15.0pt;font-weight: bold;}	 */
/* 	.msg{text-align: center;} */

</style>
</head>
<body>
	<c:set value="${GcdcList[0]}" var="Go_come"/>
	<c:set value="${startDay}" var="startDay"/>	
	<c:set value="${endDay}" var="endDay"/>	
	<%
			String startDay = (String)pageContext.getAttribute("startDay");
			String endDay = (String)pageContext.getAttribute("endDay");

		    Date stDate = null;
		    DateFormat sdFormat1 = new SimpleDateFormat("yyyy-MM-dd");
		    DateFormat sdFormat2 = new SimpleDateFormat("d");
		    DateFormat sdFormat3 = new SimpleDateFormat("dd");
		    stDate = sdFormat1.parse(startDay);    
		    Calendar cal = Calendar.getInstance();
		    cal.setTime(stDate);		    
		    cal.add(Calendar.DATE, 1);
		    
		    Calendar cal1 = Calendar.getInstance();
		    cal1.setTime(stDate);		    
		    cal1.add(Calendar.DATE, 1);	
	%>	
	<div style="text-align: center;  font-weight: bold;"><h3>${Go_come.go_doc_title}</h3></div>
	<!-- <font size="15.0pt" color="#000000" ><B>투약 의뢰서</B></font> -->
	<table cellpadding="0mm" cellspacing="0mm" width="148mm">
		<tr><td align="left" width="33mm" height="6mm">노선명</td><td width="5mm" align="center">:</td><td width="110mm">${Go_come.go_doc_rname}</td> </tr>
		<tr><td align="left" width="33mm" height="6mm">운행일</td><td width="5mm" align="center">:</td><td width="110mm">${Go_come.go_doc_start} ~ ${Go_come.go_doc_end}</td> </tr>
		<tr><td align="left" width="33mm" height="6mm">운행시간</td><td width="5mm" align="center">:</td><td width="110mm">${Go_come.go_doc_ostart} ~ ${Go_come.go_doc_oarrive}</td></tr>
		<tr><td align="left" width="33mm" height="6mm">인솔교사/차량기사</td><td width="5mm" align="center">:</td><td width="110mm">${Go_come.go_doc_maint}/${Go_come.go_doc_dirv}</td></tr>
		<tr><td align="left" width="33mm" height="6mm">차량명/차량번호</td><td width="5mm" align="center">:</td><td width="110mm">${Go_come.go_doc_bname}/${Go_come.go_doc_bnum}</td></tr>
		<tr><td align="left" width="33mm" height="6mm">차량정원/운행사</td><td width="5mm" align="center">:</td><td width="110mm">${Go_come.go_doc_borad}/${Go_come.go_doc_bcom}</td></tr>
	</table>
	
	<table cellpadding="0mm" cellspacing="0mm" border="1"  width="148mm">
		<thead>
		<tr>
			<td width="13mm" height="6mm" align="center" bgcolor="#c1c1c1">구분</td><td width="65mm" height="6mm" align="center" bgcolor="#c1c1c1">점검내역</td>
			<%		
			List<String> date1 = new ArrayList();
			
			for(int i = 0; i < 5; i++)
			{
				if(i!=0){
					cal1.add(Calendar.DATE, 1);
				}				
			%>
					<th width="14mm" height="6mm" align="center" bgcolor="#c1c1c1"><%=sdFormat3.format(cal1.getTime())%>일</th>
			<%
				date1.add(sdFormat3.format(cal1.getTime()));
			}
			%>		
		</tr>
		</thead>
		<tbody>		
			
		<c:forEach items="${teach_bus_ckecklistB}" var="dto_b" varStatus="s">
			<tr>
				<c:choose>
					<c:when test="${s.count eq 1}">
						<th height="8mm" rowspan="${fn:length(teach_bus_ckecklistB)}" align="center">${dto_b.teach_buslist_type}</th>
						<th height="8mm" align="center">${dto_b.teach_buslist_cont}</th>
					</c:when>
					
					<c:otherwise>
						<th height="8mm" align="center">${dto_b.teach_buslist_cont}</th>
					</c:otherwise>
				</c:choose>
				<%	
				for(int i = 0; i<date1.size(); i++)
				{	
					boolean check_checkList = false;
				%>
					<c:forEach items="${teach_checkList}" var="checkListDto" varStatus="vs">
					<c:set value="${checkListDto.checkDateD}" var="checkDateD"/>
					<c:set value="${dto_b.teach_buslist_type_order}" var="teach_buslist_type_order"/>
					<c:set value="${checkListDto.teach_buslist_type_order}" var="teach_buslist_type_orderC"/>
					<c:set value="${dto_b.teach_buslist_cont_order}" var="teach_buslist_cont_order"/>
					<c:set value="${checkListDto.teach_buslist_cont_order}" var="teach_buslist_cont_orderC"/>
					<c:set value="${checkListDto.teach_check}" var="teach_check"/>
					<%
						String checkDateD = (String)pageContext.getAttribute("checkDateD");	
						int teach_buslist_type_order = (Integer)pageContext.getAttribute("teach_buslist_type_order");
						int teach_buslist_type_orderC = (Integer)pageContext.getAttribute("teach_buslist_type_orderC");
						int teach_buslist_cont_order = (Integer)pageContext.getAttribute("teach_buslist_cont_order");	
						int teach_buslist_cont_orderC = (Integer)pageContext.getAttribute("teach_buslist_cont_orderC");	
						int teach_check = (Integer)pageContext.getAttribute("teach_check");
						if((date1.get(i).equals(checkDateD))
								&&(teach_buslist_type_order==teach_buslist_type_orderC)
								&&(teach_buslist_cont_order==teach_buslist_cont_orderC)
								&&(teach_check==1)){
								check_checkList = true;
						%>
							<td align="center">✔</td>
						<%
						}						
					%>
					</c:forEach>				
				<%
					if(!check_checkList){
					%>
						<td>&nbsp;</td>
					<%
					check_checkList = false;
					}
				}			
				%>
				
				
			</tr>
		</c:forEach>
		
		<c:forEach items="${teach_bus_ckecklistI}" var="dto_i" varStatus="s1">
			<tr>
				<c:choose>
					<c:when test="${s1.count eq 1}">
						<th height="8mm" align="center" rowspan="${fn:length(teach_bus_ckecklistI)}"> ${dto_i.teach_buslist_type} </th>
						<th height="8mm" align="center"> ${dto_i.teach_buslist_cont} </th>
					</c:when>
					
					<c:otherwise>
						<th height="8mm" align="center">${dto_i.teach_buslist_cont}</th>
					</c:otherwise>
				</c:choose>
				<%	
				for(int i = 0; i<5; i++)
				{	
					boolean check_checkList1 = false;
				%>
					<c:forEach items="${teach_checkList}" var="checkListDtoI" varStatus="vs">
					<c:set value="${checkListDtoI.checkDateD}" var="checkDateDI"/>
					<c:set value="${dto_i.teach_buslist_type_order}" var="teach_buslist_type_orderI"/>
					<c:set value="${checkListDtoI.teach_buslist_type_order}" var="teach_buslist_type_orderCI"/>
					<c:set value="${dto_i.teach_buslist_cont_order}" var="teach_buslist_cont_orderI"/>
					<c:set value="${checkListDtoI.teach_buslist_cont_order}" var="teach_buslist_cont_orderCI"/>
					<c:set value="${checkListDtoI.teach_check}" var="teach_checkI"/>
					<%
						String checkDateDI = (String)pageContext.getAttribute("checkDateDI");	
						int teach_buslist_type_orderI = (Integer)pageContext.getAttribute("teach_buslist_type_orderI");
						int teach_buslist_type_orderCI = (Integer)pageContext.getAttribute("teach_buslist_type_orderCI");
						int teach_buslist_cont_orderI = (Integer)pageContext.getAttribute("teach_buslist_cont_orderI");	
						int teach_buslist_cont_orderCI = (Integer)pageContext.getAttribute("teach_buslist_cont_orderCI");	
						int teach_checkI = (Integer)pageContext.getAttribute("teach_checkI");
						if((date1.get(i).equals(checkDateDI))
								&&(teach_buslist_type_orderI==teach_buslist_type_orderCI)
								&&(teach_buslist_cont_orderI==teach_buslist_cont_orderCI)
								&&(teach_checkI==1)){
								check_checkList1 = true;
						%>
							<td align="center">✔</td>
						<%
						}						
					%>
					</c:forEach>				
				<%
					if(!check_checkList1){
					%>
						<td>&nbsp;</td>
					<%
					check_checkList1 = false;
					}
				}			
				%>
			</tr>
		</c:forEach>
			<c:forEach items="${teach_bus_ckecklistA}" var="dto_a" varStatus="s">
			<tr>
				<c:choose>
					<c:when test="${s.count eq 1}">
						<th height="8mm" align="center" rowspan="${fn:length(teach_bus_ckecklistA)} ">${dto_a.teach_buslist_type}</th>
						<th height="8mm" align="center">${dto_a.teach_buslist_cont}</th>
					</c:when>
					
					<c:otherwise>
						<th height="8mm" align="center">${dto_a.teach_buslist_cont}</th>
					</c:otherwise>
				</c:choose>
				<%	
				for(int i = 0; i<date1.size(); i++)
				{	
					boolean check_checkList2 = false;
				%>
					<c:forEach items="${teach_checkList}" var="checkListDtoA" varStatus="vs">
					<c:set value="${checkListDtoA.checkDateD}" var="checkDateDA"/>
					<c:set value="${dto_a.teach_buslist_type_order}" var="teach_buslist_type_orderA"/>
					<c:set value="${checkListDtoA.teach_buslist_type_order}" var="teach_buslist_type_orderCA"/>
					<c:set value="${dto_a.teach_buslist_cont_order}" var="teach_buslist_cont_orderA"/>
					<c:set value="${checkListDtoA.teach_buslist_cont_order}" var="teach_buslist_cont_orderCA"/>
					<c:set value="${checkListDtoA.teach_check}" var="teach_checkA"/>
					<%
						String checkDateDA = (String)pageContext.getAttribute("checkDateDA");	
						int teach_buslist_type_orderA = (Integer)pageContext.getAttribute("teach_buslist_type_orderA");
						int teach_buslist_type_orderCA = (Integer)pageContext.getAttribute("teach_buslist_type_orderCA");
						int teach_buslist_cont_orderA = (Integer)pageContext.getAttribute("teach_buslist_cont_orderA");	
						int teach_buslist_cont_orderCA = (Integer)pageContext.getAttribute("teach_buslist_cont_orderCA");	
						int teach_checkA = (Integer)pageContext.getAttribute("teach_checkA");
						if((date1.get(i).equals(checkDateDA))
								&&(teach_buslist_type_orderA==teach_buslist_type_orderCA)
								&&(teach_buslist_cont_orderA==teach_buslist_cont_orderCA)
								&&(teach_checkA==1)){
								check_checkList2 = true;
						%>
							<td align="center">✔</td>
						<%
						}						
					%>
					</c:forEach>				
				<%
					if(!check_checkList2){
					%>						
						<td>&nbsp;</td>
					<%
					check_checkList2 = false;
					}
				}			
				%>
			</tr>
		</c:forEach>
	
		</tbody>
	</table>	
	
	<table cellpadding="0mm" cellspacing="0mm" border="1" width="148mm">
		<tr><th width="18mm" height="12mm" rowspan="2" align="center" bgcolor="#c1c1c1">장소</th>
		<th width="15mm" height="12mm" rowspan="2" align="center" bgcolor="#c1c1c1">원아명</th>

		<%		
			List<String> date = new ArrayList();
			
			for(int i = 0; i < 5; i++)
			{
				if(i!=0){
					cal.add(Calendar.DATE, 1);
				}				
		%>
				<th width="23mm" height="6mm" colspan="2" align="center" bgcolor="#c1c1c1"><%=sdFormat3.format(cal.getTime()) %>일</th>
		<%
				date.add(sdFormat2.format(cal.getTime()));
			}
		%>
		</tr>
		<tr>
		<td width="11.5mm" height="6mm" align="center">승차</td><td width="11.5mm" height="6mm" align="center">하차</td>
		<td width="11.5mm" height="6mm" align="center">승차</td><td width="11.5mm" height="6mm" align="center">하차</td>
		<td width="11.5mm" height="6mm" align="center">승차</td><td width="11.5mm" height="6mm" align="center">하차</td>
		<td width="11.5mm" height="6mm" align="center">승차</td><td width="11.5mm" height="6mm" align="center">하차</td>
		<td width="11.5mm" height="6mm" align="center">승차</td><td width="11.5mm" height="6mm" align="center">하차</td>
		</tr>
		
		<%
			String savetoday = ""; //저장 날짜
		%>	
		<c:forEach items="${onoffData}" var="onoffDto" varStatus="vs">
		<c:set value="${onoffDto.today}" var="today"/>		
		<c:set value="${onoffDto.route_id_off}" var="route_id_off"/>
		<c:set value="${onoffDto.on_time}" var="on_time"/>
		<c:set value="${onoffDto.station_id_off}" var="station_id_off"/>
		<c:set value="${onoffDto.off_time}" var="off_time"/>
		<c:set value="${onoffDto.station_name}" var="station_name"/>
		<tr>
		
		<%
			String[] station = ((String)pageContext.getAttribute("station_name")).split(",");
			for(int s = 0; s<station.length; s++)
			{	
				if(!station[s].equals("-")){
					%>
						<td height="12mm" align="center"><%=station[s] %></td>
						<td align="center">${onoffDto.kid_name}</td>
					<%
					break;
				}
				
			}
		%>
			
		<%

		for(int i = 0; i<date.size(); i++)
		{	
			String[] today = ((String)pageContext.getAttribute("today")).split(",");
			String[] on_type = ((String)pageContext.getAttribute("route_id_off")).split(",");
			String[] on_time = ((String)pageContext.getAttribute("on_time")).split(",");
			String[] off_type = ((String)pageContext.getAttribute("station_id_off")).split(",");
			String[] off_time = ((String)pageContext.getAttribute("off_time")).split(",");
			boolean check = false;
			for(int j = 0; j<today.length; j++)
			{		
				if(today[j].equals(date.get(i))){
					check = true;
					if(on_time[j].equals("-")&&off_time[j].equals("-")){
						boolean check2 = false;
						%>
						<c:forEach var="board_and_kidDto" items="${board_and_kidList}" varStatus="vs_1">
							<c:if test="${onoffdto.kid_system_code eq board_and_kidDto.kid_system_code}">
								<td height="12mm" colspan="2" align="center">결석</td>
								<%
									check2 = true;
								%>	
							</c:if>								
						</c:forEach>
																				
						<%	
							if(!check2){
							%>
								<td height="12mm" align="center">-</td><td height="12mm" align="center">-</td>
							<%
							}
						}
						else{
						%>
							<td height="12mm" align="center"><%=on_time[j] %></td><td align="center"><%=off_time[j]%></td>
						<%
						}	
				}
			}
			if(!check){
				%>
				<td height="12mm" align="center">-</td><td height="12mm" align="center">-</td>					
				<%	
				check = false;
			}
		}			
		%>
		</tr>
		</c:forEach>
	</table>
	
	
	
</body>
</html>