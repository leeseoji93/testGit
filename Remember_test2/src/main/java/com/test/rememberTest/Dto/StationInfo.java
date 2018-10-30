package com.test.rememberTest.Dto;

import java.sql.Date;

public class StationInfo {
	private String maxcount;
	private int stationNo;
	private String center_code;
	private String affiliation;
	private String station_id;
	private String course_id;
	private String station_name;
	private String station_addr;
	private String station_type;
	private int station_use;
	private int station_order;
	private String registrant;
	private Date createtime;//생성일자
	private Date updatetime;//수정 일자
	private String latitude;
	
	private String routeExists;
	
	public StationInfo(){}
	
	public StationInfo(String maxcount, int stationNo, String center_code, String affiliation, String station_id,
			String course_id, String station_name, String station_addr, String station_type, int station_use,
			int station_order, String registrant, Date createtime, Date updatetime, String latitude, String longitude,
			int stationCnt) {
		super();
		this.maxcount = maxcount;
		this.stationNo = stationNo;
		this.center_code = center_code;
		this.affiliation = affiliation;
		this.station_id = station_id;
		this.course_id = course_id;
		this.station_name = station_name;
		this.station_addr = station_addr;
		this.station_type = station_type;
		this.station_use = station_use;
		this.station_order = station_order;
		this.registrant = registrant;
		this.createtime = createtime;
		this.updatetime = updatetime;
		this.latitude = latitude;
		this.longitude = longitude;
		this.stationCnt = stationCnt;
	}
	private String longitude;
	private int stationCnt;
	
	
	public String getMaxcount() {
		return maxcount;
	}
	public void setMaxcount(String maxcount) {
		this.maxcount = maxcount;
	}
	public int getStationNo() {
		return stationNo;
	}
	public void setStationNo(int stationNo) {
		this.stationNo = stationNo;
	}
	public String getCenter_code() {
		return center_code;
	}
	public void setCenter_code(String center_code) {
		this.center_code = center_code;
	}
	public String getAffiliation() {
		return affiliation;
	}
	public void setAffiliation(String affiliation) {
		this.affiliation = affiliation;
	}
	public String getStation_id() {
		return station_id;
	}
	public void setStation_id(String station_id) {
		this.station_id = station_id;
	}
	public String getCourse_id() {
		return course_id;
	}
	public void setCourse_id(String course_id) {
		this.course_id = course_id;
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
	public String getStation_type() {
		return station_type;
	}
	public void setStation_type(String station_type) {
		this.station_type = station_type;
	}
	public int getStation_use() {
		return station_use;
	}
	public void setStation_use(int station_use) {
		this.station_use = station_use;
	}
	public int getStation_order() {
		return station_order;
	}
	public void setStation_order(int station_order) {
		this.station_order = station_order;
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
	public int getStationCnt() {
		return stationCnt;
	}
	public void setStationCnt(int stationCnt) {
		this.stationCnt = stationCnt;
	}

	public String getRouteExists() {
		return routeExists;
	}

	public void setRouteExists(String routeExists) {
		this.routeExists = routeExists;
	}
}
