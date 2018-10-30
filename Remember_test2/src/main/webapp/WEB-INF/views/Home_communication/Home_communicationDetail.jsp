<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


<style type="text/css">
.msgboxDiv{
    width: 880px;
    margin: 0 auto;
}
.msgboxDiv_kidList{
    width: 320px;
    margin: 43px auto 0 auto;    
}
</style>

	<jsp:include page="../include/menu_admin.jsp">
      <jsp:param name="pageInMenu" value="소통"  /> 
      <jsp:param name="pageCategory" value="가정통신문"  />
      <jsp:param name="pageTitle" value="가정통신문 상세정보"  /> 
   </jsp:include>
	<div class="page">
		<div class="page-wrapper">
			<div class="pageTitle"><h2>가정통신문 상세정보</h2></div>
			
			<div class="pageContent">
				<div class="Home_communicationDetail_Content">
				<div class="msgboxDiv"><div class="msgBox" id="msgBox"></div></div>
				
				<div id="layerWindow_p" class="layerWindow">
	               <span class="modalWindow"></span>
	               <div id="loginLayer" class="loginLayer loginTypeA">
	                  <div class="layerPopContent">
	                     <p>삭제 하시겠습니까?</p> 
	                     <input id="communicationId" type="hidden"/>
	                     <input type="button" class="btn_confirming_text" onclick="closeLayer2(1)" >
	                     <input type="button" class="btn_close_text" onclick="closeLayer2(0)" >
	                  </div>
	               </div>
		        </div>
				
					<div class="Home_communicationDetail_TopContent">
					<c:set value="${Home_communicationList}" var="Home_communicationInfo"/>
					<table>
						<tr>
							<td>제목</td>
							<td colspan="2"><input class="long_input3" type="text" id="Home_communicationDetail_title" readonly="readonly" value="${Home_communicationInfo[0].title}"></td>
							
							<td>종류</td>
							<td><input class="big_input" type="text" id="Home_communicationDetail_Kind" readonly="readonly" value="${Home_communicationInfo[0].tag_name}"></td>
						</tr>
						<tr>
							<td>확인/미확인</td>
							<td class="Home_communicationDetail_check" id="Home_communicationDetail_check"></td>
							<td>
								<img src="images/button/butten_OK_B.png" onclick="stateCheck()">
							</td>
						</tr>
					</table>	
					 <div  id ="kidsList" class="kidsList" style="display: none;">					
                     	<div class="kidsList_title">원아목록</div>
	                     <a href="#" onclick="canclebtn()" style="position: absolute;top: 10px;right: 19px;">X</a>                  
	                     <div class="kidsList_content">         
                           <c:forEach items="${Home_communicationFile_stateList}" var="Home_communicationFile_state" varStatus="vs">
                                 <c:forEach var="stateListDto" items="${Home_communicationFile_stateList}" varStatus="vs_1">
                                    <c:if test="${(stateListDto.kid_system_code eq Home_communicationFile_state.kid_system_code) and (stateListDto.state eq '미확인')}">
                                       <div class="kidsList_content_kid">                              
                                          <div>
                                          <label for="chk_kids${vs.index}" style="cursor: default;">                                 
                                          <c:choose>
                                             <c:when test="${empty Home_communicationFile_state.kid_pho}">
                                                <img src="images/image_ujacar_290x290.png" class="kidsList_content_kidImg">
                                             </c:when>
                                             
                                             <c:otherwise>
                                                <img src="${Home_communicationFile_state.kid_pho}" class="kidsList_content_kidImg">    
                                             </c:otherwise>
                                          </c:choose>                                                         
                                          ${Home_communicationFile_state.kid_name}</label>
                                          </div>                                                                                       
                                       </div>
                                    </c:if>
                                 </c:forEach>         
                           </c:forEach>
                           <div class="msgboxDiv_kidList"><div class="msgBox" id="msgBox_kidList"></div></div>
                    	 </div>   
   
                    	 <div style="text-align: center; width: 80px;height: 25px;margin: 12px auto;">
                        <img src="images/button/button_resand_80x25(x2).png" onclick="resend('${Home_communicationInfo[0].communication_id}')" style="width: 80px;height: 25px;border-radius: 0%;cursor: pointer;">
                     </div>         
                  </div>   				
					</div>					
					<div class="Home_communicationDetail_MiddleContent">
						<div class="Home_communicationDetail_image" id="Home_communicationDetail_image">
							<c:forEach items="${Home_communicationPicture_urlList}" var="Home_communicationPicture" varStatus="vs">
								<img src="${Home_communicationPicture.picture_url}">
							</c:forEach>								
						</div>
					
																			
						<div class="Home_communicationDetail_textarea" id="Home_communicationDetail_textarea">	   				  
							<p>${Home_communicationInfo[0].content}</p>			
						</div>
					</div>
					<div class="Home_communicationDetail_BottomContent">
						<label>파일첨부</label>
						<c:forEach items="${Home_communicationFile_urlList}" var="Home_communicationFile" varStatus="vs">						
							<div style="display: inline-block;"><a href="${Home_communicationFile.file_url}">${Home_communicationFile.file_title}</a></div>					
						</c:forEach>	
					</div>	
				</div>	
				<div class="contentBottomBtn">			
							<div class="btnLeftBox"><input type="button" class="btn_back" value="" onclick="history.back();"> <!-- 이전버튼 클릭 --></div>
							
							<div class="btnCnterBox centerDownBtn">
								<input type="button" class="btn_update" value="" onclick="location.href = 'Home_communicationUpdateForm?communication_id=' + encodeURIComponent('${Home_communicationInfo[0].communication_id}','UTF-8')"> <!-- 수정버튼 클릭 -->
								<input type="button" class="btn_delete" value="" onclick="DeleteClick('${Home_communicationInfo[0].communication_id}')"> <!-- 삭제버튼 클릭 -->
							</div>
								
							<div class="btnRightBox">
								
							</div>
				</div>				
	<%-- 		<p><a href="Home_communicationUpdateForm?communication_id=${Home_communicationInfo[0].communication_id}"class="bottomBtn bottomBtn-C">수정</a></p> --%>					
			</div>
		</div>
	</div>
	<jsp:include page="../include/footer.jsp"/>
	<script type="text/javascript">
	var resend_count;
	$(document).ready(function(){
		var check_count_all = 0  ;
		var check_count_ok = 0  ;
		var check_count_no = 0  ;
		resend_count = 0;
		<c:forEach var="stateList" items="${Home_communicationFile_stateList}" varStatus="vs">
			if("${stateList.state}"=="미확인"){
				check_count_no++;
			}
			else if("${stateList.state}"=="확인"){
				check_count_ok++;
			}
		</c:forEach>
		
		$("#Home_communicationDetail_check").text(check_count_ok+"/"+check_count_no);
	});	
	
	
	function stateCheck(){		
		$('#kidsList').css('display','block');
	}
	
	function stateOK(){		
		$('#kidsList').css('display','none');
	}
	
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	function DeleteClick(communication_id) {	
		document.getElementById('msgBox').style.display="none";
		$('#layerWindow_p').css('display','block');
		$("#communicationId").val(communication_id);		
	}
	
   function closeLayer2(obj){ 
	   var Home_communicationListId = $("#communicationId").val();
	   
	      if(obj==1){	
    		$.ajax({  
                url : 'home_communication_Delete',
                dataType : 'json',
                type:'POST',
                data : { "communication_id" : Home_communicationListId},              
                success: function(result) { 
                	location.replace("Home_communicationList");
                },
                beforeSend: function(xhr) {
    	              xhr.setRequestHeader(header, token);
    	           },
                error:function(request,status,error){   
                	$('#msgBox').removeClass("msgBox_Success");
    	           	$('#msgBox').addClass("msgBox_Error");
                	$('#msgBox').html("<span>삭제 실패 했습니다.</span>");
                	document.getElementById('msgBox').style.display="block";
                	document.getElementById('layerWindow_p').style.display='none';
                }
             
            });
	      }
	      else{
	    	  document.getElementById('layerWindow_p').style.display='none';
	      }
   }
	
	function canclebtn() {
		document.getElementById("kidsList").style.display = "none";
		$('#msgBox_kidList').removeClass("msgBox_Error");
    	$('#msgBox_kidList').removeClass("msgBox_Success");
      	document.getElementById('msgBox_kidList').style.display="none";
	}//
	
	function resend(communication_id){
		if(resend_count<1){
			$.ajax({  
	            url : 'home_communication_resend',
	            dataType : 'json',
	            type:'POST',
	            data : {"communication_id" : communication_id},              
	            success: function(result) {         	
	            	if(result.sendCheck){            		
	                	$('#msgBox_kidList').removeClass("msgBox_Error");
	                	$('#msgBox_kidList').addClass("msgBox_Success");
	                	$('#msgBox_kidList').html("<span>재전송 했습니다.</span>");
	      	        	document.getElementById('msgBox_kidList').style.display="block";
	      	        	resend_count++;
	            	}
	            	else{
	            		$('#msgBox_kidList').removeClass("msgBox_Success");
	    	           	$('#msgBox_kidList').addClass("msgBox_Error");
	                	$('#msgBox_kidList').html("<span>재전송 실패 했습니다.</span>");
	                	document.getElementById('msgBox_kidList').style.display="block";
	            	}
	            },
	            beforeSend: function(xhr) {
		              xhr.setRequestHeader(header, token);
		           },
	            error:function(request,status,error){   
	            	$('#msgBox_kidList').removeClass("msgBox_Success");
		           	$('#msgBox_kidList').addClass("msgBox_Error");
	            	$('#msgBox_kidList').html("<span>재전송 실패 했습니다.</span>");
	            	document.getElementById('msgBox_kidList').style.display="block";
	            }	         
	        });			
		}
		else{
			$('#msgBox_kidList').removeClass("msgBox_Success");
           	$('#msgBox_kidList').addClass("msgBox_Error");
        	$('#msgBox_kidList').html("<span>재전송은 1번만 가능합니다.</span>");
        	document.getElementById('msgBox_kidList').style.display="block";
		}
		
	}//
	
	
	</script>
	
