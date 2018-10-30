package com.test.rememberTest.Dto;

import java.sql.Time;
import java.util.Date;

public class RecordDto {
	
	private Time time;
	private String station_name; 
	private String route_id;
	private int real_time_id;
	private int driv_log;
	private int driv_doc;
	private Date date;
	private String affiliation;

	private Date updatetime;
	private String tablet_id;
	private Time start_time;
	private String route_name;
	private String registrant;
	private String gateway_id;
	private Time end_time;
	private String dirver_name;
	private Date createtime;
	private String bus_num;
	private String bus_name;
	private String bus_id;
	
	private String createDateFormat;
	private String updateDateFormat;
	private String dateFormat;
	
	private String route_type;
	
	private String day;
	private int doccount;
	
	
	public RecordDto(){}


	public RecordDto(Time time, String station_name, String route_id, int real_time_id, int driv_log, int driv_doc,
			Date date, String affiliation, Date updatetime, String tablet_id, Time start_time, String route_name,
			String registrant, String gateway_id, Time end_time, String dirver_name, Date createtime, String bus_num,
			String bus_name, String bus_id, String createDateFormat, String updateDateFormat, String dateFormat,
			String route_type, String day) {
		super();
		this.time = time;
		this.station_name = station_name;
		this.route_id = route_id;
		this.real_time_id = real_time_id;
		this.driv_log = driv_log;
		this.driv_doc = driv_doc;
		this.date = date;
		this.affiliation = affiliation;
		this.updatetime = updatetime;
		this.tablet_id = tablet_id;
		this.start_time = start_time;
		this.route_name = route_name;
		this.registrant = registrant;
		this.gateway_id = gateway_id;
		this.end_time = end_time;
		this.dirver_name = dirver_name;
		this.createtime = createtime;
		this.bus_num = bus_num;
		this.bus_name = bus_name;
		this.bus_id = bus_id;
		this.createDateFormat = createDateFormat;
		this.updateDateFormat = updateDateFormat;
		this.dateFormat = dateFormat;
		this.route_type = route_type;
		this.day = day;
	}


	public Time getTime() {
		return time;
	}


	public void setTime(Time time) {
		this.time = time;
	}


	public String getStation_name() {
		return station_name;
	}


	public void setStation_name(String station_name) {
		this.station_name = station_name;
	}


	public String getRoute_id() {
		return route_id;
	}


	public void setRoute_id(String route_id) {
		this.route_id = route_id;
	}


	public int getReal_time_id() {
		return real_time_id;
	}


	public void setReal_time_id(int real_time_id) {
		this.real_time_id = real_time_id;
	}


	public int getDriv_log() {
		return driv_log;
	}


	public void setDriv_log(int driv_log) {
		this.driv_log = driv_log;
	}


	public int getDriv_doc() {
		return driv_doc;
	}


	public void setDriv_doc(int driv_doc) {
		this.driv_doc = driv_doc;
	}


	public Date getDate() {
		return date;
	}


	public void setDate(Date date) {
		this.date = date;
	}


	public String getAffiliation() {
		return affiliation;
	}


	public void setAffiliation(String affiliation) {
		this.affiliation = affiliation;
	}


	public Date getUpdatetime() {
		return updatetime;
	}


	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}


	public String getTablet_id() {
		return tablet_id;
	}


	public void setTablet_id(String tablet_id) {
		this.tablet_id = tablet_id;
	}


	public Time getStart_time() {
		return start_time;
	}


	public void setStart_time(Time start_time) {
		this.start_time = start_time;
	}


	public String getRoute_name() {
		return route_name;
	}


	public void setRoute_name(String route_name) {
		this.route_name = route_name;
	}


	public String getRegistrant() {
		return registrant;
	}


	public void setRegistrant(String registrant) {
		this.registrant = registrant;
	}


	public String getGateway_id() {
		return gateway_id;
	}


	public void setGateway_id(String gateway_id) {
		this.gateway_id = gateway_id;
	}


	public Time getEnd_time() {
		return end_time;
	}


	public void setEnd_time(Time end_time) {
		this.end_time = end_time;
	}


	public String getDirver_name() {
		return dirver_name;
	}


	public void setDirver_name(String dirver_name) {
		this.dirver_name = dirver_name;
	}


	public Date getCreatetime() {
		return createtime;
	}


	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}


	public String getBus_num() {
		return bus_num;
	}


	public void setBus_num(String bus_num) {
		this.bus_num = bus_num;
	}


	public String getBus_name() {
		return bus_name;
	}


	public void setBus_name(String bus_name) {
		this.bus_name = bus_name;
	}


	public String getBus_id() {
		return bus_id;
	}


	public void setBus_id(String bus_id) {
		this.bus_id = bus_id;
	}


	public String getCreateDateFormat() {
		return createDateFormat;
	}


	public void setCreateDateFormat(String createDateFormat) {
		this.createDateFormat = createDateFormat;
	}


	public String getUpdateDateFormat() {
		return updateDateFormat;
	}


	public void setUpdateDateFormat(String updateDateFormat) {
		this.updateDateFormat = updateDateFormat;
	}


	public String getDateFormat() {
		return dateFormat;
	}


	public void setDateFormat(String dateFormat) {
		this.dateFormat = dateFormat;
	}


	public String getRoute_type() {
		return route_type;
	}


	public void setRoute_type(String route_type) {
		this.route_type = route_type;
	}


	public String getDay() {
		return day;
	}


	public void setDay(String day) {
		this.day = day;
	}


	public int getDoccount() {
		return doccount;
	}


	public void setDoccount(int doccount) {
		this.doccount = doccount;
	}
	
	
	
}
