<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="tab_kid_update_Box">
	<c:set value="${KidsInfo}" var="dto_k"/>	
	<form action="update_kids" method="post" id="kidsUpdateForm" name="kidsUpdateForm" onkeydown="if(event.keyCode==13){event.returnValue=false;}"
	 enctype="multipart/form-data">	
	 <div class="kifInfoContentU">
		<div class="kifInfoContentU_L">
			<div class="mypageTeachImg" id="holder"></div>
 			<div class="file_input_div">
				<img src="images/button/button_photo_correct_180x50.png" class="file_input_img_btn">
				<input type="file"  onchange="filePlus(this)"  id="kid_pho_url" name="kid_pho_url" class="accountForm_kid_pho file_input_hidden">
			</div>
		</div>
		<div class="kifInfoContentU_R">
			<table>
				<tr>
					<th width="60">이름</th>
					<td colspan="3"><input type="text" class="big_input" name="kid_name" id="kid_name" value="${dto_k[0].kid_name}"></td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td colspan="3"><input type="text" class="big_input" name="kid_birthday" id="kid_birthday" value="${dto_k[0].kid_birthday}"></td>
				</tr>
				<tr>
					<th>성별</th>
					<td colspan="3">
						<input type="radio" name="kid_sex" id="kid_sex_b" value="남자">
						<label for="kid_sex_b">남자</label>
						<input type="radio" name="kid_sex" id="kid_sex_g" value="여자">
						<label for="kid_sex_g">여자</label> 
					</td>
				</tr>
				<tr>
					<th>혈액형</th>
					<td colspan="3">
						<select name="bloodRh" id="bloodRh">
							<option value="+">RH+</option>
							<option value="-">RH-</option>
						</select>
						<input type="radio" name="kid_blood" id="kid_blood_a" value="A">
						<label for="kid_blood_a">A</label>
						<input type="radio" name="kid_blood" id="kid_blood_b" value="B">
						<label for="kid_blood_b">B</label>
						<input type="radio" name="kid_blood" id="kid_blood_ab" value="AB">
						<label for="kid_blood_ab">AB</label>
						<input type="radio" name="kid_blood" id="kid_blood_o" value="O">
						<label for="kid_blood_o">O</label>
					</td>
				</tr>
				<tr>
					<th>입소일</th>
					<td>
						<input type="text" class="big_input" id="kid_enter" name="kid_enter" value="${dto_k[0].kid_enter}">
					</td>
					<th>퇴소일</th>
					<td>
						<input type="text" class="big_input" id="kid_retire_r" name="kid_retire_r" >
					</td>
				</tr>
				<tr>
					<th rowspan="2">주소</th>
					<td colspan="3">
						<select class="middle_select" id="kid_addr_si" name="kid_addr_si" onchange="guChange(this)">
							<option value="">시 선택

							<c:forEach items="${area_cityName}" var="dto" varStatus="status">	
					   			<option value="${dto.city_code}">${dto.city_name}										   									
							</c:forEach>	
						</select>
						
						<select class="middle_select" id="kid_addr_gu" name="kid_addr_gu" onchange="dongChange(this)">
							<option value="">구 선택
							<c:forEach items="${gu}" var="dto_gu" varStatus="status">	
					   			<option value="${dto_gu.district_code}">${dto_gu.district_name}										   									
							</c:forEach>					
						</select>

						<select class="middle_select" id="kid_addr_dong" name="kid_addr_dong" onchange="selectCode(this)">
							<option value="" label="동 선택">동 선택							
						</select>
					</td>
				</tr>
				<tr>
					<td colspan="3"><input type="text" id="kid_addr_rem" name="kid_addr_rem" class="long_input"></td>
				</tr>
				<tr>
					<th>반</th>
					<td>
						<select class='big_select' id='class_id' name='class_id'>
							<option value='' selected='selected'>반을 선택 해 주세요.</option>
							<c:forEach items="${classList}" var="dto_c" varStatus="status">	
							   	<option value="${dto_c.class_id}">${dto_c.class_name}										   									
							</c:forEach>	
						</select>
					</td>
				</tr>
			</table>
		</div>
	</div>
	
		
		<div class="parent_Info_Box">
			
			<input type="hidden" id="kid_system_code" name="kid_system_code" value="${dto_k[0].kid_system_code}">
			<input type="hidden" id="kid_addr" name="kid_addr">
			<input type="hidden" id="latitude" name="latitude">
			<input type="hidden" id="longitude" name="longitude">
		</div>
		<div class="pageBtn contentBottomBtn">
			<div class="btnLeftBox">
				<input type="button" value="" class="btn_back" id="cusInputBtn" onclick="kidInfo('${dto_k[0].kid_system_code}')" id="bottomBtn-Input"> <!-- 이전버튼 클릭 -->
			</div>
			<div class="btnCnterBox">
				<input type="button" value="" id="cusInputBtn" class="customD" onClick='goSubmit();'/>
						  				
	  		</div>
	  		<div class="btnRightBox">
	  			<input type="button" value="" id="cusInputBtn" class="customM" onclick="accountBack()"/>		
	  		</div>
  		</div>	
  		<input type="hidden" name="${_csrf.parameterName}" id="csrf" value="${_csrf.token}" />
	</form>
</div>


<script type="text/javascript">
	$(document).ready(function(){
		
		
		
		var classId = "${dto_k[0].class_id}";
		var kidSex = "${dto_k[0].kid_sex}";
		var kidBlood = "${dto_k[0].kid_blood}";
		var kidAddr = "${dto_k[0].kid_addr}";
		var kidAddr_rem="";
		var kidAddrArray = kidAddr.split(' ');
		var kid_addr_si="";
		
		console.log("kidAddr:"+kidAddr);
		console.log("kidAddrArray:"+kidAddrArray);
		var bloodRh = kidBlood.substr(kidBlood.length - 1, 1);
		
		$("#bloodRh").val(bloodRh).prop("selected", true);
		
		var kidBlood = kidBlood.substring(0,kidBlood.length - 1,1); 
		$("input:radio[name ='kid_blood']:input[value='"+kidBlood+"']").attr("checked", true);

		
		var kidCode = "${dto_k[0].kid_system_code}";
		
// 		guChange();
		for(var i=3;i<kidAddrArray.length;i++){
			kidAddr_rem += kidAddrArray[i]+" ";
			console.log("kidAddrArray:"+kidAddr_rem);
		}
// 		$("#kid_addr_si").text(kidAddrArray[0]).attr("selected", "selected");
// 		$("#kid_addr_gu").text(kidAddrArray[1]).attr("selected", "selected");
// 		$("#kid_addr_dong").text(kidAddrArray[2]).attr("selected", "selected");
			$("#kid_addr_si option").filter(function() {return this.text == kidAddrArray[0];}).attr('selected', true);
		$("#kid_addr_gu option").filter(function() {return this.text == kidAddrArray[1];}).attr('selected', true);
		$("#kid_addr_dong option").filter(function() {return this.text == kidAddrArray[2];}).attr('selected', true);
		
		var now_gu = $("#kid_addr_gu option:selected").val();		
		
		
		<c:forEach items="${dong}" var="dto_dong" varStatus="status">
			var now_dong = "${dto_dong.township_code}".substring(0,5);
			
			if(now_gu==now_dong){
				$("#kid_addr_dong").append("<option value='${dto_dong.township_code}'>${dto_dong.township_name}</option>");	
			}
		</c:forEach >
		
		console.log("kidAddr_rem:"+kidAddr_rem);
	
		$("#kid_addr_dong option").filter(function() {return this.text == kidAddrArray[2];}).attr('selected', true);
		$("#kid_addr_rem").val(kidAddr_rem);
		
		
		$("#class_id").val(classId).attr("selected", "selected");		//반선택
		//성별 체크
		if(kidSex=="여자"){
			$("#kid_sex_g").prop("checked", true);
		}
		else{
			$("#kid_sex_b").prop("checked", true);
		}
		//혈액형 체크
		if(kidBlood=="A"){
			$("#kid_blood_a").prop("checked", true);
		}
		else if(kidBlood=="B"){
			$("#kid_blood_b").prop("checked", true);
		}
		else if(kidBlood=="AB"){
			$("#kid_blood_ab").prop("checked", true);
		}
		else{
			$("#kid_blood_o").prop("checked", true);
		}
// 		$("#radio_1").prop("checked", true);
	
		
	});
	$(function() {
		  $( "#bus_insur" ).datepicker({
				changeMonth : true,
			    changeYear : true,
			    showMonthAfterYear:true,
			    dateFormat : "yy-mm-dd",
			    dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
		        dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], 
			    monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
			    monthNames : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']

		  });
		  $( "#kid_birthday" ).datepicker({
				changeMonth : true,
			    changeYear : true,
			    showMonthAfterYear:true,
			    dateFormat : "yy-mm-dd",
			    dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
		        dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], 
			    monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
			    monthNames : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']

		  });
		  $( "#kid_enter" ).datepicker({
				changeMonth : true,
			    changeYear : true,
			    showMonthAfterYear:true,
			    dateFormat : "yy-mm-dd",
			    dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
		        dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], 
			    monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
			    monthNames : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']

		  });$( "#kid_retire_r" ).datepicker({
				changeMonth : true,
			    changeYear : true,
			    showMonthAfterYear:true,
			    dateFormat : "yy-mm-dd",
			    dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
		        dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], 
			    monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
			    monthNames : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']

		  });
		});
</script>
<script type="text/javascript">
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

function accountBack() {
	$.ajax({
		url : 'tab_kid',
        type:'POST',
		beforeSend: function(xhr) {
              xhr.setRequestHeader(header, token);
           },
		//data: { "CODE_LEVEL": totcnt },    //escape 한글 깨짐 방지 구문  
		success : function(data) {
				$("#tabs-2").html(data); //str로 받은 data를 넘긴다.  
		},
		error : function(xhr, txtStatus, errorThrown) {
			alert("error" + errorThrown);
		}
	});
}

function kidInfo(kidCode){			//원아 상세 정보
	console.log("kidCode"+kidCode);
	
	$.ajax({
		type : "GET",
		url : "kidInfo",
		data : { "kidCode" : kidCode},
		beforeSend: function(xhr) {
              xhr.setRequestHeader(header, token);
           },
		success : function(data) {
//				setInterval('autoRefresh_div()', 3000);
    		$("#tabs-2").html(data); //str로 받은 data를 넘긴다.  
//				$('#tabs-1').load('kidInfo #tabs-3');
		},
		error : function(xhr, txtStatus, errorThrown) {
			alert("error" + errorThrown);
		}
	});
}

function goSubmit(){
	var addr_si = $("#kid_addr_si option:selected").text();
	var addr_gu = $("#kid_addr_gu option:selected").text();
	var addr_dong = $("#kid_addr_dong option:selected").text();
// 	addr_dong=addr_dong.slice(0, -2); 
// 	addr_dong=addr_dong+"동";
	var addr_rem = $("#kid_addr_rem").val();
	var kid_addr =$.trim(addr_si)+" "+$.trim(addr_gu)+" "+$.trim(addr_dong)+" "+addr_rem;
	var latitude="";
	var longitude="";
	
	var kid_retire=$("#kid_retire_r").val();
	console.log("kid_addr:"+kid_addr);
	
	if(kid_retire==""){
		$("#kid_retire_r").val("0000-00-00");
		console.log("kid_retire null:"+$("#kid_retire_r").val());
	}
	
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new daum.maps.services.Geocoder();

	// 주소로 좌표를 검색합니다
	geocoder.addressSearch(kid_addr, function(result, status) {
		console.log("좌표검색......");
	    // 정상적으로 검색이 완료됐으면 
	     if (status === daum.maps.services.Status.OK) {
	    	 console.log("좌표검색IF");
			latitude =result[0].y;
			longitude=result[0].x;
// 			document.getElementById("latitude").value=result[0].y;
// 			document.getElementById("longitude").value=result[0].x;
			document.getElementById("latitude").value=latitude;
			document.getElementById("longitude").value=longitude;
			document.getElementById("kid_addr").value=kid_addr;
			kidsUpdateForm.submit();
	    } 
	     else{
	    	console.log("좌표검색ELSE");
	    	$('#msgBox').addClass("msgBox_Error");	
	    	$('#msgBox').html("<span>잘못된 주소입니다.</span>");
	     }
	});
}



function guChange(obj) {// 대분류 변한 경우
	$("#kid_addr_gu").empty();
	console.log("value"+obj.value);
	$.ajax({  
        url : 'guSelect',
        dataType : 'json',
        type:'POST',
        data : { "cityCode" : obj.value },  
        beforeSend: function(xhr) {
            xhr.setRequestHeader(header, token);},
        success: function(result) {	            	 	      
     		var size_data=result.data;  
     		
     		$("#kid_addr_gu").append("<option value=''>구를 선택 해 주세요.</option>");
     		
	 		for(var i=0; i < size_data.length; i ++){
	 			$("#kid_addr_gu").append("<option value="+result.data[i].district_code+">"+result.data[i].district_name+"</option>");
	 		}
        },
        error:function(request,status,error){                 
     	   alert("code:"+request.status+"\n"+"error:"+error);
        }	               
    });//변경된 셀렉박스에 따른 번호		
}//guChange
function dongChange(obj){
$("#kid_addr_dong").empty();
	
	$.ajax({  
        url : 'dongSelect',
        dataType : 'json',
        type:'POST',
        data : { "districtCode" : obj.value },  
        beforeSend: function(xhr) {
            xhr.setRequestHeader(header, token);},
        success: function(result) {	            	 	      
     		var size_data=result.data;  
     		
     		$("#kid_addr_dong").append("<option value=''>동을 선택 해 주세요.</option>");
     		
	 		for(var i=0; i < size_data.length; i ++){
	 			$("#kid_addr_dong").append("<option value="+result.data[i].township_code+">"+result.data[i].township_name+"</option>");
	 		}
        },
        error:function(request,status,error){                 
     	   alert("code:"+request.status+"\n"+"error:"+error);
        }	               
    });//변경된 셀렉박스에 따른 번호	
}
function selectCode(obj){
	$("#center_code").empty();
	$('#kid_addr').empty();
	var now_CenterCode;
	
	$.ajax({  
        url : 'selectCode',
        dataType : 'json',
        type:'POST',
        data : { "adminArea" : obj.value },  
        beforeSend: function(xhr) {
            xhr.setRequestHeader(header, token);},
        success: function(result) {	            	 	      
     		console.log("selectCode Success");
     		var size_data=result.data;  
     		
     		var target_si = document.getElementById("kid_addr_si");
     		target_si= target_si.options[target_si.selectedIndex].text;
     		var target_gu = document.getElementById("kid_addr_gu");
     		target_gu = target_gu.options[target_gu.selectedIndex].text;
     		var target_dong = document.getElementById("kid_addr_dong");
     		target_dong = target_dong.options[target_dong.selectedIndex].text;
     		
     		$('#kid_addr').val(target_si+" "+target_gu+" "+target_dong);
     		
     		$('#admin_area').val(obj.value);
     		
     		if(size_data==""){
     			$("#center_code").val(obj.value+"_01");
     		}
     		else{
     			now_CenterCode = parseInt(result.data[0].center_code);	//string->int
     			now_CenterCode+=1;
     			
     			if(now_CenterCode<10){					//10미만 0 붙이기 
     				now_CenterCode+="";					//int -> String 
     				now_CenterCode= "0"+now_CenterCode;
     			}
     			else{
     				now_CenterCode+="";
     			}
     			$("#center_code").val(obj.value+"_"+now_CenterCode);
     		}
        },
        error:function(request,status,error){                 
     	   alert("code:"+request.status+"\n"+"error:"+error);
        }	               
    });//변경된 셀렉박스에 따른 번호	
}
</script>


<script>
	$(function() {				
		 $.validator.addMethod("regex", function(value, element, regexpr) {          
		     return regexpr.test(value);
		   });	 
		 var token = $("meta[name='_csrf']").attr("content");
		 var header = $("meta[name='_csrf_header']").attr("content");
		    
		$("#kidsUpdateForm").validate({
			errorClass: "validFail",
			validClass: "validSuccess",
			ignore : "",
		    rules: {
		    	kid_name : {
		    		required: true,
		    		regex: /^[ㄱ-ㅎ가-힣]{2,5}$/		    		
		    	},
		    	kid_birthday: {required: true},
		    	kid_sex: {required: true},
		    	kid_addr_si: {required: true},
		    	kid_addr_gu: {required: true},
		    	kid_addr_dong: {required: true},
		    	kid_addr_rem: {required: true},
		    	kid_enter: {required: true},
		    	class_id: {required: true}
		    },			    

		    messages: {
		    	kid_name : {required: "이름을 입력 해 주세요.",
			        regex : "2자 이상 입력 해 주세요."
		    	},
		    	kid_birthday: {required: "생년월일을 입력 해 주세요."},
		    	kid_sex: {required: "성별을 선택 해 주세요."},
		    	kid_addr_si: {required: "시를 선택 해 주세요."},
		    	kid_addr_gu: {required: "구를 선택 해 주세요."},
		    	kid_addr_dong: {required: "동을 선택 해 주세요."},
		    	kid_addr_rem: {required: "상세 주소를 입력 해 주세요."},
		    	kid_enter: {required: "입소일을 입력 해 주세요."},
		    	class_id: {required: "반을 선택 해 주세요."}
		    },		    
		    success: function(label) {
//                   label.addClass("validSuccess").text("사용가능합니다.");
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