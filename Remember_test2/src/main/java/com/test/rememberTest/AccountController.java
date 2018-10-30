package com.test.rememberTest;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.SocketException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
public class AccountController {
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
		private Korea_admin_areaService korea_admin_areaService;
	 
	 protected static String FTP_IP   = "13.125.170.255"; // FTP 접속지 IP
	 protected static int    FTP_PORT = 21;             // FTP 접속지 Port
	 protected static String FTP_ID   = "hskim";        // ID
	 protected static String FTP_PWD  = "hskim21";        // PASSWORD
	 protected static String TOMCAT_PORT  = ":8080";        // TOMCAT_PORT
	 protected static String FTP_PATH = "";
    
    FTPClient ftpclient = null;
    
     public AccountController() {
    	 ftpclient = new FTPClient();
	}
//	private String registrant = "rlaskal12";
	
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
	@RequestMapping(value="findPassWord")	   
	public String findPassWord(HttpServletRequest request){
		return "account/findPassWord";		
	}//키드 시스템코드 체크
	@ResponseBody
	@RequestMapping(value="findPwForm",method=RequestMethod.POST)	   
	public HashMap<String, Object> findPwForm(HttpServletRequest request){
		System.out.println("=============signOut=============");
		String staff_id = request.getParameter("staff_id");
		String staff_name = request.getParameter("staff_name");
		String staff_phone = request.getParameter("staff_phone");
		
		List<StaffDto> findStaff_pw= staffService.findStaffPw(staff_id,staff_name,staff_phone);
		HashMap<String, Object> hashmap = new HashMap<String,Object>();	
		System.out.println("findStaff_pw:"+findStaff_pw.get(0).getStaff_pw());
		String accountPw = findStaff_pw.get(0).getStaff_pw();
		
		int length = accountPw.length();
		length = length-2;
		accountPw = accountPw.substring(0, length);
		accountPw = accountPw+"**";
		hashmap.put("accountPw", accountPw); 	     
	    return hashmap;	
	}//아이디 찾기
	@RequestMapping(value="findId")	   
	public String findId(HttpServletRequest request){
		return "account/findId";		
	}//키드 시스템코드 체크
	
	@ResponseBody
	@RequestMapping(value="findIdForm",method=RequestMethod.POST)	   
	public HashMap<String, Object> findIdForm(HttpServletRequest request){
		System.out.println("=============signOut=============");
		String staff_name = request.getParameter("staff_name");
		String staff_phone = request.getParameter("staff_phone");
		
		List<StaffDto> findStaff_id= staffService.findStaffId(staff_name,staff_phone);
		HashMap<String, Object> hashmap = new HashMap<String,Object>();	
		System.out.println("findStaff_id:"+findStaff_id.get(0).getStaff_id());
		String accountId = findStaff_id.get(0).getStaff_id();
		
		int length = accountId.length();
		length = length-2;
		accountId = accountId.substring(0, length);
		accountId = accountId+"**";
		hashmap.put("accountId", accountId); 	     
	    return hashmap;	
	}//아이디 찾기
	@ResponseBody
	@RequestMapping(value="signOut",method=RequestMethod.POST)	   
	public HashMap<String, Object> signOut(HttpServletRequest request){
		System.out.println("=============signOut=============");
//		SecurityContextHolder.clearContext();
		String staff_id = request.getParameter("staff_id");
		String staff_name = request.getParameter("staff_name");
		String re_staff_name = staff_name+"(탈퇴)"; 
		int check = staffService.getsignOut(singleton.getCenter_code(), staff_id,re_staff_name);
		
		System.out.println("check : "+check);
		HashMap<String, Object> hashmap = new HashMap<String,Object>();	
		hashmap.put("check", check); 	     
	    return hashmap;	
	}//탈퇴
	
	@RequestMapping(value="saveChangePassword",method=RequestMethod.POST)	   
	public String saveChangePassword(HttpServletRequest request){
		sessionCheck();	
		String staff_pw =  request.getParameter("staff_pw");	
		
		String staff_id = singleton.getId();
		System.out.println("staff_pw:"+staff_pw+"//staff_id: "+staff_id);
		staffService.changePassWord(singleton.getCenter_code(),staff_pw,staff_id);	
//		System.out.println("station_id_count :"+stationService.selectMaxStation_id(code));
		return "redirect:/mypage";		
	}//키드 시스템코드 체크
	@RequestMapping(value="changePassWord")
	public String changePassWord(Model model){
		sessionCheck();	
		
		return "account/changePassWord";
	}//내 정보
	@RequestMapping(value="checkedPassWord")
	public String changePw(Model model){
		sessionCheck();	
		System.out.println("checkedPassWord singleton.getId():"+singleton.getName());
		List<StaffDto> staffInfo = staffService.getDetailInfo(singleton.getCenter_code(),singleton.getId());
		
		model.addAttribute("staffInfo",staffInfo);
		
		return "account/checkedPassWord";
	}//내 정보
	
	@RequestMapping(value="mypage")
	public String mypage(Model model){
		sessionCheck();	
//		System.out.println("good:");
		System.out.println("mypage singleton.getId():"+singleton.getName());
//		staffService.UpdateStaff(singleton.getCenter_code(),singleton.getId(), staff_id, staff_name,staff_type, staff_phone, staff_email,staff_position);
//		staffService.UpdateRoles(center_code,staff_id,role);		//권한 부여하기
		List<StaffDto> staffInfo = staffService.getDetailInfo(singleton.getCenter_code(),singleton.getId());
		
		model.addAttribute("staffInfo",staffInfo);
		
		return "account/mypage";
	}//내 정보
	@ResponseBody
	@RequestMapping(value="checkPassword",method=RequestMethod.POST)	   
	public HashMap<String, Object> checkPassword(HttpServletRequest request){
		sessionCheck();	
		String staff_pw =  request.getParameter("staff_pw");		
		String staff_id = singleton.getId();
		List<StaffDto> passwordCheck =  staffService.checkPassWord(staff_pw,staff_id);	
//		System.out.println("station_id_count :"+stationService.selectMaxStation_id(code));
		HashMap<String, Object> hashmap = new HashMap<String,Object>();	
		boolean check = true;
		
		if(passwordCheck.size() == 0){
			check = false;
		}
		
		hashmap.put("passwordCheck", check); 	     
	    return hashmap;		
	}//키드 시스템코드 체크
	
	@RequestMapping(value="MypageUpdate")
	public String MypageUpdate(Model model){
		sessionCheck();	
		System.out.println("singleton.getId():"+singleton.getName());
		
		List<StaffDto> staffInfo = staffService.getDetailInfo(singleton.getCenter_code(),singleton.getId());
		
		model.addAttribute("staffInfo",staffInfo);
		model.addAttribute("SaveMypageForm",new StaffDto());
		return "account/MypageUpdate";
	}//내 수정 페이지
	
	@RequestMapping(value="SaveMypageForm", method=RequestMethod.POST)
	public String SaveMypageForm(StaffDto staffDto,
			@RequestParam("staff_phot_url") List<MultipartFile> file_url){
		sessionCheck();	
		
		staffDto.setCenter_code(singleton.getCenter_code());
		staffDto.setClass_id(singleton.getCenter_code()+staffDto.getClass_id());
		
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
	      
	      
		staffService.updateStaffInfo(staffDto);		//권한 부여하기
		return "redirect:/mypage";
	}//반등록
	
	
	@RequestMapping(value="UpdateAllStaff",method=RequestMethod.POST)
	public String UpdateAllStaff(
			@RequestParam("staff_id") List<String> staff_id,
			@RequestParam("staff_name") List<String> staff_name,
			@RequestParam("staff_phone") List<String> staff_phone,
			@RequestParam("staff_position") List<String> staff_position,
			@RequestParam("staff_type") List<String> staff_type,
			@RequestParam("staff_email") List<String> staff_email,
			@RequestParam("role") List<String> role){
		
//		System.out.println("good:");
		sessionCheck();	
		System.out.println("getStaff_name:"+staff_id);
		System.out.println("staff_name:"+staff_name);
		System.out.println("staff_phone:"+staff_phone);
		System.out.println("staff_position:"+staff_position);
		System.out.println("staff_type:"+staff_type);
		System.out.println("staff_email:"+staff_email);
		System.out.println("role:"+role);
		
		staffService.UpdateStaff(singleton.getCenter_code(),singleton.getId(), staff_id, staff_name,staff_type, staff_phone, staff_email,staff_position);
//		staffService.UpdateRoles(center_code,staff_id,role);		//권한 부여하기
		return "redirect:/accountList";
	}//교직원 계정 업데이트 
	
	
	
	@RequestMapping(value="accountList")
	public String accountList(Model model)
	{		
		System.out.println("==========singleTon:"+singleton.getCenter_code());
		sessionCheck();		
		
		List<StaffDto> positionType = staffService.positionType(singleton.getCenter_code());
		model.addAttribute("positionType",positionType);
		
		List<ClassDto> classList = classService.allClassList(singleton.getCenter_code());
		model.addAttribute("classList",classList);
		
		List<StaffDto> staffList = staffService.staffList_notAdmin_group(singleton.getCenter_code());
		model.addAttribute("staffList",staffList);	
		
		List<KidDto> kidsList = kidService.getAllKidList(singleton.getCenter_code());
		model.addAttribute("kidsList",kidsList);
		
		List<ParentDto> parentList = parentService.getAllParent(singleton.getCenter_code());
		model.addAttribute("parentList", parentList);
		
		List<KidDto> kidParentList = kidService.getParentList(singleton.getCenter_code());		
		model.addAttribute("kidParentList",kidParentList);
		
		model.addAttribute("center_code", singleton.getCenter_code());
		
		return "account/accountList";
	}//교직원 계정조회(목록)
	
	@ResponseBody
	@RequestMapping(value="updateRepreParent")	   
	public HashMap<String, Object> updateRepreParent(HttpServletRequest request){
		sessionCheck();	
		String kid_system_code = request.getParameter("kid_code");
		String par_id = request.getParameter("par_id");

				
		int update_parID =  kidService.updateRepreParentId(kid_system_code,par_id);	
//		System.out.println("station_id_count :"+stationService.selectMaxStation_id(code));
		HashMap<String, Object> hashmap = new HashMap<String,Object>();	
		hashmap.put("update_parID", update_parID); 	     
	    return hashmap;	
	}//키드 시스템코드 체크
	
	@RequestMapping(value="tab_parent")
	public String tab_parent(Model model)
	{		
		
		System.out.println("==========singleTon:"+singleton.getCenter_code());
		sessionCheck();		
		
		List<ParentDto> parentList = parentService.getAllParent(singleton.getCenter_code());
		model.addAttribute("parentList", parentList);
		
		model.addAttribute("center_code", singleton.getCenter_code());
		
		return "account/tab_parent";
	}//학부모 계정조회(목록)
	
	
	
	
	@RequestMapping("tab_teachers")
	public String tab_teacher(Model model,HttpServletRequest request){ 
		
		String staff_id =  request.getParameter("staff_id");
		System.out.println("staffList 시작시");
		
		List<ClassDto> classList = classService.allClassList(singleton.getCenter_code());
		model.addAttribute("classList",classList);
		
		List<StaffDto> staffList = staffService.staffList_notAdmin(singleton.getCenter_code());
		model.addAttribute("staffList",staffList);
		
		return "account/tab_teachers";
	}//교직원 계정 조회
	
	@RequestMapping("accountUpdate")
	public String accountUpdate(Model model,HttpServletRequest request,Map<String, Object> modelMap) throws UnsupportedEncodingException
	{	
//		modelMap.put("account_teacher",new StaffDto());
		
		System.out.println("tab_teachers_update 시작시");
		System.out.println("single:"+singleton.getCenter_code());
		List<StaffDto> staffAccount = staffService.getAllStaffList(singleton.getCenter_code());
		List<StaffDto> classList = staffService.getAllClassList(singleton.getCenter_code());
		
		model.addAttribute("staffAccount",staffAccount);		//교직원 정보	
		model.addAttribute("classList",classList);		//반 리스트
		
		return "account/accountUpdate";
	}//교직원 계정 수정
	
	@RequestMapping("tab_teachers_update")
	public String tab_teachers_update(Model model,HttpServletRequest request,Map<String, Object> modelMap) throws UnsupportedEncodingException
	{	
//		modelMap.put("account_teacher",new StaffDto());
		
		System.out.println("tab_teachers_update 시작시");
		String staff_id =  request.getParameter("staff_id");
		System.out.println("staff_id:"+staff_id);
		
		List<StaffDto> staffAccount = staffService.getStaffAccount(singleton.getCenter_code(),staff_id);
		List<StaffDto> classList = staffService.getAllClassList(singleton.getCenter_code());
		
		model.addAttribute("staffAccount",staffAccount);		//교직원 정보	
		model.addAttribute("classList",classList);		//반 리스트
		
		return "account/tab_teachers_update";
	}//교직원 계정 수정
	
	@RequestMapping(value="UpdateStaffAccount", method = RequestMethod.POST)
	public String UpdateStaffAccount(@ModelAttribute StaffDto staffDto,
			@RequestParam("staff_photo_url") List<MultipartFile> file_url) 
	{	
		sessionCheck();	
		System.out.println("UpdateStaffAccount 시작");
		System.out.println("staff_id_type:"+staffDto.getStaff_id_type());
		staffDto.setCenter_code(singleton.getCenter_code());
		System.out.println("classId:" +staffDto.getClass_id());

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
//	       System.out.println("ImageUrlList"+ImageUrlList.get(0));
	      
		staffService.updateStaffInfo(staffDto);		//권한 부여하기
		System.out.println("classId :"+staffDto.getClass_id());
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
	}//교직원 계정 수정 처리
	
	@ResponseBody
	@RequestMapping(value="kid_system_code_Check",method=RequestMethod.POST)	   
	public HashMap<String, Object> kid_system_code_Check(HttpServletRequest request){
		sessionCheck();	
//		System.out.println("컨트롤에서 station_id_Check시작~");
		String code =  request.getParameter("center_code");					
		List<KidDto> kid_code_count =  kidService.selectMaxKid_code(code);	
//		System.out.println("station_id_count :"+stationService.selectMaxStation_id(code));
		HashMap<String, Object> hashmap = new HashMap<String,Object>();	
		hashmap.put("kid_code_count", kid_code_count); 	     
	    return hashmap;		
	}//키드 시스템코드 체크
	
	@RequestMapping(value = "accountForm_kids", method = RequestMethod.GET)
	public String accountForm_kids(Model model,HttpServletRequest request){ 
		sessionCheck();	
		List<korea_admin_areaDto> area_cityName =  korea_admin_areaService.selectArea_cityName();
		List<StaffDto> classList = staffService.getAllClassList(singleton.getCenter_code());
		model.addAttribute("area_cityName",area_cityName);			//시
		model.addAttribute("classList",classList);		//반 리스트
		model.addAttribute("kidsForm",new KidDto());
		model.addAttribute("center_code",singleton.getCenter_code());
		
		List<KidDto> kidsList = kidService.getAllKidList(singleton.getCenter_code());
		model.addAttribute("kidsList",kidsList);
		
		System.out.println("tab_kid 시작시");
		
		return "account/accountForm_kids";
	}//교직원 계정 조회
	
	@RequestMapping(value="insert_kids", method = RequestMethod.POST)	//원장 원등록 insert
	public String insert_kids( KidDto kidDto,
			@RequestParam("kid_pho_url") List<MultipartFile> file_url) {
		sessionCheck();
		
		String kidAddr = kidDto.getKid_addr();
		String kidAddr_rem = kidDto.getKid_addr_rem();
		String kidBlood = kidDto.getKid_blood();
		kidBlood = kidBlood + kidDto.getBloodRh();
		kidDto.setKid_blood(kidBlood);
		
		kidDto.setKid_addr(kidAddr+" "+kidAddr_rem);
		
		System.out.println("setKid_addr:"+kidDto.getKid_addr());
		

		if(!file_url.get(0).isEmpty()){kidDto.setKid_pho("http://13.125.170.255:8080/Spring/Account/Image/2109059_01_20180108114141_image_ujacar_290x290.png");}
//		
		if(kidDto.getkid_retire_r().equals("")){
			kidDto.setkid_retire_r("0000-00-00");
		}
		System.out.println("class"+kidDto.getClass_id());
		
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
	    		 kidDto.setKid_pho(ImageUrlList.get(0));   
	    			
	      }	      
	    List<KidDto> kid_code_count =  kidService.selectMaxKid_code(singleton.getCenter_code());	
	    
	    String kid_system_code = singleton.getCenter_code() + "_K_" +  kid_code_count.get(0).getMaxcount();
	    kidDto.setKid_system_code(kid_system_code);
		
		kidDto.setCenter_code(singleton.getCenter_code());
		kidDto.setStaff_id(singleton.getId());
		kidService.addKidsInfo(kidDto);		//권한 부여하기
		
		
		return "redirect:/accountList";
	}// 원아 등록
	
	
	@RequestMapping(value="tab_kid")
	public String tab_kid(Model model,HttpServletRequest request){ 
		sessionCheck();	
		System.out.println("tab_kid 시작시");
//		int total=10;
//		if(pageid==1){}
//		else{
//			pageid=(pageid-1)*total+1;
//		}
		
		List<KidDto> kidsList = kidService.getAllKidList(singleton.getCenter_code());
		model.addAttribute("kidsList",kidsList);
		List<KidDto> kidParentList = kidService.getParentList(singleton.getCenter_code());		
		model.addAttribute("kidParentList",kidParentList);
		
		return "account/tab_kid";
	}//원아 조회
	
	@ResponseBody
	@RequestMapping(value="tab_kid_delete",method=RequestMethod.POST)	   
	public HashMap<String, Object> tab_kid_delete(HttpServletRequest request){
		
		String kid_system_code =  request.getParameter("kid_system_code");
		String center_code = singleton.getCenter_code();
		System.out.println("=======kid_system_code:"+kid_system_code);
		System.out.println("center_code:"+center_code);
		
		HashMap<String, Object> hashmap = new HashMap<String,Object>();	
		int deleteKid;
		try {
			deleteKid = kidService.deleteKid(center_code,kid_system_code);
			hashmap.put("deleteKid", deleteKid); 
		} catch (Exception e) {
			deleteKid = 0;
			hashmap.put("deleteKid", deleteKid); 
		}	     
		
		
	    return hashmap;		
	}//학부모 승인 거절 체크
	
	@ResponseBody
	@RequestMapping(value="tab_teacher_delete",method=RequestMethod.POST)	   
	public HashMap<String, Object> tab_teacher_delete(HttpServletRequest request){
		
		String staff_id =  request.getParameter("staff_id");
		String staff_name = request.getParameter("staff_name");
		String center_code = singleton.getCenter_code();
		String downRoles = "MEMBER_OUT";
		
		List<StaffDto> StaffRole = staffService.staffList_StaffRoles(center_code, staff_id);
		
		 
		HashMap<String, Object> hashmap = new HashMap<String,Object>();	
		
		if((StaffRole.get(0).getRole()).equals("MEMBER_OUT")) {
			hashmap.put("tab_teacher_delete", 0);
		}
		else{
			staff_name = staff_name+"(탈퇴)";
			System.out.println("center_code:"+center_code);
			
			int tab_teacher_delete = staffService.deleteStaff(center_code,staff_id,staff_name);
			staffService.staffDownRoles(center_code,staff_id,downRoles);//권한 낮추기
			System.out.println("tab_teacher_delete:"+tab_teacher_delete);
	
			hashmap.put("tab_teacher_delete", 1);
		} 	
		System.out.println("hashmap : " + hashmap);
	    return hashmap;		
	}//학부모 승인 거절 체크
	
	
	
	@RequestMapping(value="tab_kid_update",method=RequestMethod.GET)
	public String tab_kid_update(Model model,HttpServletRequest request)
	{
		sessionCheck();	
//		model.addAttribute("kidsUpdateForm",new KidDto());
		
		String kid_system_code =  request.getParameter("kid_system_code");
		
		List<KidDto> KidsInfo = kidService.getKidsInfo(singleton.getCenter_code(),kid_system_code);
		List<StaffDto> classList = staffService.getAllClassList(singleton.getCenter_code());
		
		List<korea_admin_areaDto> area_cityName =  korea_admin_areaService.selectArea_cityName();
		String[] si = KidsInfo.get(0).getKid_addr().split(" ");
		
		List<korea_admin_areaDto> gu =  korea_admin_areaService.selectArea_gu(si[0]);
		List<korea_admin_areaDto> dong =  korea_admin_areaService.selectArea_dong(si[0]);
		
		model.addAttribute("area_cityName",area_cityName);	//시
		model.addAttribute("classList",classList);	// 반 리스트
		model.addAttribute("KidsInfo",KidsInfo);	//한 원아에 대한 원아 정보
		model.addAttribute("gu",gu);	//구
		model.addAttribute("dong",dong);	//동
		
		return "account/tab_kid_update";
	}//원아 정보 수정
	
	@RequestMapping(value="update_kids", method = RequestMethod.POST)
	public String UpdateKidsInfo(@ModelAttribute KidDto kidDto,
			@RequestParam("kid_pho_url") List<MultipartFile> file_url) 
	{	
		sessionCheck();	
		System.out.println("getkid_retire_r:"+kidDto.getkid_retire_r() );
		System.out.println("getStaff_id:"+singleton.getId());
		
		String kidBlood = kidDto.getKid_blood();
		kidBlood = kidBlood + kidDto.getBloodRh();
		kidDto.setKid_blood(kidBlood);
		
		kidDto.setStaff_id(singleton.getId());
//		if(kidDto.getkid_retire_r()==" "){
//			System.out.println("null");
//			kidDto.setkid_retire_r("0000-00-00");
//		}
//		kidDto.setStaff_id(singleton.getId());
//		String test = kidDto.getkid_retire_r();
//		if(test==null){
//			System.out.println("널 입니다.");
//		}
		
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
	 	                   
	 	                  kidDto.setKid_pho(ImageUrlList.get(0));   
	 	                  
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
	      System.out.println("addr : "+kidDto.getKid_addr());
	      kidService.updateKidsInfo(kidDto);		//원아 정보 수정
		
		return "redirect:/accountList";
	}//교직원 계정 수정 처리
	
	@ResponseBody
	@RequestMapping(value="parent_checkStater",method=RequestMethod.POST)	   
	public HashMap<String, Object> parent_checkStater(HttpServletRequest request){
		
		String par_id = request.getParameter("par_id");
		String stater = request.getParameter("check_stater");
		String kid_code = request.getParameter("kid_code");
		String center_code = singleton.getCenter_code();
		
		String isCheck =kidService.checkParent(kid_code);		//원아에 학부모 들어가있는지 체크
		System.out.println("par_id:"+par_id);
		System.out.println("check_stater:"+stater);
		System.out.println("kid_code:"+kid_code);
		System.out.println("isCheck:"+isCheck);
		if(stater.equals("승인")){
			if(isCheck.equals("1")){
				kidService.updateParentId(kid_code,par_id);
//				System.out.println("if ==isCheck:"+isCheck);
			}
		}
		
		int check_Stater = parentService.updateStater(center_code,par_id,stater,kid_code);
		HashMap<String, Object> hashmap = new HashMap<String,Object>();	
		hashmap.put("check_Stater", check_Stater); 	     
	    return hashmap;		
	}//학부모 승인 거절 체크
	
	@ResponseBody
	@RequestMapping(value="kidsSearch",method=RequestMethod.POST)	   
	public HashMap<String, Object> kidsSearch(HttpServletRequest request){
		
		String keyWord = request.getParameter("keyWord");
		
		List<KidDto> kidsSearchResult = kidService.getkidsSearchResult(singleton.getCenter_code(),keyWord);
		HashMap<String, Object> hashmap = new HashMap<String,Object>();	
		hashmap.put("kidsSearchResult", kidsSearchResult); 	     
	    return hashmap;		
	}//반별 원아 리스트
	
	@ResponseBody
	@RequestMapping(value="kidsInClass",method=RequestMethod.POST)	   
	public HashMap<String, Object> kidsInClass(HttpServletRequest request){
		
		String class_id = request.getParameter("class_id");
		
		List<KidDto> kidsListInClass = kidService.getkidsListInClass(singleton.getCenter_code(),class_id);
		HashMap<String, Object> hashmap = new HashMap<String,Object>();	
		hashmap.put("kidsListInClass", kidsListInClass); 	     
	    return hashmap;		
	}//원아 검색
	
	
	@RequestMapping(value="staffInfo", method = RequestMethod.GET)	//원장 원등록 insert
	public String staffInfo(HttpServletRequest request,Model model) {			
		sessionCheck();	
		String staffId = request.getParameter("staffId");
		
		List<StaffDto> staff_Info = staffService.getStaffInfo(singleton.getCenter_code(),staffId);
		model.addAttribute("staff_Info",staff_Info);
		
		return "account/staffInfo";
	}// 교직원 계정 상세 조회
	
	@RequestMapping(value="kidInfo", method = RequestMethod.GET)	//원장 원등록 insert
	public String kidInfo(HttpServletRequest request,Model model) {			
		sessionCheck();	
		String kidCode = request.getParameter("kidCode");
		
		List<KidDto> kid_Info = kidService.getKidInfo(singleton.getCenter_code(),kidCode);
		model.addAttribute("kid_Info",kid_Info);
		
		List<ParentDto> kidsParent = parentService.getKidsParent(singleton.getCenter_code(),kidCode);
		if(kidsParent.size()>0){
			model.addAttribute("kidsParent",kidsParent);
			model.addAttribute("length",kidsParent.size());
		}else{
			model.addAttribute("kidsParent",'-');
			model.addAttribute("length",0);
		}
		
		
		return "account/kidInfo";
	}// 원아 상세 조회
	@ResponseBody
	@RequestMapping(value="staffId_orderBy")
	public HashMap<String, Object> staffId_orderBy(HttpServletRequest request,
			Model model){
		sessionCheck();	
		String oderBy_type = request.getParameter("orderBy_type");
		String obj = request.getParameter("obj");//1: 아이디, 2: 이름, 3:직책, 4:반	
		
		String sortSelect = request.getParameter("sortSelect");
		
		List<StaffDto> staffList = staffService.selectAllStaff_sort(singleton.getCenter_code(), oderBy_type, obj,sortSelect);
//		model.addAttribute("staffList",staffList);	
		
		HashMap<String, Object> hashmap = new HashMap<String, Object>();	
		hashmap.put("staffList", staffList);
		return hashmap;
	}
	
	@ResponseBody
	@RequestMapping(value="staffId_orderBy_Kids")
	public HashMap<String, Object> staffId_orderBy_Kids(HttpServletRequest request,
			Model model){
		sessionCheck();	
		String orderBy_type = request.getParameter("orderBy_type");
		String obj = request.getParameter("obj");//1: 이름, 2: 생년월일, 3:성별, 4:반, 5:혈액형	
		
		String sortSelect = request.getParameter("sortSelect");
		
		List<KidDto> kidsList = kidService.getAllKidList_sort(singleton.getCenter_code(), orderBy_type, obj,sortSelect);
//		model.addAttribute("staffList",staffList);	
		List<KidDto> kidParentList = kidService.getParentList(singleton.getCenter_code());
		
		HashMap<String, Object> hashmap = new HashMap<String, Object>();	
		hashmap.put("kidsList", kidsList);
		hashmap.put("kidParentList", kidParentList);
		return hashmap;
	}
	
	@ResponseBody
	@RequestMapping(value="orderBy_Parent")
	public HashMap<String, Object> orderBy_Parent(HttpServletRequest request,
			Model model){
		sessionCheck();	
		String orderBy_type = request.getParameter("orderBy_type");
		String obj = request.getParameter("obj");//1: 부모아이디, 2: 부모이름, 3:자녀이름	
		
		List<ParentDto> parentList = parentService.getAllParent_sort(singleton.getCenter_code(), orderBy_type, obj);	
		
		HashMap<String, Object> hashmap = new HashMap<String, Object>();	
		hashmap.put("parentList", parentList);
		return hashmap;
	}
	
	
	@ResponseBody
	@RequestMapping(value="check_staff_id",method=RequestMethod.POST)	   
	 public boolean checkName(HttpServletRequest request){
			
		 String formData=  request.getParameter("formData"); 	     	      		 
		 
		 List<StaffDto> StaffList = staffService.getStaffIdCheck(formData);
	      boolean nameCheck = true; //false : 이름 중복됨, true 중복 안됨.
	      
	      
	      if(StaffList.size()==0) {
	    	  System.out.println("1");
			  System.out.println(formData);
			  nameCheck = true;
	      }
	      else {
	    	  System.out.println("2");
			   System.out.println(formData);	    			  
			   nameCheck = false;
	      }	    
    	  System.out.println(nameCheck);
	      return nameCheck;
	            
   }//
}
