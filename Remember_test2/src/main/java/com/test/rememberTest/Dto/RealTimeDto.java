package com.test.rememberTest.Dto;

import java.sql.Date;
import java.sql.Time;


public class RealTimeDto {
	
	private String real_time_id;
	private String affiliation;
	private String route_id;
	private String station_id;
	private String sch_time;
	private String arrive_time;
	private String real_time_type;
	private String borad_nem;
	private Date updatetime;
	
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
	
	private String route_start;
	private String route_arrive;
	
	private String station_name;
	private String station_addr;
	private String latitude;
	private String longitude;
	private String cntBK;
	
	public RealTimeDto(){
		
	}
	
	public RealTimeDto(String real_time_id, String affiliation, String route_id, String station_id, String sch_time,
			String arrive_time, String real_time_type, String borad_nem, Date updatetime, String bus_borad,
			String staff_id, String staff_name, String staff_phone, String mainStaff_id, String mainStaff_name,
			String mainStaff_phone, String subStaff_id, String subStaff_name, String subStaff_phone, String bus_name,
			String bus_num, String kid_name, String kid_system_code, String kid_addr, String station_name,
			String station_addr, String latitude, String longitude, String cntBK) {
		super();
		this.real_time_id = real_time_id;
		this.affiliation = affiliation;
		this.route_id = route_id;
		this.station_id = station_id;
		this.sch_time = sch_time;
		this.arrive_time = arrive_time;
		this.real_time_type = real_time_type;
		this.borad_nem = borad_nem;
		this.updatetime = updatetime;
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
		this.station_addr = station_addr;
		this.latitude = latitude;
		this.longitude = longitude;
		this.cntBK = cntBK;
	}
	public String getReal_time_id() {
		return real_time_id;
	}
	public void setReal_time_id(String real_time_id) {
		this.real_time_id = real_time_id;
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
	public String getStation_id() {
		return station_id;
	}
	public void setStation_id(String station_id) {
		this.station_id = station_id;
	}
	public String getSch_time() {
		return sch_time;
	}
	public void setSch_time(String sch_time) {
		this.sch_time = sch_time;
	}
	public String getArrive_time() {
		return arrive_time;
	}
	public void setArrive_time(String arrive_time) {
		this.arrive_time = arrive_time;
	}
	public String getReal_time_type() {
		return real_time_type;
	}
	public void setReal_time_type(String real_time_type) {
		this.real_time_type = real_time_type;
	}
	public String getBorad_nem() {
		return borad_nem;
	}
	public void setBorad_nem(String borad_nem) {
		this.borad_nem = borad_nem;
	}
	public Date getUpdatetime() {
		return updatetime;
	}
	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
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
	

}
