<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set value="${detailBeacon}" var="dto_c"/>
<h3>상세 정보 수정</h3>
<form name="beaconUpdateSave" id="beaconUpdateSave" action="beaconUpdateSave" method="post" onkeydown="if(event.keyCode==13){event.returnValue=false;}"
	 enctype="multipart/form-data">
<table id="ClassListTable_Equi_u" class="Table_Align_C">
	<tr>
		<td colspan="2">
			<div class="thumbnail-wrapper">
				<div class="thumbnail">
					<div class="centered" id="holder">
					</div>
				</div>
			</div>
		</td>
	</tr>
	
	<tr align="left">
		<th>기기명</th>
	</tr>
	<tr align="right">
		<td><input type="text" class="input216_27 bg_Gray" name="beacon_id" id="beacon_id" readonly="readonly" value="${dto_c[0].beacon_id}"></td>
	</tr>
	<tr align="left">
		<th>관리자</th>
	</tr>
	<tr align="right">
		<td colspan="2"> 
			<select class="select200_27" id="staff_id" name="staff_id">
				<option value=''>관리자 선택</option>
				<c:forEach items="${staffList}" var="k" varStatus="s">	
		   			<option value="${k.staff_id}">${k.staff_name}</option>						   									
				</c:forEach>	
			</select>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<label id="staff_id-error" class="validFail" for="staff_id"></label>
		</td>
	</tr>
	<tr align="left">
		<th>사용여부</th>
	</tr>
	<tr align="right">
		<td colspan="2"> 
			<input type="radio" name="beacon_use" id="beacon_use_s" value="보관"><label for="beacon_use_s">보관</label>
			<input type="radio" name="beacon_use" id="beacon_use_l" value="분실"><label for="beacon_use_l">분실</label>
			<input type="radio" name="beacon_use" id="beacon_use_k" value="원아배정"><label for="beacon_use_k">원아배정<span></span></label>
		</td>
	</tr>
	<tr align="left">
		<th>물품상태</th>
	</tr>
	<tr align="right">
		<td colspan="2"> 
			<input type="radio" name="beacon_stat" id="beacon_stat_g" value="양호"><label for="beacon_stat_g">양호</label>
			<input type="radio" name="beacon_stat" id="beacon_stat_b" value="파손"><label for="beacon_stat_b">파손</label>
			<input type="radio" name="beacon_stat" id="beacon_stat_c" value="교체중"><label for="beacon_stat_c">교체중<span></span></label>
		</td>
	</tr>
	<tr align="left">
		<th>사진</th>
	</tr>
	<tr>
		<td colspan="2">
			<input type="text" id="fileName" class="file_input_textbox" readonly >
			<div class="file_input_div">
				<img src="images/button/button_folder.png" class="file_input_img_btn">
				<input type="file" onchange="filePlus(this)" name="equipment_install_url" id="equipment_install_url" multiple class="inputFile216_27 file_input_hidden">
			</div>
		</td>
	</tr>
	<tr align="left">
		<th>제조사</th>
	</tr>
	<tr align="right">
		<td colspan="2">
			<input type="text" name="beacon_com" id="beacon_com" value="경성테크놀러지" readonly="readonly" class="input216_27 bg_Gray">
		</td>
	</tr>
</table>
<input type="hidden" name="${_csrf.parameterName}" id="csrf" value="${_csrf.token}" />
<div class="pageBtn contentBottomBtn">
	<div class="btnLeftBox">
<!--	<input type="button" value="" class="btn_back" id="cusInputBtn3" onclick="kidInfo()" id="bottomBtn-Input"> 이전버튼 클릭 -->
	</div>
	<div class="btnCnterBox">
		<input type="submit" value="" id="cusInputBtn" class="btn_done" />
 	</div>
 	<div class="btnRightBox">
<%--  		<input type="button" value="" id="cusInputBtn2" class="customM" onclick="accountBack('${dto_c[0].beacon_id}')"/>		 --%>
 	</div>
</div>
</form>
<script>
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
	function accountBack(beacon_id){
		$.ajax({  
            url : 'beaconDetail',
            type:'POST',
            data : { "beacon_id" : beacon_id},
            beforeSend: function(xhr) {
	            xhr.setRequestHeader(header, token);
	        	},
            success: function(result) {	            	 	      
         		console.log("success!!!");
         		$("#categoryList_con").html(result); //str로 받은 data를 넘긴다. 
            },
            error:function(request,status,error){                 
         	   alert("code:"+request.status+"\n"+"error:"+error);
            }
        });
	}
	
	function goUpdate(){
		beaconUpdateSave.submit();
	}
	$(document).ready(function(){	
		
		var staff_id = "${dto_c[0].staff_id}";
		
		var beacon_use ="${dto_c[0].beacon_use}";
		$("input[value='"+beacon_use+"']").attr('checked', true);
		
		var beacon_stat="${dto_c[0].beacon_stat}";
		$("input[value='"+beacon_stat+"']").attr('checked', true);
		
		$("#staff_id").val(staff_id).attr('selected', true);
		
		console.log("staff_id:"+staff_id);
		console.log("beacon_use:"+beacon_use);
		
		console.log("beacon_stat:"+beacon_stat);
		
		
		$(".thumbnail .centered img").each(function() {
			 
	       $(this).load(function(){ //이미지를 다 불러온후 확인하기 위해
	     	var imgWidth = this.naturalWidth; //이미지 크키가 정해져 있지 않을때
	     	var imgHeight = this.naturalHeight;
			var imgWidth2 = $(this).width(); //이미지 크키가 정해져 있을때
			
			if(imgWidth>imgHeight){$(".thumbnail .centered img").addClass("landscape");}
			else{$(".thumbnail .centered img").addClass("portrait");}
			console.log("imgWidth:"+imgWidth);
			console.log("imgHeight:"+imgHeight);
			console.log("imgWidth2:"+imgWidth2);
		
	       });
	    });
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
       var file_Name = $("#equipment_install_url").val();
       $("#fileName").val(file_Name);
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
	    
	$("#beaconUpdateSave").validate({
		errorClass: "validFail",
		validClass: "validSuccess",
		ignore : "",
		onfocusout: false,
		onkeyup: false,
	    rules: {
	    	staff_id: {
	    		required: true
	    	}
	    },			    

	    messages: {
	    	staff_id: {
	    		required: "관리자를 선택 해 주세요."
	        },
	    },		    
	    success: function(label) {
//              label.addClass("validSuccess").text("사용가능합니다.");
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
</body>

</html>