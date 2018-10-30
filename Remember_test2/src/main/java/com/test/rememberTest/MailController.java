package com.test.rememberTest;

import java.io.IOException;
import java.net.SocketException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.internet.MimeMessage;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPReply;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.test.rememberTest.Dao.Becon.BeaconService;
import com.test.rememberTest.Dao.Center.CenterService;
import com.test.rememberTest.Dao.Damege_goods.Damege_goodsService;
import com.test.rememberTest.Dao.Damege_goods.EmailSender;
import com.test.rememberTest.Dao.Equipment.EquipmentService;
import com.test.rememberTest.Dao.Staff.StaffService;
import com.test.rememberTest.Dto.BeaconDto;
import com.test.rememberTest.Dto.Car;
import com.test.rememberTest.Dto.CenterDto;
import com.test.rememberTest.Dto.ClassDto;
import com.test.rememberTest.Dto.Damege_goodsDto;
import com.test.rememberTest.Dto.EquipmentDto;
import com.test.rememberTest.Dto.Singleton;
import com.test.rememberTest.Dto.StaffDto;

@Controller
public class MailController {
	
	@Autowired
	private Damege_goodsService damege_goodsService;
	@Autowired
	private StaffService staffService;
	@Autowired
	private CenterService centerService;
	@Autowired
    private EmailSender emailSender;
	@Autowired
	private BeaconService beaconSerive;
	@Autowired
	private EquipmentService equipmentService;
	
	
	 protected static String FTP_IP   = "13.125.170.255"; // FTP 접속지 IP
	 protected static int    FTP_PORT = 21;             // FTP 접속지 Port
	 protected static String FTP_ID   = "hskim";        // ID
	 protected static String FTP_PWD  = "hskim21";        // PASSWORD
	 protected static String TOMCAT_PORT  = ":8080";        // TOMCAT_PORT
	 protected static String FTP_PATH = "";
	    
	FTPClient ftpclient = null;
	    
	public MailController() {
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
			singleton.setS_email(staffList.get(0).getStaff_email());
		}
	}
	@ResponseBody
	@RequestMapping(value="damageSearch",method=RequestMethod.POST)
    public HashMap<String, Object> damageSearch (Model model,HttpServletRequest request) throws Exception {
		sessionCheck();	
		String keyWord = request.getParameter("keyWord");
		
		List<Damege_goodsDto> damageSearch = damege_goodsService.getDamageSearch(singleton.getCenter_code(),keyWord);
		HashMap<String, Object> hashmap = new HashMap<String,Object>();
		hashmap.put("damageSearch", damageSearch);	
	    return hashmap;	
    }
	
	@RequestMapping(value="damegeDetail")
    public String damegeDetail (Model model,Damege_goodsDto email,ServletRequest request) throws Exception {
		sessionCheck();	
		String equipment_id = request.getParameter("damege_type"); 
		List<Damege_goodsDto> damegeDetail = damege_goodsService.damegeGoodsDetail(equipment_id);
		model.addAttribute("damegeDetail", damegeDetail);
         	     
		return "contactUs/damegeDetail";
    }
	
	@RequestMapping(value="asList")
	public String asList(Model model,HttpServletRequest request){
		sessionCheck();	
		
		List<Damege_goodsDto> allDamegeList = damege_goodsService.allDamegeGoodsList(singleton.getCenter_code());
		model.addAttribute("allDamegeList", allDamegeList);
		
		return "contactUs/asList";
	}//기기배정 상세조회
	
	@ResponseBody
	@RequestMapping(value="findAllEquipment",method=RequestMethod.POST)
    public HashMap<String, Object> findAllEquipment (Model model,Damege_goodsDto email,ServletRequest request) throws Exception {
		sessionCheck();	
		
		String type= request.getParameter("equipment_type");
		type=type.trim();
		String kind= request.getParameter("equipment_kind");
		System.out.println("type:"+type+"// kind:"+kind);
		HashMap<String, Object> hashmap = new HashMap<String,Object>();
//		type="비콘";
		System.out.println("typeSize:"+type.length());
		if(type.equals("비콘")){
			List<BeaconDto> equi_List = beaconSerive.getBeaconList(singleton.getCenter_code());
			System.out.println("eq1 :"+equi_List.get(0).getBeacon_id());
			hashmap.put("equi_List", equi_List);
		}
		else{
			if(type.equals("테블릿")){
				List<EquipmentDto> equi_List = equipmentService.getTabletList(singleton.getCenter_code());
				System.out.println("eq2 :"+equi_List.get(0).getEquipment_id());
				hashmap.put("equi_List", equi_List);	
			}
			else{
				List<EquipmentDto> equi_List = equipmentService.getGateWayList(singleton.getCenter_code());
				System.out.println("eq3 :"+equi_List.get(0).getEquipment_id());
				hashmap.put("equi_List", equi_List);	
			}
			
		}
        System.out.println("type:"+type);
         	     
	    return hashmap;	
    }
	
//	@ResponseBody
	@RequestMapping(value="sendMail", method=RequestMethod.POST)
    public String sendEmailAction (Model model,Damege_goodsDto email,ServletRequest request,
			@RequestParam("damege_photo_url") List<MultipartFile> file_url) throws Exception {
		sessionCheck();	
//        Damege_goodsDto email = new Damege_goodsDto();
		List<CenterDto> detailCenter = centerService.detailCenter(singleton.getCenter_code());
		
		String reciver = "leeseoji93@naver.com"; //받을사람의 이메일입니다.
        
		List<String> ImageUrlList = new ArrayList<String>();
	      List<String> fileUrlList = new ArrayList<String>();
	      List<String> fileTitle = new ArrayList<String>();
	      String fileUUID="";
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
	 	             fileUUID =singleton.getCenter_code() + "_" +today+ "_"+filename;

	 	              boolean isSuccess_image = ftpclient.storeFile(fileUUID, mf.getInputStream());
	 	              
	 	              if (isSuccess_image) {
	 	                   System.out.println(filename+"업로드 성공");
	 	                   upload_check = true;
	 	                   ImageUrlList.add("http://"+ FTP_IP + TOMCAT_PORT + "/Spring/Account/Image/" +  fileUUID);
	 	                  email.setDamege_photo(ImageUrlList.get(0));   
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
        
	    String subject = request.getParameter("equipment_type");
        subject = "["+detailCenter.get(0).getCenter_name()+"] "+subject+"파손 문의 메일입니다.";
        String content = request.getParameter("damege_reason")+"<p style='font-size:13px;'><strong>파손사진</strong></p><img src='http://"+FTP_IP + TOMCAT_PORT +"/Spring/Account/Image/"+fileUUID+"'>";
        
         
        email.setReceiver(reciver);
        email.setSubject(subject);
        email.setContent(content);
        
        email.setdamege_reason(request.getParameter("damege_reason").trim());
        email.setStaff_id(singleton.getId());
        email.setCenter_code(singleton.getCenter_code());
        
        damege_goodsService.insertDamegeGoods(email);        
        emailSender.SendEmail(email);
        
        HashMap<String, Object> hashmap = new HashMap<String,Object>();
        
        hashmap.put("data", 1); 	     
	    return "contactUs/mailSend_Success";	
    }
	@RequestMapping(value="mailSend_Success")
	public String mailSend_Success(Model model,HttpServletRequest request){
		sessionCheck();	
		return "contactUs/mailSend_Success";
	}//메일 전송 완료 페이지
	
	@RequestMapping(value="mailForm")
	public String mailForm(Model model,HttpServletRequest request){
		sessionCheck();	
		System.out.println("testetstsetste");
			
		model.addAttribute("sendMail",new Damege_goodsDto());
		
		return "contactUs/mailForm";
	}//기기배정 상세조회
}
