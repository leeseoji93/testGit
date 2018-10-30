package com.test.rememberTest;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.SocketException;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPReply;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;

import com.test.rememberTest.Dao.BusRoute.BusRouteService;
import com.test.rememberTest.Dao.Car.CarService;
import com.test.rememberTest.Dao.Center.CenterService;
import com.test.rememberTest.Dao.Class.ClassService;
import com.test.rememberTest.Dao.Equipment.EquipmentService;
import com.test.rememberTest.Dao.Kid.KidService;
import com.test.rememberTest.Dao.Korea_admin_area.Korea_admin_areaService;
import com.test.rememberTest.Dao.Staff.StaffService;
import com.test.rememberTest.Dto.Car;
import com.test.rememberTest.Dto.CenterDto;
import com.test.rememberTest.Dto.ClassDto;
import com.test.rememberTest.Dto.KidDto;
import com.test.rememberTest.Dto.ParentDto;
import com.test.rememberTest.Dto.Singleton;
import com.test.rememberTest.Dto.StaffDto;
import com.test.rememberTest.Dto.StationInfo;
import com.test.rememberTest.Dto.korea_admin_areaDto;
import com.test.rememberTest.parent.ParentService;

@Controller
public class ClassController {
	 @Autowired
	 private CarService carService;	
	 
	 @Autowired
	 private StaffService staffService;
	 
	 @Autowired
	 private EquipmentService equipmentService;
	 
	 @Autowired
	 private BusRouteService busRouteService;
	 
	 @Autowired
	 private KidService kidService;
	 
	 @Autowired
	 private ParentService parentService;
	 
	 @Autowired
	 private ClassService classService;
	 
	 @Autowired
	 private CenterService centerService;
	 
	 @Autowired
		private Korea_admin_areaService korea_admin_areaService;
	 
//	private String registrant = "rlaskal12";
	
	 protected static String FTP_IP   = "13.125.170.255"; // FTP 접속지 IP
	 protected static int    FTP_PORT = 21;             // FTP 접속지 Port
	 protected static String FTP_ID   = "hskim";        // ID
	 protected static String FTP_PWD  = "hskim21";        // PASSWORD
	 protected static String TOMCAT_PORT  = ":8080";        // TOMCAT_PORT
	 protected static String FTP_PATH = "";
	    
	    FTPClient ftpclient = null;
	    
	     public ClassController() {
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
	@RequestMapping(value="centerInfo")
	public String centerInfo(Model model){
		sessionCheck();	
		System.out.println("centerInfo 시작!!!!!!!!!!!!!!");
		System.out.println("singleton:"+singleton.getCenter_code());
		
		List<CenterDto> detailCenter = centerService.detailCenter(singleton.getCenter_code());
		model.addAttribute("detailCenter",detailCenter);	
		
//		model.addAttribute("addClass",new ClassDto());
		
//		staffService.UpdateRoles(center_code,staff_id,role);		//권한 부여하기
		return "class/centerInfo";
	}//원 조회
	
	@RequestMapping(value="centerUpdate")
	public String centerUpdate(Model model){
		sessionCheck();	
		System.out.println("UpdateCenter 시작!!!!!!!!!!!!!!");
		System.out.println("singleton:"+singleton.getCenter_code());
		
		List<CenterDto> detailCenter = centerService.detailCenter(singleton.getCenter_code());
		model.addAttribute("detailCenter",detailCenter);	
		
		List<korea_admin_areaDto> area_cityName =  korea_admin_areaService.selectArea_cityName();
		String[] si = detailCenter.get(0).getCenter_addr().split(" ");
		
		List<korea_admin_areaDto> gu =  korea_admin_areaService.selectArea_gu(si[0]);
		List<korea_admin_areaDto> dong =  korea_admin_areaService.selectArea_dong(si[0]);
		
		model.addAttribute("area_cityName",area_cityName);	//시
		model.addAttribute("gu",gu);	//구
		model.addAttribute("dong",dong);	//동
		
//		model.addAttribute("addClass",new ClassDto());
		
//		staffService.UpdateRoles(center_code,staff_id,role);		//권한 부여하기
		return "class/centerUpdate";
	}//원 수정
	
	@RequestMapping(value="saveUpdaeCenter",method=RequestMethod.POST)
	public String saveUpdaeCenter(Model model,@ModelAttribute CenterDto centerDto,
			@RequestParam("center_pho_url") List<MultipartFile> file_url){
		sessionCheck();	
		String si = centerDto.getCenter_addr_si();
		String gu = centerDto.getCenter_addr_gu();
		String dong = centerDto.getCenter_addr_dong();
		System.out.println(si+" "+gu+" "+dong);
		System.out.println(centerDto.getCenter_addr());
		
		String time= centerDto.getOpenTime()+"~"+centerDto.getCloseTime();
		centerDto.setCenter_otim(time);
		centerDto.setCenter_code(singleton.getCenter_code());
		
		
		
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
	 	                  centerDto.setCenter_pho(ImageUrlList.get(0));   
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
	      
	       
	       
		centerService.UpdateCenter(centerDto);
//		model.addAttribute("addClass",new ClassDto());
		
//		staffService.UpdateRoles(center_code,staff_id,role);		//권한 부여하기
		return "redirect:/centerInfo";
	}//원 수정 등록
	
	@RequestMapping(value="addClassForm")
	public String addClassForm(Model model){
		sessionCheck();	
		System.out.println("addClassForm 시작!!!!!!!!!!!!!!");
		System.out.println("singleton:"+singleton.getCenter_code());
		
		List<StaffDto> staffList = staffService.Staff_selectTeacher(singleton.getCenter_code());
		model.addAttribute("staffList",staffList);	
		
		List<StaffDto> classList = staffService.getAllClassList(singleton.getCenter_code());
		model.addAttribute("classList",classList);
		
		List<KidDto> kidsList = kidService.getAllKidList(singleton.getCenter_code());
		model.addAttribute("kidsList",kidsList);
		
		List<ClassDto> allClassList= classService.allClassList(singleton.getCenter_code());
		model.addAttribute("allClassList", allClassList);
		
		model.addAttribute("addClass",new ClassDto());
		
//		staffService.UpdateRoles(center_code,staff_id,role);		//권한 부여하기
		return "class/addClassForm";
	}//반등록 폼
	
	
	@RequestMapping(value="addClass", method=RequestMethod.POST)
	public String addClass(ClassDto classDto){
		sessionCheck();	
		List<ClassDto> class_count =  classService.selectMaxClass_id(singleton.getCenter_code());	
		String class_id = singleton.getCenter_code() + "_C0_"+class_count.get(0).getMaxcount();
		System.out.println("class_id"+class_id);
		classDto.setClass_id(class_id);
		classDto.setCenter_code(singleton.getCenter_code());
//		classDto.setClass_id(singleton.getCenter_code()+classDto.getClass_id());
		
		classService.addClass(classDto);
		return "redirect:/ClassList";
	}//반등록
	
	@ResponseBody
	@RequestMapping(value="DeleteClass",method=RequestMethod.POST)	   
	public HashMap<String, Object> parent_checkStater(HttpServletRequest request){
		
		String classId = request.getParameter("classId");
		String center_code = singleton.getCenter_code();
		
		System.out.println("center_code:"+center_code);
		
		int deleteClass = classService.deleteClass(center_code,classId);
		HashMap<String, Object> hashmap = new HashMap<String,Object>();	
		hashmap.put("deleteClass", deleteClass); 	     
	    return hashmap;		
	}//반 삭제
	
	@RequestMapping(value="UpdateClassForm")
	public String updateClassForm(Model model,@RequestParam(value="class_id", required = false) String class_id){
		sessionCheck();	
		System.out.println("updateClassForm 시작!!!!!!!!!!!!!!"+class_id);
		System.out.println("singleton:"+singleton.getCenter_code());
		
		List<StaffDto> staffList = staffService.Staff_selectTeacher(singleton.getCenter_code());
		model.addAttribute("staffList",staffList);	
//		
//		List<StaffDto> classList = staffService.getAllClassList(singleton.getCenter_code());
//		model.addAttribute("classList",classList);
//		
//		List<KidDto> kidsList = kidService.getAllKidList(singleton.getCenter_code());
//		model.addAttribute("kidsList",kidsList);
		
		List<ClassDto> allClassList= classService.allClassList(singleton.getCenter_code());
		model.addAttribute("allClassList", allClassList);
		
		List<ClassDto> detailClass = classService.detailClass(singleton.getCenter_code(),class_id);
		model.addAttribute("detailClass", detailClass);
		
		model.addAttribute("addClass",new ClassDto());
		
//		staffService.UpdateRoles(center_code,staff_id,role);		//권한 부여하기
		return "class/UpdateClassForm";
	}//반수정 폼
	
	@RequestMapping(value="saveupdateClassForm", method = RequestMethod.POST)
	public String saveupdateClassForm(@ModelAttribute ClassDto classDto) 
	{	
		System.out.println("updateClassForm");
		classDto.setCenter_code(singleton.getCenter_code());
		classService.updateClass(classDto);		//
//		System.out.println("updateClassForm:::"+classDto.getClass_id());
		return "redirect:/ClassList";
	}//반 수정 DB
	
	
	@RequestMapping(value="detailClassForm")
	public String detailClassForm(Model model,HttpServletRequest request){
		sessionCheck();	
		
		String class_id = request.getParameter("class_id");
		System.out.println("class_id:"+class_id);
		
		List<ClassDto> detailClass = classService.detailClass(singleton.getCenter_code(),class_id);
		model.addAttribute("detailClass", detailClass);
		
		List<KidDto> detailClassKids= kidService.allClassKidsList(singleton.getCenter_code(),class_id);
		model.addAttribute("detailClassKids", detailClassKids);
		
		List<ClassDto> allClassList= classService.allClassList(singleton.getCenter_code());
		model.addAttribute("allClassList", allClassList);
		
		return "class/detailClassForm";
	}//반등록 폼
	
	
	@ResponseBody
	@RequestMapping(value="classId_Check",method=RequestMethod.POST)	   
	public HashMap<String, Object> classId_Check(HttpServletRequest request){
//		System.out.println("컨트롤에서 station_id_Check시작~");
		String code =  singleton.getCenter_code();					
		List<ClassDto> class_count =  classService.selectMaxClass_id(code);	
//		System.out.println("station_id_count :"+stationService.selectMaxStation_id(code));
		HashMap<String, Object> hashmap = new HashMap<String,Object>();	
		hashmap.put("class_count", class_count); 	     
	    return hashmap;		
	}//
	
	
	@RequestMapping(value="ClassList")
	public String ClassList(Model model){
		sessionCheck();
		
		List<ClassDto> allClassList= classService.allClassList(singleton.getCenter_code());
		model.addAttribute("allClassList", allClassList);
//		staffService.UpdateRoles(center_code,staff_id,role);		//권한 부여하기
		return "class/ClassList";
	}//반 조회
	
	@ResponseBody
	@RequestMapping(value="classSearch", method=RequestMethod.POST)
	public HashMap<String, Object> classSearch(@Valid @RequestParam HashMap<String,Object> param,StationInfo stationInfo){
		String searchName =(String) param.get("keyWord"); 
		
		HashMap<String, Object> hashmap = new HashMap<String,Object>();	
		List<ClassDto> searchKey= classService.searchClass(searchName,singleton.getCenter_code());
		hashmap.put("searchKey", searchKey);   

		return hashmap;
	}
	
	@ResponseBody
	@RequestMapping(value="checkName_class_name",method=RequestMethod.POST)	   
	 public boolean checkName_class_name(HttpServletRequest request,Model model){
		sessionCheck();	
		 String formData=  request.getParameter("formData"); 	     	      		 
		 String baseData=  request.getParameter("baseData"); 
		 System.out.println("formData : "+formData+"// baseData: "+baseData);
		 List<ClassDto> classList = classService.allClassList(singleton.getCenter_code());
				 
	      boolean nameCheck = true; //false : 이름 중복됨, true 중복 안됨.      
	    
	      
    	  for (int index = 0; index < classList.size(); index++) {
 	    	 
	    	   if(classList.get(index).getClass_name().equals(formData))
	    	   {
	    		   if(formData.equals(baseData))
	    		   {
	    			   System.out.println(formData);
	    			   System.out.println(baseData);
	    			 
	    			   nameCheck = true;
	    			   System.out.println(nameCheck);
	    		   }
	    		   else
	    		   {
	    			   System.out.println("formData : "+formData);
	    			   System.out.println("baseData : "+baseData);	    			  
	    			   nameCheck = false;
	    			   System.out.println(nameCheck);
	    		   }		   
	    	   }
	      }//중복 요소 검사 
	      return nameCheck;
   }//차량 이름 중복 검사
	@ResponseBody
	@RequestMapping(value="checkName_staff")	   
	 public boolean checkName_staff(HttpServletRequest request,Model model){
			
		 String formData=  request.getParameter("formData"); 	     	      		 
		 String baseData=  request.getParameter("baseData"); 
		 String chk= request.getParameter("chk");
		 String sem = request.getParameter("class_sem");
		 
		 System.out.println("class_sem:"+sem+"formData:"+formData+"/baseData:"+baseData+"/chk:"+chk);
		 
		 List<StaffDto> staffList = staffService.getChkStaff(chk,singleton.getCenter_code(),formData,sem);
//		 System.out.println("staffList: "+ staffList.get(0).getStaff_id_1());
//		 System.out.println("staffListSize: "+staffList.size());
		 boolean nameCheck = true; //false : 이름 중복됨, true 중복 안됨.      
    	  for (int index = 0; index < staffList.size(); index++) {
    		  if(chk.equals("1")){
    			  if(staffList.get(index).getStaff_id_1().equals(formData)){
	   	    		   if(formData.equals(baseData))
	   	    		   {
	   	    			   nameCheck = true;
	   	    		   }
	   	    		   else
	   	    		   {
	   	    			   nameCheck = false;
	   	    		   }		   
	   	    	   }
    		  }else{
    			  if(staffList.get(index).getStaff_id_2().equals(formData)){
	   	    		   if(formData.equals(baseData))
	   	    		   {
	   	    			   nameCheck = true;
	   	    		   }
	   	    		   else
	   	    		   {
	   	    			   nameCheck = false;
	   	    		   }		   
	   	    	   }
    		  }
 	    	 
	    	   
	      }//중복 요소 검사 
	      return nameCheck;
   }//차량 이름 중복 검사

}
