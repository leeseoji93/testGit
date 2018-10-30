package com.test.rememberTest;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
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

import com.test.rememberTest.Dao.BusRoute.BusRouteService;
import com.test.rememberTest.Dao.Car.CarService;
import com.test.rememberTest.Dao.Equipment.EquipmentService;
import com.test.rememberTest.Dao.Staff.StaffService;
import com.test.rememberTest.Dto.BusRouteDto;
import com.test.rememberTest.Dto.Car;
import com.test.rememberTest.Dto.EquipmentDto;
import com.test.rememberTest.Dto.Singleton;
import com.test.rememberTest.Dto.StaffDto;



@Controller
public class CarController {
	
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
//	List<StaffDto> Staff_center_code =  staffService.getDriverPList(center_code,registrant); //센터 코드 가져오는거
	
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
	
	@RequestMapping("/CarInfoView")
	public String carInfoView(Model model)
	{				
		sessionCheck();	
		List<Car> carList = carService.getCarList(singleton.getCenter_code());	
        model.addAttribute("list", carList);		
		return "Car/CarInfoView";
	}//차량 정보 조회
	
	@RequestMapping("/DataInputForm")
	public String writeForm(Model model) {
		sessionCheck();	
//		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//		String today = dateFormat.format(new Date());		
		List<StaffDto> driver =  staffService.getDriverList(singleton.getCenter_code());	
	
		model.addAttribute("driver",driver);
		model.addAttribute("center_code",singleton.getCenter_code());
		model.addAttribute("registrant",singleton.getId());
		model.addAttribute("car",new Car());
		return "Car/DataInputForm";
	}//차량 추가 화면 
	
	@RequestMapping(value="/DataInput" ,method=RequestMethod.POST)
	public String write(Car car,Model model) {	
		
		String code =  car.getCenter_code();				
		List<Car> bus_id_count =  carService.selectMaxBus_id(code);	
		String bus_id = code + "_B0_" + bus_id_count.get(0).getMaxcount();
		
		car.setBus_id(bus_id);
		carService.setCarList(car);	
	
		return "redirect:/CarInfoView";	
						
	}//차량 추가 유효성 검사
	
	@RequestMapping("/CarDetailInfo")
	public String DetilInfo(HttpServletRequest request,Model model) throws UnsupportedEncodingException {			
		System.out.println("===========CarDetailInfo");
		String temp =  request.getParameter("num");
		System.out.println("temp"+temp);
		String word =  new String(temp.getBytes("8859_1"),"utf-8");
		
		List<Car> carList = carService.getDetailCarList(word);
		List<BusRouteDto> routeNameList = busRouteService.Route_selectData1(word);
		
		model.addAttribute("list", carList);  
		model.addAttribute("routeNameList", routeNameList);  
		return "Car/CarDetailInfo";
	
	
	}//차량 상세정보 보기	
	
	@RequestMapping("/DataUpdateForm")
	public String updateForm(HttpServletRequest request,Model model) throws UnsupportedEncodingException {
		String temp =  request.getParameter("num");
		String bus_id =  new String(temp.getBytes("8859_1"),"utf-8");		
		
		List<Car> carList = carService.getBaseData(bus_id);
		List<StaffDto> driver =  staffService.getDriverList(singleton.getCenter_code());	
		
//		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy.MM.dd"); //수정된거 구분을 주기위해서 인풋은 '.', 수정은 '-'로 구분해둠
//		String today = dateFormat.format(new Date());		
//		
//		model.addAttribute("date",today);
		
		model.addAttribute("driver",driver);
		model.addAttribute("baseCar",carList);		
		model.addAttribute("car",new Car());
		return "Car/DataUpdateForm";
	}//차량 정보 수정 화면
	
	@RequestMapping("/DataUpdate")
	public String updateForm(Car car,Model model) {		
	
		carService.setUpdateCar(car);
		return "redirect:/CarInfoView";	
	}//차량 정보 수정
	
	@ResponseBody
	@RequestMapping(value="keyWordSearch",method=RequestMethod.POST)	   
	 public HashMap<String, Object> keyWordSearch(@RequestParam HashMap<String,Object> param){
			
	      String keyWord= (String) param.get("keyWord"); 	     	      
	      HashMap<String, Object> hashmap = new HashMap<String,Object>();	      
	      List<Car> carList = carService.keyWordSearchList(singleton.getCenter_code(),keyWord);      
	      
	      hashmap.put("data", carList);   
	      return hashmap;
	            
   }//차량 키워드 비동기 검색
	
	
	@ResponseBody
	@RequestMapping(value="checkName",method=RequestMethod.POST)	   
	 public boolean checkName(HttpServletRequest request){
			
		 String formData=  request.getParameter("formData"); 	     	      		 
		 String baseData=  request.getParameter("baseData"); 
		 
		 List<Car> carList = carService.getCarList(singleton.getCenter_code()); 
	      boolean nameCheck = true; //false : 이름 중복됨, true 중복 안됨.      
	    
	      
    	  for (int index = 0; index < carList.size(); index++) {
 	    	 
	    	   if(carList.get(index).getBus_name().equals(formData))
	    	   {
	    		   if(formData.equals(baseData))
	    		   {
	    			   System.out.println("1");
	    			   System.out.println(formData);
	    			   System.out.println(baseData);	    			 
	    			   nameCheck = true;
	    			   
	    		   }
	    		   else
	    		   {
	    			   System.out.println("2");
	    			   System.out.println(formData);
	    			   System.out.println(baseData);	    			  
	    			   nameCheck = false;
	    			  
	    		   }		   
	    	   }	    	 
	      }//중복 요소 검사 
    	  System.out.println(nameCheck);
	      return nameCheck;
	            
   }//차량 이름 중복 검사
		
	@ResponseBody
	@RequestMapping(value="checkNum",method=RequestMethod.POST)	   
	 public boolean checkNum(HttpServletRequest request){
			
		 String formData=  request.getParameter("formData"); 	     	      		 
		 String baseData=  request.getParameter("baseData"); 
		 
		 List<Car> carList = carService.getCarList(singleton.getCenter_code()); 
	      boolean numCheck = true; //false : 이름 중복됨, true 중복 안됨.      
	    
	      
    	  for (int index = 0; index < carList.size(); index++) {
 	    	 
	    	   if(carList.get(index).getBus_num().equals(formData))
	    	   {
	    		   if(formData.equals(baseData))
	    		   {    			  	    			 
	    			   numCheck = true;
	    			  
	    		   }
	    		   else
	    		   {	    			       			  
	    			   numCheck = false;	    			  
	    		   }		   
	    	   }
	      }//중복 요소 검사 

	      return numCheck;
	            
   }//차량 번호 중복 검사
	
	@ResponseBody
	@RequestMapping(value="DataDelete",method=RequestMethod.POST)	   
	public HashMap<String, Object> delete(HttpServletRequest request) throws UnsupportedEncodingException {
		String temp =  request.getParameter("del");
		String word =  new String(temp.getBytes("8859_1"),"utf-8");		
		HashMap<String, Object> hashmap = new HashMap<String,Object>();	
		
		try {
			carService.setDeleteCar(word);
		} catch (Exception e) {
			hashmap.put("delcheck", "false"); 	     
		    return hashmap;	
		}
		
		hashmap.put("delcheck", "true"); 	     
	    return hashmap;		
	}//차량 정보 삭제
	
	@ResponseBody
	@RequestMapping(value="phoneInput",method=RequestMethod.POST)	   
	public HashMap<String, Object> phoneInput(HttpServletRequest request){
		String name =  request.getParameter("name");					
		List<StaffDto> driver =  staffService.getDriverPList(singleton.getCenter_code(),name);	
		
		HashMap<String, Object> hashmap = new HashMap<String,Object>();	
		hashmap.put("data", driver); 	     
	    return hashmap;		
	}//운전기사 연락처 자동 입력
	
	@ResponseBody
	@RequestMapping(value="bus_id_Check",method=RequestMethod.POST)	   
	public HashMap<String, Object> bus_id_Check(HttpServletRequest request){
		String code =  request.getParameter("center_code");					
		List<Car> bus_id_count =  carService.selectMaxBus_id(code);	
		
		HashMap<String, Object> hashmap = new HashMap<String,Object>();	
		hashmap.put("bus_id_count", bus_id_count); 	     
	    return hashmap;		
	}//버스 아이디 등록 하기 위한 최대 값 가져오기
	
	@ResponseBody
	@RequestMapping(value="equipment",method=RequestMethod.POST)	   
	public HashMap<String, Object> equipment(HttpServletRequest request){
		String code =  request.getParameter("center_code");					
		List<EquipmentDto> equipment =  equipmentService.selectEquipment(code);		
		
		HashMap<String, Object> hashmap = new HashMap<String,Object>();	
		hashmap.put("equipment", equipment); 	     
	    return hashmap;		
	}//장비 목록 값
	
	@ResponseBody
	@RequestMapping(value="checkgate",method=RequestMethod.POST)	   
	 public boolean checkgate(HttpServletRequest request){
			
		 String formData=  request.getParameter("formData"); 	     	      		 
		 String baseData=  request.getParameter("baseData"); 
		 
		 List<Car> carList = carService.getCarList(singleton.getCenter_code()); 
	      boolean gateCheck = true; //false : 이름 중복됨, true 중복 안됨.      
	    
	      
    	  for (int index = 0; index < carList.size(); index++) {
 	    	 
	    	   if(carList.get(index).getEquipment_gate_id().equals(formData))
	    	   {
	    		   if(formData.equals(baseData))
	    		   {    			  	    			 
	    			   gateCheck = true;
	    			  
	    		   }
	    		   else
	    		   {	    			       			  
	    			   gateCheck = false;	    			  
	    		   }		   
	    	   }
	      }//중복 요소 검사 

	      return gateCheck;
	            
   }//게이트웨이 중복 검사
	
	@ResponseBody
	@RequestMapping(value="checktablet",method=RequestMethod.POST)	   
	 public boolean checktablet(HttpServletRequest request){
			
		 String formData=  request.getParameter("formData"); 	     	      		 
		 String baseData=  request.getParameter("baseData"); 
		 
		 List<Car> carList = carService.getCarList(singleton.getCenter_code()); 
	      boolean tabletCheck = true; //false : 이름 중복됨, true 중복 안됨.      
	    
	      
    	  for (int index = 0; index < carList.size(); index++) {
 	    	 
	    	   if(carList.get(index).getEquipment_tablet_id().equals(formData))
	    	   {
	    		   if(formData.equals(baseData))
	    		   {    			  	    			 
	    			   tabletCheck = true;
	    			  
	    		   }
	    		   else
	    		   {	    			       			  
	    			   tabletCheck = false;	    			  
	    		   }		   
	    	   }
	      }//중복 요소 검사 

	      return tabletCheck;
	            
   }//테블릿중복 검사

}
