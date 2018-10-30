package com.test.rememberTest;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.event.ApplicationContextEvent;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.RememberMeAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.ModelAndView;

import com.test.rememberTest.Dao.BusRoute.BusRouteService;
import com.test.rememberTest.Dao.Car.CarService;
import com.test.rememberTest.Dao.Center.CenterService;
import com.test.rememberTest.Dao.Center_Code.Center_CodeService;
import com.test.rememberTest.Dao.Class.ClassService;
import com.test.rememberTest.Dao.Equipment.EquipmentService;
import com.test.rememberTest.Dao.Home_communication.Home_communicationService;
import com.test.rememberTest.Dao.Kid.KidService;
import com.test.rememberTest.Dao.Korea_admin_area.Korea_admin_areaService;
import com.test.rememberTest.Dao.Medication_request.Medication_requestService;
import com.test.rememberTest.Dao.Record.RecordService;
import com.test.rememberTest.Dao.Staff.StaffService;
import com.test.rememberTest.Dao.Teach_bus_check.Teach_bus_checkService;
import com.test.rememberTest.Dao.User.UserService;
import com.test.rememberTest.Dto.BusRouteDto;
import com.test.rememberTest.Dto.CenterDto;
import com.test.rememberTest.Dto.Center_CodeDto;
import com.test.rememberTest.Dto.ClassDto;
import com.test.rememberTest.Dto.EquipmentDto;
import com.test.rememberTest.Dto.Home_communicationDto;
import com.test.rememberTest.Dto.KidDto;
import com.test.rememberTest.Dto.Medication_requestDto;
import com.test.rememberTest.Dto.MemberInfo;
import com.test.rememberTest.Dto.RecordDto;
import com.test.rememberTest.Dto.Singleton;
import com.test.rememberTest.Dto.StaffDto;
import com.test.rememberTest.Dto.StationInfo;
import com.test.rememberTest.Dto.Teach_bus_checkDto;
import com.test.rememberTest.Dto.korea_admin_areaDto;
import com.test.rememberTest.parent.ParentService;


/**
 * Handles requests for the application home page.
 */
@Controller
@SessionAttributes(value = { "sessionUser","mId","mEmail" })
public class HomeController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	@Autowired
	private UserService userService;
	@Autowired
	private CenterService centerService; 
	@Autowired
	private Korea_admin_areaService korea_admin_areaService; 
	@Autowired
	private Center_CodeService center_CodeService; 
	@Autowired
	private StaffService staffService;
	@Autowired
	private EquipmentService equipmentService;
	@Autowired
	private BusRouteService busRouteService;
	@Autowired
	private ClassService classService;
	@Autowired
	private Medication_requestService medication_requestService;
	@Autowired
	private Home_communicationService home_communicationService;
	@Autowired
	private RecordService recordService;
	@Autowired
	private Teach_bus_checkService teach_bus_checkService;
	
//	Singleton singleton = Singleton.getInstance();
//	Singleton singleton1 = Singleton.getInstance();
	WebApplicationContext context = ContextLoader.getCurrentWebApplicationContext();
	Singleton singleton = (Singleton)context.getBean("singleton");
	
	public void sessionCheck() {
		if(singleton==null){
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
			List<StaffDto> staffList = staffService.getCenterCode(authentication.getName());
			singleton.setCenter_code(staffList.get(0).getCenter_code());
			singleton.setId(authentication.getName());
			singleton.setName(staffList.get(0).getStaff_name());
			singleton.setS_email(staffList.get(0).getStaff_email());
		}
	}
	
	@RequestMapping(value = { "/", "/welcome**","/home"}, method = RequestMethod.GET)
	public ModelAndView defaultPage(HttpServletRequest request,HttpSession session) {
		ModelAndView model = new ModelAndView();
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		model.addObject("authentication", authentication.getName());
		System.out.println("authentication :"+authentication.getName() );
		
		if(authentication.getName()!="anonymousUser"){
			String staffName = authentication.getName();
			List<StaffDto> staffList =  staffService.getCenterCode(staffName);
			singleton.setCenter_code(staffList.get(0).getCenter_code());
			singleton.setId(staffName);
			singleton.setName(staffList.get(0).getStaff_name());
			
			model.addObject("message", "Welcome");
			model.addObject("id", singleton.getId());
			model.addObject("name", singleton.getName());
			model.addObject("center_code",singleton.getCenter_code());
			
			//계정 관리 Count
			List<StaffDto> accountCountList = staffService.getDashboardAccountCount(staffList.get(0).getCenter_code());
			model.addObject("accountCountList", accountCountList);
			
			//기기 관리 Count
			List<EquipmentDto> equipAllCount = equipmentService.getDashboardEquiCount(staffList.get(0).getCenter_code());
			model.addObject("equipAllCount", equipAllCount);
			
			//차량 정보 관리 Count - 차량, 정류장
			List<BusRouteDto> carNStationCount = busRouteService.getCarNStationCount(staffList.get(0).getCenter_code());
			model.addObject("carNStationCount", carNStationCount);
			
			//차량 정보 관리 Count - 노선 3개
			List<BusRouteDto> routeLatestList =  busRouteService.getRouteLatestList(singleton.getCenter_code());
			model.addObject("routeLatestList", routeLatestList);
			
			//반 개수
			List<ClassDto> classList = classService.Class_Select_AllList(singleton.getCenter_code());
			model.addObject("classList", classList);
			model.addObject("classListSize", classList.size());
			
			//대조서
			List<List<Medication_requestDto>> mdList = new ArrayList<List<Medication_requestDto>>();
			for(int i=0;i<classList.size();i++){
				List<Medication_requestDto> medication_requestLatestList = medication_requestService.Medication_requestLatestList(classList.get(i).getClass_id(),singleton.getCenter_code());
				model.addObject("medi_req_LatestList"+i, medication_requestLatestList);
				mdList.add(medication_requestLatestList);
			}
			model.addObject("mdList", mdList);
			
			//가정통신문
			List<List<Home_communicationDto>> hc_List = new ArrayList<List<Home_communicationDto>>();
			for(int i=0;i<classList.size();i++){
				List<Home_communicationDto> home_communi_LatestList = home_communicationService.home_communi_LatestList(classList.get(i).getClass_id());
				model.addObject("home_communi_LatestList"+i, home_communi_LatestList);
				hc_List.add(home_communi_LatestList);
			}
			model.addObject("hcList", hc_List);
			
			System.out.println("hc_List"+hc_List.size());
			
			List<ClassDto> myClass = classService.getMyClassInfo(singleton.getId());
			model.addObject("myClass", myClass);
			
			//반 대조서
			List<List<Medication_requestDto>> mdList_MyClass = new ArrayList<List<Medication_requestDto>>();
			for(int i=0;i<myClass.size();i++){
				List<Medication_requestDto> medication_requestLatestList = medication_requestService.Medication_requestLatestList(myClass.get(i).getClass_id(),singleton.getCenter_code());
				model.addObject("medi_req_LatestList"+i, medication_requestLatestList);
				mdList_MyClass.add(medication_requestLatestList);
			}
			model.addObject("mdList_MyClass", mdList_MyClass);
			
			//반 가정 통신문
			List<List<Home_communicationDto>> hc_List_MyClass = new ArrayList<List<Home_communicationDto>>();
			for(int i=0;i<myClass.size();i++){
				List<Home_communicationDto> home_communi_LatestList = home_communicationService.home_communi_LatestList(myClass.get(i).getClass_id());
				model.addObject("home_communi_LatestList"+i, home_communi_LatestList);
				hc_List_MyClass.add(home_communi_LatestList);
			}
			model.addObject("hc_List_MyClass", hc_List_MyClass);
			
			//교직원- 차량운행일지
			List<RecordDto> recordDriv_Doc = recordService.getLatest_RecordDriv_Doc(singleton.getCenter_code());
			model.addObject("recordDriv_Doc", recordDriv_Doc);
			
			//교직원 - 차량점검표
			List<Teach_bus_checkDto> teach_bus_ckecklist = teach_bus_checkService.getLatestCheckList(singleton.getCenter_code());
			model.addObject("teach_bus_ckecklist", teach_bus_ckecklist);
		}

		model.setViewName("hello");
		return model;

	}
	@RequestMapping(value="footer")
	public String footer(Model model){
//		model.addAttribute("userForm",new MemberInfo());
		return "include/footer";
	}
	
	@RequestMapping(value="index")
	public String index(Model model){
//		model.addAttribute("userForm",new MemberInfo());
		return "index";
	}
	
	@RequestMapping(value="signupForm_After", method = RequestMethod.GET)
	public String signupForm_After(Model model){
//		model.addAttribute("userForm",new MemberInfo());
		return "signupForm_After";
	}
	
	/***********회원 관리************/
	@RequestMapping(value="accessDenied")
	public String accessDenied(){
		
		return "accessDenied";
	}
	@RequestMapping(value = "/admin**", method = RequestMethod.GET)
	public ModelAndView adminPage() {

		ModelAndView model = new ModelAndView();
		model.addObject("title", "Spring Security Remember Me");
		model.addObject("message", "This page is for ROLE_ADMIN only!");
		model.setViewName("admin");
		return model;

	}

	@RequestMapping(value = "/admin/update**", method = RequestMethod.GET)
	public ModelAndView updatePage(HttpServletRequest request) {

		ModelAndView model = new ModelAndView();

		if (isRememberMeAuthenticated()) {
			//send login for update
			setRememberMeTargetUrlToSession(request);
			model.addObject("loginUpdate", true);
			model.setViewName("/login");
			
		} else {
			model.setViewName("update");
		}

		return model;

	}

	@RequestMapping(value = {"/login","/login**"} ,method = RequestMethod.GET)
	public ModelAndView login(@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "logout", required = false) String logout, HttpServletRequest request,final HttpSession session) {
		System.out.println("**************로그인 시작***************");
		
		ModelAndView model = new ModelAndView();
		
		System.out.println("request:"+request);
		if (error != null) {
			model.addObject("error", "Invalid username and password!");
			
			String targetUrl = getRememberMeTargetUrlFromSession(request);

			if(StringUtils.hasText(targetUrl)){
				model.addObject("targetUrl", targetUrl);
				model.addObject("loginUpdate", true);
			}
		}
		System.out.println("========logout 값 :"+logout);
		if (logout != null) {
			model.addObject("msg", "You've been logged out successfully.");
		}
		model.setViewName("login");

		return model;

	}
	
	@RequestMapping(value="/logout", method = RequestMethod.GET)
	public String logoutPage (HttpServletRequest request, HttpServletResponse response) {
	    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    if (auth != null){    
	        new SecurityContextLogoutHandler().logout(request, response, auth);
	    }
	    return "redirect:/login?logout";//You can redirect wherever you want, but generally it's a good practice to show login screen again.
	}
	
	

	@RequestMapping(value = "userType", method = RequestMethod.GET)
	public String userType(){
		return "userType";
	}
	
	@ResponseBody
	@RequestMapping(value="guSelect",method=RequestMethod.POST)	   
	public HashMap<String, Object> guSelect(HttpServletRequest request){
		String cityCode =  request.getParameter("cityCode");					
		List<korea_admin_areaDto> area_districtName =  korea_admin_areaService.selectArea_districtName(cityCode);	
		
		HashMap<String, Object> hashmap = new HashMap<String,Object>();	
		hashmap.put("data", area_districtName); 	     
	    return hashmap;		
	}//구 선택
	
	@ResponseBody
	@RequestMapping(value="dongSelect",method=RequestMethod.POST)	   
	public HashMap<String, Object> dongSelect(HttpServletRequest request){
		String districtCode =  request.getParameter("districtCode");
		System.out.println("districtCode :"+districtCode);
		List<korea_admin_areaDto> area_townshipName =  korea_admin_areaService.selectArea_townshipName(districtCode);	
		
		HashMap<String, Object> hashmap = new HashMap<String,Object>();	
		hashmap.put("data", area_townshipName); 	     
	    return hashmap;		
	}//동 선택
	
	@ResponseBody
	@RequestMapping(value="selectCode",method=RequestMethod.POST)	   
	public HashMap<String, Object> selectCode(HttpServletRequest request){
		String adminArea =  request.getParameter("adminArea");
		List<Center_CodeDto> admin_Area =  center_CodeService.selectCode(adminArea);	
		
		HashMap<String, Object> hashmap = new HashMap<String,Object>();	
		hashmap.put("data", admin_Area); 	 
		System.out.println("admin_Area:"+admin_Area);
	    return hashmap;		
	}//센터코드 확인
	
	@RequestMapping(value = "signupForm_admin", method = RequestMethod.GET)	//원장 회원가입 폼
	public String signupForm_admin(Model model) {
		System.out.println("signupForm_admin 시작");
		List<korea_admin_areaDto> area_cityName =  korea_admin_areaService.selectArea_cityName();
		
		model.addAttribute("area_cityName",area_cityName);			//시
		
		model.addAttribute("adminForm",new StaffDto());
		model.addAttribute("adminForm",new CenterDto());
		return "signupForm_admin";
	}
	
//	@RequestMapping(value = "signupForm_After", method = RequestMethod.POST)	//원장 회원가입 폼
//	public String signupForm_After(Model model) {
//		System.out.println("signupForm_admin 시작");
//		return "signupForm_After";
//	}
	
	@RequestMapping(value="insert_admin", method = RequestMethod.POST)	//원장 원등록 insert
	public String insert_admin( StaffDto adminForm,CenterDto centerForm) {				
		System.out.println("getAdmin_area:"+adminForm.getAdmin_area());
		
		centerService.addCenterCode(centerForm);
		centerService.addCenter(centerForm);
		staffService.addStaff(adminForm);		
		staffService.addRoles(adminForm);		//권한 부여하기
		return "login";
	}
	
	
	@RequestMapping(value = "signupForm", method = RequestMethod.GET)
	public String signupForm(Model model) {
//		Map<String, Object> model
//		MemberInfo user = new MemberInfo();
//		model.put("userForm", user);
		
		model.addAttribute("AgreeForm",new StaffDto());
		return "signupForm";
	}
	
	@RequestMapping(value="signupForm1", method = RequestMethod.POST)
	public String doLogin( MemberInfo userForm) {				
	
		userService.addUser(userForm);				
		return "redirect:/userList";
	}
	
	@RequestMapping(value="/userList", method=RequestMethod.GET)
    public String userList(Model model,
                @RequestParam(value="page", defaultValue="1") int page,
                @RequestParam(value="word", required=false) String word) {
        List<MemberInfo> userList = userService.getUserList(page, word);
        model.addAttribute("userList", userList);
        model.addAttribute("page", page);
        model.addAttribute("lastPage", userService.getLastPage());
        return "userList";
    }
	
	@RequestMapping(value="checkId",method=RequestMethod.POST)
	public @ResponseBody HashMap<String, Object> checkId(@Valid @RequestParam HashMap<String,Object> param,MemberInfo memberInfo,Model model,Errors errors){
	//	System.out.println(param);
	//	System.out.println("id id"+param.get("mId"));
		System.out.println("checkId시작");
		String chk_id= (String) param.get("mId");			//입력한 Id값 받아옴
		int id_len = chk_id.length();
		MemberInfo sessionUser = userService.GetCheckId(chk_id);	//입력한 Id값이랑 DB비교하려고
		HashMap<String, Object> hashmap = new HashMap<String,Object>();
		
		if(id_len>5&&id_len<14){
			System.out.println("sessionUse : "+sessionUser);
			
//			hashmap.put("mId",sessionUser);
			if (sessionUser == null) {
				hashmap.put("mId","사용 가능한 ID입니다.");
			} else {
	//			String result_id = sessionUser.getmId();
	//			model.addAttribute("chk_id", result_id);
				hashmap.put("mId", "이미 해당 ID가 존재합니다.");
	//			System.out.println("hashmap : "+hashmap.put("mId", result_id));
			}
		}else{
			errors.rejectValue("chk_id", "rejected", "Id는 최소 일치 하지 않습니다.");
			hashmap.put("mId", "id 최소 길이는~");
		}
		return hashmap;
				
	}
	
	
	@RequestMapping(value = "/error_403", method = RequestMethod.GET)
	public ModelAndView accesssDenied() {

		ModelAndView model = new ModelAndView();

		System.out.println("error403page.");

		model.setViewName("error/error_403");
		return model;

	}
	
	
	private boolean isRememberMeAuthenticated() {
		System.out.println("------------isRememberMeAuthenticated 시작------------");
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (authentication == null) {
			System.out.println("------------authentication 시작------------");
			return false;
		}

		return RememberMeAuthenticationToken.class.isAssignableFrom(authentication.getClass());
	}
	
	/**
	 * save targetURL in session
	 */
	private void setRememberMeTargetUrlToSession(HttpServletRequest request){
		System.out.println("------------setRememberMeTargetUrlToSession 시작------------");
		HttpSession session = request.getSession(false);
		if(session!=null){
			session.setAttribute("targetUrl", "/admin/update");
		}
	}

	/**
	 * get targetURL from session
	 */
	private String getRememberMeTargetUrlFromSession(HttpServletRequest request){
		System.out.println("------------getRememberMeTargetUrlFromSession 시작------------");
		String targetUrl = "";
		HttpSession session = request.getSession(false);
		if(session!=null){
			System.out.println("------------session.getAttribute 값은 : "+session.getAttribute("targetUrl"));
			targetUrl = session.getAttribute("targetUrl")==null?"":session.getAttribute("targetUrl").toString();
			System.out.println("------------targetUrl 값은 : "+targetUrl);
		}
		return targetUrl;
	}
	
	
	
}