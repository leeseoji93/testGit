package com.test.rememberTest;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.SocketException;
import java.net.URL;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

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
import com.test.rememberTest.Dao.Class.ClassService;
import com.test.rememberTest.Dao.Home_communication.Home_communicationService;
import com.test.rememberTest.Dao.Kid.KidService;
import com.test.rememberTest.Dao.Staff.StaffService;
import com.test.rememberTest.Dto.ClassDto;
import com.test.rememberTest.Dto.Home_communicationDto;
import com.test.rememberTest.Dto.KidDto;
import com.test.rememberTest.Dto.Medication_requestDto;
import com.test.rememberTest.Dto.Singleton;
import com.test.rememberTest.Dto.StaffDto;



@Controller
public class Home_communicationController {
	
	 @Autowired
	 private Home_communicationService home_communicationService;
	 
	 @Autowired
	 private ClassService classService;
	 
	 @Autowired
	 private KidService kidService; 
	 
	 @Autowired
	 private StaffService staffService;
	 
	 protected static String FTP_IP   = "13.125.170.255"; // FTP 접속지 IP
	 protected static int    FTP_PORT = 21;             // FTP 접속지 Port
	 protected static String FTP_ID   = "hskim";        // ID
	 protected static String FTP_PWD  = "hskim21";        // PASSWORD
	 protected static String TOMCAT_PORT  = ":8080";        // TOMCAT_PORT
	 protected static String FTP_PATH = "";
	 
	 FTPClient ftpclient = null;
	 
	  public Home_communicationController() {
	    ftpclient = new FTPClient();
	  }
	 
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
	
	@RequestMapping("/Home_communicationList")
	public String medication_contrast_documentList(Model model)
	{				
		sessionCheck();	
		List<ClassDto> classList = classService.Class_Select_AllList(singleton.getCenter_code());
		model.addAttribute("classList", classList);
		 
		String class_id= classList.get(0).getClass_id();
		
		Date date = new Date();	    
	    Calendar cal = Calendar.getInstance();	    
	    cal.setTime(date);
//	    int num = cal.get(Calendar.DAY_OF_WEEK); 	    
	    cal.add(Calendar.DATE, -1);	 
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	    String today = sdf.format(cal.getTime()); 


	    List<Home_communicationDto> Home_communicationList = home_communicationService.Home_communicationDao_select_classCommunicationList(class_id, today);        
		model.addAttribute("Home_communicationList", Home_communicationList);  
		model.addAttribute("today", today);  

		return "Home_communication/Home_communicationList";
	}//가정 통신문 리스트 조회
	
	@RequestMapping(value="/Home_communicationForm" ,method=RequestMethod.GET)
	public String Home_communicationForm(Model model) {		
		sessionCheck();			
		
		List<StaffDto> staffInfo = staffService.getStaffInfo(singleton.getCenter_code(), singleton.getId());
		
		model.addAttribute("tag_list", home_communicationService.Home_communicationDao_select_communication_tagData());
		model.addAttribute("class_list", classService.Class_Select_AllList(singleton.getCenter_code()));
		model.addAttribute("staffInfo",staffInfo);
	   
		return "Home_communication/Home_communicationForm";	
						
	}//가정 통신문 입력 폼



	@RequestMapping(value="/Home_communicationInsert" ,method=RequestMethod.POST)
	public String Home_communicationInsert(Model model,HttpServletRequest request
			,Home_communicationDto home_communicationDto,@RequestParam("picture") List<MultipartFile> picture_url
			,@RequestParam("file") List<MultipartFile> file_url,Locale locale) {	
		sessionCheck();		
		home_communicationDto.setCenter_code(singleton.getCenter_code());
		home_communicationDto.setStaff_id(singleton.getId());				
		String Maxcount = home_communicationService.Home_communicationDao_select_communication_Maxcount(singleton.getCenter_code());
		home_communicationDto.setCommunication_id(Maxcount);
		
		List<KidDto> KidList =  kidService.Kid_select_ClassKid(home_communicationDto.getClass_id(),singleton.getCenter_code());
		
		home_communicationService.Home_communicationDao_insert_home_communicationInsert(home_communicationDto);
		
		
		//푸시 메세지 타입
		String msg_type="parents_home_communication";
		
		
		List<String> ImageUrlList = new ArrayList<String>();
		List<String> fileUrlList = new ArrayList<String>();
		List<String> fileTitle = new ArrayList<String>();
		boolean upload_check = false;
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
		        ftpclient.changeWorkingDirectory("/Home_communication/Image");
		       
		        if(!picture_url.get(0).isEmpty()){
	        	   for(int i =0; i < picture_url.size(); i++) {
			        	MultipartFile mf = picture_url.get(i);
			 	        String filename = mf.getOriginalFilename();
			 	        
				 	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
				 	    String today = dateFormat.format(new Date());
				 	    String fileUUID = today+ "_"+filename;

				 	    boolean isSuccess_image = ftpclient.storeFile(fileUUID, mf.getInputStream());
			 	       
				        if (isSuccess_image) {
			                System.out.println(filename+"업로드 성공");
			                upload_check = true;
			                ImageUrlList.add("http://"+ FTP_IP + TOMCAT_PORT + "/Spring/Home_communication/Image/" +  fileUUID);
			            }
				        else {
				        	upload_check = false;
				        }		                
			        }
	        	   home_communicationService.Home_communicationDao_insert_communication_pictureInsert(ImageUrlList,Maxcount);
		        }			     	 
		        

		        ftpclient.changeWorkingDirectory("/Home_communication/File");
		        	
		        if(!file_url.get(0).isEmpty()){
		        	for(int i =0; i < file_url.size(); i++) {
			        	MultipartFile mf = file_url.get(i);
			 	        String filename = mf.getOriginalFilename();
			 	       
				 	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
				 	    String today = dateFormat.format(new Date());
				 	    String fileUUID = today+ "_"+filename;
				 	    boolean isSuccess_hwp = ftpclient.storeFile(fileUUID, mf.getInputStream());
			 	       
				        if (isSuccess_hwp) {
			                System.out.println(filename+"업로드 성공");
			                upload_check = true;
			                fileUrlList.add("http://"+ FTP_IP + TOMCAT_PORT + "/Spring/Home_communication/File/" +  fileUUID);
			                fileTitle.add(filename);
			            } 
				        else {
				        	upload_check = false;
				        }
			        }		
			        home_communicationService.Home_communicationDao_insert_communication_fileInsert(fileUrlList,Maxcount, fileTitle);
		        }    			        
		        
		        ftpclient.logout();
		        ftpclient.disconnect(); 
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

//		        home_communicationService.Home_communicationDao_insert_communication_pictureInsert(ImageUrlList,Maxcount);
//		        home_communicationService.Home_communicationDao_insert_communication_fileInsert(fileUrlList,Maxcount, fileTitle);

		home_communicationService.Home_communicationDao_insert_communication_transInsert(KidList, Maxcount, singleton.getCenter_code());
	   
		
		
		//가정통시문 푸시 알림
	        List<KidDto> fcm_token_list = kidService.Kid_select_tokenData(home_communicationDto.getClass_id(),singleton.getCenter_code());
	        //list값 = fcm토큰값, 부모아이디, 아이이름   
	        for(int i = 0; i<fcm_token_list.size(); i++) {
	         try {
	        	 final String apiKey = "AAAAQuz7CBI:APA91bEdABgVn76hQd-CispwSrHvcxz-AX7ZffRLsGxG84LlFnzAy1lMd4eoRbDmfS4xw1bAKiyf8AwJVGq7-zyY9xtEE5DH31EepNAUqY8Zx3K8P4PNjHhpyMZLu5dDLrOTbcJdi5ll";
	  	       URL url = new URL("https://fcm.googleapis.com/fcm/send");
	  	       HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	  	       conn.setDoOutput(true);
	  	       conn.setRequestMethod("POST");
	  	       conn.setRequestProperty("Content-Type", "application/json");
	  	       conn.setRequestProperty("Authorization", "key=" + apiKey);

	  	       conn.setDoOutput(true);
	  	       
	  	       String userId =(String) request.getSession().getAttribute("ssUserId");

	  	      // String test="이렇게 된다고"+kid_name+"이렇게 된다고";
	  	      //    System.out.println(test);
	  	          
	  	          
	  	       // 이걸로 보내면 특정 토큰을 가지고있는 어플에만 알림을 날려준다  위에 둘중에 한개 골라서 날려주자
	  	       //String input = "{\"data\" : {\"title\" : \""+kid_name+"("+class_name+")"+"투약의뢰서 작성 \", \"body\" : \"여기다 내용 넣기\"}, \"to\":\"fPN_92XlmuE:APA91bFnrRt8fbwS6BjV0wwvK4mYwwXjvqfUILEoi7PzemIAlGehtFPqRrkGe0cdwPqIhF1hxTi0yJHbRc89hKM-fiRAUQBn-yOsg74_YUIJQ1rsL2SZUGKK-iFbuy1l3nQfTU5VHRL3\"}";
	  	       
	  	      
	  	    	 String input = "{\"data\" : {\"title\" : \" 유치원 알림 \", \"body\" : \"가정통신문 도착\", \"msg_type\" : \""+msg_type+"\"}, \"to\":\""+fcm_token_list.get(i).getFcm_token()+"\"}";
	  	    	 OutputStream os = conn.getOutputStream();
		  	       
		  	       // 서버에서 날려서 한글 깨지는 사람은 아래처럼  UTF-8로 인코딩해서 날려주자
		  	       os.write(input.getBytes("UTF-8"));
		  	       os.flush();
		  	       os.close();

		  	       int responseCode = conn.getResponseCode();
		  	       System.out.println("\nSending 'POST' request to URL : " + url);
		  	       System.out.println("Post parameters : " + input);
		  	       System.out.println("Response Code : " + responseCode);
		  	       
		  	       BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		  	       String inputLine;
		  	       StringBuffer response = new StringBuffer();

		  	       while ((inputLine = in.readLine()) != null) {
		  	           response.append(inputLine);
		  	       }
		  	       in.close();
		  	       // print result
		  	       System.out.println(response.toString());
	  	       

			} catch (Exception e) {
				// TODO: handle exception
			}      
	        }
		return "redirect:/Home_communicationList";						
	}//가정 통신문 입력	

	@RequestMapping("/Home_communicationDetail")
	public String Home_communicationDetail(Model model, HttpServletRequest request)
	{		
		String communication_id = request.getParameter("communication_id");
		
		List<Home_communicationDto> Home_communicationList = home_communicationService.Home_communicationDao_select_CommunicationDetailList(communication_id);
		
		List<Home_communicationDto> Home_communicationPicture_urlList = home_communicationService.Home_communication_select_CommunicationPicture(communication_id);
		
		List<Home_communicationDto> Home_communicationFile_urlList = home_communicationService.Home_communication_select_CommunicationFile(communication_id);
		
		List<Home_communicationDto> Home_communicationFile_stateList = home_communicationService.Home_communication_select_transDetailList(communication_id);
		
		model.addAttribute("Home_communicationList",Home_communicationList);
		
		model.addAttribute("Home_communicationPicture_urlList",Home_communicationPicture_urlList);
		
		model.addAttribute("Home_communicationFile_urlList",Home_communicationFile_urlList);
		
		model.addAttribute("Home_communicationFile_stateList",Home_communicationFile_stateList);
		
		return "Home_communication/Home_communicationDetail";
	}//가정통신문상세정보  페이지전환
	
	@RequestMapping(value="/Home_communicationUpdateForm" ,method=RequestMethod.GET)
	public String Home_communicationUpdateForm(Model model,HttpServletRequest request) {	
		sessionCheck();	
		String communication_id = request.getParameter("communication_id");
		System.out.println("communication_id : " + communication_id);
		
		List<Home_communicationDto> Home_communicationList = home_communicationService.Home_communicationDao_select_CommunicationDetailList(communication_id);
		
		List<Home_communicationDto> Home_communicationPicture_urlList = home_communicationService.Home_communication_select_CommunicationPicture(communication_id);
		
		List<Home_communicationDto> Home_communicationFile_urlList = home_communicationService.Home_communication_select_CommunicationFile(communication_id);
		
		model.addAttribute("Home_communicationList",Home_communicationList);
		
		model.addAttribute("Home_communicationPicture_urlList",Home_communicationPicture_urlList);
		
		model.addAttribute("Home_communicationFile_urlList",Home_communicationFile_urlList);
		
		List<StaffDto> staffInfo = staffService.getStaffInfo(singleton.getCenter_code(), singleton.getId());
		
		model.addAttribute("staffInfo", staffInfo);
		
		model.addAttribute("tag_list", home_communicationService.Home_communicationDao_select_communication_tagData());
		model.addAttribute("class_list", classService.Class_Select_AllList(singleton.getCenter_code()));
		model.addAttribute("communication_id", communication_id);
		
		//가정 통신문 확인여부는 전부 미확인으로 바꿔줘야함
//		model.addAttribute("tag_list", home_communicationService.Home_communicationDao_select_communication_tagData());
//		model.addAttribute("class_list", classService.Class_Select_AllList(center_code));
	   
		return "Home_communication/Home_communicationUpdate";	
						
	}//가정 통신문 수정 폼
	
	
	@RequestMapping(value="/Home_communicationUpdate" ,method=RequestMethod.POST)
	public String Home_communicationUpdate(Model model,HttpServletRequest request
			,Home_communicationDto home_communicationDto,@RequestParam("picture") List<MultipartFile> picture_url
			,@RequestParam("file") List<MultipartFile> file_url,Locale locale) {	
		sessionCheck();	
		String communication_id = request.getParameter("communication_id");
		System.out.println("communication_id : " + communication_id);
			
		home_communicationDto.setCenter_code(singleton.getCenter_code());
		home_communicationDto.setStaff_id(singleton.getId());	
		home_communicationDto.setCommunication_id(communication_id);
				
		List<KidDto> KidList =  kidService.Kid_select_ClassKid(home_communicationDto.getClass_id(),singleton.getCenter_code());
		
		home_communicationService.Home_communicationDao_update_home_communicationUpdate(home_communicationDto);
		
		//푸시 메세지 타입
		String msg_type = "parents_home_communication";
		
		List<String> ImageUrlList = new ArrayList<String>();
		List<String> fileUrlList = new ArrayList<String>();
		List<String> fileTitle = new ArrayList<String>();
		boolean upload_check = false;
		
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
			        ftpclient.changeWorkingDirectory("/Home_communication/Image");
			       
			        if(!picture_url.get(0).isEmpty()){
		        	 for(int i =0; i < picture_url.size(); i++) {
				        	MultipartFile mf = picture_url.get(i);
				 	        String filename = mf.getOriginalFilename();
				 	        
					 	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
					 	    String today = dateFormat.format(new Date());
					 	    String fileUUID =singleton.getCenter_code() + "_" +today+ "_"+filename;

					 	    boolean isSuccess_image = ftpclient.storeFile(fileUUID, mf.getInputStream());
				 	       
					        if (isSuccess_image) {
				                System.out.println(filename+"업로드 성공");
				                upload_check = true;
				                ImageUrlList.add("http://"+ FTP_IP + TOMCAT_PORT + "/Spring/Home_communication/Image/" +  fileUUID);
				            }
					        else {
					        	upload_check = false;
					        }
				        }	
				        
				        home_communicationService.Home_communicationDao_insert_communication_pictureInsert(ImageUrlList,communication_id);				        
			        }
			       
			        
			        ftpclient.changeWorkingDirectory("/Home_communication/File");

			        if(!file_url.get(0).isEmpty()){
				        for(int i =0; i < file_url.size(); i++) {
				        	MultipartFile mf = file_url.get(i);
				 	        String filename = mf.getOriginalFilename();
				 	       
					 	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
					 	    String today = dateFormat.format(new Date());
					 	    String fileUUID =singleton.getCenter_code() + "_" + today+ "_"+filename;
					 	    boolean isSuccess_hwp = ftpclient.storeFile(fileUUID, mf.getInputStream());
				 	       
					        if (isSuccess_hwp) {
				                System.out.println(filename+"업로드 성공");
				                upload_check = true;
				                fileUrlList.add("http://"+ FTP_IP + TOMCAT_PORT + "/Spring/Home_communication/File/" +  fileUUID);
				                fileTitle.add(filename);
				            } 
					        else {
					        	upload_check = false;
					        }
				        }	
				        
				        home_communicationService.Home_communicationDao_insert_communication_fileInsert(fileUrlList,communication_id, fileTitle);
			        }
			        
			        ftpclient.logout();
			        ftpclient.disconnect(); 
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
			    System.out.println(upload_check);
//		        home_communicationService.Home_communicationDao_insert_communication_pictureInsert(ImageUrlList,communication_id);
//		        home_communicationService.Home_communicationDao_insert_communication_fileInsert(fileUrlList,communication_id, fileTitle);
		        	        
	    
		home_communicationService.Home_communicationDao_insert_communication_transInsert(KidList, communication_id, singleton.getCenter_code());
	   
		
		//가정통시문 푸시 알림
        List<KidDto> fcm_token_list = kidService.Kid_select_tokenData(home_communicationDto.getClass_id(),singleton.getCenter_code());
        //list값 = fcm토큰값, 부모아이디, 아이이름   
        for(int i = 0; i<fcm_token_list.size(); i++) {
         try {
        	 final String apiKey = "AAAAQuz7CBI:APA91bEdABgVn76hQd-CispwSrHvcxz-AX7ZffRLsGxG84LlFnzAy1lMd4eoRbDmfS4xw1bAKiyf8AwJVGq7-zyY9xtEE5DH31EepNAUqY8Zx3K8P4PNjHhpyMZLu5dDLrOTbcJdi5ll";
  	       URL url = new URL("https://fcm.googleapis.com/fcm/send");
  	       HttpURLConnection conn = (HttpURLConnection) url.openConnection();
  	       conn.setDoOutput(true);
  	       conn.setRequestMethod("POST");
  	       conn.setRequestProperty("Content-Type", "application/json");
  	       conn.setRequestProperty("Authorization", "key=" + apiKey);

  	       conn.setDoOutput(true);
  	       
  	       String userId =(String) request.getSession().getAttribute("ssUserId");

  	      // String test="이렇게 된다고"+kid_name+"이렇게 된다고";
  	      //    System.out.println(test);
  	          
  	          
  	       // 이걸로 보내면 특정 토큰을 가지고있는 어플에만 알림을 날려준다  위에 둘중에 한개 골라서 날려주자
  	       //String input = "{\"data\" : {\"title\" : \""+kid_name+"("+class_name+")"+"투약의뢰서 작성 \", \"body\" : \"여기다 내용 넣기\"}, \"to\":\"fPN_92XlmuE:APA91bFnrRt8fbwS6BjV0wwvK4mYwwXjvqfUILEoi7PzemIAlGehtFPqRrkGe0cdwPqIhF1hxTi0yJHbRc89hKM-fiRAUQBn-yOsg74_YUIJQ1rsL2SZUGKK-iFbuy1l3nQfTU5VHRL3\"}";
  	       
  	     
  	    	 String input = "{\"data\" : {\"title\" : \" 유치원 알림 \", \"body\" : \"가정통신문 도착\", \"msg_type\" : \""+msg_type+"\"}, \"to\":\""+fcm_token_list.get(i).getFcm_token()+"\"}";
  	    	 OutputStream os = conn.getOutputStream();
	  	       
	  	       // 서버에서 날려서 한글 깨지는 사람은 아래처럼  UTF-8로 인코딩해서 날려주자
	  	       os.write(input.getBytes("UTF-8"));
	  	       os.flush();
	  	       os.close();

	  	       int responseCode = conn.getResponseCode();
	  	       System.out.println("\nSending 'POST' request to URL : " + url);
	  	       System.out.println("Post parameters : " + input);
	  	       System.out.println("Response Code : " + responseCode);
	  	       
	  	       BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	  	       String inputLine;
	  	       StringBuffer response = new StringBuffer();

	  	       while ((inputLine = in.readLine()) != null) {
	  	           response.append(inputLine);
	  	       }
	  	       in.close();
	  	       // print result
	  	       System.out.println(response.toString());
  	       

		} catch (Exception e) {
			// TODO: handle exception
		}
        }
		return "redirect:/Home_communicationList";						
	}//가정 통신문 수정 업데이트	


	@ResponseBody
	@RequestMapping(value="home_communication_createTable",method=RequestMethod.POST)	   
	 public HashMap<String, Object> createTable(@RequestParam HashMap<String,Object> param){
			
	      String class_id= (String) param.get("class_id"); 	
	      String date= (String) param.get("date"); 
	      
	      HashMap<String, Object> hashmap = new HashMap<String,Object>();	
	      
	      List<Home_communicationDto> Home_communicationList = home_communicationService.Home_communicationDao_select_classCommunicationList(class_id, date);
	  
	      hashmap.put("Home_communicationList", Home_communicationList);   
	      return hashmap;
	            
	}//가정통신문 리스트 출력
	
	@ResponseBody
	@RequestMapping(value="home_communication_Delete",method=RequestMethod.POST)	   
	public HashMap<String, Object> home_communication_Delete(HttpServletRequest request) throws UnsupportedEncodingException {
		String communication_id =  request.getParameter("communication_id");
		HashMap<String, Object> hashmap = new HashMap<String,Object>();		

		home_communicationService.Home_communicationDao_delete_home_communicationDelete(communication_id);
   
	    return hashmap;		
	}//가정통신문 리스트 삭제
	
	@ResponseBody
	@RequestMapping(value="home_communication_resend",method=RequestMethod.POST)	   
	public HashMap<String, Object> home_communication_resend(HttpServletRequest request) throws UnsupportedEncodingException {
		
		//푸시 메세지 타입
		String msg_type = "parents_home_communication";
		
		String communication_id =  request.getParameter("communication_id");
		
		HashMap<String, Object> hashmap = new HashMap<String,Object>();		

		List<KidDto> unidentified_fcm_token_list = kidService.unidentified_Kid_select_tokenData(communication_id,singleton.getCenter_code());
		
		boolean sendCheck = true;
		   for(int i = 0; i<unidentified_fcm_token_list.size(); i++) {
	  try {
           final String apiKey = "AAAAQuz7CBI:APA91bEdABgVn76hQd-CispwSrHvcxz-AX7ZffRLsGxG84LlFnzAy1lMd4eoRbDmfS4xw1bAKiyf8AwJVGq7-zyY9xtEE5DH31EepNAUqY8Zx3K8P4PNjHhpyMZLu5dDLrOTbcJdi5ll";
  	       URL url = new URL("https://fcm.googleapis.com/fcm/send");
  	       HttpURLConnection conn = (HttpURLConnection) url.openConnection();
  	       conn.setDoOutput(true);
  	       conn.setRequestMethod("POST");
  	       conn.setRequestProperty("Content-Type", "application/json");
  	       conn.setRequestProperty("Authorization", "key=" + apiKey);

  	       conn.setDoOutput(true);
  	       
  	       String userId =(String) request.getSession().getAttribute("ssUserId");

  	      // String test="이렇게 된다고"+kid_name+"이렇게 된다고";
  	      //    System.out.println(test);
  	          
  	          
  	       
  	       // 이걸로 보내면 특정 토큰을 가지고있는 어플에만 알림을 날려준다  위에 둘중에 한개 골라서 날려주자
  	       //String input = "{\"data\" : {\"title\" : \""+kid_name+"("+class_name+")"+"투약의뢰서 작성 \", \"body\" : \"여기다 내용 넣기\"}, \"to\":\"fPN_92XlmuE:APA91bFnrRt8fbwS6BjV0wwvK4mYwwXjvqfUILEoi7PzemIAlGehtFPqRrkGe0cdwPqIhF1hxTi0yJHbRc89hKM-fiRAUQBn-yOsg74_YUIJQ1rsL2SZUGKK-iFbuy1l3nQfTU5VHRL3\"}";
  	       
  	    
  	    	 String input = "{\"data\" : {\"title\" : \" 유치원 알림 \", \"body\" : \"가정통신문 도착\", \"msg_type\" : \""+msg_type+"\"}, \"to\":\""+unidentified_fcm_token_list.get(i).getFcm_token()+"\"}";
  	    	 OutputStream os = conn.getOutputStream();
	  	       
	  	       // 서버에서 날려서 한글 깨지는 사람은 아래처럼  UTF-8로 인코딩해서 날려주자
	  	       os.write(input.getBytes("UTF-8"));
	  	       os.flush();
	  	       os.close();

	  	       int responseCode = conn.getResponseCode();
	  	       System.out.println("\nSending 'POST' request to URL : " + url);
	  	       System.out.println("Post parameters : " + input);
	  	       System.out.println("Response Code : " + responseCode);
	  	       
	  	       BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	  	       String inputLine;
	  	       StringBuffer response = new StringBuffer();

	  	       while ((inputLine = in.readLine()) != null) {
	  	           response.append(inputLine);
	  	       }
	  	       in.close();
	  	       // print result
	  	       System.out.println(response.toString());
  	       

		} catch (Exception e) {
			sendCheck = false;
		}
		   }
		hashmap.put("sendCheck", sendCheck);   
	    return hashmap;		
	}//가정통신문 재전송

}





