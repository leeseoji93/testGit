package com.test.rememberTest;

import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
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
import org.springframework.web.servlet.View;

import com.mysql.fabric.xmlrpc.base.Array;
import com.test.rememberTest.Dao.BusRoute.BusRouteService;
import com.test.rememberTest.Dao.Car.CarService;
import com.test.rememberTest.Dao.RealTime.RealTimeService;
import com.test.rememberTest.Dao.Record.RecordDao;
import com.test.rememberTest.Dao.Record.RecordService;
import com.test.rememberTest.Dao.Staff.StaffService;
import com.test.rememberTest.Dao.Teach_bus_check.Teach_bus_checkService;
import com.test.rememberTest.Dto.BusRouteDto;
import com.test.rememberTest.Dto.Car;
import com.test.rememberTest.Dto.RealTimeDto;
import com.test.rememberTest.Dto.RecordDto;
import com.test.rememberTest.Dto.Singleton;
import com.test.rememberTest.Dto.StaffDto;
import com.test.rememberTest.Dto.Teach_bus_checkDto;

@Controller
public class RealTimeController {
	
	private String center_code="2109059_01";
	
	@Autowired
	private BusRouteService busRouteService; 
	
	@Autowired
	private RealTimeService realTimeService;
	
	@Autowired
	private StaffService staffService;
	
	@Autowired
	private Teach_bus_checkService teach_bus_checkService;
	
	@Autowired
	private RecordService recordService;
	
	@Autowired
	private CarService carService;
	
	
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
	
	@RequestMapping(value="realTimeViewer")
	public String realTimeViewer(ModelMap modelMap) {				
		sessionCheck();	
		List<BusRouteDto> routeUse = busRouteService.getUseRouteAll(center_code);
		
		System.out.println("routeUse :"+routeUse);
	    
		modelMap.addAttribute("routeUse", routeUse);
		return "realTime/realTimeViewer";
	}
	
	@ResponseBody
	@RequestMapping(value="realTimeView_Data",method=RequestMethod.POST)
	public HashMap<String, Object> realTimeView_Data(HttpServletRequest request){
		System.out.println("realTimeView_Data 시작");
		sessionCheck();	
		String route_id = request.getParameter("route_id");
		
		List<BusRouteDto> realTimeInfo = busRouteService.getRouteInfoAll(route_id);
		List<BusRouteDto> routeBoardKid = busRouteService.getrouteBoardKid(center_code,route_id);
//		List<BusRouteDto> stationInRoute = busRouteService.getstationInRoute(route_id,center_code);
		List<RealTimeDto> realTimeRoute = realTimeService.getRealTimeRoute(center_code,route_id);
		HashMap<String, Object> hasmap = new HashMap<String, Object>();
		hasmap.put("realTimeInfo", realTimeInfo);
		hasmap.put("routeBoardKid", routeBoardKid);
//		hasmap.put("stationInRoute", stationInRoute);
		hasmap.put("realTimeRoute", realTimeRoute);
		return hasmap;
	}
	
	@ResponseBody
	@RequestMapping(value="realTimeCar",method=RequestMethod.POST)
	public HashMap<String, Object> realTimeCar(HttpServletRequest request){
		System.out.println("realTimeCar 시작");
		sessionCheck();	
		String route_id = request.getParameter("route_id");
		
		List<RealTimeDto> realTimeCar_data = realTimeService.getRealTimeCar(route_id,center_code);
		HashMap<String, Object> hasmap = new HashMap<String, Object>();
		hasmap.put("realTimeCar_data", realTimeCar_data);
		
		
		return hasmap;
	}
	
	@RequestMapping(value="carCheckManagement_ajax", method={RequestMethod.POST,RequestMethod.GET})
	public String carCheckManagement_ajax(HttpServletRequest request,
			Model model){
		sessionCheck();	 
		String routeSelect = request.getParameter("routeSelect");
		String driveYear = request.getParameter("driveYear");
		String driveMon = request.getParameter("driveMon");
		String route_name = request.getParameter("routeName");
		
//		System.out.println("routeSelect:"+routeSelect);
//		System.out.println("driveYear:"+driveYear);
//		System.out.println("driveMon:"+driveMon);
//		System.out.println("route_name:"+route_name);
		if(driveMon.length()<2){driveMon = "0"+driveMon;}
		String checkDateYNM = driveYear+"-"+driveMon;
		
		List<BusRouteDto> routeList = busRouteService.getRouteList(singleton.getCenter_code());
		model.addAttribute("routeList",routeList);
		
		List<Teach_bus_checkDto> teach_checkList = teach_bus_checkService.getTeachCheckList(singleton.getCenter_code(),checkDateYNM,routeList.get(0).getRoute_id());
		model.addAttribute("checkList",teach_checkList);
		
		if(teach_checkList.size()!=0){
			if(teach_checkList.get(0).getToday().equals("")){
				model.addAttribute("today", teach_checkList.get(0).getToday());
			}else{
				model.addAttribute("today", '-');
			}
		}else{
			model.addAttribute("today", '-');
		}
		
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
		
		route_name = route_name.trim();
		
		int d_year = Integer.parseInt(driveYear);
		int d_mon = Integer.parseInt(driveMon);
		
        Calendar currentCalendar = Calendar.getInstance();
        currentCalendar.set(d_year,d_mon-1,1);
        
        int lastDay =  currentCalendar.getActualMaximum(Calendar.DATE);
        model.addAttribute("lastDay", lastDay);
		
		if(driveMon.length()==1){driveMon="0"+driveMon;}
		
		String day = driveYear+"-"+driveMon;
		List<Teach_bus_checkDto> dailycheckInfo = teach_bus_checkService.getDailyCheckInfo(route_name,routeSelect);
//		List<Teach_bus_checkDto> selectCheckTable = teach_bus_checkService.getTeachCheckList(singleton.getCenter_code(),day,routeSelect);
//		
//		model.addAttribute("data", selectCheckTable);
		model.addAttribute("dailycheckInfo", dailycheckInfo);
		model.addAttribute("driveMon", driveMon);
		
		return "realTime/carCheckManagement_ajax";
	}
	
	@ResponseBody
	@RequestMapping(value="dailyCarCheck",method=RequestMethod.POST)
	public HashMap<String, Object> dailyCarCheck(HttpServletRequest request,
			Model model){
		System.out.println("dailyCarCheck 시작");
		sessionCheck();	
		String routeSelect = request.getParameter("routeSelect");
		String driveYear = request.getParameter("driveYear");
		String driveMon = request.getParameter("driveMon");
		String route_name = request.getParameter("routeName");
		route_name = route_name.trim();
		System.out.println("routeSelect:"+routeSelect);
		System.out.println("driveYear:"+driveYear);
		System.out.println("driveMon:"+driveMon);
		
		int d_year = Integer.parseInt(driveYear);
		int d_mon = Integer.parseInt(driveMon);
		HashMap<String, Object> hasmap = new HashMap<String, Object>();
		
		Calendar currentCalendar = Calendar.getInstance();
        currentCalendar.set(d_year,d_mon-1,1);
        
        int lastDay =  currentCalendar.getActualMaximum(Calendar.DATE);
        model.addAttribute("lastDay", lastDay);
        System.out.println("lastDay:"+lastDay);
		if(driveMon.length()==1){driveMon="0"+driveMon;}
		
		String day = driveYear+"-"+driveMon;
		List<Teach_bus_checkDto> dailycheckInfo = teach_bus_checkService.getDailyCheckInfo(route_name,routeSelect);
		List<Teach_bus_checkDto> selectCheckTable = teach_bus_checkService.getTeachCheckList(singleton.getCenter_code(),day,routeSelect);
//		List<RealTimeDto> realTimeCar_data = realTimeService.getRealTimeCar(route_id,center_code);
//		System.out.println("dailycheckInfo"+dailycheckInfo.get(0).getRoute_name());
//		System.out.println("da:"+dailycheckInfo.get(0).getRoute_name());
		
		int chk ;
		chk=1;
		
		List<Teach_bus_checkDto> teach_bus_ckecklistB = teach_bus_checkService.getCheckListContent(singleton.getCenter_code(),chk);
		hasmap.put("teach_bus_ckecklistB",teach_bus_ckecklistB);
		
		chk=2;
		List<Teach_bus_checkDto> teach_bus_ckecklistI = teach_bus_checkService.getCheckListContent(singleton.getCenter_code(),chk);
		hasmap.put("teach_bus_ckecklistI",teach_bus_ckecklistI);
		
		chk=3;
		List<Teach_bus_checkDto> teach_bus_ckecklistA = teach_bus_checkService.getCheckListContent(singleton.getCenter_code(),chk);
		hasmap.put("teach_bus_ckecklistA",teach_bus_ckecklistA);
		
		hasmap.put("lastDay", lastDay);
		hasmap.put("data", selectCheckTable);
		hasmap.put("dailycheckInfo", dailycheckInfo);
		return hasmap;
	}
	
	@RequestMapping(value="carCheckManagement")
	public String carCheckManagement(Model model) {				
		sessionCheck();	
		
		DateFormat dataFormat = new SimpleDateFormat("YYYY-MM");
		Date date = new Date();
		
		DecimalFormat df = new DecimalFormat("00");
        Calendar currentCalendar = Calendar.getInstance();
        String lastDay =  df.format(currentCalendar.getActualMaximum(Calendar.DAY_OF_MONTH ));
        model.addAttribute("lastDay",lastDay);	//이번달 마지막 날짜
        
		String checkDateYNM = dataFormat.format(date);
		
		List<BusRouteDto> routeList = busRouteService.getRouteList(singleton.getCenter_code());
		model.addAttribute("routeList",routeList);
		
		//bus_daily_check 에서 차량 정보 가져 옴
		List<Teach_bus_checkDto> dailycheckInfo = teach_bus_checkService.getDailyCheckInfo(routeList.get(0).getRoute_name(),routeList.get(0).getRoute_id());
//		model.addAttribute("dailycheckInfo",dailycheckInfo);
		
//		List<Teach_bus_checkDto> dailycheckInfo = teach_bus_checkService.getDetailCarInfo(routeList.get(0).getRoute_id());
		model.addAttribute("dailycheckInfo",dailycheckInfo);
		
		List<Teach_bus_checkDto> teach_checkList = teach_bus_checkService.getTeachCheckList(singleton.getCenter_code(),checkDateYNM,routeList.get(0).getRoute_id());
		model.addAttribute("checkList",teach_checkList);
		
		if(teach_checkList.size()!=0){
			if(teach_checkList.get(0).getToday().equals("")){
				model.addAttribute("today", teach_checkList.get(0).getToday());
			}else{
				model.addAttribute("today", '-');
			}
		}else{
			model.addAttribute("today", '-');
		}
		
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
		boolean check = false;
		model.addAttribute("check",check);
		
//		System.out.println("teach_checkList"+teach_checkList.get(0).getTeach_check());
		return "realTime/carCheckManagement";
	}
	
	@RequestMapping(value="carCheckManagement_main")
	public String carCheckManagement_main(Model model,HttpServletRequest request) {				
		sessionCheck();	
		
		String route_name = request.getParameter("rm");
		String route_id = request.getParameter("ri");
		String main_year = request.getParameter("my");
		String main_mon = request.getParameter("mm");
		
		System.out.println("route_name:"+route_name);
		System.out.println("main_year:"+main_year);
		System.out.println("main_mon:"+main_mon);	

		int main_year_i = Integer.parseInt(main_year);
		int main_mon_i = Integer.parseInt(main_mon);
		
		model.addAttribute("route_id",route_id);
		model.addAttribute("main_year_i",main_year_i);
		model.addAttribute("main_mon_i",main_mon_i);
		
		Calendar cal = Calendar.getInstance();
		cal.set(main_year_i,main_mon_i-1,1);
        
        int lastDay =  cal.getActualMaximum(Calendar.DATE);
        model.addAttribute("lastDay", lastDay);
        
		String checkDateYNM = main_year+"-"+main_mon;
		System.out.println("checkDateYNM:"+checkDateYNM);
		
		List<BusRouteDto> routeList = busRouteService.getRouteList(singleton.getCenter_code());
		model.addAttribute("routeList",routeList);
		
		//bus_daily_check 에서 차량 정보 가져 옴
		List<Teach_bus_checkDto> dailycheckInfo = teach_bus_checkService.getDailyCheckInfo(routeList.get(0).getRoute_name(),routeList.get(0).getRoute_id());
//		model.addAttribute("dailycheckInfo",dailycheckInfo);
		
//		List<Teach_bus_checkDto> dailycheckInfo = teach_bus_checkService.getDetailCarInfo(routeList.get(0).getRoute_id());
		model.addAttribute("dailycheckInfo",dailycheckInfo);
		
		List<Teach_bus_checkDto> teach_checkList = teach_bus_checkService.getTeachCheckList(singleton.getCenter_code(),checkDateYNM,routeList.get(0).getRoute_id());
		model.addAttribute("checkList",teach_checkList);
		
		if(teach_checkList.size()!=0){
			if(teach_checkList.get(0).getToday().equals("")){
				model.addAttribute("today", teach_checkList.get(0).getToday());
			}else{
				model.addAttribute("today", '-');
			}
		}else{
			model.addAttribute("today", '-');
		}
		
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
		boolean check = true;
		model.addAttribute("check",check);
		
//		System.out.println("teach_checkList"+teach_checkList.get(0).getTeach_check());
		return "realTime/carCheckManagement";
	}
	
	@RequestMapping(value="saveCheckManagement", method=RequestMethod.POST)
	public String saveCheckManagement(HttpServletRequest request){
		
		String[] teach_check = request.getParameterValues("teach_check");
		String year = request.getParameter("nowYear");
		String mon = request.getParameter("nowMon");
		String route_id = request.getParameter("route_id");
		route_id=route_id.trim();
		String teach_check_date = request.getParameter("teach_check_date");
		String teach_check_date_2 = teach_check_date.substring(0, 7);			//2018-02
		System.out.println("teach_check_date:"+teach_check_date);
		String nowYNM = year+"-"+mon;
				
		int[] typeArray = new int[teach_check.length];
		int[] contentArray = new int[teach_check.length];
		String[] dayArray = new String[teach_check.length];
		int[] checkArray = new int[teach_check.length];
		String[] todayArray = new String[teach_check.length];
		
		for(int i=0;i<teach_check.length;i++){
			String[] teach_checkArray = teach_check[i].split("_");
			typeArray[i] = Integer.parseInt(teach_checkArray[0]);
			contentArray[i] = Integer.parseInt(teach_checkArray[1]);
			if(teach_checkArray[2].length()==1){teach_checkArray[2]="0"+teach_checkArray[2];}
			dayArray[i] = teach_checkArray[2];
			checkArray[i] = Integer.parseInt(teach_checkArray[3]);
			todayArray[i] = year+"-"+mon+"-"+teach_checkArray[2];
		}
		
		teach_bus_checkService.deleteAllCheckList(teach_check_date_2,singleton.getCenter_code(),route_id);
		teach_bus_checkService.deleteDailyAllCheckList(teach_check_date_2,singleton.getCenter_code(),route_id);
		teach_bus_checkService.updateAllCheckList(typeArray,contentArray,dayArray,checkArray,route_id,teach_check_date,singleton.getCenter_code(),singleton.getId(),todayArray);
//		
		
		System.out.println("nowYear:"+year);
		System.out.println("nowMon:"+mon);
		return "redirect:/carCheckManagement";
	}
	@RequestMapping(value="carCheckManagement_Update")
	public String carCheckManagement_Update(Model model,HttpServletRequest request) {				
		sessionCheck();			
		
		System.out.println("carCheckManagement_Update 시작");
		String re_Year = request.getParameter("y");
		String re_Mon = request.getParameter("m");
		if(re_Mon.length()==1){re_Mon="0"+re_Mon;}
		String checkDateYNM = re_Year+"-"+re_Mon;
		String route_id = request.getParameter("route");
		
		int nowyear = Integer.parseInt(re_Year);
		int nowMon = Integer.parseInt(re_Mon);
//		SimpleDateFormat transeDate = new SimpleDateFormat("yyyyMMdd");
		Calendar cal = Calendar.getInstance();
		cal.set(nowyear,nowMon-1,1);
        
        int lastDay =  cal.getActualMaximum(Calendar.DATE);
        model.addAttribute("lastDay", lastDay);
		
		model.addAttribute("re_Year",re_Year);
		model.addAttribute("re_Mon",re_Mon);
//		DecimalFormat df = new DecimalFormat("00");
//        Calendar currentCalendar = Calendar.getInstance();
////        String lastDay =  df.format(currentCalendar.getActualMaximum(Calendar.DAY_OF_MONTH ));
////        model.addAttribute("lastDay",lastDay);	//이번달 마지막 날짜
        
		List<BusRouteDto> routeList = busRouteService.getRouteName(route_id);
		model.addAttribute("routeList",routeList);
		List<Teach_bus_checkDto> dailycheckInfo = teach_bus_checkService.getDetailCarInfo(route_id);
		model.addAttribute("dailycheckInfo",dailycheckInfo);
//		System.out.println("dailycheckInfo:"+dailycheckInfo.get(0).getStaff_name());
////		List<Teach_bus_checkDto> dailycheckInfo = teach_bus_checkService.getDailyCheckInfo(routeList.get(0).getRoute_name(),route_id);
//		List<Teach_bus_checkDto> dailycheckInfo = teach_bus_checkService.getDetailCarInfo(routeList.get(0).getRoute_id());
//		model.addAttribute("dailycheckInfo",dailycheckInfo);
//				
		List<Teach_bus_checkDto> teach_bus_ckecklist = teach_bus_checkService.getCheckListContentAll(singleton.getCenter_code());
		model.addAttribute("teach_bus_ckecklist",teach_bus_ckecklist);
		
		List<Teach_bus_checkDto> teach_checkList = teach_bus_checkService.getTeachCheckList(singleton.getCenter_code(),checkDateYNM,route_id);
		model.addAttribute("checkList",teach_checkList);
		
		//오늘 날짜
		SimpleDateFormat sysdate = new SimpleDateFormat("yyyy-MM-dd");
        Calendar c1 = Calendar.getInstance();
        String strToday = sysdate.format(c1.getTime());

	
		if(teach_checkList.size()!=0){
			model.addAttribute("today", teach_checkList.get(0).getToday());
		}else{
			model.addAttribute("today", strToday);
		}
//		
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
		
		return "realTime/carCheckManagement_Update";
	}
	@RequestMapping(value="vehicleLogList")
	public String vehicleLogList(Model model,HttpServletRequest request) {
		sessionCheck();	
		
		List<BusRouteDto> routeList = busRouteService.getRouteList(singleton.getCenter_code());
		model.addAttribute("routeList",routeList);
		
		return"realTime/vehicleLogList";
	}
	
	
	@RequestMapping(value="vehicleLogList_sub")
	public String vehicleLogList_sub(Model model,HttpServletRequest request) {
		sessionCheck();	
		
		String route_id =request.getParameter("route_id");
		String selectYM;
		
		if(request.getParameter("date")==null) {
			Date date = new Date();       
		    Calendar cal = Calendar.getInstance();       
		    cal.setTime(date);
		       
		    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
			       
		    selectYM = sdf.format(cal.getTime()); 
		}
		else{
			selectYM = request.getParameter("date");
		}
		  
		
		System.out.println("selectYM:"+selectYM);
//		List<RecordDto> recordRouteList = recordService.getRecordRoute(route_id,selectYM,singleton.getCenter_code());
		List<RecordDto> recordDriv_Doc = recordService.getRecordDriv_Doc(route_id,selectYM,singleton.getCenter_code());
		model.addAttribute("routeList",recordDriv_Doc);
		model.addAttribute("route_id",route_id);
		model.addAttribute("selectYM",selectYM);
		
		return"realTime/vehicleLogList_sub";
	}
	@RequestMapping(value="vehicleLogList_select")
	public String vehicleLogList_select(Model model,HttpServletRequest request) {
		sessionCheck();	
		
		String route_id =request.getParameter("route_id");
		String selectYM = request.getParameter("date");
		
//		List<RecordDto> recordRouteList = recordService.getRecordRoute(route_id,selectYM,singleton.getCenter_code());
		List<RecordDto> recordDriv_Doc = recordService.getRecordDriv_Doc(route_id,selectYM,singleton.getCenter_code());
		model.addAttribute("routeList",recordDriv_Doc);
		model.addAttribute("route_id",route_id);
		model.addAttribute("selectYM",selectYM);
		
		return"realTime/vehicleLogList_sub";
	}
	@RequestMapping(value="vehicleLogDetail")
	public String vehicleLogDetail(Model model,HttpServletRequest request) {
		sessionCheck();	
		
		String route_id = request.getParameter("r");
		String dayR = request.getParameter("cdf");
		String day ="";
		day = dayR.replaceAll("[.]", "-"); 
		String month ="01";
		String year ="2018";
		String selectYM = year+"-"+month;
		
		
		System.out.println("route_id:"+route_id);
		System.out.println("day:"+day);
		
		List<RecordDto> detailRecordList = recordService.getDetailRecordList(route_id,day);
		model.addAttribute("detailRecordList",detailRecordList);
		
		List<RecordDto> recordDriv_Doc = recordService.getRecordDriv_Doc(route_id,selectYM,singleton.getCenter_code());
		model.addAttribute("routeList",recordDriv_Doc);
		return"realTime/vehicleLogDetail";
	}
	
	@RequestMapping(value="vehicleListDown")
	public String vehicleListDown(Model model,HttpServletRequest request){
		String[] driv_doc = request.getParameter("driv_doc").split(",");
		String route_id = request.getParameter("route_id");
		
		System.out.println("day:"+driv_doc.length);
		
//		List<RecordDto> recordDriv_Doc = recordService.getRecordDriv_Doc(route_id,selectYM,singleton.getCenter_code());
		List<RecordDto> recordListArray = recordService.selectRecord_DownData(route_id,driv_doc);
		model.addAttribute("recordListArray",recordListArray);
		model.addAttribute("route_name", recordListArray.get(0).getRoute_name());
		model.addAttribute("bus_num", recordListArray.get(0).getBus_num());
		model.addAttribute("loopCnt", driv_doc.length);
		System.out.println("============route_name"+recordListArray.size());
		
		return "realTime/vehicleListDown";
	}
	@RequestMapping(value="vehicleListDown_Excel")
	public View vehicleListDown_Excel(Model model,HttpServletRequest request)throws Exception{
		String[] driv_doc = request.getParameter("driv_doc").split(",");
		String route_id = request.getParameter("route_id");
		
		System.out.println("day:"+driv_doc.length);
		for(int i=0;i<driv_doc.length;i++){
			System.out.println("driv_doc:"+driv_doc[i]);
		}
		
//		List<RecordDto> recordDriv_Doc = recordService.getRecordDriv_Doc(route_id,selectYM,singleton.getCenter_code());
		
		List<RecordDto> recordListArray = recordService.selectRecord_DownData(route_id,driv_doc);
		model.addAttribute("recordListArray",recordListArray);
		model.addAttribute("route_name", recordListArray.get(0).getRoute_name());
		model.addAttribute("bus_num", recordListArray.get(0).getBus_num());
		model.addAttribute("createDateFormat", recordListArray.get(0).getCreateDateFormat());
		model.addAttribute("loopCnt", driv_doc.length);
		System.out.println("============route_name"+recordListArray.size());
		
		return new listDown_Excel_vehicle();
	}
	@RequestMapping(value="carCheckManagementDown_Excel")
	public View carCheckManagementDown_Excel(Model model,HttpServletRequest request)throws Exception{
		String route_id = request.getParameter("route_id");
		String route_name = request.getParameter("route_name");
		String[] route_name_arr = route_name.split(" (");
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		
		System.out.println("route_id :"+route_id);
		System.out.println("route_name :"+route_name_arr[0]);
		System.out.println("year :"+year);
		System.out.println("month :"+month);
		
		if(month.length()<2){
			month = "0"+month;
		}
		String checkDateYNM = year+"-"+month;
		
		DecimalFormat df = new DecimalFormat("00");
        Calendar currentCalendar = Calendar.getInstance();
        String lastDay =  df.format(currentCalendar.getActualMaximum(Calendar.DAY_OF_MONTH ));
        model.addAttribute("lastDay",lastDay);	//이번달 마지막 날짜
        System.out.println("lastDay_s:"+lastDay);
        
		List<BusRouteDto> routeList = busRouteService.getRouteList(singleton.getCenter_code());
		model.addAttribute("routeList",routeList);
		
		//bus_daily_check 에서 차량 정보 가져 옴
		List<Teach_bus_checkDto> dailycheckInfo = teach_bus_checkService.getDailyCheckInfo(route_name_arr[0],route_id);
//		model.addAttribute("dailycheckInfo",dailycheckInfo);
		
//		List<Teach_bus_checkDto> dailycheckInfo = teach_bus_checkService.getDetailCarInfo(routeList.get(0).getRoute_id());
		model.addAttribute("dailycheckInfo",dailycheckInfo);
		
		List<Teach_bus_checkDto> teach_checkList = teach_bus_checkService.getTeachCheckList2(singleton.getCenter_code(),checkDateYNM,route_id);
		model.addAttribute("checkList",teach_checkList);
		
//		if(teach_checkList.size()!=0){
//			if(teach_checkList.get(0).getToday().equals("")){
//				model.addAttribute("today", teach_checkList.get(0).getToday());
//			}else{
//				model.addAttribute("today", '-');
//			}
//		}else{
//			model.addAttribute("today", '-');
//		}
		
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
		
		
		System.out.println("listDown_Excel_carCheck gogo");
		return new listDown_Excel_carCheck();
	}
	@RequestMapping(value="carCheckBreakdown")
	public String carCheckBreakdown(Model model) {				
		
	        
		return "realTime/carCheckBreakdown";
	}
	@RequestMapping(value="carCheckBreakdownUpdate")
	public String carCheckBreakdownUpdate(Model model) {				
		
	        
		return "realTime/carCheckBreakdownUpdate";
	}
	
	
}
