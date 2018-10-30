package com.test.rememberTest.Dto;

import java.sql.Date;

public class Stat_scheDto {
	
	private String affiliation;
	
	private String station_id;
	
	private String route_id;
	
	private String arrive_time;
	
	private String registrant;
	
	private Date createtime;
	
	private Date updatetime;
	
	
	public Stat_scheDto() {}


	public Stat_scheDto(String affiliation, String station_id, String route_id, String arrive_time, String registrant,
			Date createtime, Date updatetime) {
		super();
		this.affiliation = affiliation;
		this.station_id = station_id;
		this.route_id = route_id;
		this.arrive_time = arrive_time;
		this.registrant = registrant;
		this.createtime = createtime;
		this.updatetime = updatetime;
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


	public String getRoute_id() {
		return route_id;
	}


	public void setRoute_id(String route_id) {
		this.route_id = route_id;
	}


	public String getArrive_time() {
		return arrive_time;
	}


	public void setArrive_time(String arrive_time) {
		this.arrive_time = arrive_time;
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
}
