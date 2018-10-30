package com.test.rememberTest;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
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

import com.test.rememberTest.Dao.Board_and_kid.Board_and_kidService;
import com.test.rememberTest.Dao.BusRoute.BusRouteService;
import com.test.rememberTest.Dao.Car.CarService;
import com.test.rememberTest.Dao.Center.CenterService;
import com.test.rememberTest.Dao.Course.CourseService;
import com.test.rememberTest.Dao.Course_and_station.Course_and_stationService;
import com.test.rememberTest.Dao.Kid.KidService;
import com.test.rememberTest.Dao.RealTime.RealTimeService;
import com.test.rememberTest.Dao.Staff.StaffService;
import com.test.rememberTest.Dao.Stat_sche.Stat_scheService;
import com.test.rememberTest.Dao.Station.StationService;
import com.test.rememberTest.Dto.Board_and_kidDto;
import com.test.rememberTest.Dto.BusRouteDto;
import com.test.rememberTest.Dto.Car;
import com.test.rememberTest.Dto.CenterDto;
import com.test.rememberTest.Dto.CourseDto;
import com.test.rememberTest.Dto.Course_and_stationDto;
import com.test.rememberTest.Dto.KidDto;
import com.test.rememberTest.Dto.MemberInfo;
import com.test.rememberTest.Dto.RealTimeDto;
import com.test.rememberTest.Dto.Singleton;
import com.test.rememberTest.Dto.StaffDto;
import com.test.rememberTest.Dto.Stat_scheDto;
import com.test.rememberTest.Dto.StationInfo;

@Controller
public class BusRouteController {
	
	@Autowired
	private StationService stationService;
	@Autowired
	private KidService kidService; 
	@Autowired
	private BusRouteService busRouteService; 
	@Autowired
	 private CenterService centerService;	
	@Autowired
	 private CourseService courseService;
	@Autowired
	 private StaffService staffService;
	@Autowired
	 private CarService carService;	
	@Autowired
	private Course_and_stationService course_and_stationService;	
	@Autowired
	 private Stat_scheService stat_scheService;
	@Autowired
	 private Board_and_kidService board_and_kidService;
	@Autowired
	private RealTimeService realTimeService;
	
	
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
	@RequestMapping(value="routeDelete")
	public HashMap<String, Object> routeDelete(@RequestParam HashMap<String,Object> param){
		sessionCheck();	
		System.out.println("routeDelete 시작");
		String route_id= (String) param.get("route_id");
		String course_id= (String) param.get("course_id");
		
		System.out.println("route_id"+route_id+"//couse_id:"+course_id);
		
		busRouteService.getRouteDelete(route_id);
		courseService.getCourseDelete(course_id);
		
		HashMap<String, Object> hashmap = new HashMap<String,Object>();	
		
		return hashmap;	
	}
	
	@RequestMapping(value="busRouteForm")
	public String busRouteForm(Model model) {				
		sessionCheck();	
		List<Car> carList = carService.getCarList(singleton.getCenter_code());
		List<StaffDto> staffList = staffService.Staff_selectTeacher(singleton.getCenter_code());
		List<StationInfo> stationList = stationService.getStationUseList(singleton.getCenter_code());//정류장 배치
		List<KidDto> kidList = kidService.Kid_Selectdata(singleton.getCenter_code(),null);			
		List<BusRouteDto> routeList = busRouteService.Route_selectDataList(singleton.getCenter_code()); 
		
		model.addAttribute("center_code", singleton.getCenter_code()); 
		model.addAttribute("registrant", singleton.getId()); 
		
		model.addAttribute("routeList", routeList); 
		model.addAttribute("kidList", kidList); 
	    model.addAttribute("stationList", stationList);		
        model.addAttribute("carList", carList);//차량 배치스탭 차량 정보
        model.addAttribute("staffList", staffList);
		return "busRoute/busRouteForm";
	}
	

	@RequestMapping(value="busRouteInput" ,method=RequestMethod.POST)
	public String busRouteInput(BusRouteDto busRouteDto,CourseDto courseDto,Course_and_stationDto course_and_stationDto
			,@RequestParam("station_id") List<String> station_id,Stat_scheDto stat_scheDto,@RequestParam("arrive_time") List<String> arrive_time
			,Board_and_kidDto board_and_kidDto)
	{	
		String code =  busRouteDto.getAffiliation();
		List<BusRouteDto>Route_id_count =  busRouteService.Route_selectMaxRoute_id(code);		
		String Route_code_type = "_R0_";
		System.out.println("Route_code_type : " + Route_code_type);
		String Route_count = Route_id_count.get(0).getMaxcount();		
		String Route_id = code + Route_code_type + Route_count;
		System.out.println("Route_id : " + Route_id);
		busRouteDto.setRoute_id(Route_id);
					
		List<CourseDto> course_id_count =  courseService.Course_selectMaxCourse_id(code);	
		String course_id = code + "_CR_" + course_id_count.get(0).getMaxcount();
		courseDto.setCourse_id(course_id);
		course_and_stationDto.setCourse_id(course_id);
		busRouteDto.setCourse_id(course_id);
		board_and_kidDto.setRoute_id(Route_id);
		
		courseService.Course_insertCourse(courseDto.getAffiliation(), course_id, courseDto.getCourse_name()
				,true, courseDto.getRegistrant());			
		
		course_and_stationService.course_and_station_insert(course_id,station_id);		
	
		busRouteService.Route_insertData(busRouteDto);	
		
		stat_scheService.Stat_sche_insert(stat_scheDto.getAffiliation(), Route_id
					, station_id, arrive_time, stat_scheDto.getRegistrant());
			
		board_and_kidService.Board_and_kid_insert(board_and_kidDto, singleton.getCenter_code());
	
		return "redirect:/busRouteList";	
	}//노선 정보 입력
	

	@ResponseBody
	@RequestMapping(value="routeUseChk", method=RequestMethod.POST)
	public HashMap<String, Object> routeUseChk(HttpServletRequest request,@ModelAttribute BusRouteDto busRouteDto){
		
//		String route_id =request.getParameter("route_id"); 
//		System.out.println("searchName : "+route_id);
//		boolean route_type=request.getParameter("route_type");
//		String affiliation = request.getParameter("affiliation");
//		System.out.println("route_type : "+route_type);
//		System.out.println("affiliation : "+affiliation);
		
		sessionCheck();	
		String route_id =request.getParameter("route_id"); 
		boolean route_use=busRouteDto.isRoute_use();
		
		System.out.println("route_id :"+route_id+"/route_type:"+route_use);
		
		HashMap<String, Object> hashmap = new HashMap<String,Object>();	
		
		int searchKey =busRouteService.routeUseCheck(route_id,route_use);
		hashmap.put("searchKey", searchKey);
		return hashmap;	
	}//사용여부
	
	@ResponseBody
	@RequestMapping(value="routeSearch", method=RequestMethod.POST)
	public HashMap<String, Object> routeSearch(@Valid @RequestParam HashMap<String,Object> param,BusRouteDto busRouteDto){
		sessionCheck();	
		String searchName =(String) param.get("keyWord"); 
		System.out.println("searchName : "+searchName);
		
		HashMap<String, Object> hashmap = new HashMap<String,Object>();	
		List<BusRouteDto> searchKey = busRouteService.searchRoute(searchName,singleton.getCenter_code());
//		List<StationInfo> searchKey= stationService.searchStation(searchName);
		
		System.out.println("searchKey : "+searchKey);
		hashmap.put("searchKey", searchKey);   

		return hashmap;
	}
	
	@ResponseBody
	@RequestMapping(value="checkCenter_position",method={RequestMethod.POST,RequestMethod.GET})	   
	 public HashMap<String, Object> checkCenter(@RequestParam HashMap<String,Object> param){
		sessionCheck();	
	      String center_code= (String) param.get("center_code");    

	      HashMap<String, Object> hashmap = new HashMap<String,Object>();	      
	      List<CenterDto> positionList = centerService.Center_selectDataPosition(center_code);	    
    	  hashmap.put("positionList", positionList);   
	      return hashmap;
	         	            
   }//센터(유치원)의 위도,경도 값 불러오기
	
	
	@RequestMapping(value="busRouteDetail")
	public String busRouteDetail(@RequestParam(value="route_id", required = false) String route_id,ModelMap modelMap) {				
		System.out.println("busRouteDetail시작--------"); 
		sessionCheck();	
		List<BusRouteDto> routeDetail = busRouteService.getRouteDetail(route_id);
//		List<BusRouteDto> stationInRoute = busRouteService.getstationInRoute(route_id,center_code);
		List<BusRouteDto> kidsInStaion = busRouteService.getKidInStation(route_id);
		List<BusRouteDto> stationInRoute = busRouteService.getstationInRoute(route_id);
		
		modelMap.addAttribute("routeDetail", routeDetail);
		modelMap.addAttribute("stationInRoute", stationInRoute);
		modelMap.addAttribute("kidsInStaion", kidsInStaion);
		
		
		return "busRoute/busRouteDetail";
	}
	@ResponseBody
	@RequestMapping(value="kidInStation")
	public HashMap<String, Object> kidInStation(@RequestParam HashMap<String,Object> param){
		sessionCheck();	
		System.out.println("kidInStation 시작");
		String route_id= (String) param.get("route_id");
		String station_id= (String) param.get("station_id");
		
		System.out.println("route_id"+route_id+"//station:"+station_id);
		
		List<BusRouteDto> kidsInStaion = busRouteService.getKidInStation(route_id);
		List<BusRouteDto> allKidInRoute = busRouteService.getAllKidInRoute(route_id); 
		
		HashMap<String, Object> hashmap = new HashMap<String,Object>();	
		hashmap.put("kidsInStaion", kidsInStaion);
		hashmap.put("allKidInRoute", allKidInRoute);
		
		return hashmap;	
	}
	
	
	
	@RequestMapping(value="busRouteList")
	public String busRouteList(Model model) {			
		sessionCheck();	
		 List<BusRouteDto> routeList =  busRouteService.getRouteList(singleton.getCenter_code());
		 List<BusRouteDto> routeInfoAll = busRouteService.getRouteInfoAll(singleton.getCenter_code());
		 List<BusRouteDto> routeKidsAll = busRouteService.getRouteKidsAll(singleton.getCenter_code());
		 System.out.println("routeInfoAll :"+routeInfoAll );
		 model.addAttribute("routeList", routeList);
		 model.addAttribute("routeInfoAll", routeInfoAll);
		 model.addAttribute("routeKidsAll", routeKidsAll);
		return "busRoute/busRouteList";
	}
	
	@RequestMapping(value="busRouteUpdate")
	public String busRouteUpdate(Model model,HttpServletRequest request) {		
		System.out.println("busRouteUpdate");
		sessionCheck();	
		String route_id = request.getParameter("route_id");
		
		System.out.println("route_id:"+route_id);
		List<BusRouteDto> baseRouteList = busRouteService.Route_selectUpdateBaseData(route_id);	
		
		List<Car> carList = carService.getCarList(singleton.getCenter_code());
		List<StaffDto> staffList = staffService.Staff_selectTeacher(singleton.getCenter_code());
		List<StationInfo> stationList = stationService.getStationUseList(singleton.getCenter_code());//정류장 배치
		List<KidDto> kidList = kidService.Kid_Selectdata(singleton.getCenter_code(),route_id);			
		List<BusRouteDto> routeList = busRouteService.Route_selectDataList(singleton.getCenter_code()); 
		 
		model.addAttribute("center_code", singleton.getCenter_code()); 
		model.addAttribute("registrant", singleton.getId()); 
		
		model.addAttribute("baseRouteList", baseRouteList); 
		
		model.addAttribute("routeList", routeList); 
		model.addAttribute("kidList", kidList); 
	    model.addAttribute("stationList", stationList);		
        model.addAttribute("carList", carList);//차량 배치스탭 차량 정보
        model.addAttribute("staffList", staffList);
		return "busRoute/busRouteUpdate";
	}
	
	@RequestMapping(value="busRouteUpdate" ,method=RequestMethod.POST)
	public String busRouteUpdate(BusRouteDto busRouteDto,CourseDto courseDto,Course_and_stationDto course_and_stationDto
			,@RequestParam("station_id") List<String> station_id,Stat_scheDto stat_scheDto,@RequestParam("arrive_time") List<String> arrive_time
			,Board_and_kidDto board_and_kidDto)
	{	
		sessionCheck();	
		courseService.Course_UpdateCourse(courseDto.getCourse_id(), courseDto.getCourse_name(), true);

		course_and_stationService.course_and_station_delete(course_and_stationDto.getCourse_id());
		course_and_stationService.course_and_station_insert(course_and_stationDto.getCourse_id(),station_id);	
		
		busRouteService.Route_updateData(busRouteDto);

		board_and_kidService.Board_and_kid_delete(board_and_kidDto.getRoute_id());
		stat_scheService.Stat_sche_delete(stat_scheDto.getRoute_id());
		
		stat_scheService.Stat_sche_insert(stat_scheDto.getAffiliation(), stat_scheDto.getRoute_id()
				, station_id, arrive_time, stat_scheDto.getRegistrant());			

		board_and_kidService.Board_and_kid_insert(board_and_kidDto, singleton.getCenter_code());

		return "redirect:/busRouteList";	
	}//노선 정보 수정
	
	@ResponseBody
	@RequestMapping(value="checkRoute",method=RequestMethod.POST)	   
	 public HashMap<String, Object> checkRoute(@RequestParam HashMap<String,Object> param){
	      String bus_id= (String) param.get("bus_id"); 
	      String route_start= (String) param.get("route_start"); 
	      String route_arrive= (String) param.get("route_arrive"); 

	      HashMap<String, Object> hashmap = new HashMap<String,Object>();	      
	     
	      List<BusRouteDto> routeList = busRouteService.Route_selectData(bus_id,route_start,route_arrive);  
	     	      
    	  hashmap.put("routeList", routeList);   
	      return hashmap;
	         	            
   }//차량배치 노선 배치 여부
	
	@ResponseBody
	@RequestMapping(value="checkTeacher",method=RequestMethod.POST)	   
	 public HashMap<String, Object> checkTeacher(@RequestParam HashMap<String,Object> param){
	      String staff_id= (String) param.get("staff_id"); 
	      String route_start= (String) param.get("route_start"); 
	      String route_arrive= (String) param.get("route_arrive");    

	      HashMap<String, Object> hashmap = new HashMap<String,Object>();	      
	     
	      List<BusRouteDto> routeList = busRouteService.Route_selectDataTeacher(staff_id,route_start,route_arrive);  
	     	      
    	  hashmap.put("routeList", routeList);   
	      return hashmap;
	         	            
   }//인솔교사배치 노선 배치 여부
	
	@ResponseBody
	@RequestMapping(value="route_id_Check",method=RequestMethod.GET)
	public HashMap<String, Object> route_id_Check2(HttpServletRequest request) {				
		String code =  request.getParameter("affiliation");	
		String token =  request.getParameter("token");	
		System.out.println("token:"+token);
		List<BusRouteDto>Route_id_count =  busRouteService.Route_selectMaxRoute_id(code);	
		
		HashMap<String, Object> hashmap = new HashMap<String,Object>();	
		hashmap.put("Route_id_count", Route_id_count); 	     
	    return hashmap;		
	}
	
	
	@ResponseBody
	@RequestMapping(value="route_id_Check",method=RequestMethod.POST)	   
	public HashMap<String, Object> route_id_Check(HttpServletRequest request){
		String code =  request.getParameter("affiliation");					
		List<BusRouteDto>Route_id_count =  busRouteService.Route_selectMaxRoute_id(code);	
		
		HashMap<String, Object> hashmap = new HashMap<String,Object>();	
		hashmap.put("Route_id_count", Route_id_count); 	     
	    return hashmap;		
	}//route 아이디 등록 하기 위한 최대 값 가져오기
	
	@ResponseBody
	@RequestMapping(value="course_id_Check",method=RequestMethod.POST)	   
	public HashMap<String, Object> bus_id_Check(HttpServletRequest request){
		String code =  request.getParameter("affiliation");					
		List<CourseDto> course_id_count =  courseService.Course_selectMaxCourse_id(code);	
		HashMap<String, Object> hashmap = new HashMap<String,Object>();	
		hashmap.put("course_id_count", course_id_count); 	     
	    return hashmap;		
	}//코스 아이디 등록 하기 위한 최대 값 가져오기
	
	
//	@RequestMapping(value="busRouteUpdate")
//	public String busRouteUpdate(Model model) {		
//		System.out.println("busRouteUpdate");
//		List<KidDto> kidList = kidService.Kid_Selectdata();
//		
//		model.addAttribute("kidList",kidList);
//		return "busRoute/busRouteUpdate";
//	}
	
}
