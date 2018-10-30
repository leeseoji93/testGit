<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
	<jsp:include page="../include/menu_admin.jsp">
		<jsp:param name="pageInMenu" value="기기관리"  />
		<jsp:param name="pageCategory" value="테블릿&게이트웨이"  />
		<jsp:param name="pageTitle" value="설치수정"  /> 
	</jsp:include>
<c:set value="${data}" var="dto_k"/>	
<div class="page">
	<div class="page-wrapper">
		<div class="pageTitle"><h2>설치 수정</h2></div>
	
		
		<div class="pageContent ">
			<form action="installEqu_UpdateSave" method="post" id="installEqu_UpdateSave" name="installEqu_UpdateForm" onkeydown="if(event.keyCode==13){event.returnValue=false;}"
	 enctype="multipart/form-data">
	 		<div class="installEquipmentUpdate_Content">
	 			<div class="installEquipmentDetail_Content_img" id="holder">
					<img src="${dto_k[0].equipment_install}">
				</div>
				
				<div class="installEquipmentDetail_Content_table">
					<table>
						<tr>
							<th>${dto_k[0].equipment_type}<input type="hidden" class="big_input" name="equipment_type" id="equipment_type" value="${dto_k[0].equipment_type}"></th>
							<td></td>
						</tr>
<!-- 						<tr> -->
<!-- 							<th>사진</th> -->
<!-- 							<td><input type="file" class="big_input" name="equipment_install_url" id="equipment_install_url" multiple class="inputFile216_27" onchange="filePlus(this)"> </td> -->
<!-- 						</tr> -->
						<tr>
							<th>기기명</th>
							<td>${dto_k[0].equipment_name}</td>
						</tr>
						<tr>
							<th>설치위치</th>
							<td>
								<select class="big_select" id="equipment_install_loc" name="equipment_install_loc">
									<c:forEach items="${carList}" var="dto" varStatus="s">	
							   			<option value="${dto.bus_name}">${dto.bus_name}										   									
									</c:forEach>	
								</select>	
							</td>
						</tr>
						<tr>
							<th>설치자</th>
							<td>
								<select class="big_select" id="equipment_install_man" name="equipment_install_man">
									<option value="${dto_k[0].equipment_install_man}">${dto_k[0].equipment_install_man}
									<c:forEach items="${staffList}" var="dto" varStatus="s">	
							   			<option value="${dto.staff_id}">${dto.staff_name}										   									
									</c:forEach>	
								</select>
							</td>
						</tr>
						<tr>
							<th>설치일</th>
							<td><input type="text" class="big_input bg_Gray" name="equipment_install_date" id="equipment_install_date" value="${dto_k[0].INSTALLDATEFORMAT}" readonly="readonly"></td>
						</tr>
					</table>
				
				</div>
	 		</div>
	 		
			
			<input type="hidden" name="equipment_id" id="equipment_id" value="${dto_k[0].equipment_id}" />
			<input type="hidden" name="${_csrf.parameterName}" id="csrf" value="${_csrf.token}" />
			<div class="pageBtn contentBottomBtn">
				<div class="btnLeftBox">
					<input type="button" value="" class="btn_back" id="cusInputBtn2" onclick="history.back();"> <!-- 이전버튼 클릭 -->
				</div>
				<div class="btnCnterBox">
					<input type="submit" value="" id="cusInputBtn" class="customD"/>
							  				
		  		</div>
		  		<div class="btnRightBox">
		  			<input type="button" value="" id="cusInputBtn" class="customM" onclick="location.href='installEquipmentList'"/>		
		  		</div>
	  		</div>	
	  		
			</form>
		</div>
	</div>
</div>
<script type="text/javascript">
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
$(document).ready(function(){	
	var type= "${dto_k[0].equipment_type}";
	if(type=="게이트웨이"){
		console.log("게이트웨이");
		$("#equipment_install_loc").append("<option value='원 입구'>원 입구</option>");	
	}
	
	 
	$("#equipment_install_loc").val("${dto_k[0].equipment_install_loc}").prop("selected", true);
	
	
	
});	
function info(){
	$('#layerWindow').css('display','block');

	var busId = $('#bus_id').val();
	console.log("busId:"+busId);
	
	$.ajax({
		type : "get",
		url : "CarDetailInfo",
		data : { "num" : busId},
		beforeSend: function(xhr) {
              xhr.setRequestHeader(header, token);
           },
		success : function(data) {
			console.log("test");
//				setInterval('autoRefresh_div()', 3000);
			 var e = $(data).find('table');
// 			 var refine = $("#layerPopContent").html(data).find('.pageTitle');
			 console.log("e:"+e);
			 $('#findInfo').html(e);
// 			$('#layerPopContent').html(data.list[0].bus_name);
//				$('#msgBox').addClass("msgBox_Success");	
//	    		$('#msgBox').html("<span>삭제 되었습니다.</span>");
//	    		document.getElementById('msgBox').style.display="block";
		},
		error : function(xhr, txtStatus, errorThrown) {
			alert("error" + errorThrown);
		}
	});
	
}

function closeLayer(obj){
	document.getElementById('layerWindow').style.display='none';	
}	
	
</script>		

<script type="text/javascript">
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
   holder.innerHTML = '';
   
   var file_kind = this_obj.value.lastIndexOf('.');
   var file_name = this_obj.value.substring(file_kind+1,this_obj.length);
   var file_type = file_name.toLowerCase();
   
//    var upload = document.getElementById('Home_communicationForm_imgfile'),
    holder = document.getElementById('holder'),
    state = document.getElementById('status');

   
   var check_file_type = new Array();
   check_file_type = ['jpg','gif','png','jpeg','bmp'];   

   
    var files = event.target.files;
    
    for(var i = 0; i< files.length; i++)
     {             
       var file = this_obj.files[i];      

       if(check_file_type.indexOf(file.type.substring((file.type.lastIndexOf('/'))+1,file.type.length))==-1){   
          
//           var parent_Obj=this_obj.parentNode
//           var node=parent_Obj.replaceChild(this_obj.cloneNode(true),this_obj);            
          check_file = false;
         }         
     }   
   
    if(!check_file){
      alert("이미지만 넣어주세요!!");
       $("#holder").empty();
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

                 image.width = 260;
                 image.height = 200; 
                 image.title = file_name;
                 image.src = window.URL.createObjectURL(base64StringToBlob(base64));
                 image.className = "file_image";
                 holder.appendChild( image );
                
               }, false);                
            reader.readAsDataURL(file);
        }
    }
    

   if (typeof window.FileReader == 'undefined') {
//      state.className = 'fail';
//      state.innerHTML = 'fail';
   }   
   else {
//      state.className = 'success';
//      state.innerHTML = 'success';
   }
    
}
</script>				
</body>
</html>