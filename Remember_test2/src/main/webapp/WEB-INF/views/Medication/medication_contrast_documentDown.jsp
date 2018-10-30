<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> --%>
<%@ page language="java" contentType="application/hwp;charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<c:set value="${medication_requestList[0].class_name}" var="requestList_class_name"/>
<c:set value="${medication_requestList[0].medication_date}" var="requestList_medication_date"/>
<%
	String name = (String)pageContext.getAttribute("requestList_class_name");
	name += ((String)pageContext.getAttribute("requestList_medication_date")).substring(6, 9);
	name += "투약대조서";
	name = java.net.URLEncoder.encode(name, "UTF-8");
	String ext = ".hwp";
	//한글(HWP)로 다운로드/실행, filename에 저장될 파일명 지정.
	response.setHeader("Content-Type", "application/hwp");
	
// 	response.setContentType("application/octer-stream");	
	response.setHeader("Content-Transper-Encoding", "binary");
	
	response.setHeader("Content-Disposition", "attachment;filename="+name+ext);
	response.setHeader("Content-Description", "JSP Generated Data");
	     
	// 열기/저장 선택창이 뜨지않고 바로 저장되도록 함
	// response.setContentType("application/hwp");
	 
	%>
<style type="text/css">	

/* 	.title{text-align: center;font-size:15.0pt;font-weight: bold;}	 */
/* 	.msg{text-align: center;} */
	.responsibility{text-decoration: underline; font-weight: bold;}
	.center{text-align: right;}
</style>
</head>
<body>

	<c:forEach var="medication_requestListdto" items="${medication_requestList}" varStatus="vs">
			<table cellpadding="0" cellspacing="5.0mm" border="1mm" width="148mm" height="114mm"> <!--한글 150  / 232(두개 넣을거니까 116) -->
			<tr>
			<td width="64mm" height="102mm" align="center">
				<table width="64mm">
					<tr height="11mm"><th width="54mm" align="center"><font size="15.0pt" color="#000000" ><B>투약 의뢰서</B></font></th></tr>
					<tr height="11mm"><td width="54mm" align="center">금일 아래 유아의 투약을 의뢰합니다.</td></tr>
					<tr>
						<td width="54mm" height="48mm" align="center" >
							<table cellpadding="0" cellspacing="0" >
								<tr><th width="21mm" height="6mm" align="right" style="border-top: 0.12mm solid;border-left: 0.12mm solid;">이름(반) :</th><td width="44.5mm" style="border-top: 0.12mm solid;border-right: 0.12mm solid;">${medication_requestListdto.kid_name}(${medication_requestListdto.class_name})</td></tr>
								<tr><th width="21mm" height="6mm" align="right" style="border-left: 0.12mm solid;">증상 :</th><td width="32mm" style="border-right: 0.12mm solid;">${medication_requestListdto.symptom}</td></tr>
								<tr><th width="21mm" height="6mm" align="right" style="border-left: 0.12mm solid;">약의 종류 :</th><td width="32mm" style="border-right: 0.12mm solid;">${medication_requestListdto.medication_kind}</td></tr>
								<tr><th width="21mm" height="6mm" align="right" style="border-left: 0.12mm solid;">투약 용량 :</th><td width="32mm" style="border-right: 0.12mm solid;">${medication_requestListdto.volume}</td></tr>
								<tr><th width="21mm" height="6mm" align="right" style="border-left: 0.12mm solid;">투약 횟수 :</th><td width="32mm" style="border-right: 0.12mm solid;">${medication_requestListdto.count}</td></tr>
								<tr><th width="21mm" height="6mm" align="right" style="border-left: 0.12mm solid;">투약 시간 :</th><td width="32mm" style="border-right: 0.12mm solid;">${medication_requestListdto.dosing_time}</td></tr>
								<tr><th width="21mm" height="6mm" align="right" style="border-left: 0.12mm solid;">보관 방법 :</th><td width="32mm" style="border-right: 0.12mm solid;">${medication_requestListdto.keep}</td></tr>
								<tr><th width="21mm" height="6mm" align="right" style="border-bottom: 0.12mm solid;border-left: 0.12mm solid;">특이사항 :</th><td width="32mm" style="border-bottom: 0.12mm solid;border-right: 0.12mm solid;">${medication_requestListdto.uniqueness}</td></tr>
							</table>						
						</td>
					</tr> 
					<tr height="10mm"><td width="54mm" style="text-align: center;">${medication_requestListdto.medication_date}</td></tr>
					<tr height="10mm"><td id="sign_parent" width="54mm" style="text-align: center;">보호자 : ${medication_requestListdto.par_name}<img width="8mm" id="sign_parent" src="${sign_url_parent}"/></td></tr>
					<tr height="10mm"><td class="responsibility" width="54mm" style="text-align: left;">※투약으로 인한 책임은 의뢰자가 집니다.</td></tr>
					
				</table>
			</td>
			<td width="64mm" height="102mm" align="center">
				<table width="64mm" cellpadding="0" cellspacing="0">
					<tr height="17mm"><th width="54mm" align="center"><font size="15.0pt" color="#000000" ><B>투약 확인서</B></font></th></tr>
					<tr>
						<td width="54mm" height="50mm" align="center">
							<table cellpadding="0" cellspacing="0" border="1mm">
								<tr height="16.6mm">
								<th width="15.8mm" align="center">구분</th>
								<th width="17.8mm" align="center">투약시간</th>
								<th width="9.8mm" align="center">용량</th>
								<th width="7.8mm"  align="center">횟수</th>
								<th width="11.8mm" align="center">투약자</th></tr>							
								<tr height="16.6mm">
								<td width="11.8mm" align="center">1</td>
								<td width="14.8mm" align="center">${medication_requestListdto.dosing_time}</td>
								<td width="10.8mm" align="center">${medication_requestListdto.volume}</td>
								<td width="6.8mm" align="center">${medication_requestListdto.count}</td>
								<td width="9.8mm" align="center">${medication_requestListdto.staff_name}</td></tr>
								<tr height="16.6mm"><th width="11.8mm" align="center">특이사항</th>
								<td colspan="4" align="center">${medication_requestListdto.uniqueness1}</td></tr>
							</table>
						</td>
					</tr>
					<tr><td class="responsibility" width="64mm" height="15mm">금일 본원의 아동에 대해서 의뢰하신 내용대로 투약하엿음을 보고합니다.</td></tr>
					<tr><td width="64mm" height="8mm" style="text-align: center;">${medication_requestListdto.medication_date}</td></tr>
					<tr><td width="64mm" height="8mm" style="text-align: center;">담당교사 : ${medication_requestListdto.staff_name}<img width="8mm" id="sign_teacher" src="${sign_url_teacher}"/></td></tr>
					<tr><td class="center" width="64mm" height="4mm">${medication_requestListdto.center_name}</td></tr>
				</table>
			</td>				
		</tr>
	</table>
	</c:forEach>	
</body>
</html>