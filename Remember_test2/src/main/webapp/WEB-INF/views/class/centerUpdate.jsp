<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<jsp:include page="../include/menu_admin.jsp">
		<jsp:param name="pageInMenu" value="시설관리"  />
		<jsp:param name="pageCategory" value="원정보"  />
		<jsp:param name="pageTitle" value="원수정"  /> 
	</jsp:include>
	
<div class="page">
	<div class="page-wrapper">
		<div class="pageTitle"><h2>원수정 </h2></div>
		<div class="pageContent centerUpdatepage">
		<form action="saveUpdaeCenter" name="centerUpdateForm" id="centerUpdateForm" method="post" onkeydown="if(event.keyCode==13){event.returnValue=false;}"
	 enctype="multipart/form-data">
			<div class="centerUpdateContent ">
				
	<!-- 			<div class="msgBox" id="msgBox"></div> -->
				<table>
				<c:set value="${detailCenter}" var="dto_c"/>
	<%-- 			<c:forEach items="${detailCenter}" var="dto_c" varStatus="s"> --%>
					<tr>
						<td></td>
						<td colspan="3" align="left"><span>*는 필수 입력 사항 입니다.</span></td>
					</tr>
					<tr>
						<th width="100">기관명*</th>
						<td colspan="3"><input type="text" maxlength="20" class="big_Input" id="center_name" name="center_name" value="${dto_c[0].center_name}"> </td>
					</tr>
					<tr>
						<th>대표자명*</th>
						<td colspan="3"><input type="text" maxlength="5" class="big_Input" id="center_repn" name="center_repn" value="${dto_c[0].center_repn}"></td>
					</tr>
					<tr>
						<th>원장명*</th>
						<td colspan="3"><input type="text" maxlength="5" class="big_Input" id="center_dirn" name="center_dirn" value="${dto_c[0].center_dirn}"></td>
					</tr>
					<tr>
						<th>전화번호*</th>
						<td colspan="3"><input type="tel" maxlength="12" onkeydown="onlyNumber(this)" class="big_Input" id="center_phon" name="center_phon" value="${dto_c[0].center_phon}"></td>
					</tr>
					<tr>
						<th rowspan="2">주소*</th>
						<td>
							<select class="middle_select" id="center_addr_si" name="center_addr_si" onchange="guChange(this)">
								<option value="">시 선택
								<c:forEach items="${area_cityName}" var="dto" varStatus="status">	
						   			<option value="${dto.city_code}">${dto.city_name}										   									
								</c:forEach>	
							</select>
						</td>
						<td>
							<select class="middle_select" id="center_addr_gu" name="center_addr_gu" onchange="dongChange(this)">
								<option value="">구 선택
								<c:forEach items="${gu}" var="dto_gu" varStatus="status">	
						   			<option value="${dto_gu.district_code}">${dto_gu.district_name}										   									
								</c:forEach>					
							</select>
						</td>
						<td>
							<select class="middle_select" id="center_addr_dong" name="center_addr_dong" onchange="selectCode(this)">
								<option value="" label="동 선택">동 선택							
							</select>
						</td>
					</tr>
					<tr>
						<td colspan="3"><input type="text" class="long_input" id="center_addr_rem" name="center_addr_rem" value=""></td>
					</tr>
					<tr>
						<td></td>
						<td colspan="3"><label id="center_addr_si-error" class="validFail" for="center_addr_si"></label>
						<label id="center_addr_gu-error" class="validFail" for="center_addr_gu"></label>
						<label id="center_addr_dong-error" class="validFail" for="center_addr_dong"></label>
						<label id="center_addr_rem-error" class="validFail" for="center_addr_rem"></label></td>
					</tr>
					<tr>
						<th>설립유형*</th>
						<td colspan="3">
							<input type="radio" id="center_type1" name="center_type" value="어린이집">어린이집
							<input type="radio" id="center_type2" name="center_type" value="유치원">유치원
						</td>
					</tr>
					<tr>
						<th>운영시간*</th>
						<td colspan="3">
							<input type="text" class="ssmall_Input" id="openTime" name="openTime" value="">~
							<input type="text" class="ssmall_Input" id="closeTime" name="closeTime" value="">
						<label id="openTime-error" class="validFail" for="openTime"></label>
						<label id="closeTime-error" class="validFail" for="closeTime"></label></td>
					</tr>
					<tr>
						<th>설립일*</th>
						<td colspan="3"><input type="text" class="big_Input" id="center_dest" name="center_dest" value="${dto_c[0].center_dest}"></td>
					</tr>
					<tr>
						<th>개원일*</th>
						<td colspan="3"><input type="text" class="big_Input" id="center_open" name="center_open" value="${dto_c[0].center_open}"></td>
					</tr>
					<tr>
						<th>관할행정기관</th>
						<td colspan="3"><input type="text" class="big_Input" id="center_adma" name="center_adma" value="${dto_c[0].center_adma}"></td>
					</tr>
					<tr>
						<th>평가인증 연월</th>
						<td colspan="3"><input type="text" class="big_Input" id="center_eval" name="center_eval" value="${dto_c[0].center_eval}"></td>
					</tr>
					<tr>
						<th>홈페이지 URL</th>
						<td colspan="3"><input type="text" class="big_Input" id="center_web" name="center_web" value="${dto_c[0].center_web}"></td>
					</tr>
					<tr>
						<th>사진</th>
						<td colspan="3">
							<input type="file"  onchange="filePlus(this)"  id="center_pho_url" name="center_pho_url" class="big_Input">
							<!-- <img src="images/button/button_folder_54x54.png"> --></td>
					</tr>
	<%-- 			</c:forEach> --%>
				</table>
				
				<input type="hidden" id="latitude" name="latitude" class="big_input" value="${dto_c[0].latitude}">
				<input type="hidden" id="longitude" name="longitude" class="big_input" value="${dto_c[0].longitude}">
				<input type="hidden" name="center_addr" id="center_addr" value="" />
				<input type="hidden" name="${_csrf.parameterName}" id="csrf" value="${_csrf.token}" />
				</div>
				<div class="pageBtn contentBottomBtn">						
					<div class="btnLeftBox">
						<input type="button" value="" class="btn_back" id="cusInputBtn" onclick="history.back();" id="bottomBtn-Input"> <!-- 이전버튼 클릭 -->
					</div>
					<div class="btnCnterBox">
						<input type="submit"" class="btn_update" id="cusInputBtn" value=""/><!-- onclick="gosubmit()" -->
					</div>
					<div class="btnRightBox">			
<!-- 						<input type="button" value="" id="cusInputBtn" class="customM" onclick="accountList()"/>	  				 -->
			  		</div> 
				</div>
			</form>
			
			
		</div>
	</div>
</div>
<jsp:include page="../include/footer.jsp"/>
<script type="text/javascript">
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
	function onlyNumber(obj) {
	    $(obj).keyup(function(){
	         $(this).val($(this).val().replace(/[^0-9]/g,""));
	    }); 
	}
	$(document).ready(function(){	
		var center_otim = "${dto_c[0].center_otim}";
		var center_type = "${dto_c[0].center_type}";
		var center_addr = "${dto_c[0].center_addr}";
		var center_rem="";
		var center_addr_Array = center_addr.split(' ');
		var center_otim_Array = center_otim.split('~');
		
// 		for(var i=3;i<center_addr_Array.length;i++){
// 			center_rem += center_addr_Array[i];
// 		}
		
		$("#center_addr_si option").filter(function() {return this.text == center_addr_Array[0];}).attr('selected', true);
		$("#center_addr_gu option").filter(function() {return this.text == center_addr_Array[1];}).attr('selected', true);
		
		var now_gu = $("#center_addr_gu option:selected").val();		
		
		for(var i=3;i<center_addr_Array.length;i++){
			center_rem += center_addr_Array[i];
		}
		console.log("center_rem:"+center_rem);
		<c:forEach items="${dong}" var="dto_dong" varStatus="status">
			var now_dong = "${dto_dong.township_code}".substring(0,5);
			
			if(now_gu==now_dong){
				$("#center_addr_dong").append("<option value='${dto_dong.township_code}'>${dto_dong.township_name}</option>");	
			}
		</c:forEach >
		
	
		$("#center_addr_dong option").filter(function() {return this.text == center_addr_Array[2];}).attr('selected', true);
		$("#center_addr_rem").val(center_rem);
		$("#openTime").val(center_otim_Array[0]);
		$("#closeTime").val(center_otim_Array[1]);
		
		
		console.log("center_type:"+center_type);
		$("input[value='"+center_type+"']").attr('checked', true);
		
		
		
	});
	function gosubmit(){
	}
	function guChange(obj) {// 대분류 변한 경우
		$("#center_addr_gu").empty();
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
	     		
	     		$("#center_addr_gu").append("<option value=''>구를 선택 해 주세요.</option>");
	     		
		 		for(var i=0; i < size_data.length; i ++){
		 			$("#center_addr_gu").append("<option value="+result.data[i].district_code+">"+result.data[i].district_name+"</option>");
		 		}
	        },
	        error:function(request,status,error){                 
	     	   alert("code:"+request.status+"\n"+"error:"+error);
	        }	               
	    });//변경된 셀렉박스에 따른 번호		
	}//guChange
	function dongChange(obj){
	$("#center_addr_dong").empty();
		
		$.ajax({  
	        url : 'dongSelect',
	        dataType : 'json',
	        type:'POST',
	        data : { "districtCode" : obj.value },  
	        beforeSend: function(xhr) {
	            xhr.setRequestHeader(header, token);},
	        success: function(result) {	            	 	      
	     		var size_data=result.data;  
	     		
	     		$("#center_addr_dong").append("<option value=''>동을 선택 해 주세요.</option>");
	     		
		 		for(var i=0; i < size_data.length; i ++){
		 			$("#center_addr_dong").append("<option value="+result.data[i].township_code+">"+result.data[i].township_name+"</option>");
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
	$(function() {
		$("#openTime").timepicki();
		$("#closeTime").timepicki();
		  $( "#center_dest" ).datepicker({
				changeMonth : true,
			    changeYear : true,
			    showMonthAfterYear:true,
			    dateFormat : "yy-mm-dd",
			    dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
		        dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], 
			    monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
			    monthNames : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']

		  });
		  $( "#center_open" ).datepicker({
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
		    
		$("#centerUpdateForm").validate({
			errorClass: "validFail",
			validClass: "validSuccess",
			ignore : "",
		    rules: {
		    	center_name : {
		    		required: true,
	    			regex: /^[\s|ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|\*]{2,20}$/			    		
		    	},
		    	center_repn: {
		    		required: true,
		    		regex: /^[ㄱ-ㅎ가-힣]{2,5}$/
		    	},
		    	center_dirn:{
		    		required: true,
		    		regex: /^[ㄱ-ㅎ가-힣]{2,5}$/
		    	},
		    	center_phon:{
		    		required: true,
		    		regex:/^[0-9]{8,12}$/
		    	},
		    	center_addr_si: {required: true},
		    	center_addr_gu: {required: true},
		    	center_addr_dong: {required: true},
		    	center_addr_rem: {required: true},
		    	center_type: {required: true},
		    	openTime:{required: true},
		    	closeTime:{required: true},
		    	center_dest:{required: true},
		    	center_open:{required: true}
		    },			    
		    messages: {
		    	class_name: {
		            required: "센터 이름을 입력 해 주세요.",
		            regex : "2자 이상 입력 해 주세요."
		        },
		        center_repn: {
		        	required : "대표자를 입력 해 주세요.",
		        	regex : "2자 이상 입력 해 주세요."
		        },
		        center_dirn: {
		        	required : "원장을 입력 해 주세요.",
		        	regex : "2자 이상 입력 해 주세요."
		        },
		        center_phon:{
		        	required : "전화번호를 입력 해 주세요.",
		        	regex : "숫자만 입력 가능 합니다."
		    	},
		    	center_addr_si: {required : "시를 선택 해 주세요."},
		    	center_addr_gu: {required : "구를 선택 해 주세요."},
		    	center_addr_dong: {required : "동을 선택 해 주세요."},
		    	center_addr_rem: {required : "상세주소를 입력 해 주세요."},
		    	center_type: {required : "설립 유형을 선택 해 주세요."},
		    	openTime:{required : "운영시간을 입력 해 주세요."},
		    	closeTime:{required : "운영시간을 입력 해 주세요."},
		    	center_dest:{required : "설립일을 입력 해 주세요."},
		    	center_open:{required : "개원일을 입력 해 주세요."}
		    },			    
		    success: function(label) {
//                   label.addClass("validSuccess").text("사용가능합니다.");
		    },submitHandler: function(form) {
		    	var si = $("#center_addr_si option:selected").text();
				var gu = $("#center_addr_gu option:selected").text();
				var dong = $("#center_addr_dong option:selected").text();
				var rem = $("#center_addr_rem").val();
				
				var latitude="";
				var longitude="";
				
				si = si.trim();
				gu = gu.trim();
				dong = dong.trim();
				
				var center_addr = si+" "+gu+" "+dong+" "+rem; 
				$("#center_addr").val(center_addr);
				
				// 주소-좌표 변환 객체를 생성합니다
				var geocoder = new daum.maps.services.Geocoder();

				// 주소로 좌표를 검색합니다
				geocoder.addressSearch(center_addr, function(result, status) {
//		 			console.log("addr_si :"+addr_si+"/addr_gu:"+addr_gu+"/addr_dong"+addr_dong+"/addr_rem:"+addr_rem);
				    // 정상적으로 검색이 완료됐으면 
				     if (status === daum.maps.services.Status.OK) {
				    	 console.log("status :");
						latitude =result[0].y;
						longitude=result[0].x;
//			 			document.getElementById("latitude").value=result[0].y;
//			 			document.getElementById("longitude").value=result[0].x;
						document.getElementById("latitude").value=latitude;
						document.getElementById("longitude").value=longitude;
						document.getElementById("center_addr").value=center_addr;
						
						centerUpdateForm.submit();
				    } 
				});   
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
