<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<jsp:include page="../include/menu_admin.jsp">
	<jsp:param name="pageInMenu" value="기기관리" />
	<jsp:param name="pageCategory" value="A/S신청" />
	<jsp:param name="pageTitle" value="" />
</jsp:include>

<%-- <c:set value="${detailCenter}" var="dto_c"/> --%>
<div class="page">
	<div class="page-wrapper">
		<div class="pageTitle">
			<h2>A/S신청</h2>
		</div>
		
		<div class="pageContent asform" id="pageContent">
			<div class="msgBox" id="msgBox"></div>
			<div id="layerWindow" class="layerWindow">
				
				<span class="modalWindow"></span>
				<div id="loginLayer" class="loginLayer2 loginTypeA">
					<div class="layerPopContent" id="layerPopContent">
						<div class="msgBox_Popup" id="msgBox_Popup"></div> 
						<center>기기찾기</center>
						<div class="equipSearchBox">
							<input type="text" name="keyWord" id="keyWord">
							<input type="button" value="" id="searchBtn">
						</div>
						<div class="findInfoBox">
							<div class="findInfoTitle">
								기기명
							</div>
							<div class="findInfo" >
								<table id="findInfoTable">
								</table>
							</div>
						</div>
						<input type="hidden" name="bus_id" id="bus_id" value="${dto_k[0].bus_id}">
						<input type="button" onclick="closeLayer(1)" value="" class="btn_close_text">
					</div>
				</div>
			</div>
			
			<div class="ASsign textAlign-C">
				 작성된 내용은 경성테크놀러지(아티유자)로 메일이 전송됩니다.<br>
			</div>
			<div class="asBox textAlign-C" id="asBox">
				<div class="container textAlign-C" id="container">
					<form action="sendMail" method="post" name="sendMail" id="sendMail"onkeydown="if(event.keyCode==13){event.returnValue=false;}"
	 enctype="multipart/form-data">
						<table>
							<tr>
								<th>분류</th>
								<td>
									<select name="equipment_type" id="equipment_type" class="input216_27" onchange="asKindsSelect()">
										<option value="">분류를 선택 해 주세요.
										<option value="게이트웨이">게이트웨이
										<option value="비콘">비콘
										<option value="테블릿">테블릿
										<option value="기타">기타
									</select> 
								</td>
								<td>
									<label id="equipment_type-error" class="validFail" for="equipment_type"></label>								
								</td>
							</tr>
							<tr>	
								<th></th>
								<td>
									<input type="text" name="damege_type" id="damege_type" class="bg_Gray input216_27" readonly="readonly">
									<input type="button" value="" name="findBtn" id="findBtn" class="btn_find" onclick="find_Equipment()"> 
								</td>
								<td>
									<label id="damege_type-error" class="validFail" for="damege_type"></label>								
								</td>
							</tr>
							<tr>
								<th>제조사</th>
								<td><input type="text" name="equipment_com" id="equipment_com" class="input216_27" value="경성"> </td>
							</tr>
							<tr>
								<th>내용</th>
								<td>
									<textarea rows="" cols="" name="damege_reason" id="damege_reason" class="text400_70">
									
									</textarea>
								</td>
								<td>
									<label id="damege_reason-error" class="validFail" for="damege_reason"></label>								
								</td>
							</tr>
							<tr>
								<th>첨부사진</th>
								<td>
<!-- 									<input type="text" id="damege_photo" name="damege_photo" class="input216_27"> -->
									<input type="file" onchange="filePlus(this)" name="damege_photo_url" id="damege_photo_url" multiple class="inputFile216_27">
<!-- 									<input type="button" value="" class="btn_addFile" id="addFile"> -->
								</td>
								<td>
									<label id="damege_photo_url-error" class="validFail" for="damege_photo_url"></label>								
								</td>
							</tr>
						</table>
						
						<div align="center">
							<input type="submit" value="" class="btn btn-warning btn_done"> <!-- onclick="sendEmail()" -->
						</div>
						<input type="hidden" name="${_csrf.parameterName}" id="csrf" value="${_csrf.token}" />
					</form>
				</div>
			</div>
		</div>

	</div>
</div>
<jsp:include page="../include/footer.jsp"/>



<script type="text/javascript">
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
function asKindsSelect(){
	var selectKind = $("#equipment_type option:selected").val();
	console.log("selectKind:"+selectKind);
	if(selectKind=="기타"){
		$("#findBtn").attr('disabled', true);
		$("#damege_type").val("");
	}
	else{
		$("#findBtn").attr('disabled', false);
		find_Equipment();
	}
	
}
function find_Equipment(){
	var selectKind = $("#equipment_type option:selected").val();		
	
	console.log("selectKind:"+selectKind);
	if(selectKind==''){				//기기종류를 선택 해주세요 상태일 때
		$('#msgBox').addClass("msgBox_Error");	
		$('#msgBox').html("<span>파손물품 종류를 선택 해 주세요.</span>");
		document.getElementById('msgBox').style.display="block";
	}else{
		document.getElementById('msgBox').style.display="none";
		$('#layerWindow').css('display','block');
		document.getElementById('msgBox_Popup').style.display="none";
		
		var equipment_type = $("#equipment_type").val();
		var equipment_kind ="";
		
		if(equipment_type=="비콘"){equipment_kind="beacon";}
		else{equipment_kind="equipment";}
		console.log("equipment_type"+equipment_type);
		
		$.ajax({
			type : "POST",
			url : "findAllEquipment",
			data : { "equipment_type" : equipment_type,"equipment_kind":equipment_kind},
			beforeSend: function(xhr) {
	              xhr.setRequestHeader(header, token);
	        },
			success : function(data) {
				$("#findInfoTable").empty();
				
				var size_data="";
				if(equipment_type=="비콘"){
					size_data=data.equi_List;
// 					console.log("if : "+data.equi_List[20].beacon_id);
					for(var i=0; i<size_data.length; i ++){
						var beacon_name = data.equi_List[i].beacon_id.split('_');
			        	console.log("beacon_name:"+beacon_name);
	               	 $("#findInfoTable")
	               	 .append("<tr><td width=57>"+beacon_name[2]+"-"+beacon_name[3]+"</td>"
	               			 +"<td>"+data.equi_List[i].beacon_id+"</td>"
	               			 +"<td onclick=\"event.cancelBubble = true;\"><input  type=\"button\" id=\"equipmentSelect\" class='btn_choice_text' value=\"\" onclick=\"equipmentSelect(\'"+data.equi_List[i].beacon_id+"\')\"</td></tr>");
	                } 
				}
				else{
					console.log("test");
					size_data=data.equi_List;
					for(var i=0; i<size_data.length; i ++){
						var equip_name = data.equi_List[i].equipment_id.split('_');
		            	console.log("equip_name:"+equip_name);
	               	 $("#findInfoTable")
	               	 .append("<tr><td width=57>"+equip_name[2]+"-"+equip_name[3]+"</td>"
	               			 +"<td>"+data.equi_List[i].equipment_id+"</td>"
	               			 +"<td onclick=\"event.cancelBubble = true;\"><input  type=\"button\" id=\"equipmentSelect\" class='btn_choice_text' value=\"\" onclick=\"equipmentSelect(\'"+data.equi_List[i].equipment_id+"\')\"</td></tr>");
	                } 
				}
			},
			error : function(xhr, txtStatus, errorThrown) {
				alert("error" + errorThrown);
			}
		});
	}
	
	
}
function closeLayer(obj){
	document.getElementById('layerWindow').style.display='none';	
}	
function equipmentSelect(equId){
	$("#damege_type").val(equId);
	console.log("equipmentSelect");
	document.getElementById('layerWindow').style.display='none';
}
function sendEmail(){
	console.log("sendEmail");
	 var queryString = $("#sendMail").serialize() ;

	$.ajax({
		type : "POST",
		url : "sendMail",
		data : queryString,
		beforeSend: function(xhr) {
              xhr.setRequestHeader(header, token);
           },
		success : function(data) {
			console.log("test");
// 			window.location.reload();
// 				setInterval('autoRefresh_div()', 3000);
			$('#pageContent').load('mailForm #container');
			$('#msgBox').addClass("msgBox_Success");	
    		$('#msgBox').html("<span>A/S 신청이 되었습니다.</span>");
    		document.getElementById('msgBox').style.display="block";
    		
    		document.getElementById('sendEmail').submit();
			
		},
		error : function(xhr, txtStatus, errorThrown) {
			alert("error" + errorThrown);
		}
	});
}
$("#searchBtn").click(function(){		
	var selectKind = $("#equipment_type option:selected").val();		//어떤게 선택 됬는지
	console.log("selectKind:"+selectKind);
	var keyword = $.trim($("#keyWord").val());
	var equiptment_kind;
	
	if(keyword==''){
		$('#msgBox_Popup').addClass("msgBox_Error");	
		$('#msgBox_Popup').html("<span>키워드를 입력 해 주세요.</span>");
		document.getElementById('msgBox_Popup').style.display="block";
	}else{
		if(selectKind=="비콘"){					//찾는게 비콘일 경우
			equipment_kind="beacon";
		
			$.ajax({  
		    	url : 'BeaconSearch',
		        dataType : 'json',
		        type:'POST',
		        data : { "keyWord" : keyword ,"equipment_type":$("#equipment_type").val()},
		        beforeSend: function(xhr) {
			    	xhr.setRequestHeader(header, token);
			    },
		        // data : $('#msg').serializeArray(),
		        success: function(data) {           	   
			        $("#equiTable tr").remove(); 
			        var size_data=data.beaconResult;
			        for(var i=0; i < size_data.length; i ++){
			        	var beacon_name = data.beaconResult[i].beacon_id.split('_');
			        	console.log("beacon_name:"+beacon_name);
			     		$("#findInfoTable")
			     		.html("<tr><td width=57>"+beacon_name[2]+"-"+beacon_name[3]+"</td>"
			     			 +"<td>"+data.beaconResult[i].beacon_id+"</td>"
		              		 +"<td onclick=\"event.cancelBubble = true;\">"
		              		 +"<input  type=\"button\" id=\"equipmentSelect\" class='btn_choice_text' value=\"\" onclick=\"equipmentSelect(\'"+data.beaconResult[i].beacon_id+"\')\"</td>"
		              		 +"</tr>");
			        }
		        },
		        error:function(request,status,error){                 
		        	alert("code:"+request.status+"\n"+"error:"+error);
		        }
			});
		}
		else{									//찾는게 테블릿, 게이트웨이일 경우
			equipment_kind="equipment";
			console.log("equipment_kind:"+equipment_kind);
			$.ajax({  
		    	url : 'EquipmentSearch',
		        dataType : 'json',
		        type:'POST',
		        data : { "keyWord" : keyword ,"equipment_type":selectKind},
		        beforeSend: function(xhr) {
			    	xhr.setRequestHeader(header, token);
			    },
		        // data : $('#msg').serializeArray(),
		        success: function(data) {           	   
		           	         	
		        $("#equiTable tr").remove(); 
		        	var size_data=data.equipmentResult;
		            for(var i=0; i < size_data.length; i ++){
		            	var equip_name = data.equipmentResult[i].equipment_id.split('_');
		            	console.log("equip_name:"+equip_name);
		            $("#findInfoTable")
		     		.html("<tr><td width=57>"+equip_name[2]+"-"+equip_name[3]+"</td>"
		     			 +"<td>"+data.equipmentResult[i].equipment_id+"</td>"
	              		 +"<td onclick=\"event.cancelBubble = true;\">"
	              		 +"<input  type=\"button\" id=\"equipmentSelect\" class='btn_choice_text' value=\"\" onclick=\"equipmentSelect(\'"+data.equipmentResult[i].equipment_id+"\')\"</td>"
	              		 +"</tr>");
		            }
		        },
		        error:function(request,status,error){                 
		        	alert("code:"+request.status+"\n"+"error:"+error);
		        }
			});
		}	
	}
	
	
});

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
<script>
$(function() {				
	 $.validator.addMethod("regex", function(value, element, regexpr) {          
	     return regexpr.test(value);
	   });	 
	 var token = $("meta[name='_csrf']").attr("content");
	 var header = $("meta[name='_csrf_header']").attr("content");
	    
	$("#sendMail").validate({
		errorClass: "validFail",
		validClass: "validSuccess",
		ignore : "",
		onfocusout: false,
		onkeyup: false,
	    rules: {
	    	equipment_type: {
	    		required: true
	    	},
	    	damege_reason: {
	    		required: true
	    	},
	    	damege_photo_url: {
	    		required: true
	    	}
	    },			    

	    messages: {
	    	equipment_type: {
	    		required: "분류를 선택 해 주세요."
	        },
	    	damege_reason: {
	    		required: "내용 입력 해 주세요."
	    	},
	    	damege_photo_url: {
	    		required: "사진을 첨부 해 주세요."
	    	}
	    },		    
	    success: function(label) {
             label.addClass("validSuccess").text("");
	    },
	    invalidHandler: function(form, validator){ //입력값이 잘못된 상태에서 submit 할때 호출
			var errors = validator.numberOfInvalids();
			if (errors) {						
				validator.errorList[0].element.focus();
			} 
		}
	});	
});
</script>   
