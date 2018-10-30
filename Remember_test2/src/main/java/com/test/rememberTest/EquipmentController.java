package com.test.rememberTest;

import java.io.IOException;
import java.net.SocketException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
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

import com.test.rememberTest.Dao.Becon.BeaconService;
import com.test.rememberTest.Dao.Car.CarService;
import com.test.rememberTest.Dao.Class.ClassService;
import com.test.rememberTest.Dao.Equipment.EquipmentService;
import com.test.rememberTest.Dao.Kid.KidService;
import com.test.rememberTest.Dao.Staff.StaffService;
import com.test.rememberTest.Dto.BeaconDto;
import com.test.rememberTest.Dto.Car;
import com.test.rememberTest.Dto.ClassDto;
import com.test.rememberTest.Dto.EquipmentDto;
import com.test.rememberTest.Dto.KidDto;
import com.test.rememberTest.Dto.Singleton;
import com.test.rememberTest.Dto.StaffDto;

@Controller
public class EquipmentController {
	 
	 @Autowired
	 private StaffService staffService;
	 @Autowired
	 private EquipmentService equipmentService;
	 @Autowired
	 private CarService carService;
	 @Autowired
	 private BeaconService beaconService; 
	 @Autowired
	 private ClassService classService;
	 @Autowired
	 private KidService kidService;
	 
	 protected static String FTP_IP   = "192.168.0.30"; // FTP 접속지 IP
	    protected static int    FTP_PORT = 65500;             // FTP 접속지 Port
	    protected static String FTP_ID   = "hskim";        // ID
	    protected static String FTP_PWD  = "1234";        // PASSWORD
	    protected static String TOMCAT_PORT  = ":8080";        // TOMCAT_PORT
	    protected static String FTP_PATH = "";
	    
	    FTPClient ftpclient = null;
	    
	    public EquipmentController() {
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
	@ResponseBody
	@RequestMapping(value="autoMatching",method={RequestMethod.GET, RequestMethod.POST})
	public HashMap<String, Object> autoMatching(Model model,HttpServletRequest request){
		sessionCheck();
		
		//총 원아 수
		List<KidDto> allKids = kidService.getAllKidList(singleton.getCenter_code());
		//총 비콘 
		List<BeaconDto> allBeacon = beaconService.getBeaconList(singleton.getCenter_code());
		System.out.println("234:"+allBeacon.size());
		
		String autoMatching = request.getParameter("mathchingFirst");
		System.out.println("autoMatching:"+autoMatching);
		
		int autoMatchingResult=0;
		if(autoMatching.equals("0")){
			autoMatchingResult = beaconService.autoMatching(singleton.getCenter_code(),allBeacon,allKids);
		}
		
		HashMap<String, Object> hashmap = new HashMap<String,Object>();	
		hashmap.put("autoMatchingResult", autoMatchingResult); 
		
	    return hashmap;
	}
	
	@ResponseBody
	@RequestMapping(value="updateMatchingCut",method={RequestMethod.GET, RequestMethod.POST})
	public HashMap<String, Object> updateMatchingCut(Model model,HttpServletRequest request){
		sessionCheck();
		String[] checkArray = request.getParameterValues("chk");
		String[] beacon_idArray = request.getParameterValues("beacon_id");
		String[] kid_system_codeArray = request.getParameterValues("kid_system_code");
//		System.out.println("checkArray:"+checkArray[0]);
//		System.out.println("checkArray:"+checkArray[1]);
//		System.out.println("checkArray:"+checkArray[2]);
//		System.out.println("checkArray:"+checkArray[3]);
//		System.out.println("kid_system_code:"+kid_system_codeArray.length);
		
		System.out.println("checkArray.length:"+checkArray.length);
		System.out.println("beacon_idArray.length:"+beacon_idArray.length);
		System.out.println("kid_system_codeArray.length:"+kid_system_codeArray.length);
		
		int updateCut = beaconService.getCutMatching(singleton.getCenter_code(),checkArray,beacon_idArray,kid_system_codeArray);
//		int def = beaconService.cutMatching(singleton.getCenter_code(),checkArray,beacon_idArray,kid_system_codeArray);
		HashMap<String, Object> hashmap = new HashMap<String,Object>();	
	    return hashmap;
	}
	
	@ResponseBody
	@RequestMapping(value="beaconCondition",method=RequestMethod.POST)	   
	public HashMap<String, Object> beaconCondition(Model model,HttpServletRequest request){
		System.out.println("=============signOut=============");
		sessionCheck();
		String search_Keyword = request.getParameter("search_Keyword");
		if(search_Keyword==""){search_Keyword=null;}
		String search_ClassId = request.getParameter("search_ClassId");
		String search_ClassYear = request.getParameter("search_ClassYear");
		
//		model.addAttribute("matchingSave",new EquipmentDto());
		List<BeaconDto> matchingCondition = beaconService.getBeaconCondition(singleton.getCenter_code(),search_Keyword,search_ClassId,search_ClassYear);
	
		HashMap<String, Object> hashmap = new HashMap<String,Object>();	
		hashmap.put("data", matchingCondition); 	     
	    return hashmap;	
	}//아이디 찾기
	
	
	@RequestMapping(value="matchingPresentCondition")
	public String matchingPresentCondition(Model model){
		sessionCheck();
		
		List<KidDto> notMatchingKids = kidService.notMatchingCount(singleton.getCenter_code());
		model.addAttribute("notMatchingKids", notMatchingKids);
		
		List<ClassDto> kindOfClass = classService.allClassList(singleton.getCenter_code());
		model.addAttribute("kindOfClass", kindOfClass);
		
		List<KidDto> kidAge = classService.getKidAge(singleton.getCenter_code()); //연령대
		model.addAttribute("kidAge", kidAge);
//		int def = beaconService.updateMatching(singleton.getCenter_code(),beacon_id,kid_system_code);
	    return "equipment/matchingPresentCondition";
	}
	
	
	@RequestMapping(value="matchingSave",method={RequestMethod.POST,RequestMethod.GET})
	public String matchingSave(HttpServletRequest request){
		sessionCheck();
		
		String[] beacon_idArray = request.getParameterValues("beacon_id");
		String[] kid_Array = request.getParameterValues("kid_system_code");
		
		System.out.println("beacon_idArray:"+beacon_idArray);
		
		System.out.println("beacon_idArray:"+beacon_idArray.length);
		System.out.println("kid_Array:"+kid_Array.length);
		System.out.println("kid_Array:"+kid_Array[0]);
		int def = beaconService.updateMatching(singleton.getCenter_code(),beacon_idArray,kid_Array);
		HashMap<String, Object> hashmap = new HashMap<String,Object>();	
		hashmap.put("def", def); 	     
	    return "redirect:/matchingPresentCondition";
	}
	
	@ResponseBody
	@RequestMapping(value="matchingKidsNBeacon",method=RequestMethod.POST)	   
	public HashMap<String, Object> matchingKidsNBeacon(Model model,HttpServletRequest request){
		System.out.println("=============signOut=============");
		sessionCheck();
		String search_Keyword = request.getParameter("search_Keyword");
		if(search_Keyword==""){search_Keyword=null;}
		String search_ClassId = request.getParameter("search_ClassId");
		String search_ClassYear = request.getParameter("search_ClassYear");
		
		System.out.println("========"+search_Keyword+"========"+search_ClassId+"========"+search_ClassYear);
		model.addAttribute("matchingSave",new EquipmentDto());
//		int chk = equipmentService.getDeleteEquipment(singleton.getCenter_code(),equipmentArray);
		List<KidDto> matchingKids = kidService.getMatchingKids(singleton.getCenter_code(),search_Keyword,search_ClassId,search_ClassYear);
		HashMap<String, Object> hashmap = new HashMap<String,Object>();	
		hashmap.put("matchingKids", matchingKids); 	     
	    return hashmap;	
	}//아이디 찾기
	
	@RequestMapping(value="beaconMatching", produces="text/plain;charset=UTF-8")
	public String beaconMatching(Model model,HttpServletRequest request) throws Exception{
		sessionCheck();	
		
		List<KidDto> notMatchingKids = kidService.notMatchingCount(singleton.getCenter_code());
		model.addAttribute("notMatchingKids", notMatchingKids);
//		System.out.println("notMatchingKids:"+notMatchingKids.get(0).getBeaconCnt());
		List<BeaconDto> allOfBeacon = beaconService.matchingBeaconList(singleton.getCenter_code());
		model.addAttribute("allOfBeacon", allOfBeacon);
		
//		System.out.println("beacon_phot: "+allOfBeacon.get(0).getBeacon_phot());
		List<ClassDto> kindOfClass = classService.allClassList(singleton.getCenter_code());
		model.addAttribute("kindOfClass", kindOfClass);
		
		List<KidDto> kidAge = classService.getKidAge(singleton.getCenter_code()); //연령대
		model.addAttribute("kidAge", kidAge);
		
		return "equipment/beaconMatching";
	}//기기배정 상세조회
	
	@RequestMapping(value="installEquipmentDetail", produces="text/plain;charset=UTF-8")
	public String installEquipmentDetail(Model model,HttpServletRequest request) throws Exception{
		sessionCheck();	
		request.setCharacterEncoding("utf-8");
		String equipment_id = request.getParameter("equipment_id");
		String equipment_type = request.getParameter("equipment_type");
		System.out.println("equipment_type:"+equipment_type);
		if(equipment_type.equals("게이트웨이")){
			List<EquipmentDto> gateway_List = equipmentService.getGateWayList(singleton.getCenter_code());
			model.addAttribute("equip_List",gateway_List);
		}else{
			List<EquipmentDto> tabletList = equipmentService.getTabletList(singleton.getCenter_code());
			model.addAttribute("equip_List",tabletList);
		}
		System.out.println("equipment_id:"+equipment_id+"// equipment_type:"+equipment_type);
		
		List<EquipmentDto> detailGateway =  equipmentService.getDetailTablet(equipment_id,singleton.getCenter_code());	
		model.addAttribute("data", detailGateway);
		
		return "equipment/installEquipmentDetail";
	}//기기배정 상세조회
	
	@RequestMapping(value="installEqu_UpdateSave",method=RequestMethod.POST)
	public String installEqu_UpdateSave(EquipmentDto equipmentDto,HttpServletRequest request) throws Exception{
		sessionCheck();	
		String EQ_type= equipmentDto.getEquipment_type();
		System.out.println("=================");
		EQ_type = EQ_type.trim(); 
		System.out.println("EQ_type:"+EQ_type);
		equipmentDto.setCenter_code(singleton.getCenter_code());
		
		equipmentService.installEquipmentUpdate(equipmentDto);
		if(EQ_type.equals("테블릿")){
			System.out.println("테블릿");
			equipmentService.busEquipmentUpdateT(equipmentDto);
		}else{
			System.out.println("게이트웨이");
			equipmentService.busEquipmentUpdate(equipmentDto);
		}
	      equipmentService.busEquipmentUpdate(equipmentDto);
		return "redirect:/installEquipmentList";	
	}//기기배정 수정
	
	@RequestMapping(value="installEquipmentUpdate", produces="text/plain;charset=UTF-8")
	public String installEquipmentUpdate(Model model,HttpServletRequest request) throws Exception{
		sessionCheck();	
		
		String equipment_id = request.getParameter("equipment_id");
		
		System.out.println("equipment_id:"+equipment_id);
		
		List<EquipmentDto> detailGateway =  equipmentService.getDetailTablet(equipment_id,singleton.getCenter_code());	
		model.addAttribute("data", detailGateway);
		
		List<StaffDto> staffList = staffService.getAllStaffList(singleton.getCenter_code());
		model.addAttribute("staffList",staffList);	
		
		List<Car> carList = carService.getCarList(singleton.getCenter_code());	
        model.addAttribute("carList", carList);	
		
        model.addAttribute("installEqu_UpdateForm",new EquipmentDto());
		return "equipment/installEquipmentUpdate";
	}//기기배정 수정
	@ResponseBody
	@RequestMapping(value="DeleteEquipment",method=RequestMethod.POST)	   
	public HashMap<String, Object> DeleteEquipment(HttpServletRequest request){
		System.out.println("=============signOut=============");
		String[] equipmentArray = request.getParameterValues("arrayParam");		//넘겨받은 배열
	
//		for(int i=0;i<lisetDelete.size();i++){
//			deleteArray.add(deleteList.get(i));
//		}
//		for(int i=0;i<deleteList.size();i++){
//			System.out.println("Array:"+deleteArray.get(i));
//		}
		System.out.println("========"+equipmentArray.length);
//		System.out.println("========"+equipmentArray[1]);
//		System.out.println("========"+equipmentArray[0]);
		
		int chk = equipmentService.getDeleteEquipment(singleton.getCenter_code(),equipmentArray);
		HashMap<String, Object> hashmap = new HashMap<String,Object>();	
		hashmap.put("chk", chk); 	     
	    return hashmap;	
	}//아이디 찾기
	@RequestMapping(value="installEquipmentList")
	public String installEquipmentList(Model model){
		sessionCheck();	
		
		List<EquipmentDto> gateway_List = equipmentService.getGateWayList(singleton.getCenter_code());
		model.addAttribute("gateway_List",gateway_List);
		
		List<EquipmentDto> tabletList = equipmentService.getTabletList(singleton.getCenter_code());
		model.addAttribute("tabletList",tabletList);
		
		System.out.println("//////////gateway_List :"+gateway_List.get(0).getEquipment_install_man());
//		System.out.println(tabletList.get(3).getEquipment_id());
		return "equipment/installEquipmentList";
	}//기기배정
	@RequestMapping(value="installEquipment")
	public String installEquipment(Model model){
		sessionCheck();	
		
		List<EquipmentDto> gateway_List = equipmentService.getGateWayList(singleton.getCenter_code());
		model.addAttribute("gateway_List",gateway_List);
		
		System.out.println("//////////gateway_List :"+gateway_List.get(0).getEquipment_id());
//		System.out.println(tabletList.get(3).getEquipment_id());
		return "equipment/installEquipment";
	}//기기배정
	
	
	@RequestMapping(value="gatewayList")
	public String gatewayList(Model model){
		sessionCheck();	
		
		List<EquipmentDto> gateway_List = equipmentService.getGateWayList(singleton.getCenter_code());
		model.addAttribute("gateway_List",gateway_List);
		
		System.out.println("//////////gateway_List :"+gateway_List.get(0).getEquipment_id());
//		System.out.println(tabletList.get(3).getEquipment_id());
		return "equipment/gatewayList";
	}//게이트웨이 조회
	
//	@ResponseBody
	@RequestMapping(value="gatewayDetail",method=RequestMethod.POST)	   
	public String gatewayDetail(Model model,HttpServletRequest request){
		sessionCheck();	
		String equipment_id =  request.getParameter("equipment_id");
		List<EquipmentDto> detailGateway =  equipmentService.getDetailTablet(equipment_id,singleton.getCenter_code());	
		System.out.println("detailGateway :"+detailGateway .get(0).getEquipment_install());
		model.addAttribute("data", detailGateway); 	     
	    return "equipment/gatewayDetail";
	}//게이트웨이 상세조회
	
	@RequestMapping(value="gatewayUpdate", method=RequestMethod.POST)
	public String gatewayUpdate(Model model,HttpServletRequest request){
		sessionCheck();	
		
		String equipment_id = request.getParameter("equipment_id");
		System.out.println("equipment_id에서 equipment_id:"+equipment_id);
		List<EquipmentDto> detailGateway =  equipmentService.getDetailTablet(equipment_id,singleton.getCenter_code());
		model.addAttribute("detailGateway",detailGateway);
		List<StaffDto> staffList = staffService.staffList_notAdmin(singleton.getCenter_code());
		model.addAttribute("staffList",staffList);	
//		
		model.addAttribute("gatewayUpdateSave",new EquipmentDto());
		return "equipment/gatewayUpdate";
	}//비콘 수정
	
	@RequestMapping(value="gatewayUpdateSave",method=RequestMethod.POST)	   
	public String gatewayUpdateSave(HttpServletRequest request,EquipmentDto equipmentDto,
			@RequestParam("equipment_install_url") List<MultipartFile> file_url){
		sessionCheck();	
		equipmentDto.setCenter_code(singleton.getCenter_code());
		equipmentDto.setEquipment_type("게이트웨이");
		
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
	 	                   equipmentDto.setEquipment_install(ImageUrlList.get(0));   
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
	       
		
		equipmentService.UpdateEquipment(equipmentDto);
	    return "redirect:/gatewayList";		
	}//탭 수정 저장
	
	@ResponseBody
	@RequestMapping(value="BeaconSearch",method=RequestMethod.POST)	   
	public HashMap<String, Object> BeaconSearch(HttpServletRequest request){
		String keyWord = request.getParameter("keyWord");
		String equipment_type = request.getParameter("equipment_type");
	
		List<BeaconDto> beaconResult = beaconService.getBeaconSeach(singleton.getCenter_code(),keyWord);
		HashMap<String, Object> hashmap = new HashMap<String,Object>();	
		hashmap.put("beaconResult", beaconResult); 	     
	    return hashmap;	
	}//아이디 찾기
	
	
	@ResponseBody
	@RequestMapping(value="EquipmentSearch",method=RequestMethod.POST)	   
	public HashMap<String, Object> EquipmentSearch(HttpServletRequest request){
		String keyWord = request.getParameter("keyWord");
		String equipment_type = request.getParameter("equipment_type");
	
		List<EquipmentDto> equipmentResult = equipmentService.equipmentSearch(singleton.getCenter_code(),keyWord,equipment_type);
		HashMap<String, Object> hashmap = new HashMap<String,Object>();	
		hashmap.put("equipmentResult", equipmentResult); 	     
	    return hashmap;	
	}//아이디 찾기
	
	
	@RequestMapping(value="tabletList")
	public String tabletList(Model model){
		sessionCheck();	
		
		List<EquipmentDto> tabletList = equipmentService.getTabletList(singleton.getCenter_code());
		model.addAttribute("tabletList",tabletList);
//		System.out.println(tabletList.get(3).getEquipment_id());
		return "equipment/tabletList";
	}//탭조회
	
	
	
//	@ResponseBody
	@RequestMapping(value="tabletDetail")	   
	public String tabletDetail(Model model,HttpServletRequest request){
		sessionCheck();	
		String equipment_id =  request.getParameter("equipment_id");
		List<EquipmentDto> detailTablet =  equipmentService.getDetailTablet(equipment_id,singleton.getCenter_code());	
//		System.out.println("detailTablet :"+detailTablet.get(0).getEquipment_id());
//		System.out.println("detailTablet :"+detailTablet.get(0).getEquipment_install());
//		System.out.println("station_id_count :"+stationService.selectMaxStation_id(code));
		model.addAttribute("data", detailTablet); 	     
		return "equipment/tabletDetail";	
	}//비콘 상세조회
	
	@RequestMapping(value="tabletUpdate", method=RequestMethod.POST)
	public String tabletUpdate(Model model,HttpServletRequest request){
		sessionCheck();	
		
		String equipment_id = request.getParameter("equipment_id");
		System.out.println("equipment_id에서 equipment_id:"+equipment_id);
		List<EquipmentDto> detailTablet =  equipmentService.getDetailTablet(equipment_id,singleton.getCenter_code());
		model.addAttribute("detailTablet",detailTablet);
		System.out.println("detailTablet:"+detailTablet.get(0).getEquipment_id());
		System.out.println("detailTablet:"+detailTablet.get(0).getStaff_name());
		List<StaffDto> staffList = staffService.staffList_notAdmin(singleton.getCenter_code());
		model.addAttribute("staffList",staffList);	
		System.out.println("detailTablet:"+detailTablet.get(0).getStaff_name());
//		
		model.addAttribute("tableUpdateSave",new EquipmentDto());
		return "equipment/tabletUpdate";
	}//비콘 수정
	
	@RequestMapping(value="tabletUpdateSave",method=RequestMethod.POST)	   
	public String tabletUpdateSave(HttpServletRequest request,EquipmentDto equipmentDto,
			@RequestParam("equipment_install_url") List<MultipartFile> file_url){
		sessionCheck();	
		equipmentDto.setCenter_code(singleton.getCenter_code());
		equipmentDto.setEquipment_type("테블릿");
//		System.out.println("!file_url.get(0):"+file_url.get(0).toString());
		
		List<String> ImageUrlList = new ArrayList<String>();
	      List<String> fileUrlList = new ArrayList<String>();
	      List<String> fileTitle = new ArrayList<String>();
	      boolean upload_check = false;    
	    System.out.println("check : " + file_url.get(0).isEmpty());
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
	 	                  equipmentDto.setEquipment_install(ImageUrlList.get(0));
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
	    equipmentService.UpdateEquipment(equipmentDto);
	    return "redirect:/tabletList";		
	}//탭 수정 저장
	
	
//	@ResponseBody
	@RequestMapping(value="beaconDetail",method=RequestMethod.POST)	   
	public String BeaconDetail(Model model,HttpServletRequest request){
		sessionCheck();	
		System.out.println("=========beaconDetail==========");
		String beacon_id =  request.getParameter("beacon_id");
		List<BeaconDto> detailBeacon =  beaconService.getDetailBeacon(beacon_id,singleton.getCenter_code());	
//		System.out.println("station_id_count :"+stationService.selectMaxStation_id(code));
//		HashMap<String, Object> hashmap = new HashMap<String,Object>();	
		model.addAttribute("detailBeacon", detailBeacon); 	     
	    return "equipment/beaconDetail";		
	}//비콘 상세조회
	
	@RequestMapping(value="beaconUpdateSave",method=RequestMethod.POST)	   
	public String BeaconUpdateSave(HttpServletRequest request,BeaconDto beaconDto,
			@RequestParam("equipment_install_url") List<MultipartFile> file_url){
		System.out.println("beaconUpdateSave 시작");
		sessionCheck();	
		beaconDto.setCenter_code(singleton.getCenter_code());
		
		
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
	 	                   beaconDto.setBeacon_phot(ImageUrlList.get(0));  
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
	       
	    
	    
		beaconService.UpdateBeancon(beaconDto);	
//		System.out.println("station_id_count :"+stationService.selectMaxStation_id(code));
	    return "redirect:/beaconList";		
	}//비콘 수정 저장
	
	@RequestMapping(value="beaconUpdate", method=RequestMethod.POST)
	public String beaconAddForm(Model model,HttpServletRequest request){
		sessionCheck();	
		
		String beaconid = request.getParameter("beacon_id");
		System.out.println("beaconUpdate에서 beaconid:"+beaconid);
		List<BeaconDto> detailBeacon =  beaconService.getDetailBeacon(beaconid,singleton.getCenter_code());
		model.addAttribute("detailBeacon",detailBeacon);
		
		List<StaffDto> staffList = staffService.staffList_notAdmin(singleton.getCenter_code());
		model.addAttribute("staffList",staffList);	
//		
		model.addAttribute("beaconUpdateSave",new BeaconDto());
		return "equipment/beaconUpdate";
	}//비콘 수정
	@RequestMapping(value="beaconList")
	public String beaconList(Model model){
		sessionCheck();	
		
		List<BeaconDto> beaconList = beaconService.getBeaconList(singleton.getCenter_code());
		model.addAttribute("beaconList",beaconList);
		
		
		model.addAttribute("AddBeaconForm",new BeaconDto());
		return "equipment/beaconList";
	}//비콘 등록
//	@RequestMapping(value="SaveMypageForm", method=RequestMethod.POST)
//	public String SaveMypageForm(StaffDto staffDto){
//		sessionCheck();	
//		
//		staffDto.setCenter_code(singleton.getCenter_code());
//		staffDto.setClass_id(singleton.getCenter_code()+staffDto.getClass_id());
//		
//		staffService.updateStaffInfo(staffDto);		//권한 부여하기
//		return "redirect:/mypage";
//	}//반등록
	
	
}
