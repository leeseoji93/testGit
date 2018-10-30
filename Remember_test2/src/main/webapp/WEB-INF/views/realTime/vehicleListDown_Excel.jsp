<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.text.SimpleDateFormat"%> 
<%@page import="java.util.Date"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<style type="text/css">
/* @page */
/*  {margin:1.0in .34in 1.0in .47in; */
/*  mso-header-margin:.5in; */
/*  mso-footer-margin:.5in; */
/*  mso-page-orientation:landscape;} */
</style>
<% 
//참고 하기 한글명 파일
	String filename = "차량운행일지";
	String ext = ".xls";
	filename = java.net.URLEncoder.encode(filename, "UTF-8");
	response.setContentType("application/octer-stream");
	response.setHeader("Content-Transper-Encoding", "binary");
	response.setHeader("Content-Disposition", "attachment;filename="+filename+ext);
	response.setHeader("Content-Description", "JSP Generated Data");

   //한글(HWP)로 다운로드/실행, filename에 저장될 파일명 지정.
//    response.setHeader("Content-Type", "aapplication/hwp");
//    response.setHeader("Content-Disposition", "attachment;filename=차량운행일지.hwp");
//    response.setHeader("Content-Description", "JSP Generated Data");
        
   // 열기/저장 선택창이 뜨지않고 바로 저장되도록 함
   response.setContentType("application/hwp");
    
%> 	
<style type="text/css">   

/*    .title{text-align: center;font-size:15.0pt;font-weight: bold;}    */
/*    .msg{text-align: center;} */
   .responsibility{text-decoration: underline; font-weight: bold;}
   .center{text-align: right;}
   table td{padding:7px 20px;}
</style>
</head>
<body>
	<c:set var="route_name" value="${route_name}" />
	<c:set var="bus_num" value="${bus_num}" />
	<%
		String driv_docA = "first";
		String temp ="";
		String saveTime = "";
		String nowTime="";
		
		String[] savaTimeArray;
		String[] nowTimeArray;
		
		int saveTimeSec;
		int nowTimeSec=0;
		int leadTimeSec;
		
		int leadTimeSec_S;
		int leadTimeSec_M;
		int leadTimeSec_H;
		
		String leadTimeSec_SSt;
		String leadTimeSec_MSt;
		String leadTimeSec_HSt;
		String nowLeadTime;
	%>
	
	<c:forEach var="recordList" items="${recordListArray}" varStatus="s">
	<fmt:parseNumber var = "i" integerOnly = "true" type = "number" value = "${recordList.real_time_id}" />
	<c:set var="driv_doc" value="${recordList.driv_doc}" />
	<c:set value="${recordList.time}" var="time" />	
	<% 
		Object driv_docBO = pageContext.getAttribute("driv_doc"); 
		String driv_docB = driv_docBO.toString();
		
// 		driv_docA = driv_docB;	
		int i=1;
		
		nowTime = (String)pageContext.getAttribute("time").toString();
    	
		if(!driv_docB.equals(driv_docA) ||driv_docA=="first"){
// 		if(Integer.parseInt(driv_docB)==1){
		saveTime = nowTime;
		savaTimeArray =saveTime.split(":");	
    	saveTimeSec = (Integer.parseInt(savaTimeArray[0]))*60*60 + (Integer.parseInt(savaTimeArray[1]))*60 +(Integer.parseInt(savaTimeArray[2]));				//시
		
	%>	
		</table>
		<table  cellpadding="10" cellspacing="0mm" width="148mm">
			<tr>
				<th width="148mm" align="center" style="font-size: 20px;"><h1>차량운행일지</h1></th>
			</tr>
			<tr>
				<th width="148mm" align="center" style="font-size: 17px;" ><h3>${route_name}(${bus_num})</h3></th>
			</tr>
			<tr>
				<th width="148mm" align="right" >운행일 : ${recordList.createDateFormat}</th>
			</tr>
		</table>
		<table id="detailRecordT"  cellpadding="10" cellspacing="0mm" border="1mm" height="200mm" style="margin-bottom: 100px"> 	
			
			<tr>
				<th width="10mm" height="10mm" background="#c2c1c1"></th>
				<th width="46mm" height="10mm" background="#c2c1c1">정류장명</th>
				<th width="46mm" height="10mm" background="#c2c1c1">도착시간</th>
				<th width="46mm" height="10mm" background="#c2c1c1">소요시간</th>
			</tr>
	   		<tr  id="routeList${s.count}">
				<td width="10mm" height="10mm" id="${recordList.real_time_id}"><c:out value = "${i+1}" /></td>
				<td width="46mm" height="10mm" id="${recordList.real_time_id}">${recordList.station_name}</td>
				
				<td width="46mm" height="10mm" id="beforeTime${s.count}">${recordList.time}</td>
				<td width="46mm" height="10mm" id=""></td>
			</tr>
	 	
	<%	
			temp = driv_docB;
			driv_docA = temp;
		}

		else{
			savaTimeArray =saveTime.split(":");	
	    	saveTimeSec = (Integer.parseInt(savaTimeArray[0]))*60*60 + (Integer.parseInt(savaTimeArray[1]))*60 +(Integer.parseInt(savaTimeArray[2]));				//시
	    	
	    	nowTimeArray = nowTime.split(":");
	    	nowTimeSec = (Integer.parseInt(nowTimeArray[0]))*60*60 + (Integer.parseInt(nowTimeArray[1]))*60 +(Integer.parseInt(nowTimeArray[2]));				//시
	    	
	    	leadTimeSec = nowTimeSec - saveTimeSec;
	    	
	    	if(leadTimeSec>60){
	    		leadTimeSec_H = ((leadTimeSec/60)/60);
	    		
	    		leadTimeSec = leadTimeSec-((leadTimeSec_H*60)*60);
//	     		63612 /60 /60 = 17 // 63612-(60*60*17) = 2412
//	    		2412 / 60 = 40.2  // 2412 - (60*40) =12
	    		
	    		leadTimeSec_M = (leadTimeSec/60);
	    		leadTimeSec = leadTimeSec-(leadTimeSec_M*60);
	    		
	    		leadTimeSec_S = leadTimeSec;
	    	}else{
	    		leadTimeSec_S=leadTimeSec;
	    		leadTimeSec_M=0;
	    		leadTimeSec_H=0;
	    	}
	    	if(leadTimeSec_S<10){
	    		leadTimeSec_SSt = Integer.toString(leadTimeSec_S);
	    		leadTimeSec_SSt = "0"+leadTimeSec_SSt;
	    	}
	    	else{
	    		leadTimeSec_SSt = Integer.toString(leadTimeSec_S);
	    	}
	    	if(leadTimeSec_M<10){
	    		leadTimeSec_MSt = Integer.toString(leadTimeSec_M);
	    		leadTimeSec_MSt = "0"+leadTimeSec_MSt;
	    	}
	    	else{
	    		leadTimeSec_MSt = Integer.toString(leadTimeSec_M);
	    	}
	    	if(leadTimeSec_H<10){
//	     		console.log("leadTimeSec_H :"+leadTimeSec_H);
	    		leadTimeSec_HSt = "00";
	    	}else{
	    		leadTimeSec_HSt = Integer.toString(leadTimeSec_H);
	    	}
	    	
	%>
			<c:set value="${recordList.time}" var="time" />	
			<tr  id="routeList${s.count}" >
				<td width="10mm" height="10mm" id="${recordList.real_time_id}"><c:out value = "${i+1}" /></td>
				<td width="46mm" height="10mm" id="${recordList.real_time_id}">${recordList.station_name}</td>
				<%
// 					nowTime = pageContext.getAttribute("time").toString();
				
				%>
				<td width="46mm" height="10mm" id="beforeTime${s.count}">${recordList.time}</td>
				<td width="46mm" height="10mm" id="leadTime${s.count}"><%=leadTimeSec_HSt %>:<%=leadTimeSec_MSt %>:<%=leadTimeSec_SSt %></td>
			</tr>
	<%		
		driv_docA= driv_docB;
		saveTime = nowTime;

		}
		
		
	%>	
   	</c:forEach>  
 

</body>
</html>