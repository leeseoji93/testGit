package com.test.rememberTest.Dto;

import java.util.Date;

public class Teach_bus_checkDto {

	private String center_code;
	private Date creatime;
	private String staff_id;
	private int teach_buslist_cont_order;
	private int teach_buslist_type_order;
	private int teach_check;
	private Date teach_check_date;
	private int teach_check_id;
	private Date updatetime;
	
	private String affiliation;
	private Date ckeckdate;
	private String registrant;
	private String teach_buslist_cont;
	private String teach_buslist_type;
	
	private String checkDateAll;
	private String checkDateD;
	
	private int bus_borad;
	private Date bus_insur;
	private String bus_num;
	private String bus_staff;
	private int drive_mon;
	private int drive_year;
	private String main_staff_id;
	private String route_arrive;
	private String route_id;
	private String route_name;
	private String route_start;
	private String sub_staff_id;
	private String today;
	
	private String insurformat;
	
	private String staff_name;
	private String formatToday;
	
	private String group_cont_order;
	private String group_teach_check;
	
	private String checkDateYear;
	private String checkDateMon;
	
	private String route_type;
	
	public Teach_bus_checkDto(){}
	
	public Teach_bus_checkDto(String center_code, Date creatime, String staff_id, int teach_buslist_cont_order,
			int teach_buslist_type_order, int teach_check, Date teach_check_date, int teach_check_id, Date updatetime,
			String affiliation, Date ckeckdate, String registrant, String teach_buslist_cont,
			String teach_buslist_type) {
		super();
		this.center_code = center_code;
		this.creatime = creatime;
		this.staff_id = staff_id;
		this.teach_buslist_cont_order = teach_buslist_cont_order;
		this.teach_buslist_type_order = teach_buslist_type_order;
		this.teach_check = teach_check;
		this.teach_check_date = teach_check_date;
		this.teach_check_id = teach_check_id;
		this.updatetime = updatetime;
		this.affiliation = affiliation;
		this.ckeckdate = ckeckdate;
		this.registrant = registrant;
		this.teach_buslist_cont = teach_buslist_cont;
		this.teach_buslist_type = teach_buslist_type;
	}
	public String getCenter_code() {
		return center_code;
	}
	public void setCenter_code(String center_code) {
		this.center_code = center_code;
	}
	public Date getCreatime() {
		return creatime;
	}
	public void setCreatime(Date creatime) {
		this.creatime = creatime;
	}
	public String getStaff_id() {
		return staff_id;
	}
	public void setStaff_id(String staff_id) {
		this.staff_id = staff_id;
	}
	public int getTeach_buslist_cont_order() {
		return teach_buslist_cont_order;
	}
	public void setTeach_buslist_cont_order(int teach_buslist_cont_order) {
		this.teach_buslist_cont_order = teach_buslist_cont_order;
	}
	public int getTeach_buslist_type_order() {
		return teach_buslist_type_order;
	}
	public void setTeach_buslist_type_order(int teach_buslist_type_order) {
		this.teach_buslist_type_order = teach_buslist_type_order;
	}
	public int getTeach_check() {
		return teach_check;
	}
	public void setTeach_check(int teach_check) {
		this.teach_check = teach_check;
	}
	public Date getTeach_check_date() {
		return teach_check_date;
	}
	public void setTeach_check_date(Date teach_check_date) {
		this.teach_check_date = teach_check_date;
	}
	public int getTeach_check_id() {
		return teach_check_id;
	}
	public void setTeach_check_id(int teach_check_id) {
		this.teach_check_id = teach_check_id;
	}
	public Date getUpdatetime() {
		return updatetime;
	}
	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}
	public String getAffiliation() {
		return affiliation;
	}
	public void setAffiliation(String affiliation) {
		this.affiliation = affiliation;
	}
	public Date getCkeckdate() {
		return ckeckdate;
	}
	public void setCkeckdate(Date ckeckdate) {
		this.ckeckdate = ckeckdate;
	}
	public String getRegistrant() {
		return registrant;
	}
	public void setRegistrant(String registrant) {
		this.registrant = registrant;
	}
	public String getTeach_buslist_cont() {
		return teach_buslist_cont;
	}
	public void setTeach_buslist_cont(String teach_buslist_cont) {
		this.teach_buslist_cont = teach_buslist_cont;
	}
	public String getTeach_buslist_type() {
		return teach_buslist_type;
	}
	public void setTeach_buslist_type(String teach_buslist_type) {
		this.teach_buslist_type = teach_buslist_type;
	}

	public String getCheckDateAll() {
		return checkDateAll;
	}

	public void setCheckDateAll(String checkDateAll) {
		this.checkDateAll = checkDateAll;
	}

	public String getCheckDateD() {
		return checkDateD;
	}

	public void setCheckDateD(String checkDateD) {
		this.checkDateD = checkDateD;
	}
	public int getBus_borad() {
		return bus_borad;
	}

	public void setBus_borad(int bus_borad) {
		this.bus_borad = bus_borad;
	}

	public Date getBus_insur() {
		return bus_insur;
	}

	public void setBus_insur(Date bus_insur) {
		this.bus_insur = bus_insur;
	}

	public String getBus_num() {
		return bus_num;
	}

	public void setBus_num(String bus_num) {
		this.bus_num = bus_num;
	}

	public String getBus_staff() {
		return bus_staff;
	}

	public void setBus_staff(String bus_staff) {
		this.bus_staff = bus_staff;
	}

	public int getDrive_mon() {
		return drive_mon;
	}

	public void setDrive_mon(int drive_mon) {
		this.drive_mon = drive_mon;
	}

	public int getDrive_year() {
		return drive_year;
	}

	public void setDrive_year(int drive_year) {
		this.drive_year = drive_year;
	}

	public String getMain_staff_id() {
		return main_staff_id;
	}

	public void setMain_staff_id(String main_staff_id) {
		this.main_staff_id = main_staff_id;
	}

	public String getRoute_arrive() {
		return route_arrive;
	}

	public void setRoute_arrive(String route_arrive) {
		this.route_arrive = route_arrive;
	}

	public String getRoute_id() {
		return route_id;
	}

	public void setRoute_id(String route_id) {
		this.route_id = route_id;
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

	public String getSub_staff_id() {
		return sub_staff_id;
	}

	public void setSub_staff_id(String sub_staff_id) {
		this.sub_staff_id = sub_staff_id;
	}

	public String getToday() {
		return today;
	}

	public void setToday(String today) {
		this.today = today;
	}

	public String getInsurformat() {
		return insurformat;
	}

	public void setInsurformat(String insurformat) {
		this.insurformat = insurformat;
	}

	public String getStaff_name() {
		return staff_name;
	}

	public void setStaff_name(String staff_name) {
		this.staff_name = staff_name;
	}

	public String getFormatToday() {
		return formatToday;
	}

	public void setFormatToday(String formatToday) {
		this.formatToday = formatToday;
	}

	public String getGroup_cont_order() {
		return group_cont_order;
	}

	public void setGroup_cont_order(String group_cont_order) {
		this.group_cont_order = group_cont_order;
	}

	public String getGroup_teach_check() {
		return group_teach_check;
	}

	public void setGroup_teach_check(String group_teach_check) {
		this.group_teach_check = group_teach_check;
	}

	public String getCheckDateYear() {
		return checkDateYear;
	}

	public void setCheckDateYear(String checkDateYear) {
		this.checkDateYear = checkDateYear;
	}

	public String getCheckDateMon() {
		return checkDateMon;
	}

	public void setCheckDateMon(String checkDateMon) {
		this.checkDateMon = checkDateMon;
	}

	public String getRoute_type() {
		return route_type;
	}

	public void setRoute_type(String route_type) {
		this.route_type = route_type;
	}
	
}
