package com.test.rememberTest;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.ModelAndView;

import com.test.rememberTest.Dao.BusRoute.BusRouteService;
import com.test.rememberTest.Dao.Center.CenterService;
import com.test.rememberTest.Dao.Kid.KidService;
import com.test.rememberTest.Dao.Staff.StaffService;
import com.test.rememberTest.Dao.Station.StationService;
import com.test.rememberTest.Dto.BusRouteDto;
import com.test.rememberTest.Dto.CenterDto;
import com.test.rememberTest.Dto.KidDto;
import com.test.rememberTest.Dto.Singleton;
import com.test.rememberTest.Dto.StaffDto;
import com.test.rememberTest.Dto.StationInfo;

@Controller
public class StationController {
	
	@Autowired
	private StationService stationService;
	
	@Autowired
	private StaffService staffService;
	
	@Autowired
	private CenterService centerService;
	
	@Autowired
	private KidService kidService; 
	
	@Autowired
	 private BusRouteService busRouteService;
	
	
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
	@RequestMapping(value="centerAddr",method=RequestMethod.POST)	   
	public HashMap<String, Object> center_addr(HttpServletRequest request){
		System.out.println("컨트롤에서 center_add시작~2");
		String code2 =  request.getParameter("center_code");		
		List<CenterDto> centerAddr =  centerService.selectCenter_Addr(singleton.getCenter_code());	
		HashMap<String, Object> hashmap = new HashMap<String,Object>();	
		hashmap.put("centerAddr", centerAddr); 	     
	    return hashmap;		
	}//버스 아이디 등록 하기 위한 최대 값 가져오기
	
	
	@ResponseBody
	@RequestMapping(value="station_id_Check",method=RequestMethod.POST)	   
	public HashMap<String, Object> station_id_Check(HttpServletRequest request){
//		System.out.println("컨트롤에서 station_id_Check시작~");
		String code =  request.getParameter("center_code");					
		List<StationInfo> station_id_count =  stationService.selectMaxStation_id(code);	
//		System.out.println("station_id_count :"+stationService.selectMaxStation_id(code));
		HashMap<String, Object> hashmap = new HashMap<String,Object>();	
		hashmap.put("station_id_count", station_id_count); 	     
	    return hashmap;		
	}//버스 아이디 등록 하기 위한 최대 값 가져오기
	
	
	@ResponseBody
	@RequestMapping(value="affiliation_Check",method=RequestMethod.POST)	   
	public HashMap<String, Object> affiliation_Check(@RequestParam HashMap<String,Object> param){
		System.out.println("컨트롤에서 affiliation_Check시작~");
		
		
		String code= (String) param.get("registrant");
		
		//String code =  request.getParameter("registrant");					
		List<StaffDto> check =  staffService.getStaffList(code);	
		System.out.println("code parm : "+check.get(0).getCenter_code());
		HashMap<String, Object> hashmap = new HashMap<String,Object>();	
		hashmap.put("data", check); 	     
	    return hashmap;		
	}//등록자 센터 코드 가져오기
	
	
	@RequestMapping(value = "stationForm", method = RequestMethod.GET)
	public String stationForm(Map<String, Object> model,ModelMap modelMap,Model model2,Principal principal){
		sessionCheck();
		System.out.println("stationForm시작시작");
		model.put("STForm",new StationInfo());
		
		List<CenterDto> centerAddr =  centerService.selectCenter_Addr(singleton.getCenter_code());
		List<KidDto> kidList = kidService.Kid_Selectdata(singleton.getCenter_code(),null);
		System.out.println("test:"+centerAddr.get(0).getCenter_code());
		
		modelMap.addAttribute("name", principal.getName());
		
		List<StationInfo> stationList = stationService.getStationList(singleton.getCenter_code());
		modelMap.addAttribute("stationList", stationList);
        
		modelMap.addAttribute("kidList", kidList);
		modelMap.addAttribute("centerAddr", centerAddr);	

		return "station/stationForm";
	}
		
	@RequestMapping(value="stationInsert", method = RequestMethod.POST)
	public String doAddStation(@Valid StationInfo STForm) {
		sessionCheck();
		System.out.println("stationInsert시작시작");
		System.out.println("STForm ID: "+STForm.getStation_id());
		stationService.addStation(STForm);
		return "redirect:/stationList";
	}

	@RequestMapping(value="stationList", method=RequestMethod.GET)
    public String stationList(Model model){
		sessionCheck();
		List<StationInfo> stationList = stationService.getStationList(singleton.getCenter_code());
        		
        model.addAttribute("stationList", stationList);   
        model.addAttribute("Center_code",singleton.getCenter_code());
   
        return "station/stationList";
    }
	
	@RequestMapping(value="stationDetail", method=RequestMethod.GET)
	public String stationDetail(@RequestParam(value="station_id", required = false) String station_id,HttpServletRequest request,ModelMap modelMap)throws Exception{
		sessionCheck();
		
		StationInfo sessionStation = stationService.getDetailStation(station_id);
		List<BusRouteDto> routeNameList = busRouteService.stationNameInRoute(station_id);
		System.out.println("routeNameList :" );
		modelMap.addAttribute("sessionStation", sessionStation);
		modelMap.addAttribute("routeNameList", routeNameList); 
		
		return "station/stationDetail";
	}
	
	@ResponseBody
	@RequestMapping(value="stationDelete")
	public HashMap<String, Object> stationDelete(@RequestParam(value="station_id", required = false) String station_id,
			HttpServletRequest request,ModelMap modelMap)throws Exception{
		System.out.println("Delete 시작");
		System.out.println("Delete에서 stationNo값은 : "+station_id);
		String stationNo2 = station_id;

		HashMap<String, Object> hashmap = new HashMap<String,Object>();	
		try {
			stationService.getDeleteStation(stationNo2);
		} catch (Exception e) {
			hashmap.put("delcheck", "false"); 	     
		    return hashmap;	
		}
		
		hashmap.put("delcheck", "true"); 	     
	    return hashmap;	
	}
	
	
	//정류장 수정
	@RequestMapping(value="stationUpdate")
	public String stationUpdate(@RequestParam(value="station_id", required = false) String station_id,Map<String, Object> model,ModelMap modelMap){
		sessionCheck();
		model.put("STForm",new StationInfo());
		
		StationInfo sessionStation = stationService.getDetailStation(station_id);
		List<CenterDto> centerAddr =  centerService.selectCenter_Addr(singleton.getCenter_code());
		List<KidDto> kidList = kidService.Kid_Selectdata(singleton.getCenter_code(),null);
		List<StationInfo> stationList = stationService.getStationList(singleton.getCenter_code());
		modelMap.addAttribute("stationList", stationList);
		modelMap.addAttribute("kidList", kidList);
		modelMap.addAttribute("sessionStation", sessionStation);
		modelMap.addAttribute("centerAddr", centerAddr);
		return "station/stationUpdate";
	}
	
	
	@RequestMapping(value="stationUpdateSave")
	public String stationUpdateSave(@ModelAttribute StationInfo stationInfo,HttpServletRequest request) throws Exception{
		sessionCheck();
		System.out.println("stationUpdateSave 시작 ======"+stationInfo.getStation_use());
		String station_id = request.getParameter("station_id");
		System.out.println("getstation_id : "+station_id);
		stationInfo.setCenter_code(singleton.getCenter_code());
		stationInfo.setRegistrant(singleton.getId());
		
		stationService.updateStation(stationInfo);
		return "redirect:/stationList";
	}
	
	@ResponseBody
	@RequestMapping(value="stationSearch", method=RequestMethod.POST)
	public HashMap<String, Object> stationSearch(@Valid @RequestParam HashMap<String,Object> param,StationInfo stationInfo){
		sessionCheck();
		String searchName =(String) param.get("keyWord"); 
		
		HashMap<String, Object> hashmap = new HashMap<String,Object>();	
		List<StationInfo> searchKey= stationService.searchStation(singleton.getCenter_code(),searchName);
		
		hashmap.put("searchKey", searchKey);   

		return hashmap;
	}
	
	@ResponseBody
	@RequestMapping(value="stNameOverlap")
	public HashMap<String, Object> stNameOverlap(HttpServletRequest request, @RequestParam HashMap<String,Object> param) throws Exception{
		sessionCheck();
		System.out.println("stNameOverlap에서 시작!!!!!!!!!!!!!!!!!!!!!!");
		String stName = (request.getParameter("stName") == null) ? "" : String
			     .valueOf(request.getParameter("stName"));
		
		HashMap<String, Object> hashmap = new HashMap<String,Object>();	
		StationInfo chk = stationService.chkStName(stName);
		
		System.out.println("STName:"+stName);
		System.out.println("chk:"+chk);
		int tf;
		if(chk!=null){
			System.out.println("chk!=null");
			tf =3;
		}else if(chk==null&&stName==""){
			System.out.println("chk==null");
			tf =2;
		}
		else{
			System.out.println("chk!=null");
			tf =1;
		}
		hashmap.put("stName", tf);
		return hashmap;
	}
	
	@ResponseBody
	@RequestMapping(value="checkName_station",method=RequestMethod.POST)	   
	 public boolean checkName(HttpServletRequest request,Model model){
			
		 String formData=  request.getParameter("formData"); 	     	      		 
		 String baseData=  request.getParameter("baseData"); 
		 System.out.println("formData : "+formData+"// baseData: "+baseData);
		 List<StationInfo> stationList = stationService.getStationList(singleton.getCenter_code());
	      boolean nameCheck = true; //false : 이름 중복됨, true 중복 안됨.      
	    
	      
    	  for (int index = 0; index < stationList.size(); index++) {
 	    	 
	    	   if(stationList.get(index).getStation_name().equals(formData))
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
	
	
}
