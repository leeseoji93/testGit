package com.test.rememberTest;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import com.test.rememberTest.Dao.Class.ClassService;
import com.test.rememberTest.Dao.Medication_confirmation.Medication_confirmationService;
import com.test.rememberTest.Dao.Medication_request.Medication_requestService;
import com.test.rememberTest.Dao.Staff.StaffService;
import com.test.rememberTest.Dto.ClassDto;
import com.test.rememberTest.Dto.Medication_confirmationDto;
import com.test.rememberTest.Dto.Medication_requestDto;
import com.test.rememberTest.Dto.Singleton;
import com.test.rememberTest.Dto.StaffDto;



/**
 * Handles requests for the application home page.
 */
@Controller
public class MedicationController {
	private static final Logger logger = LoggerFactory.getLogger(MedicationController.class);
	
	@Autowired
	private ClassService classService;
	
	@Autowired
	private Medication_requestService medication_requestService;
	
	@Autowired
	private Medication_confirmationService medication_confirmationService;
	
	@Autowired
	private StaffService staffService;
	
	WebApplicationContext context = ContextLoader.getCurrentWebApplicationContext();
	Singleton singleton = (Singleton)context.getBean("singleton");
		
	public void sessionCheck() {
		if(singleton.getCenter_code()==null){
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
			List<StaffDto> staffList = staffService.getCenterCode(authentication.getName());
			singleton.setCenter_code(staffList.get(0).getCenter_code());
			singleton.setId(authentication.getName());
			singleton.setName(staffList.get(0).getStaff_name());
		}
	}
	
	@RequestMapping("/medication_contrast_documentList")
	public String medication_contrast_documentList(Model model)
	{				
		sessionCheck();	
		List<ClassDto> classList = classService.Class_Select_AllList(singleton.getCenter_code());
		model.addAttribute("classList", classList);
		 
		String class_id= classList.get(0).getClass_id();
		
		Date date = new Date();	    
	    Calendar cal = Calendar.getInstance();	    
	    cal.setTime(date);
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
	    String today = sdf.format(cal.getTime());  

        System.out.println(today);
	      
	    List<Medication_requestDto> medication_requestList = medication_requestService.Medication_requestDao_select(class_id, today);
      
	    model.addAttribute("medication_requestList", medication_requestList);  
	    model.addAttribute("today", today);   
	      
		return "Medication/medication_contrast_documentList";
	}//대조서 리스트 조회 화면
	
	@RequestMapping("/medication_contrast_document")
	public String medication_contrast_document(Model model, HttpServletRequest request,HttpServletResponse response)
	{				
		System.out.println(request.getParameter("request_id"));
		
		List<Medication_requestDto> medication_requestList = medication_requestService.Medication_requestDao_requestselect(request.getParameter("request_id"));
		List<Medication_confirmationDto> medication_confirmationList = medication_confirmationService.Medication_confirmation_select(request.getParameter("request_id"));
			
		String sign_url_parent = medication_requestService.Medication_requestDao_select_getByteImage(request.getParameter("request_id"));	
//		byte[] BimageContent_parent = (byte[]) org.apache.commons.codec.binary.Base64.decodeBase64(sign_url_parent);
//		String imageContent_parent = org.apache.commons.codec.binary.Base64.encodeBase64String(BimageContent_parent);
		
		String sign_url_teacher = medication_confirmationService.Medication_confirmation_select_getByteImage(request.getParameter("request_id"));	
//		byte[] BimageContent_teacher = (byte[]) org.apache.commons.codec.binary.Base64.decodeBase64(sign_url_teacher);
//		String imageContent_teacher = org.apache.commons.codec.binary.Base64.encodeBase64String(BimageContent_teacher);
		
		model.addAttribute("sign_url_parent", sign_url_parent);
		model.addAttribute("sign_url_teacher", sign_url_teacher);
		model.addAttribute("request_id", request.getParameter("request_id"));
		model.addAttribute("medication_requestList", medication_requestList);
		model.addAttribute("medication_confirmationList", medication_confirmationList);
		
		return "Medication/medication_contrast_documentDetail";
	}//대조서 상세정보 폼으로 페이지전환

	@RequestMapping("/medication_contrast_document_multiDown")
	public String medication_contrast_document_multiDown(Model model, HttpServletRequest request)
	{		
		String[] request_id_List = request.getParameter("request_id").split(",");
		List<Medication_requestDto> medication_requestList = medication_requestService.Medication_requestDao_select_DownData(request_id_List);
		
		String sign_url_parent = medication_requestService.Medication_requestDao_select_getByteImage(request.getParameter("request_id"));	
//		byte[] BimageContent_parent = (byte[]) org.apache.commons.codec.binary.Base64.decodeBase64(sign_url_parent);
//		String imageContent_parent = org.apache.commons.codec.binary.Base64.encodeBase64String(BimageContent_parent);
		
		String sign_url_teacher = medication_confirmationService.Medication_confirmation_select_getByteImage(request.getParameter("request_id"));	
//		byte[] BimageContent_teacher = (byte[]) org.apache.commons.codec.binary.Base64.decodeBase64(sign_url_teacher);
//		String imageContent_teacher = org.apache.commons.codec.binary.Base64.encodeBase64String(BimageContent_teacher);

		model.addAttribute("medication_requestList", medication_requestList);
		model.addAttribute("sign_url_parent", sign_url_parent);
		model.addAttribute("sign_url_teacher", sign_url_teacher);
		
		return "Medication/medication_contrast_documentDown";
	}//대조서 다운로드(다중선택)
	
	

	@RequestMapping("/medication_diaryList")
	public String medication_diaryList(Model model, HttpServletRequest request)
	{		
		sessionCheck();	
		List<ClassDto> classList = classService.Class_Select_AllList(singleton.getCenter_code());
	    Date date = new Date();	    
	    Calendar cal = Calendar.getInstance();	    
	    cal.setTime(date);

	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
	    String today = sdf.format(cal.getTime());  
	    
	    String year = today.substring(0, 4);
	    String month = today.substring(5, 7);
	    
	    model.addAttribute("today", today);
	    model.addAttribute("year", year);
	    model.addAttribute("month", month);
		model.addAttribute("classList", classList);
		return "Medication/medication_diaryList";
	}//투약일지 조회 리스트
	
	@RequestMapping("/medication_diary")
	public String medication_diary(Model model, HttpServletRequest request)
	{			
		List<Medication_requestDto> medication_requestList = medication_requestService.Medication_requestDao_select(request.getParameter("class_id")
				, request.getParameter("date"));
		
		model.addAttribute("class_id", request.getParameter("class_id"));
		model.addAttribute("date", request.getParameter("date"));
		model.addAttribute("medication_requestList", medication_requestList);
		model.addAttribute("medication_requestList_size",medication_requestList.size());
		
		return "Medication/medication_diaryDetail";
	}//투약일지상세정보 폼으로 페이지전환
	
	@RequestMapping("/medication_diary_multiDown")
	public String medication_diary_multiDown(Model model, HttpServletRequest request)
	{		
		String[] date_List = request.getParameter("date").split(",");
		System.out.println("date : " +request.getParameter("date"));
		System.out.println("class_id : " + request.getParameter("class_id"));
		List<Medication_requestDto> medication_diaryList = medication_requestService.Medication_requestDao_select_diaryDown(date_List, request.getParameter("class_id"));

		List<ClassDto> classList = classService.Class_Select_AllList(singleton.getCenter_code());
		
		for(int i = 0; i<classList.size(); i++){
			if(request.getParameter("class_id").equals(classList.get(i).getClass_id())) {
				model.addAttribute("Class_name", classList.get(i).getClass_name());
			}				
		}
		
		model.addAttribute("medication_diaryList", medication_diaryList);
		model.addAttribute("medication_diaryList_size",medication_diaryList.size());
		
		return "Medication/medication_diaryDetailDown";
	}//일지 다운로드(다중선택)	

	
	@ResponseBody
	@RequestMapping(value="createTable",method=RequestMethod.POST)	   
	 public HashMap<String, Object> createTable(@RequestParam HashMap<String,Object> param){
			
	      String class_id= (String) param.get("class_id"); 	
	      String date= (String) param.get("date"); 

	      HashMap<String, Object> hashmap = new HashMap<String,Object>();	
	      
	      List<Medication_requestDto> medication_requestList = medication_requestService.Medication_requestDao_select(class_id, date);
      
	      hashmap.put("medication_requestList", medication_requestList);   
	      return hashmap;
	            
   }//대조서 리스트 출력
	
//	@RequestMapping(value="saveImage",method=RequestMethod.POST)
//	public String saveImage(Medication_requestDto vo) {	
//		
//	    try {
//	        Map<String, Object> hmap = new HashMap<String, Object>();
//	        hmap.put("img", vo.getSign_url().getBytes());
//	        System.out.println("hmap : " + hmap);
//	        medication_requestService.Medication_requestDao_insert_setByteImage(hmap);    
//	    } catch (Exception e) {
//	        e.printStackTrace();
//	    }
//	    return "redirect:/test";
//	}//의뢰서 이미지 삽입(임시)
//	
//	@RequestMapping(value="saveImage1",method=RequestMethod.POST)
//	public String saveImage1(Medication_confirmationDto vo) {	
//	    try {
//	        Map<String, Object> hmap = new HashMap<String, Object>();
//	        hmap.put("img", vo.getSing_url().getBytes());
//	        System.out.println("hmap : " + hmap);
//	        medication_confirmationService.Medication_confirmation_insert_setByteImage(hmap);    
//	    } catch (Exception e) {
//	        e.printStackTrace();
//	    }
//	    return "redirect:/test";
//	}//확인서 이미지 삽입(임시)

}