package com.test.rememberTest.Dto;

import java.sql.Date;
import java.sql.Time;


public class BusRouteDto {
	
	private String affiliation;
	private String route_id;
	private String course_id;
	private String bus_id;
	private String sub_staff_id;
	private String main_staff_id;
	private String route_type;
	private String route_name;
	private String route_start;
	private String route_arrive;
	private String route_sem;
	private String route_year;
	private boolean route_use;
	private String registrant;
	private Date createtime;
	private Date updatetime;
	private String maxcount;//등록된 루트 수 파악
	private String course_name;//등록된 루트 수 파악
	private String arrive_time;	//정류장 도착 시간
	

	private String bus_borad;
	private String staff_id;
	private String staff_name;
	private String staff_phone;
	private String mainStaff_id;
	private String mainStaff_name;
	private String mainStaff_phone;
	private String subStaff_id;
	private String subStaff_name;
	private String subStaff_phone;
	private String bus_name;
	private String bus_num;
	private String kid_name;
	private String kid_system_code;
	private String kid_addr;
	
	private String station_name;
	private String station_id;
	private String station_addr;
	private String latitude;
	private String longitude;
	private String cntBK;
	
	private String kid_pho;
	private String staff_phot;
	
	
	private String main_staff_name;
	private String sub_staff_name;
	private String bus_staff_id;
	private String bus_staff_name;
	private String equipment_gate_id;
	private String equipment_tablet_id;
	private String bus_insur;
	private String bus_com;
		
	private String mainStaff_phot;
	private String subStaff_phot;
	
	private String UPDATEDATEFORMAT;
	private String CREATEDATEFORMAT;
	
	private String kid_latitude;
	private String kid_longitude;
	
	private int station_AllCount;
	private int bus_AllCount;
	private int station_Use_AllCount;
	private int bus_Use_AllCount;
	private int kid_count;
	
	public BusRouteDto(){}
	
	
	public BusRouteDto(String affiliation, String route_id, String course_id, String bus_id, String sub_staff_id,
			String main_staff_id, String route_type, String route_name, String route_start, String route_arrive,
			String route_sem, String route_year, boolean route_use, String registrant, Date createtime, Date updatetime,
			String maxcount, String course_name, String arrive_time, String bus_borad, String staff_id,
			String staff_name, String staff_phone, String mainStaff_id, String mainStaff_name, String mainStaff_phone,
			String subStaff_id, String subStaff_name, String subStaff_phone, String bus_name, String bus_num,
			String kid_name, String kid_system_code, String kid_addr, String station_name, String station_id,
			String station_addr, String latitude, String longitude, String cntBK, String kid_pho, String staff_phot,
			String main_staff_name, String sub_staff_name, String bus_staff_id, String bus_staff_name,
			String equipment_gate_id, String equipment_tablet_id, String bus_insur, String bus_com,
			String mainStaff_phot, String subStaff_phot) {
		super();
		this.affiliation = affiliation;
		this.route_id = route_id;
		this.course_id = course_id;
		this.bus_id = bus_id;
		this.sub_staff_id = sub_staff_id;
		this.main_staff_id = main_staff_id;
		this.route_type = route_type;
		this.route_name = route_name;
		this.route_start = route_start;
		this.route_arrive = route_arrive;
		this.route_sem = route_sem;
		this.route_year = route_year;
		this.route_use = route_use;
		this.registrant = registrant;
		this.createtime = createtime;
		this.updatetime = updatetime;
		this.maxcount = maxcount;
		this.course_name = course_name;
		this.arrive_time = arrive_time;
		this.bus_borad = bus_borad;
		this.staff_id = staff_id;
		this.staff_name = staff_name;
		this.staff_phone = staff_phone;
		this.mainStaff_id = mainStaff_id;
		this.mainStaff_name = mainStaff_name;
		this.mainStaff_phone = mainStaff_phone;
		this.subStaff_id = subStaff_id;
		this.subStaff_name = subStaff_name;
		this.subStaff_phone = subStaff_phone;
		this.bus_name = bus_name;
		this.bus_num = bus_num;
		this.kid_name = kid_name;
		this.kid_system_code = kid_system_code;
		this.kid_addr = kid_addr;
		this.station_name = station_name;
		this.station_id = station_id;
		this.station_addr = station_addr;
		this.latitude = latitude;
		this.longitude = longitude;
		this.cntBK = cntBK;
		this.kid_pho = kid_pho;
		this.staff_phot = staff_phot;
		this.main_staff_name = main_staff_name;
		this.sub_staff_name = sub_staff_name;
		this.bus_staff_id = bus_staff_id;
		this.bus_staff_name = bus_staff_name;
		this.equipment_gate_id = equipment_gate_id;
		this.equipment_tablet_id = equipment_tablet_id;
		this.bus_insur = bus_insur;
		this.bus_com = bus_com;
		this.mainStaff_phot = mainStaff_phot;
		this.subStaff_phot = subStaff_phot;
	}
	public String getAffiliation() {
		return affiliation;
	}
	public void setAffiliation(String affiliation) {
		this.affiliation = affiliation;
	}
	public String getRoute_id() {
		return route_id;
	}
	public void setRoute_id(String route_id) {
		this.route_id = route_id;
	}
	public String getCourse_id() {
		return course_id;
	}
	public void setCourse_id(String course_id) {
		this.course_id = course_id;
	}
	public String getBus_id() {
		return bus_id;
	}
	public void setBus_id(String bus_id) {
		this.bus_id = bus_id;
	}
	public String getSub_staff_id() {
		return sub_staff_id;
	}
	public void setSub_staff_id(String sub_staff_id) {
		this.sub_staff_id = sub_staff_id;
	}
	public String getMain_staff_id() {
		return main_staff_id;
	}
	public void setMain_staff_id(String main_staff_id) {
		this.main_staff_id = main_staff_id;
	}
	public String getRoute_type() {
		return route_type;
	}
	public void setRoute_type(String route_type) {
		this.route_type = route_type;
	}
	public String getRoute_name() {
		return route_name;
	}
	public void setRoute_name(String route_name) {
		this.route_name = route_name;
	}
	public String getRoute_start() {
		return route_start;
	}
	public void setRoute_start(String route_start) {
		this.route_start = route_start;
	}
	public String getRoute_arrive() {
		return route_arrive;
	}
	public void setRoute_arrive(String route_arrive) {
		this.route_arrive = route_arrive;
	}
	public String getRoute_sem() {
		return route_sem;
	}
	public void setRoute_sem(String route_sem) {
		this.route_sem = route_sem;
	}
	public String getRoute_year() {
		return route_year;
	}
	public void setRoute_year(String route_year) {
		this.route_year = route_year;
	}
	public boolean isRoute_use() {
		return route_use;
	}
	public void setRoute_use(boolean route_use) {
		this.route_use = route_use;
	}
	public String getRegistrant() {
		return registrant;
	}
	public void setRegistrant(String registrant) {
		this.registrant = registrant;
	}
	public Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	public Date getUpdatetime() {
		return updatetime;
	}
	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}
	public String getMaxcount() {
		return maxcount;
	}
	public void setMaxcount(String maxcount) {
		this.maxcount = maxcount;
	}
	public String getCourse_name() {
		return course_name;
	}
	public void setCourse_name(String course_name) {
		this.course_name = course_name;
	}
	public String getArrive_time() {
		return arrive_time;
	}
	public void setArrive_time(String arrive_time) {
		this.arrive_time = arrive_time;
	}
	public String getBus_borad() {
		return bus_borad;
	}
	public void setBus_borad(String bus_borad) {
		this.bus_borad = bus_borad;
	}
	public String getStaff_id() {
		return staff_id;
	}
	public void setStaff_id(String staff_id) {
		this.staff_id = staff_id;
	}
	public String getStaff_name() {
		return staff_name;
	}
	public void setStaff_name(String staff_name) {
		this.staff_name = staff_name;
	}
	public String getStaff_phone() {
		return staff_phone;
	}
	public void setStaff_phone(String staff_phone) {
		this.staff_phone = staff_phone;
	}
	public String getMainStaff_id() {
		return mainStaff_id;
	}
	public void setMainStaff_id(String mainStaff_id) {
		this.mainStaff_id = mainStaff_id;
	}
	public String getMainStaff_name() {
		return mainStaff_name;
	}
	public void setMainStaff_name(String mainStaff_name) {
		this.mainStaff_name = mainStaff_name;
	}
	public String getMainStaff_phone() {
		return mainStaff_phone;
	}
	public void setMainStaff_phone(String mainStaff_phone) {
		this.mainStaff_phone = mainStaff_phone;
	}
	public String getSubStaff_id() {
		return subStaff_id;
	}
	public void setSubStaff_id(String subStaff_id) {
		this.subStaff_id = subStaff_id;
	}
	public String getSubStaff_name() {
		return subStaff_name;
	}
	public void setSubStaff_name(String subStaff_name) {
		this.subStaff_name = subStaff_name;
	}
	public String getSubStaff_phone() {
		return subStaff_phone;
	}
	public void setSubStaff_phone(String subStaff_phone) {
		this.subStaff_phone = subStaff_phone;
	}
	public String getBus_name() {
		return bus_name;
	}
	public void setBus_name(String bus_name) {
		this.bus_name = bus_name;
	}
	public String getBus_num() {
		return bus_num;
	}
	public void setBus_num(String bus_num) {
		this.bus_num = bus_num;
	}
	public String getKid_name() {
		return kid_name;
	}
	public void setKid_name(String kid_name) {
		this.kid_name = kid_name;
	}
	public String getKid_system_code() {
		return kid_system_code;
	}
	public void setKid_system_code(String kid_system_code) {
		this.kid_system_code = kid_system_code;
	}
	public String getKid_addr() {
		return kid_addr;
	}
	public void setKid_addr(String kid_addr) {
		this.kid_addr = kid_addr;
	}
	public String getStation_name() {
		return station_name;
	}
	public void setStation_name(String station_name) {
		this.station_name = station_name;
	}
	public String getStation_id() {
		return station_id;
	}
	public void setStation_id(String station_id) {
		this.station_id = station_id;
	}
	public String getStation_addr() {
		return station_addr;
	}
	public void setStation_addr(String station_addr) {
		this.station_addr = station_addr;
	}
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	public String getCntBK() {
		return cntBK;
	}
	public void setCntBK(String cntBK) {
		this.cntBK = cntBK;
	}
	public String getKid_pho() {
		return kid_pho;
	}
	public void setKid_pho(String kid_pho) {
		this.kid_pho = kid_pho;
	}
	public String getStaff_phot() {
		return staff_phot;
	}
	public void setStaff_phot(String staff_phot) {
		this.staff_phot = staff_phot;
	}
	public String getMain_staff_name() {
		return main_staff_name;
	}
	public void setMain_staff_name(String main_staff_name) {
		this.main_staff_name = main_staff_name;
	}
	public String getSub_staff_name() {
		return sub_staff_name;
	}
	public void setSub_staff_name(String sub_staff_name) {
		this.sub_staff_name = sub_staff_name;
	}
	public String getBus_staff_id() {
		return bus_staff_id;
	}
	public void setBus_staff_id(String bus_staff_id) {
		this.bus_staff_id = bus_staff_id;
	}
	public String getBus_staff_name() {
		return bus_staff_name;
	}
	public void setBus_staff_name(String bus_staff_name) {
		this.bus_staff_name = bus_staff_name;
	}
	public String getEquipment_gate_id() {
		return equipment_gate_id;
	}
	public void setEquipment_gate_id(String equipment_gate_id) {
		this.equipment_gate_id = equipment_gate_id;
	}
	public String getEquipment_tablet_id() {
		return equipment_tablet_id;
	}
	public void setEquipment_tablet_id(String equipment_tablet_id) {
		this.equipment_tablet_id = equipment_tablet_id;
	}
	public String getBus_insur() {
		return bus_insur;
	}
	public void setBus_insur(String bus_insur) {
		this.bus_insur = bus_insur;
	}
	public String getBus_com() {
		return bus_com;
	}
	public void setBus_com(String bus_com) {
		this.bus_com = bus_com;
	}
	public String getMainStaff_phot() {
		return mainStaff_phot;
	}
	public void setMainStaff_phot(String mainStaff_phot) {
		this.mainStaff_phot = mainStaff_phot;
	}
	public String getSubStaff_phot() {
		return subStaff_phot;
	}
	public void setSubStaff_phot(String subStaff_phot) {
		this.subStaff_phot = subStaff_phot;
	}


	public String getUPDATEDATEFORMAT() {
		return UPDATEDATEFORMAT;
	}


	public void setUPDATEDATEFORMAT(String uPDATEDATEFORMAT) {
		UPDATEDATEFORMAT = uPDATEDATEFORMAT;
	}


	public String getCREATEDATEFORMAT() {
		return CREATEDATEFORMAT;
	}


	public void setCREATEDATEFORMAT(String cREATEDATEFORMAT) {
		CREATEDATEFORMAT = cREATEDATEFORMAT;
	}


	public String getKid_latitude() {
		return kid_latitude;
	}


	public void setKid_latitude(String kid_latitude) {
		this.kid_latitude = kid_latitude;
	}


	public String getKid_longitude() {
		return kid_longitude;
	}


	public void setKid_longitude(String kid_longitude) {
		this.kid_longitude = kid_longitude;
	}


	public int getStation_AllCount() {
		return station_AllCount;
	}


	public void setStation_AllCount(int station_AllCount) {
		this.station_AllCount = station_AllCount;
	}


	public int getBus_AllCount() {
		return bus_AllCount;
	}


	public void setBus_AllCount(int bus_AllCount) {
		this.bus_AllCount = bus_AllCount;
	}


	public int getStation_Use_AllCount() {
		return station_Use_AllCount;
	}


	public void setStation_Use_AllCount(int station_Use_AllCount) {
		this.station_Use_AllCount = station_Use_AllCount;
	}


	public int getBus_Use_AllCount() {
		return bus_Use_AllCount;
	}


	public void setBus_Use_AllCount(int bus_Use_AllCount) {
		this.bus_Use_AllCount = bus_Use_AllCount;
	}


	public int getKid_count() {
		return kid_count;
	}


	public void setKid_count(int kid_count) {
		this.kid_count = kid_count;
	}
	
	
	
		

}
