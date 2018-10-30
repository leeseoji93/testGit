<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/realTime.css">
<title>차량운행일지 일일점검표 관리 수정</title>
</head>
<body>
<jsp:include page="../include/menu_admin.jsp"/>
	<div class="page">
		<div class="page-wrapper">
			<div class="pageTitle"><h2>차량운행일지 일일점검표 관리 수정</h2></div>
				
			<div class="pageContent">
				<div class="CheckBreakdown-Box">
					<div class="CheckBreakdown-Box-Title">
						▶ 운행전 점검
						<button name="addDriveBef">운행전 점검 추가</button>
					</div>
					<div class="CheckBreakdown-Box-Con">
						<table>
							<tr>
								<td><input type="text" name="" class="big_input" value="차량 외부의 이상 유,무를 확인 한다."></td>
							</tr>
							<tr>
								<td><input type="text" class="big_input" value="차량시동 후 엔진 및 각종 계기판 이상 유,무를 확인한다."></td>
							</tr>
							<tr name="trQuestionBef">
								<td><input type="text" class="big_input" value="차량 추랄 전 탑승자의 안전벨츠 및 문단속을 확인한다."></td>
							</tr>
						
						</table>
					</div>
				</div>
				
				<div class="CheckBreakdown-Box">
					<div class="CheckBreakdown-Box-Title">
						▶ 운행중 점검
						<button name="addDriveIng">운행중 점검 추가</button>
					</div>
					<div class="CheckBreakdown-Box-Con">
						<table>
							<tr>
								<td><input type="text" name="" class="big_input" value="차량 외부의 이상 유,무를 확인 한다."></td>
							</tr>
							<tr>
								<td><input type="text" class="big_input" value="차량시동 후 엔진 및 각종 계기판 이상 유,무를 확인한다."></td>
							</tr>
							<tr name="trQuestionIng">
								<td><input type="text" class="big_input" value="차량 추랄 전 탑승자의 안전벨츠 및 문단속을 확인한다."></td>
							</tr>
						
						</table>
					</div>
				</div>
				
				<div class="CheckBreakdown-Box">
					<div class="CheckBreakdown-Box-Title">
						▶ 운행후 점검
						<button name="addDriveAft">운행후 점검 추가</button>
					</div>
					<div class="CheckBreakdown-Box-Con">
						<table>
							<tr>
								<td><input type="text" class="big_input" value="차량 외부의 이상 유,무를 확인 한다."></td>
							</tr>
							<tr>
								<td><input type="text" class="big_input" value="차량시동 후 엔진 및 각종 계기판 이상 유,무를 확인한다."></td>
							</tr>
							<tr name="trQuestionAft">
								<td><input type="text" class="big_input" value="차량 추랄 전 탑승자의 안전벨츠 및 문단속을 확인한다."></td>
							</tr>
						
						</table>
					</div>
				</div>
			<script>
			    //추가 버튼
			    $(document).on("click","button[name=addDriveBef]",function(){
			         
			        var addDriveBefText =  '<tr name="trQuestionBef">'+
			            '   <td>'+
			            '       <input type="text" class="big_input" placeholder="내용을 입력 해 주세요">'+
			            '       <button class="btn btn-default" name="delQuestion">삭제</button>'+
			            '   </td>'+
			            '</tr>';
			             
			        var trHtml = $( "tr[name=trQuestionBef]:last" ); //last를 사용하여 trQuestion라는 명을 가진 마지막 태그 호출
			        trHtml.after(addDriveBefText); //마지막 trQuestion명 뒤에 붙인다.
			    });
			    
			  //추가 버튼
			    $(document).on("click","button[name=addDriveIng]",function(){
			         
			        var addDriveBefText =  '<tr name="trQuestionIng">'+
			            '   <td>'+
			            '       <input type="text" class="big_input" placeholder="내용을 입력 해 주세요">'+
			            '       <button class="btn btn-default" name="delQuestion">삭제</button>'+
			            '   </td>'+
			            '</tr>';
			             
			        var trHtml = $( "tr[name=trQuestionIng]:last" ); //last를 사용하여 trQuestion라는 명을 가진 마지막 태그 호출
			        trHtml.after(addDriveBefText); //마지막 trQuestion명 뒤에 붙인다.
			    });
			  
			  //추가 버튼
			    $(document).on("click","button[name=addDriveAft]",function(){
			         
			        var addDriveBefText =  '<tr name="trQuestionAft">'+
			            '   <td>'+
			            '       <input type="text" class="big_input" placeholder="내용을 입력 해 주세요">'+
			            '       <button class="btn btn-default" name="delQuestion">삭제</button>'+
			            '   </td>'+
			            '</tr>';
			             
			        var trHtml = $( "tr[name=trQuestionAft]:last" ); //last를 사용하여 trQuestion라는 명을 가진 마지막 태그 호출
			        trHtml.after(addDriveBefText); //마지막 trQuestion명 뒤에 붙인다.
			    });
			    //삭제 버튼
			    $(document).on("click","button[name=delQuestion]",function(){
			        var trHtml = $(this).parent().parent();
			        trHtml.remove(); //tr 테그 삭제
			    });
			</script>	
			
			
			<div class="pageBtn contentBottomBtn">
					<div class="btnLeftBox">
						<input type="submit" value="수정" id="cusInputBtn">
					</div>
					<div class="btnCnterBox">
						<a href="stationList" class="bottomBtn bottomBtn-L">이전</a>
					</div>
				</div>
				
			</div>
		</div>
	</div>
</body>
</html>