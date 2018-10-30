package com.test.rememberTest;

import java.io.IOException;
import java.net.SocketException;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPReply;
import org.springframework.beans.factory.annotation.Autowired;
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
import org.springframework.web.multipart.MultipartFile;

import com.test.rememberTest.Dao.BusRoute.BusRouteService;
import com.test.rememberTest.Dao.Car.CarService;
import com.test.rememberTest.Dao.Equipment.EquipmentService;
import com.test.rememberTest.Dao.Korea_admin_area.Korea_admin_areaService;
import com.test.rememberTest.Dao.Staff.StaffService;
import com.test.rememberTest.Dto.Singleton;
import com.test.rememberTest.Dto.StaffDto;
import com.test.rememberTest.Dto.StationInfo;



@Controller
public class StaffController {
	
	 @Autowired
	 private CarService carService;	
	 
	 @Autowired
	 private StaffService staffService;
	 
	 @Autowired
	 private EquipmentService equipmentService;
	 
	 @Autowired
	 private BusRouteService busRouteService;
	 
//	private String center_code = "2109059_01";
//	private String registrant = "rlaskal12";
	 protected static String FTP_IP   = "13.125.170.255"; // FTP 접속지 IP
	 protected static int    FTP_PORT = 21;             // FTP 접속지 Port
	 protected static String FTP_ID   = "hskim";        // ID
	 protected static String FTP_PWD  = "hskim21";        // PASSWORD
	 protected static String TOMCAT_PORT  = ":8080";        // TOMCAT_PORT
	 protected static String FTP_PATH = "";
    
    FTPClient ftpclient = null;
    
     public StaffController() {
    	 ftpclient = new FTPClient();
	}
	     
	WebApplicationContext context = ContextLoader.getCurrentWebApplicationContext();
	Singleton singleton = (Singleton)context.getBean("singleton");
	
	public void sessionCheck() {
		
		if(singleton.getCenter_code()==null){
			System.out.println("널이다!!!!!!!!");
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
			List<StaffDto> staffList = staffService.getCenterCode(authentication.getName());
			singleton.setCenter_code(staffList.get(0).getCenter_code());
			singleton.setId(authentication.getName());
			singleton.setName(staffList.get(0).getStaff_name());
		}
	}
	 
	@RequestMapping("accountForm")
	public String accountForm(Model model,HttpServletRequest request)
	{		
		sessionCheck();   
		List<StaffDto> classList = staffService.getAllClassList(singleton.getCenter_code());
		model.addAttribute("classList",classList);	// 반 리스트
		return "account/accountForm";
	}//교직원 계정등록 page
	
	  @RequestMapping(value="insertAllStaff",method=RequestMethod.POST)
	   public String insertAllStaff(HttpServletRequest request,StaffDto staffDto,
				@RequestParam("staff_photo_url") List<MultipartFile> file_url){
	      sessionCheck();   
	      String[] area_code = singleton.getCenter_code().split("_");
	      int admin_area = Integer.parseInt(area_code[0]);
	      
	      
	      System.out.println("staff_id_type:"+staffDto.getStaff_id_type());
	      System.out.println("class_name:"+staffDto.getClass_id());
	      System.out.println("staffDto.getClass_id():"+staffDto.getClass_id());
	      


	      List<String> ImageUrlList = new ArrayList<String>();
	      List<String> fileUrlList = new ArrayList<String>();
	      List<String> fileTitle = new ArrayList<String>();
	      boolean upload_check = false;
	      if(!file_url.get(0).isEmpty()){
	        try {
	           ftpclient.connect(FTP_IP, FTP_PORT);  // FTP 연결
	           ftpclient.login(FTP_ID, FTP_PWD);     // FTP 로그인 
	          
	           System.out.println("FTP 연결 시도중");
	          
	           int reply = ftpclient.getReplyCode(); // 연결후 응답확인
	          
	           if(!FTPReply.isPositiveCompletion(reply)) {
	             System.out.println("FTP 연결거부");
	           } else {
	             System.out.println("FTP 연결됨");
	             
	             ftpclient.enterLocalPassiveMode(); // important!
	             ftpclient.setFileType(FTP.BINARY_FILE_TYPE);
	             ftpclient.setControlEncoding("euc-kr");           
	             ftpclient.changeWorkingDirectory("/Account/Image");
	             for(int i =0; i < file_url.size(); i++) {
	                MultipartFile mf = file_url.get(i);
	                 String filename = mf.getOriginalFilename();
	                 
	                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
	                String today = dateFormat.format(new Date());
	                String fileUUID =singleton.getCenter_code() + "_" +today+ "_"+filename;

	                boolean isSuccess_image = ftpclient.storeFile(fileUUID, mf.getInputStream());
	                
	                if (isSuccess_image) {
	                     System.out.println(filename+"업로드 성공");
	                     upload_check = true;
	                     ImageUrlList.add("http://"+ FTP_IP + TOMCAT_PORT + "/Spring/Account/Image/" +  fileUUID);
	                    staffDto.setStaff_phot(ImageUrlList.get(0)); 
	                 }
	                else {
	                   upload_check = false;
	                }
	             }    
	                       
	             ftpclient.logout();
	             ftpclient.disconnect(); 			//접속해제
	           }
	         } catch (SocketException e) {
	           e.printStackTrace();
	         } catch (IOException e) {
	           if(ftpclient.isConnected()) {
	             try {
	               ftpclient.disconnect();
	             } catch (IOException e1) {
	               e1.printStackTrace();
	             }
	           }
	           System.out.println("연결실패");
	           e.printStackTrace();
	         }
	      }	     
	      
	      
	      staffDto.setCenter_code(singleton.getCenter_code());
	      staffDto.setAdmin_area(admin_area);
	      staffDto.setRegistrant(singleton.getId());
	      System.out.println("staffDto"+staffDto.getStaff_phot());
	      
	      staffService.InsertStaff(staffDto);
	      staffService.addRoles(staffDto);      //권한 부여하기
	      
	      System.out.println("staffDto.getClass_id() : "+staffDto.getClass_id());
//	      System.out.println(staffDto.getClass_id().isEmpty());
	      if(staffDto.getStaff_position().equals("보육교사")){
	    	  System.out.println("staffDto.getStaff_id_type():"+staffDto.getStaff_id_type());
	    	  if(staffDto.getClass_id().isEmpty()){
	    		  staffDto.setStaff_id_1(staffDto.getStaff_id());
	    		  staffService.updateChangeStaffInClass(staffDto);  
    		  }else{
    			  if(staffDto.getStaff_id_type().equals("staff_id_1")){
	    			  staffDto.setStaff_id_1(staffDto.getStaff_id());
		    		  staffService.updateChangeStaffInClass(staffDto);
		    	  }else{
		    		  staffDto.setStaff_id_2(staffDto.getStaff_id());
		    		  staffService.updateChangeStaffInClass2(staffDto);
		    	  }
    		  }
	      }
	      return "redirect:/accountList";
	   }//교직원 계정 등록 -insert

	
	
	@ResponseBody
	@RequestMapping(value="checkStaffId",method=RequestMethod.POST)	   
	 public boolean checkStaffId(HttpServletRequest request,Model model){
		 	
//		 String formData=  request.getParameter("formData"); 	     	      		 
//		 String baseData=  request.getParameter("baseData"); 
		 String formData=request.getParameter("staff_id");
		 System.out.println("test!!: " + request.getParameter("staff_id"));
//		 System.out.println("formData : "+formData+"// baseData: "+baseData);
		 List<StaffDto> staffIdList = staffService.getStaffIdCheck(formData);
		 
	      boolean nameCheck = true; //false : 이름 중복됨, true 중복 안됨.      
	    
	      
    	  for (int index = 0; index < staffIdList.size(); index++) {
 	    	 
	    	   if(staffIdList.get(index).getStaff_id().equals(formData))
	    	   {
//	    		   if(formData.equals(baseData))
//	    		   {
//	    			   System.out.println(formData);
//	    			   System.out.println(baseData);
//	    			 
//	    			   nameCheck = true;
//	    			   System.out.println(nameCheck);
//	    		   }
//	    		   else
//	    		   {
//	    			   System.out.println("formData : "+formData);
//	    			   System.out.println("baseData : "+baseData);	    			  
	    			   nameCheck = false;
//	    			   System.out.println(nameCheck);
//	    		   }		   
	    	   }
	      }//중복 요소 검사 

	      return nameCheck;
	            
   }//staff ID 중복 검사
	
}
