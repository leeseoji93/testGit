<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.test.rememberTest.Dto.Singleton"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<jsp:include page="../include/menu_admin.jsp">
		<jsp:param name="pageInMenu" value="계정관리"  />
		<jsp:param name="pageCategory" value="원아"  />
		<jsp:param name="pageTitle" value="계정 등록"  /> 
	</jsp:include>
	
<div class="page">
	<div class="page-wrapper">
		<div class="pageTitle"><h2>원아 등록 </h2></div>
		<form action="insert_kids" method="post" id="kidsForm" onkeydown="if(event.keyCode==13){event.returnValue=false;}"
	 enctype="multipart/form-data">
		<div class="pageContent700 accountForm_kids">
			<div class="categoryContent2">

				
				<div class="kids_Info_Box">
					<div class="kids_Photo_Box">
						<table>
							<tr>
								<th><div id="holder" class="profileImg"></div></th>
							</tr>
							<tr>
								<td>
									<div class="file_input_div">
										<img src="images/button/button_photo_correct_180x50.png" class="file_input_img_btn">
										<input type="file"  onchange="filePlus(this)"  id="kid_pho_url" name="kid_pho_url" class="accountForm_kid_pho file_input_hidden">
									</div>
									
								</td>
							</tr>
						</table>
					</div>
					<table>
						<tr>
							<th width="90px">이름</th>
							<td width="560px" colspan="5"><input type="text" class="big_input" name="kid_name" id="kid_name" maxlength="5"></td>
						</tr>
						<tr>
							<th>생년월일</th>
							<td colspan="5"><input type="text" class="big_input" name="kid_birthday" id="kid_birthday"></td>
						</tr>
						<tr>
							<th>성별</th>
							<td colspan="1">
								<input type="radio" name="kid_sex" id="kid_sex_b" value="남자" checked="checked">
								<label for="kid_blood_b">남</label>
							</td>
							<td colspan="4">
								<input type="radio" name="kid_sex" id="kid_sex_g" value="여자">
								<label for="kid_blood_g">여</label>
							</td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<th>혈액형</th>
							<td>
								<select name="bloodRh" id="bloodRh">
									<option value="+">RH+</option>
									<option value="-">RH-</option>
								</select>
							</td>
							<td>
								<input type="radio" name="kid_blood" id="kid_blood_a" value="A" checked="checked">
								<label for="kid_blood_a">A</label>
							</td>
							<td>
								<input type="radio" name="kid_blood" id="kid_blood_b" value="B">
								<label for="kid_blood_b">B</label>
							</td>
							<td>
								<input type="radio" name="kid_blood" id="kid_blood_ab" value="AB">
								<label for="kid_blood_ab">AB</label>
							</td>
							<td>
								<input type="radio" name="kid_blood" id="kid_blood_o" value="O">
								<label for="kid_blood_o">O</label>
							</td>
						</tr>
						<tr>
							<th rowspan="3">주소</th>
							<td  colspan="5">
								<select class="middle_select" id="kid_addr_si" name="kid_addr_si" onchange="guChange(this)">
									<option value="" label="시 선택">시 선택
		<!-- 										<option value="">직업선택</option> -->
		<!-- 									    <option value="학생">학생</option> -->
		<!-- 									    <option value="회사원" selected="selected">회사원</option> -->
		<!-- 									    <option value="기타">기타</option> -->
									<c:forEach items="${area_cityName}" var="dto" varStatus="status">
							   			<option value="${dto.city_code}" label="${dto.city_name}">${dto.city_name}
									</c:forEach>
								</select>

								<select class="middle_select" id="kid_addr_gu" name="kid_addr_gu" onchange="dongChange(this)">
									<option value="" label="구 선택">
								</select>

								<select class="middle_select" id="kid_addr_dong" name="kid_addr_dong" onchange="selectCode(this)">
									<option value="" label="동 선택">
								</select>
							</td>
						</tr>
						<tr>
							<td colspan="5"><label id="kid_addr_si-error" class="validFail" for="kid_addr_si"></label>
							<label id="kid_addr_gu-error" class="validFail" for="kid_addr_gu"></label>
							<label id="kid_addr_dong-error" class="validFail" for="kid_addr_dong"></label></td>
						</tr>
						<tr>
							<td  colspan="5"><input type="text" id="kid_addr_rem" name="kid_addr_rem" class="long_input"></td>
						</tr>
						<tr>
							<th>입소일</th>
							<td colspan="5">
								<input type="text" id="kid_enter" name="kid_enter" class="big_input"><label id="kid_enter-error" class="validFail" for="kid_enter"></label>
							</td>
						</tr>
						<tr>
							<th>퇴소일</th>
							<td colspan="5">
								<input type="text" id="kid_retire_r" name="kid_retire_r" class="big_input">
							</td>
						</tr>
						<tr>
							<th>반</th>
							<td  colspan="5">
								<select class='big_select' id='class_id' name='class_id' onchange="classChange(this)">
									<option value='' selected='selected'>반을 선택 해 주세요.</option>
									<c:forEach items="${classList}" var="dto_c" varStatus="status">
									   	<option value="${dto_c.class_id}">${dto_c.class_name}
									</c:forEach>
								</select>
								<label id="class_id-error" class="validFail" for="class_id"></label>
							</td>
						</tr>
					</table>
				</div>
				
				<div class="parent_Info_Box">

<!-- 					<table> -->
<!-- 						<tr> -->
<!-- 							<th rowspan="2"  width="90px">보호자1</th> -->
<!-- 							<td><input type="text" class="big_input" name="par_name" id="par_name" placeholder="성명"></td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 							<td><input type="tel" class="big_input" name="par_phone" id="par_phone" placeholder="전화번호"></td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 							<th rowspan="2">보호자2</th> -->
<!-- 							<td><input type="text" class="big_input" name="par_name" id="par_name" placeholder="성명"></td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 							<td><input type="tel" class="big_input" name="par_phone" id="par_phone" placeholder="전화번호"></td> -->
<!-- 						</tr> -->
<!-- 					</table> -->
					<input type="hidden" id="kid_system_code" name="kid_system_code">
					<input type="hidden" id="kid_addr" name="kid_addr">
					<input type="hidden" id="latitude" name="latitude">
					<input type="hidden" id="longitude" name="longitude">
				</div>
				<input type="hidden" name="${_csrf.parameterName}" id="csrf" value="${_csrf.token}" />
				<div class="pageBtn contentBottomBtn">
					<div class="btnLeftBox">
					</div>
					<div class="btnCnterBox">
						<input type="submit" value="" id="cusInputBtn" class="customD" />
			  		</div>
			  		<div class="btnRightBox">
			  		</div>
		  		</div>
			</div>
		</div>



		<div class="pageContent256 accountForm_kids_r">
			<div class="categoryList">
				<div class="searchBox_accountKids">
					반별원아
					<input type="text" name="keyWord" id="keyWord">
					<input type="button" value="" id="searchBtn">
				</div>

				<div class="categoryList_con" id="categoryList_con">
					<ul class="categoryList_con_ul" id="categoryList_con_ul">
						<li style="border-bottom: 0"><center>반을 선택 하면 <br>반의 원아 목록이 보여집니다.</center></li>
					</ul>
					
				</div>
			</div>

		</div>
		</form>
	</div>
</div>
<jsp:include page="../include/footer.jsp"/>

<script>
	var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
    <c:set value="${centerAddr}" var="dto"/>
	
		$("#searchBtn").click(function(){		
	        
			$.ajax({  
	               url : 'kidsSearch',
	               dataType : 'json',
	               type:'POST',
	               data : { "keyWord" : $("#keyWord").val() },
	               beforeSend: function(xhr) {
	 	              xhr.setRequestHeader(header, token);
	 	           },
	               // data : $('#msg').serializeArray(),
	               success: function(data) {           	   
	            	         	
	                 $("#categoryList_con_ul").empty(); 
	                 var size_data=data.kidsSearchResult;
	                 
	                 console.log("size_data.length:"+size_data.length);
	                 for(var i=0; i < size_data.length; i ++){
	                	 $("#categoryList_con_ul")
	                	 .append("<li>"+
	                				"<div class='kid_photo'><img src='"+data.kidsSearchResult[i].kid_pho+"'></div>"+
	                				"<span>"+data.kidsSearchResult[i].kid_name+"</span>"+
	                			"</li>");
	                 }
	                 
	               },
	               error:function(request,status,error){                 
	            	   alert("code:"+request.status+"\n"+"error:"+error);
	               }
			 
			});
	    });
		
		function classChange(obj){
			$("#categoryList_con_ul").empty();
				
				$.ajax({  
			        url : 'kidsInClass',
			        dataType : 'json',
			        type:'POST',
			        data : { "class_id" : obj.value },  
			        beforeSend: function(xhr) {
			            xhr.setRequestHeader(header, token);},
			        success: function(data) {	            	 	      
			     		var size_data=data.kidsListInClass;  
			     		console.log("size_data.length"+size_data.length);
	                			 
		                for(var i=0; i < size_data.length; i ++){
		                	$("#categoryList_con_ul ")
		                	 .append("<li>"+
		                				"<div class='kid_photo'><img src='"+data.kidsListInClass[i].kid_pho+"'></div>"+
		                				"<span>"+data.kidsListInClass[i].kid_name+"</span>"+
		                			"</li>");
		                }
			        },
			        error:function(request,status,error){                 
			     	   alert("code:"+request.status+"\n"+"error:"+error);
			        }	               
			    });//반 별 원아 보기	
			}
		
		$(function() {
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

			  });
			  $( "#kid_retire_r" ).datepicker({
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
</script> <!-- 버스 id, 센터 코드 히든값 셀렉 -->
	
<script>
function goSubmit(){
	var addr_si = $("#kid_addr_si option:selected").text();
	var addr_gu = $("#kid_addr_gu option:selected").text();
	var addr_dong = $("#kid_addr_dong option:selected").text();
	var addr_rem = $("#kid_addr_rem").val();
	var kid_addr =$.trim(addr_si)+" "+addr_gu+" "+addr_dong+" "+addr_rem;
	var latitude="";
	var longitude="";
	
	console.log("kid_addr :"+kid_addr );
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new daum.maps.services.Geocoder();

	// 주소로 좌표를 검색합니다
	geocoder.addressSearch(kid_addr, function(result, status) {

	    // 정상적으로 검색이 완료됐으면 
	     if (status === daum.maps.services.Status.OK) {
			latitude =result[0].y;
			longitude=result[0].x;
// 			document.getElementById("latitude").value=result[0].y;
// 			document.getElementById("longitude").value=result[0].x;
			document.getElementById("latitude").value=latitude;
			document.getElementById("longitude").value=longitude;
			document.getElementById("kid_addr").value=kid_addr;
			
// 			kidsForm.submit();
	    } 
	});
	
	
}
</script>

<script type="text/javascript">
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

function guChange(obj) {// 대분류 변한 경우
	$("#kid_addr_gu").empty();
	
	$.ajax({  
        url : 'guSelect',
        dataType : 'json',
        type:'POST',
        data : { "cityCode" : obj.value },  
        beforeSend: function(xhr) {
            xhr.setRequestHeader(header, token);},
        success: function(result) {	            	 	      
     		console.log("cityCode Success");
     		var size_data=result.data;  
     		
     		$("#kid_addr_gu").append("<option value=''>구를 선택 해 주세요.</option>");
     		
	 		for(var i=0; i < size_data.length; i ++){
	 			console.log(result.data[i].district_code);	    
	 			console.log(result.data[i].district_name);
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
     		console.log("cityCode Success");
     		var size_data=result.data;  
     		
     		$("#kid_addr_dong").append("<option value=''>구를 선택 해 주세요.</option>");
     		
	 		for(var i=0; i < size_data.length; i ++){
	 			console.log(result.data[i].township_code);	    
	 			console.log(result.data[i].township_name);
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
		    
		$("#kidsForm").validate({
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
	
</body>
</html>