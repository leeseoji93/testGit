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
<c:set value="${startMonth}" var="startMonth"/>
<%
	String name = (String)pageContext.getAttribute("startMonth") + "월";
	name += "출석부";
	name = java.net.URLEncoder.encode(name, "UTF-8");
	String ext = ".hwp";
	//한글(HWP)로 다운로드/실행, filename에 저장될 파일명 지정.
	response.setHeader("Content-Type", "aapplication/hwp");
	
	response.setContentType("application/octer-stream");	
	response.setHeader("Content-Transper-Encoding", "binary");
	
	response.setHeader("Content-Disposition", "attachment;filename="+name+ext);
	response.setHeader("Content-Description", "JSP Generated Data");
	     
	// 열기/저장 선택창이 뜨지않고 바로 저장되도록 함
	// response.setContentType("application/hwp");
	 
%>
<style type="text/css">	
	.AttendanceList_contentRight_Content_table{text-align: center;}
</style>
</head>
<body>
	<table id = "AttendanceList_contentRight_Content_table" class="AttendanceList_contentRight_Content_table"
	width="150mm" cellpadding="0mm" cellspacing="0mm" border="1">
			<tr style="text-align: center; height: 5mm">
			<td rowspan="2" colspan="15"  rowspan="2" colspan="15" valign="middle" style='border-left:solid #ffffff 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #ffffff 0.7pt;border-bottom:solid #000000 0.7pt;padding:0.8pt 0.8pt 0.8pt 0.8pt'>${startMonth}월 출석부</td>
			<th colspan="5" style="border: 1px solid #000000; font-weight: bold;">담임</th>
			<th colspan="5"  style="border: 1px solid #000000;font-weight: bold;">원감</th>
			<th colspan="5"  style="border: 1px solid #000000;font-weight: bold;">원장</th>
			<th rowspan="2" colspan="2" style="border: 1px solid #000000;font-weight: bold;">결제</th>
			</tr>
			<tr style="text-align: center; height: 18mm;">
			<td colspan="5" style="border: 1px solid #000000;">&nbsp;</td>
			<td colspan="5" style="border: 1px solid #000000;">&nbsp;</td>
			<td colspan="5" style="border: 1px solid #000000;">&nbsp;</td>
			</tr>
			<tr>
				<td width="12mm" height="10mm" style="text-align: center;">이름
<!-- 					<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";background: url(http://cdn.zetawiki.com/png/backslash.png);'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;일</SPAN></P> -->
<!-- 					<P CLASS=HStyle0 STYLE='text-align: center;'><SPAN STYLE='font-family:"굴림"'>이름 </SPAN></P> -->
				</td>
				<%
					String month = (String)pageContext.getAttribute("month");
					List date = new ArrayList();
					for(int i=1; i<=31; i++){
				%>
					<td width="4.7mm" height="10mm" style="border: 1px solid #000000; text-align: center;"><%=i %></td>
				<%								
					date.add(Integer.toString(i));								
					}
				%>
			</tr>
			<c:forEach items="${GcdList}" var="GcdDto" varStatus="vs">
				<c:set value="${GcdDto.today}" var="today"/>
				<c:set value="${GcdDto.on_type}" var="on_type"/>
				
				<tr style="text-align: center;">
					<td width="12mm" height="6mm" style="border: 1px solid #000000;">${GcdDto.kid_name}</td>
					<%
					for(int i = 0; i<date.size(); i++)
					{
						String[] today = ((String)pageContext.getAttribute("today")).split(",");
						String[] on_type = ((String)pageContext.getAttribute("on_type")).split(",");
						boolean check = false;
						for(int j = 0; j<today.length; j++)
						{	
							if(today[j].equals(date.get(i)))
							{
								check = true;
							%>		
								<td width="4.7mm" height="6mm" style="border: 1px solid #000000;text-align: center;"><%if(!(on_type[j].equals("X"))){%>O<%}else{%><%=on_type[j]%><%	}%></td>								
							<%
							}
						}
						
						if(!check){
					%>
							<td width="4.7mm" height="6mm" style="border: 1px solid #000000;text-align: center;">&nbsp;</td>												
					<%		
							check = false;
							}
						}
					%>		

				</tr>
			</c:forEach>
			<c:set value="${Gcd_size}" var="size"/>
			<%
				int size = Integer.parseInt((String)pageContext.getAttribute("size"));
				for(int i = 0; i<(30-size); i++)
				{
					%>
					<tr>												
					<%	
						for(int j = 0; j<32; j++)
						{
						%>
							<td width="4.7mm" height="6mm" style="border: 1px solid #000000;text-align: center;">&nbsp;</td>												
						<%	
						}
					%>
					</tr>												
					<%	
				}
			%>
		</table>			
</body>
</html>