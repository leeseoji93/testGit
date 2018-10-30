<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<c:set value="${GcdList[0].doc_year}" var="doc_year_title"/>
<c:set value="${GcdList[0].doc_mon}" var="doc_mon_tile"/>
<c:set value="${week}" var="doc_week_tile"/>
<%
	String name = (String)pageContext.getAttribute("doc_year_title")+"년";
	name += ((String)pageContext.getAttribute("doc_mon_tile")) + "월";
	name += ((String)pageContext.getAttribute("doc_week_tile")) + "주차";
	name += "등하원일지";
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
/* 	.td_titleCell{border-top: 1px solid #fff; border-left: 1px solid #fff; font-size: 17.0pt; font-weight: bold;} */
/* 	.td_signCell{height: 20.0mm;} */
	.td_subtitleCell{font-size: 13.0pt; text-align: left;}
	.td_subtitleCell_content{font-size: 13.0pt; text-align: left;}
	.onofftable_font_size{font-size: 10.0pt; text-align: center;"}
/* 	.td_uniquenessCell{vertical-align: top;} */
</style>
</head>
<body>
	<c:set value="${GcdList[0]}" var="Go_come"/>	
	<p style="font-weight: bold; font-size: 18.0pt; height:10mm; text-align: center;">${Go_come.doc_year}년 ${Go_come.doc_mon}월 ${doc_week_tile}주차 등하원 일지</p>
	<table width="148mm">
		<tr><td width="23mm" height="5mm" class="td_subtitleCell">반 이름</td><td width="5mm" height="5mm" style="text-align:center;">:</td><td width="120mm" height="5mm" class="td_subtitleCell_content">${Go_come.class_name}</td> </tr>
		<tr><td width="23mm" height="5mm" class="td_subtitleCell">날짜 </td><td width="5mm" height="5mm" style="text-align:center;">:</td><td width="120mm" height="5mm" class="td_subtitleCell_content">${Go_come.doc_start} ~ ${Go_come.doc_end}</td> </tr>	
	</table>	
	
	<table width="148mm" cellpadding="0mm" cellspacing="0mm" border="1">
	<c:set value="${Go_come.doc_start}" var="startDay"/>	
	<c:set value="${Go_come.doc_end}" var="endDay"/>	
		<tr class="onofftable_font_size" >
			<th width="12mm" height="12mm" align="center" style="background-color: #c1c1c1;">원아명</th>
			<%
				String saveName = ""; //저장 이름

				String startDay = (String)pageContext.getAttribute("startDay");
				String endDay = (String)pageContext.getAttribute("endDay");
				
				DateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd");
				Date startDate = sdFormat.parse(startDay);
				Calendar cal = Calendar.getInstance();
				cal.setTime(startDate);
				cal.add(Calendar.DATE, 1);
				
				DateFormat sdFormat1 = new SimpleDateFormat("yyyyMMdd");
				String tempDate1 = sdFormat.format(cal.getTime());
				
				String week[] = {"월","화","수","목","금"};
				List date = new ArrayList();
				for(int i = 0; i<5; i++)
				{
			%>
					<th colspan="2" width="25.2mm" height="12mm" align="center" style="background-color: #c1c1c1;"><%=tempDate1 %>(<%=week[i] %>)</th>
			<%
				date.add(tempDate1);
				cal.add(Calendar.DATE, 1);
				tempDate1 = sdFormat.format(cal.getTime());
				}
			%>
			<td width="12mm" height="12mm" style="background-color: #c1c1c1;">학부모 싸인</td>
		</tr>
		
		<c:forEach items="${OnOffList}" var="onoffDto" varStatus="vs">
		<tr class="onofftable_font_size" >
			<td height="26mm" rowspan="2">${onoffDto.kid_name}</td>
			<%
				for(int i = 0; i<5; i++)
				{
			%>
					<td height="13mm">등원<br>시간</td><td height="13mm">하원<br>시간</td>
			<%			
				}
			%>
			<td height="26mm" rowspan="2">&nbsp;</td>
		</tr>
		<tr class="onofftable_font_size" >	
		<c:set value="${onoffDto.today}" var="today"/>		
		<c:set value="${onoffDto.on_type}" var="on_type"/>
		<c:set value="${onoffDto.on_time}" var="on_time"/>
		<c:set value="${onoffDto.off_type}" var="off_type"/>
		<c:set value="${onoffDto.off_time}" var="off_time"/>
			<%
				for(int i = 0; i<date.size(); i++)
				{	
					String[] today = ((String)pageContext.getAttribute("today")).split(",");
					String[] on_type = ((String)pageContext.getAttribute("on_type")).split(",");
					String[] on_time = ((String)pageContext.getAttribute("on_time")).split(",");
					String[] off_type = ((String)pageContext.getAttribute("off_type")).split(",");
					String[] off_time = ((String)pageContext.getAttribute("off_time")).split(",");
					boolean check = false;
					for(int j = 0; j<today.length; j++){
						if(today[j].equals(date.get(i))){
							check = true;
							if(on_type[j].equals("-")&&off_type[j].equals("-")){
			%>
							<td colspan="2">결석</td>					
							
			<%		
							}
							else{
			%>
							<td><%=on_type[j]%><br><%=on_time[j] %></td>				
							<td><%=off_type[j] %><br><%=off_time[j] %></td>
			<%
							}
						}
					}
					
					if(!check){
			%>
					<td>-</td>				
					<td>-</td>
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