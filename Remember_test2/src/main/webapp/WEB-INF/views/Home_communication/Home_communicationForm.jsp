<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<style type="text/css">
	#Home_communicationForm_title-error{color: #fff}
	#Home_communicationForm_Kinds-error{color: #fff}
	#Home_communicationForm_class-error{color: #fff}
.msgboxDiv{
    width: 880px;
    margin: 0 auto;
}
</style>

<jsp:include page="../include/menu_admin.jsp">
      <jsp:param name="pageInMenu" value="소통"  /> 
      <jsp:param name="pageCategory" value="가정통신문"  />
  <jsp:param name="pageTitle" value="가정통신문작성"  />
   </jsp:include>
	<div class="page">
		<div class="page-wrapper">
			<div class="pageTitle">
				<h2>가정 통신문 작성</h2>								
			</div>	
			
			<div class="pageContent">
			<div class="msgboxDiv"><div class="msgBox" id="msgBox"></div></div>
				<form id="Home_communicationInsert" action="Home_communicationInsert" name="Home_communicationInsert" method="post" onkeydown="if(event.keyCode==13){event.returnValue=false;}" enctype="multipart/form-data">					
					<div class="Home_communicationForm_Content">
						<div class="Home_communicationForm_TopContent"><!-- 제목, 종류,미리보기 버튼  -->
							<label for="Home_communicationForm_title">제목</label><input type="text" class="long_input2 Home_communicationForm_title" id="Home_communicationForm_title" name="title" placeholder="제목을 입력해주세요.">					
							<label for="Home_communicationForm_Kinds">종류</label>
							<select id="Home_communicationForm_Kinds" class="middle_select Home_communicationForm_Kinds" name="tag_id">
								<option value="">종류선택</option>
								<c:forEach items="${tag_list}" var="Home_communicationDto" varStatus="vs">						
							   		 <option value="${Home_communicationDto.tag_id}">${Home_communicationDto.tag_name}</option>					    
								</c:forEach>					    
							</select>
							<label for="Home_communicationForm_class">반 선택</label>
							<select id="Home_communicationForm_class"  class="middle_select Home_communicationForm_class" name="class_id">
								<option value="">반선택</option>
								<c:forEach items="${class_list}" var="Home_communication_classDto" varStatus="vs">						
							   		 <option value="${Home_communication_classDto.class_id}">${Home_communication_classDto.class_name}</option>					    
								</c:forEach>	
								<option value="All">전체</option>				    
							</select>
							<img src="images/button/button_preview_90x25(x2).png" onclick="Preview_Click()">							
						</div>
						
						<div id="Home_communicationForm_Preview">
							<div class="Preview_Title">
								가정통신문 내용
							</div>
							<div class="Preview_Content">
							<c:set value="${staffInfo[0]}" var="staffdto"/>
								<div class="Preview_Content_Teacher">		
									<table>
										<tr>
											<td rowspan="2">
												<c:choose>
													<c:when test="${empty staffdto.staff_phot}">
														<img src="images/image_ujacar_290x290.png">
													</c:when>
													<c:otherwise>
														<img src="${staffdto.staff_phot}">
													</c:otherwise>
												</c:choose>	
											</td>
											<th>${staffdto.staff_name}</th>
										</tr>
										<tr>
											<%
												Date date = new Date();	    
											    Calendar cal = Calendar.getInstance();	    
											    cal.setTime(date);
// 											    int num = cal.get(Calendar.DAY_OF_WEEK); 											    
// 											    cal.add(Calendar.DATE, -num);
											    SimpleDateFormat sdf = new SimpleDateFormat("yyyy년MM월dd일");
											    String today = sdf.format(cal.getTime());  
											%>
											<td><%=today %></td>
										</tr>
									</table>
								</div>
								<div class="Preview_Content_Title">
									
								</div>
								<div id="Preview_Content_Img" class="Preview_Content_Img">
<!-- 									<img src="images/image_ujacar_290x290.png"> -->
								</div>
								<div class="Preview_Content_Content">
									
								</div>
								<div class="Preview_Content_File">
									<div class="Preview_Content_File_Icon"><img src="images/image_ujacar_290x290.png"></div>
									<div class="Preview_Content_File_Title"></div>
								</div>
							</div>
							<img class="Preview_Content_Ok" src="images/button/button_ok_80x25(x2).png" onclick="Ok_Click()">
						</div>
						
						<div class="Home_communicationForm_MiddleContent">
							<div id="ImageChoose" class="ImageChoose">
									<img src="images/button/button_imagefile_200x27(x2).png" class="file_input_img_btn" />
									<input type='file' class="Home_communicationForm_imgfile file_input_hidden" id="Home_communicationForm_imgfile" 
									name='picture' accept='image/jpeg,image/gif,image/png' onchange="filePlus(this)" multiple>
							</div>
							<div id="Home_communicationForm_image" class="Home_communicationForm_image">										
								<div id="holder" class="holder"></div>					
							</div>
						
																				
							<div id="Home_communicationForm_textarea" class="Home_communicationForm_textarea">	   				  
								<textarea id="Home_communicationForm_textarea_content" name="content" placeholder = "여기에 입력해주세요"></textarea>				
							</div>
						</div>
						<div class="Home_communicationForm_BottomContent"><!-- 파일 첨부, 버튼  -->
							<label for="fileName">파일 첨부</label>
							<input type="text" id="fileName" name="fileName" class="Homefile_input_textbox" readonly >
							<div class="file_input_div">
							    <img src="images/button/button_folder_54x54 (x2).png" class="Homefile_input_img_btn" />
							    <input type='file' class="Home_communicationForm_hwpfile Homefile_input_hidden" id="Home_communicationForm_hwpfile" 
								name="file" accept="application/haansofthwp" onchange="hwpPlus(this)" multiple>
							</div>															
 
						</div>
						<div class="pageBtn contentBottomBtn">
							<div class="btnLeftBox">
							</div>
							<div class="btnCnterBox">
								<input type="submit" id="Home_communicationForm_submit" value="" class="btn_send_text">
								<input type="button" id="Home_communicationForm_cancel" value="" class="btn_cancel_text" onclick="history.back();">
							</div>
							<div class="btnRightBox">
							</div>
						</div>
						<input type="hidden" name="${_csrf.parameterName}" id="csrf" value="${_csrf.token}" />
					</div>
				</form>
			</div><!-- content -->
		</div><!-- page-wrapper -->
	</div><!-- page -->
	<jsp:include page="../include/footer.jsp"/>
<script>
var token = $("meta[name='_csrf']").attr("content");
   var header = $("meta[name='_csrf_header']").attr("content");
   
$(function() {			
	 $.validator.addMethod("regex", function(value, element, regexpr) {  
	     return regexpr.test(value);
	   });			 

	$("#Home_communicationInsert").validate({
		errorClass: "validFail",
		validClass: "validSuccess",
		onfocusout: false,
		onkeyup: false,
		
	    rules: {
	    	title : {
	    		required: true,	    							    		
	    		regex: /^[가-힣\s|a-z|A-Z|0-9]{2,30}$/			    		
	    	},
	    	tag_id : {
	    		required: true
	    	},
	    	class_id : {
	    		required: true
	    	}
	    },			    

	    messages: {
	    	title: {
	            required: "제목을 입력해주세요.",
	            regex : "제목은 최소2자 이상 30자 이하 만 가능 합니다."			    		
	        },
	    	tag_id : {
	    		required: "종류를 선택해주세요."
	    	},
	    	class_id : {
	    		required: "반을 선택해주세요."
	    	}
	    },		    
	    success: function(label) {
//                label.addClass("validSuccess").text("정상입니다.");		   		
	    },
	    invalidHandler: function(form, validator){ //입력값이 잘못된 상태에서 submit 할때 호출
			var errors = validator.numberOfInvalids();
			if (errors) {						
				validator.errorList[0].element.focus();
// 				console.log(validator.errorList[0].message);
				$('#msgBox').empty();	        	
	        	$('#msgBox').removeClass("msgBox_Success");
	        	$('#msgBox').addClass("msgBox_Error");
	        	$('#msgBox').html(validator.errorList[0].message);
	        	document.getElementById('msgBox').style.display="block";
			} 
		},
		errorPlacement: function(error, element)
	    {	
	     
	    }
	});	
});
</script>
<!-- 중복 확인 /등록 클릭 -->

<script>
	function binaryStringToArrayBuffer(binary) {
	    var length = binary.length;
	    var buf = new ArrayBuffer(length);
	    var arr = new Uint8Array(buf);
	    for(var i=0;i<length;i++) {
	        arr[i] = binary.charCodeAt(i);
	    }
	    return buf;
	}
	
	function base64StringToBlob(base64) {
	    var type = base64.match(/data:([^;]+)/)[1];
	    base64 = base64.replace(/^[^,]+,/g, '');
	    var options = {};
	    if (type) {
	        options.type = type;
	    }
	    var binaryArrayBuffer = [ binaryStringToArrayBuffer(window.atob(base64)) ];
	    return new Blob(binaryArrayBuffer, options);
	}

	var check_file = true;
	function filePlus(this_obj){
		var x = document.getElementById("Home_communicationForm_imgfile");
		var txt = "";
		if ('files' in x) {
		    if (x.files.length > 3) {
		    	$('#msgBox').removeClass("msgBox_Success");
		        $('#msgBox').addClass("msgBox_Error");
            	$('#msgBox').html("<span>파일 개수가 초과되었습니다.</span>");
            	document.getElementById('msgBox').style.display="block";
		        document.getElementById("Home_communicationForm_imgfile").value = "";
		        $("#holder").empty();
		        $("#Preview_Content_Img").empty();
		        return false;
		    }
		}
		
		
		holder.innerHTML = '';
		Preview_Content_Img.innerHTML = '';
		
		var file_kind = this_obj.value.lastIndexOf('.');
		var file_name = this_obj.value.substring(12,this_obj.length);
		var file_type = file_name.toLowerCase();

// 		var upload = document.getElementById('Home_communicationForm_imgfile'),
	    holder = document.getElementById('holder');
	    Preview_Content_Img = document.getElementById('Preview_Content_Img');
	
		
		var check_file_type = new Array();
		check_file_type = ['jpg','gif','png','jpeg','bmp'];	
	
		
		 var files = event.target.files;
		 
		 for(var i = 0; i< files.length; i++)
	     {	 			
			 var file = this_obj.files[i];		

			 if(check_file_type.indexOf(file.type.substring((file.type.lastIndexOf('/'))+1,file.type.length))==-1){	
				 
// 				 var parent_Obj=this_obj.parentNode
// 				 var node=parent_Obj.replaceChild(this_obj.cloneNode(true),this_obj);				
				 check_file = false;
				}			
	     }	
		
		 if(!check_file){
			 $('#msgBox').removeClass("msgBox_Success");
			 $('#msgBox').addClass("msgBox_Error");
         	 $('#msgBox').html("<span>이미지만 넣어주세요!!</span>");
         	 document.getElementById('msgBox').style.display="block";
			 $("#holder").empty();
			 $("#Preview_Content_Img").empty();
			 event.target.value = null;
			 check_file = true;
			
 			 return false;
		 }
		 else{
			 
			 for(var i = 0; i< files.length; i++)
		     {	
				 var file = this_obj.files[i];		
				 
				 var reader = new FileReader();	
				 
				 reader.addEventListener("load", function () {	
						var image = new Image();
						var base64 = this.result;

				        image.width = 400;
// 				        image.height = 200; 
				        image.title = file_name;
				        image.src = window.URL.createObjectURL(base64StringToBlob(base64));
				        image.className = "file_image";
				        holder.appendChild( image );
				        
				        var image1 = new Image();
				        image1.width = 276;
// 				        image1.height = 293; 
				        image1.title = file_name;
				        image1.src = window.URL.createObjectURL(base64StringToBlob(base64));
// 				        image1.className = "file_image";
				        Preview_Content_Img.appendChild( image1 );
				        
				      }, false);					 
					reader.readAsDataURL(file);
		     }
		 }
		 

		if (typeof window.FileReader == 'undefined') {

		}//실패
		else {
			
		}//성공
		 
	}
	
	function hwpPlus(this_obj){
		var x = document.getElementById("Home_communicationForm_hwpfile");
		var txt = "";
		if ('files' in x) {
		    if (x.files.length > 1) {
		        $('#msgBox').addClass("msgBox_Error");
	         	$('#msgBox').html("<span>파일 개수가 초과되었습니다.</span>");
	         	document.getElementById('msgBox').style.display="block";
		        document.getElementById("Home_communicationForm_hwpfile").value = "";
		        return false;
		    }
		}
		
	
		
		var file_kind = this_obj.value.lastIndexOf('.');
		var file_name = this_obj.value.substring(12,this_obj.length);
		var file_type = file_name.toLowerCase();
		
		
		var check_file_type = new Array();
		check_file_type = ['haansofthwp'];//
		
		var files = event.target.files;
		 

		document.getElementById('fileName').value = file_name;
		 
		 for(var i = 0; i< files.length; i++)
	     {	 			
			 var file = this_obj.files[i];		
			 if(check_file_type.indexOf(file.type.substring((file.type.lastIndexOf('/'))+1,file.type.length))==-1){	
				 $('#msgBox').addClass("msgBox_Error");
		         $('#msgBox').html("<span>한글문서만 넣어주세요</span>");
		         document.getElementById('msgBox').style.display="block";
		         document.getElementById('fileName').value = null;
				 event.target.value = null;
				}			
	     }	
	}
	
	function Preview_Click(){		
		$('.Preview_Content_Title').text($('#Home_communicationForm_title').val());
		$('.Preview_Content_Content').text($('#Home_communicationForm_textarea_content').val());
		
		if($('#fileName').val()==null||$('#fileName').val()==''){
			$('.Preview_Content_File_Title').text("파일이 없습니다.");
		}else{
			$('.Preview_Content_File_Title').text($('#fileName').val());
		}
		$('#Home_communicationForm_Preview').css('display','block');
	}
	function Ok_Click(){
		$('#Home_communicationForm_Preview').css('display','none');
	}
	
</script>
