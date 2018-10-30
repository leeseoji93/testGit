package com.test.rememberTest;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.annotation.Around;
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

import com.test.rememberTest.Dao.Board_and_kid.Board_and_kidService;
import com.test.rememberTest.Dao.BusRoute.BusRouteService;
import com.test.rememberTest.Dao.Center.CenterService;
import com.test.rememberTest.Dao.Class.ClassService;
import com.test.rememberTest.Dao.Go_come_daily.Go_come_dailyService;
import com.test.rememberTest.Dao.Go_come_daily_car.Go_come_daily_carService;
import com.test.rememberTest.Dao.Kid.KidService;
import com.test.rememberTest.Dao.OnOff.OnOffService;
import com.test.rememberTest.Dao.Staff.StaffService;
import com.test.rememberTest.Dao.Teach_bus_check.Teach_bus_checkService;
import com.test.rememberTest.Dto.Board_and_kidDto;
import com.test.rememberTest.Dto.BusRouteDto;
import com.test.rememberTest.Dto.CenterDto;
import com.test.rememberTest.Dto.ClassDto;
import com.test.rememberTest.Dto.Go_come_dailyDto;
import com.test.rememberTest.Dto.Go_come_daily_carDto;
import com.test.rememberTest.Dto.KidDto;
import com.test.rememberTest.Dto.Medication_requestDto;
import com.test.rememberTest.Dto.OnOffDto;
import com.test.rememberTest.Dto.Singleton;
import com.test.rememberTest.Dto.StaffDto;
import com.test.rememberTest.Dto.Teach_bus_checkDto;



/**
 * Handles requests for the application home page.
 */
@Controller
public class OnOffController {	
	
	@Autowired
	private BusRouteService busRouteService;
	
	@Autowired
	private  OnOffService onOffService;
	
	@Autowired
	private CenterService centerService;
	
	@Autowired
	private Board_and_kidService board_and_kidService;
	
	@Autowired
	private Go_come_daily_carService go_come_daily_carService;
	
	@Autowired
	private Go_come_dailyService go_come_dailyService;
	
	@Autowired
	private Teach_bus_checkService teach_bus_checkService;
	
	@Autowired
	private ClassService classService;
	
	@Autowired
	private StaffService staffService;
	
	@Autowired
	private KidService kidService;
	
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
	
	@RequestMapping("/OnoffList_car")
	public String OnoffList_car(Model model)
	{		
		sessionCheck();	
		
		String today = null;
				
	    Date date = new Date();	    
	    Calendar cal = Calendar.getInstance();
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	    cal.setTime(date);
	    int num = cal.get(Calendar.DAY_OF_WEEK); 	    
	    cal.add(Calendar.DATE, -num);
	    
	    String endDate = sdf.format(cal.getTime());
	    model.addAttribute("endDate", endDate);
    
	    num = cal.get(Calendar.DAY_OF_WEEK);
	    cal.add(Calendar.DATE, -num);
	    cal.add(Calendar.DATE, 1);
	    String startDate = sdf.format(cal.getTime()); 
	    model.addAttribute("startDate", startDate);
	    
		List<BusRouteDto> routeList = busRouteService.Route_select_AllData(singleton.getCenter_code());
		String route_id = routeList.get(0).getRoute_id();
		String route_type = routeList.get(0).getRoute_type();
		
		if(route_type.equals("등원")) {
	    	route_type = "on";
	    }
	    else {
	    	route_type = "off";
	    }
		
		List<OnOffDto> onoffData = onOffService.OnOff_select_onoffData(today,route_id, route_type,"All", startDate, endDate,false);
		List<Board_and_kidDto> board_and_kidList = board_and_kidService.Board_and_kid_select_routeData(route_id);
		List<CenterDto> centerList = centerService.selectCenter_Addr(singleton.getCenter_code());
		
		route_type = routeList.get(0).getRoute_type();
		
		model.addAttribute("centerList", centerList);
		model.addAttribute("route_type", route_type);
		model.addAttribute("board_and_kidList", board_and_kidList);
		model.addAttribute("routeList", routeList);
		model.addAttribute("onoffData", onoffData);
		
		return "OnOffRecord/OnoffList_car";
	}//등하월 차량 일지 리스트 조회 
	
	@ResponseBody
	@RequestMapping(value="OnoffList_car_updateTable",method=RequestMethod.POST)	   
	 public HashMap<String, Object> OnoffList_car_updateTable(@RequestParam HashMap<String,Object> param){
		sessionCheck();	
			String today = null;  
		
	      String route_id = (String) param.get("route_id"); 
	      String route_type = (String) param.get("route_type"); 
	      String startDate = (String) param.get("startDate");
	      String endDate = (String) param.get("endDate");
	      
	      System.out.println("route_type : " + route_type);
	      
	      if(route_type.equals("등원")) {
		    	route_type = "on";
		    }
		    else {
		    	route_type = "off";
		    }
	      
	      System.out.println("route_id : " + route_id);
	      System.out.println("route_type : " + route_type);
	      System.out.println("startDate : " + startDate);
	      System.out.println("endDate : " + endDate);
	      
	      List<OnOffDto> onoffData = onOffService.OnOff_select_onoffData(today,route_id, route_type, "All", startDate, endDate,false);
	      List<Board_and_kidDto> board_and_kidList = board_and_kidService.Board_and_kid_select_routeData(route_id);
	      List<CenterDto> centerList = centerService.selectCenter_Addr(singleton.getCenter_code());
	      
	      route_type = (String) param.get("route_type"); 
	      
	      HashMap<String, Object> hashmap = new HashMap<String,Object>();
	      hashmap.put("board_and_kidList", board_and_kidList);  
	      hashmap.put("route_type", route_type);
	      hashmap.put("centerList", centerList);  
	      hashmap.put("onoffData", onoffData);  
	      return hashmap;
	            
   }//등하월 차량 일지 리스트 조회  노선,주(week) 선택
	
	@RequestMapping("/OnoffList_car_Down")
	public String OnoffList_car_Down(Model model, HttpServletRequest request)
	{		
		sessionCheck();	
		
		String route_id = request.getParameter("route_id"); 
		String route_type = request.getParameter("route_type"); 
	    String startDate = request.getParameter("startDate"); 
	    String endDate = request.getParameter("endDate"); 
	    String today = null;  
	    
	   	System.out.println("route_id : " + route_id);
	   	System.out.println("route_type : " + route_type);
	    System.out.println("startDate : " + startDate);
	    System.out.println("endDate : " + endDate);
	    
	    String[] dateList = startDate.split("-");
	      
//		List<OnOffDto> onoffData = onOffService.OnOff_select_onoffData(today,route_id, route_type, "All", startDate, endDate,true);
	    List<OnOffDto> onoffData = onOffService.OnOff_select_onoffDataGroup(today, route_id, route_type, "All", startDate, endDate);
		List<Board_and_kidDto> board_and_kidList = board_and_kidService.Board_and_kid_select_routeData(route_id);
		List<CenterDto> centerList = centerService.selectCenter_Addr(singleton.getCenter_code());
		
		List<BusRouteDto> routeBusList = busRouteService.BusRoute_select_RouteBusData(route_id);
		Go_come_daily_carDto go_come_daily_carDto = new Go_come_daily_carDto();

		go_come_daily_carDto.setGo_doc_ostart(routeBusList.get(0).getRoute_start());
		go_come_daily_carDto.setGo_doc_oarrive(routeBusList.get(0).getRoute_arrive());
		go_come_daily_carDto.setRoute_id(route_id);
		go_come_daily_carDto.setAffiliation(singleton.getCenter_code());
		go_come_daily_carDto.setRegistrant(singleton.getId());
		String title = dateList[0] + " 등하원 차량일지";
		go_come_daily_carDto.setGo_doc_title(title);
		go_come_daily_carDto.setGo_doc_year(dateList[0]);
		go_come_daily_carDto.setGo_doc_mon(dateList[1]);
		go_come_daily_carDto.setGo_doc_start(startDate);
		go_come_daily_carDto.setGo_doc_end(endDate);
		go_come_daily_carDto.setGo_doc_maint(routeBusList.get(0).getMain_staff_name());
		go_come_daily_carDto.setGo_doc_subt(routeBusList.get(0).getSub_staff_name());
		go_come_daily_carDto.setGo_doc_rname(routeBusList.get(0).getRoute_name());
		go_come_daily_carDto.setGo_doc_osem(routeBusList.get(0).getRoute_sem());
		go_come_daily_carDto.setGo_doc_oyear(routeBusList.get(0).getRoute_year());
		go_come_daily_carDto.setGo_doc_dirv(routeBusList.get(0).getBus_staff_name());
		go_come_daily_carDto.setGo_doc_tablet(routeBusList.get(0).getEquipment_tablet_id());
		go_come_daily_carDto.setGo_doc_gate(routeBusList.get(0).getEquipment_gate_id());
		go_come_daily_carDto.setGo_doc_bname(routeBusList.get(0).getBus_name());
		go_come_daily_carDto.setGo_doc_bnum(routeBusList.get(0).getBus_num());
		go_come_daily_carDto.setGo_doc_borad(routeBusList.get(0).getBus_borad());
		go_come_daily_carDto.setGo_doc_bcom(routeBusList.get(0).getBus_com());
		go_come_daily_carDto.setGo_doc_binsur(routeBusList.get(0).getBus_insur());
		
		go_come_daily_carService.Go_come_daily_car_insert(go_come_daily_carDto);
		List<Go_come_daily_carDto> GcdcList = go_come_daily_carService.Go_come_daily_car_select(route_id, startDate, endDate);
		
		List<Teach_bus_checkDto> teach_checkList = teach_bus_checkService.Teach_bus_check_select_weekdata(singleton.getCenter_code(),route_id,startDate,endDate);
	    model.addAttribute("teach_checkList",teach_checkList);

		model.addAttribute("board_and_kidList", board_and_kidList);
		model.addAttribute("route_type", route_type);
		model.addAttribute("centerList", centerList);
		model.addAttribute("onoffData", onoffData);
		model.addAttribute("GcdcList", GcdcList);
		model.addAttribute("startDay", GcdcList.get(0).getGo_doc_start());
		model.addAttribute("endDay", GcdcList.get(0).getGo_doc_end());
		
		int chk ;
		chk=1;
		
		List<Teach_bus_checkDto> teach_bus_ckecklistB = teach_bus_checkService.getCheckListContent(singleton.getCenter_code(),chk);
		model.addAttribute("teach_bus_ckecklistB",teach_bus_ckecklistB);
		
		chk=2;
		List<Teach_bus_checkDto> teach_bus_ckecklistI = teach_bus_checkService.getCheckListContent(singleton.getCenter_code(),chk);
		model.addAttribute("teach_bus_ckecklistI",teach_bus_ckecklistI);
		
		chk=3;
		List<Teach_bus_checkDto> teach_bus_ckecklistA = teach_bus_checkService.getCheckListContent(singleton.getCenter_code(),chk);
		model.addAttribute("teach_bus_ckecklistA",teach_bus_ckecklistA);
				
		return "OnOffRecord/OnoffList_carDown";
	}//등하원 차량일지 다운로드
	
	
	@RequestMapping("/OnoffList")
	public String OnoffList(Model model)
	{		
		sessionCheck();	
    
	    String today = null;
		
	    Date date = new Date();	    
	    Calendar cal = Calendar.getInstance();
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	    cal.setTime(date);
	    int num = cal.get(Calendar.DAY_OF_WEEK); 	    
	    cal.add(Calendar.DATE, -num);
	    
	    String endDate = sdf.format(cal.getTime());
	    model.addAttribute("endDate", endDate);
	    
	    num = cal.get(Calendar.DAY_OF_WEEK);
	    cal.add(Calendar.DATE, -num);
	    cal.add(Calendar.DATE, 1);
	    String startDate = sdf.format(cal.getTime()); 
	    model.addAttribute("startDate", startDate);

        List<ClassDto> classList = classService.Class_Select_AllList(singleton.getCenter_code());
        
        List<OnOffDto> OnOffList = onOffService.attendance_history_select_onoffData(today,classList.get(0).getClass_id(), startDate, endDate);

        model.addAttribute("classList", classList);
        model.addAttribute("OnOffList", OnOffList);
		
		return "OnOffRecord/OnoffList";
	}//등하원 일지 리스트 조회 
	
	@ResponseBody
	@RequestMapping(value="OnoffList_updateTable",method=RequestMethod.POST)	   
	 public HashMap<String, Object> OnoffList_updateTable(@RequestParam HashMap<String,Object> param){
		  String today = null;  
		
	      String class_id = (String) param.get("class_id");  
	      String startDate = (String) param.get("startDate");
	      String endDate = (String) param.get("endDate");

	      List<OnOffDto> OnOffList = onOffService.attendance_history_select_onoffData(today,class_id,startDate, endDate);
	            
	      HashMap<String, Object> hashmap = new HashMap<String,Object>(); 
	      hashmap.put("OnOffList", OnOffList);  
	      return hashmap;
	            
   }//등하월 일지 리스트 조회  반,주(week) 선택
	
	@RequestMapping("/OnoffList_Down")
	public String OnoffList_Down(Model model, HttpServletRequest request)
	{		
		sessionCheck();	
		String today = null;  
      
		String class_id = request.getParameter("class_id"); 
		String startDate = request.getParameter("startDate"); 
		String endDate = request.getParameter("endDate"); 
	      
	    String[] dateList = endDate.split("-");
	    

	    SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");

	    try {
			Date date = transFormat.parse(endDate);
			Calendar c = Calendar.getInstance();
			c.setTime(date);
	 		String week = String.valueOf(c.get(Calendar.WEEK_OF_MONTH));
	 		model.addAttribute("week", week);

		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

//		List<OnOffDto> OnOffList = onOffService.attendance_history_select_onoffData(today,class_id,startDate, endDate);
		  
	    List<OnOffDto> OnOffList = onOffService.attendance_history_select_onoffDataGroup(today, class_id, startDate, endDate);
	    
		Go_come_dailyDto gcd = new Go_come_dailyDto();
		gcd.setDoc_year(dateList[0]);
		gcd.setDoc_mon(dateList[1]);
		gcd.setClass_id(class_id);
		gcd.setDoc_start(startDate);
		gcd.setDoc_end(endDate);
		gcd.setCenter_code(singleton.getCenter_code());
		gcd.setStaff_id(singleton.getId());
	      
	     go_come_dailyService.Go_come_daily_insert(gcd);
	            
	    List<Go_come_dailyDto> GcdList = go_come_dailyService.Go_come_daily_select(class_id, startDate, endDate);
	    System.out.println(OnOffList.size());

	    model.addAttribute("GcdList", GcdList);
	    model.addAttribute("OnOffList", OnOffList);
		return "OnOffRecord/OnoffList_Down";
	}//등하원 일지 다운로드
	
	@RequestMapping("/AttendanceList")
	public String AttendanceList(Model model, HttpServletRequest request)
	{		
		sessionCheck();	
	    Date date = new Date();	    
	    Calendar cal = Calendar.getInstance();	    
	    cal.setTime(date);
	    String month;
		String dash_date = request.getParameter("date");
		String class_id;
		List<ClassDto> classList = classService.Class_Select_AllList(singleton.getCenter_code());
		
		String s_Month=null;
		String dash_class=null;
		if(dash_date!=null) {
			month = dash_date;
			String[] startMonth = month.split("-");
			class_id = request.getParameter("class_id");
			s_Month = startMonth[1];
			dash_class = class_id;
		}else {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
		    month = sdf.format(cal.getTime());  
		    class_id = classList.get(0).getClass_id();
		    
		    SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-M");
		    month = sdf1.format(cal.getTime());
		    String[] startMonth = month.split("-");
		    s_Month = startMonth[1];
		    
		    dash_class = "default";
		    }
		model.addAttribute("month", month);
		model.addAttribute("class_id", class_id);
		
//	    cal.add(Calendar.MONTH, -1);

	    
	    
	    
	    List<Go_come_dailyDto> GcdList = go_come_dailyService.Go_come_daily_selectMonth(class_id, month);
	    List<KidDto> kidList = kidService.Kid_select_ClassKid(classList.get(0).getClass_id(), singleton.getCenter_code());
	    		
	    
	    
	    String size = Integer.toString(GcdList.size());
	    
	    
	    model.addAttribute("Gcd_size", size);
	    model.addAttribute("startMonth", s_Month);
        model.addAttribute("classList", classList);
        model.addAttribute("GcdList", GcdList);
        model.addAttribute("kidList", kidList);
		
		
		return "OnOffRecord/AttendanceList";
	}//출석부 리스트 조회 
	
	@ResponseBody
	@RequestMapping(value="AttendanceList_updateTable",method=RequestMethod.POST)	   
	 public HashMap<String, Object> AttendanceList_updateTable(@RequestParam HashMap<String,Object> param){
		
	      String class_id = (String) param.get("class_id");  
	      String month = (String) param.get("month");

	      List<Go_come_dailyDto> GcdList = go_come_dailyService.Go_come_daily_selectMonth(class_id, month);
	            
	      System.out.println(class_id);
	      System.out.println(month);
	      
	      SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-M");
	      Date Tempmonth=null;
		  try {
			Tempmonth = sdf1.parse(month);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		  String tempDate = sdf1.format(Tempmonth);
		  String[] startMonth = tempDate.split("-");
		  
		  String size = Integer.toString(GcdList.size());
	      
	      HashMap<String, Object> hashmap = new HashMap<String,Object>(); 
	      hashmap.put("Gcd_size", size);  
	      hashmap.put("startMonth", startMonth[1]);  
	      hashmap.put("GcdList", GcdList);  
	      return hashmap;
	            
   }//출석부 리스트 조회  반,월 선택
	
	@RequestMapping("/AttendanceList_Down")
	public String AttendanceList_Down(Model model, HttpServletRequest request)
	{	
		String class_id = request.getParameter("class_id");
		String month = request.getParameter("month"); 
	      
		List<Go_come_dailyDto> GcdList = go_come_dailyService.Go_come_daily_selectMonth(class_id, month);
		
	    SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-M");
	    Date Tempmonth=null;
		try {
			Tempmonth = sdf1.parse(month);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String tempDate = sdf1.format(Tempmonth);
		String[] startMonth = tempDate.split("-");
		  
		String size = Integer.toString(GcdList.size());

	    model.addAttribute("Gcd_size", size);
	    model.addAttribute("startMonth", startMonth[1]);
        model.addAttribute("GcdList", GcdList);
		return "OnOffRecord/AttendanceDwon";
	}//출석부 다운로드

}