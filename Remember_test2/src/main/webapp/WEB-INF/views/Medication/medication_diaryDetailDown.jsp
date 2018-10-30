<%@ page language="java" contentType="application/hwp;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<c:set value="${Class_name}" var="requestList_Class_title"/>
<%
	String name = (String)pageContext.getAttribute("requestList_Class_title");
	name += "투약일지";
	name = java.net.URLEncoder.encode(name, "UTF-8");
	String ext = ".hwp";
	//한글(HWP)로 다운로드/실행, filename에 저장될 파일명 지정.
	response.setHeader("Content-Type", "application/hwp");
	
	response.setContentType("application/octer-stream");	
	response.setHeader("Content-Transper-Encoding", "binary");
	
	response.setHeader("Content-Disposition", "attachment;filename="+name+ext);
	response.setHeader("Content-Description", "JSP Generated Data");
	     
	// 열기/저장 선택창이 뜨지않고 바로 저장되도록 함
	// response.setContentType("application/hwp");	 
%>
</head>
<body>
	<%
		int trCnt=1;		//현재 tr
		int lineTr =12;		//총 tr 갯수    
		String savemonth = "0"; //저장 월
		String month = "0"; //현재 월
		Boolean last; //현재 월
	%>
	<c:choose>
		<c:when test="${fn:length(medication_diaryList) eq 0}">
			<table width="148mm" cellpadding="0" cellspacing="0">
					<tr height="4mm">
						<td align="center" width="115mm" rowspan="2" colspan="6" style="border-right: 1px solid #000000; border-bottom: 1px solid #000000;">
							<font size="17.0pt" color="#000000" ><B>양호 업무 및 투약 일지</B></font>
						</td>
						<th align="center" height="4mm" width="16.5mm" style="border: 1px solid #000000;" bgcolor="#f0f0f0"><B>담당</B></th><th align="center" height="4mm" width="16.5mm" style="border: 1px solid #000000;" bgcolor="#f0f0f0"><B>시설장</B></th>
					</tr>
					
					<tr>
						<td align="center" height="20mm" style="border: 1px solid #000000;">&nbsp;</td>
						<td align="center" height="20mm" style="border: 1px solid #000000;">&nbsp;</td>			
					</tr>
					<tr>
						<td align="center" colspan="8" height="15mm" style="border: 1px solid #000000;">
							<font size="13.0pt" color="#000000"><B style="letter-spacing: 50%">투&nbsp;&nbsp;약&nbsp;&nbsp;사&nbsp;&nbsp;항</B></font>
						</td>
					</tr>
		
					<tr>
						<th align="center" height="11mm" width="38mm" style="border: 1px solid #000000;" bgcolor="#f0f0f0"><B>날&nbsp;&nbsp;짜</B></th>
						<th align="center" height="11mm" width="21mm" style="border: 1px solid #000000;" bgcolor="#f0f0f0"><B>영유아명</B></th>
						<th align="center" height="11mm" width="17mm" style="border: 1px solid #000000;" bgcolor="#f0f0f0"><B>증&nbsp;상</B></th>
						<th align="center" height="11mm" width="21mm" style="border: 1px solid #000000;" bgcolor="#f0f0f0"><B>투약시간</B></th>
						<th align="center" height="11mm" width="15mm" style="border: 1px solid #000000;" bgcolor="#f0f0f0"><B>투약명</B></th>
						<th align="center" height="11mm" width="18mm" style="border: 1px solid #000000;" bgcolor="#f0f0f0"><B>용량</B></th>
						
						<th align="center" height="11mm" width="18.5mm" style="border: 1px solid #000000;" bgcolor="#f0f0f0"><B>투약자</B></th>
						<th align="center" height="11mm" width="18.5mm" style="border: 1px solid #000000;" bgcolor="#f0f0f0"><B>비고</B></th>
					</tr>
					
			<% 
				for(int i =0; i < 12; i++){
			%>	
				<tr>
					<td align="center" height="11mm" width="38mm" style="border: 1px solid #000000;">&nbsp;</td>
					<td align="center" height="11mm" width="21mm" style="border: 1px solid #000000;">&nbsp;</td>
					<td align="center" height="11mm" width="17mm" style="border: 1px solid #000000;">&nbsp;</td>
					<td align="center" height="11mm" width="21mm" style="border: 1px solid #000000;">&nbsp;</td>
					<td align="center" height="11mm" width="15mm" style="border: 1px solid #000000;">&nbsp;</td>
					<td align="center" height="11mm" width="18mm" style="border: 1px solid #000000;">&nbsp;</td>
					<td align="center" height="11mm" width="18.5mm" style="border: 1px solid #000000;">&nbsp;</td>
					<td align="center" height="11mm" width="18.5mm" style="border: 1px solid #000000;">&nbsp;</td>
				</tr>
			<%
				}
			%>
				<tr><td valign="top" height="47mm" colspan="8" style="border: 1px solid #000000;">※기타(특이사항)</td></tr>
				</table>
		</c:when>
		
		<c:otherwise>				
			<c:forEach var="medication_diaryListdto" items="${medication_diaryList}" varStatus="vs">
			<c:set value="${medication_diaryListdto.month}" var="month"/>
			<c:set value="${vs.last}" var="last"/>
			<%
				month = (String)pageContext.getAttribute("month");
				last = (Boolean)pageContext.getAttribute("last");
			%>
			<%
				if(savemonth.equals(month)==false && trCnt>1){
					for(int n=trCnt;n<=12;n++){
			%>
					<tr>
						<td align="center" height="11mm" width="38mm" style="border: 1px solid #000000;">&nbsp;</td>
						<td align="center" height="11mm" width="21mm" style="border: 1px solid #000000;">&nbsp;</td>
						<td align="center" height="11mm" width="17mm" style="border: 1px solid #000000;">&nbsp;</td>
						<td align="center" height="11mm" width="21mm" style="border: 1px solid #000000;">&nbsp;</td>
						<td align="center" height="11mm" width="15mm" style="border: 1px solid #000000;">&nbsp;</td>
						<td align="center" height="11mm" width="18mm" style="border: 1px solid #000000;">&nbsp;</td>
						<td align="center" height="11mm" width="18.5mm" style="border: 1px solid #000000;">&nbsp;</td>
						<td align="center" height="11mm" width="18.5mm" style="border: 1px solid #000000;">&nbsp;</td>
					</tr>			
			<%			
					}
			%>	
				<tr><td valign="top" height="47mm" colspan="8" style="border: 1px solid #000000;">※기타(특이사항)</td></tr>
				</table>
			<%	
					trCnt = 1;
				}
				if(trCnt==1){			
			%>
				<table width="148mm" cellpadding="0" cellspacing="0">
					<tr height="4mm">
						<td align="center" width="115mm" rowspan="2" colspan="6" style="border-right: 1px solid #000000; border-bottom: 1px solid #000000;">
							<font size="17.0pt" color="#000000" ><B>양호 업무 및 투약 일지</B></font>
						</td>
						<th align="center" height="4mm" width="16.5mm" style="border: 1px solid #000000;" bgcolor="#f0f0f0"><B>담당</B></th><th align="center" height="4mm" width="16.5mm" style="border: 1px solid #000000;" bgcolor="#f0f0f0"><B>시설장</B></th>
					</tr>
					
					<tr>
						<td align="center" height="20mm" style="border: 1px solid #000000;">&nbsp;</td>
						<td align="center" height="20mm" style="border: 1px solid #000000;">&nbsp;</td>			
					</tr>
					<tr>
						<td align="center" colspan="8" height="15mm" style="border: 1px solid #000000;">
							<font size="13.0pt" color="#000000"><B style="letter-spacing: 50%">투&nbsp;&nbsp;약&nbsp;&nbsp;사&nbsp;&nbsp;항</B></font>
						</td>
					</tr>
		
					<tr>
						<th align="center" height="11mm" width="38mm" style="border: 1px solid #000000;" bgcolor="#f0f0f0"><B>날&nbsp;&nbsp;짜</B></th>
						<th align="center" height="11mm" width="21mm" style="border: 1px solid #000000;" bgcolor="#f0f0f0"><B>영유아명</B></th>
						<th align="center" height="11mm" width="17mm" style="border: 1px solid #000000;" bgcolor="#f0f0f0"><B>증&nbsp;상</B></th>
						<th align="center" height="11mm" width="21mm" style="border: 1px solid #000000;" bgcolor="#f0f0f0"><B>투약시간</B></th>
						<th align="center" height="11mm" width="15mm" style="border: 1px solid #000000;" bgcolor="#f0f0f0"><B>투약명</B></th>
						<th align="center" height="11mm" width="18mm" style="border: 1px solid #000000;" bgcolor="#f0f0f0"><B>용량</B></th>
						
						<th align="center" height="11mm" width="18.5mm" style="border: 1px solid #000000;" bgcolor="#f0f0f0"><B>투약자</B></th>
						<th align="center" height="11mm" width="18.5mm" style="border: 1px solid #000000;" bgcolor="#f0f0f0"><B>비고</B></th>
					</tr>
			<%
				}
			%>
			<tr>
				<td align="center" height="11mm" width="38mm" style="border: 1px solid #000000;">${medication_diaryListdto.medication_date}</td>
				<td align="center" height="11mm" width="21mm" style="border: 1px solid #000000;">${medication_diaryListdto.kid_name}</td>
				<td align="center" height="11mm" width="17mm" style="border: 1px solid #000000;">${medication_diaryListdto.symptom}</td>
				<td align="center" height="11mm" width="21mm" style="border: 1px solid #000000;">${medication_diaryListdto.dosing_time}</td>
				<td align="center" height="11mm" width="15mm" style="border: 1px solid #000000;">${medication_diaryListdto.medication_kind}</td>
				<td align="center" height="11mm" width="18mm" style="border: 1px solid #000000;">${medication_diaryListdto.volume}</td>
				<td align="center" height="11mm" width="18.5mm" style="border: 1px solid #000000;">${medication_diaryListdto.staff_name}</td>
				<td align="center" height="11mm" width="18.5mm" style="border: 1px solid #000000;">&nbsp;</td>
			</tr>	
			
			<% 
				if (trCnt==lineTr||last){
					for(int i =0; i < lineTr-trCnt; i++){
			%>	
					<tr>
						<td align="center" height="11mm" width="38mm" style="border: 1px solid #000000;">&nbsp;</td>
						<td align="center" height="11mm" width="21mm" style="border: 1px solid #000000;">&nbsp;</td>
						<td align="center" height="11mm" width="17mm" style="border: 1px solid #000000;">&nbsp;</td>
						<td align="center" height="11mm" width="21mm" style="border: 1px solid #000000;">&nbsp;</td>
						<td align="center" height="11mm" width="15mm" style="border: 1px solid #000000;">&nbsp;</td>
						<td align="center" height="11mm" width="18mm" style="border: 1px solid #000000;">&nbsp;</td>
						<td align="center" height="11mm" width="18.5mm" style="border: 1px solid #000000;">&nbsp;</td>
						<td align="center" height="11mm" width="18.5mm" style="border: 1px solid #000000;">&nbsp;</td>
					</tr>
			<%
					}
			%>
					<tr><td valign="top" height="47mm" colspan="8" style="border: 1px solid #000000;">※기타(특이사항)</td></tr>
					</table>
			<%
					trCnt = 1;
				}
				else{
					trCnt++;
				}	
				savemonth = month;
			%>	
			</c:forEach>
		</c:otherwise>
	</c:choose>

</body>
</html>