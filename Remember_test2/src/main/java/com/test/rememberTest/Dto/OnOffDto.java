package com.test.rememberTest.Dto;

import java.sql.Date;

public class OnOffDto {
	private String center_code;
	
	private String station_id;
	
	private String route_id;
	
	private String beacon_id;
	
	private String kid_name;
	
	private String station_name;
	
	private String par_id;
	
	private String par_name;
	
	private String par_phone;
	
	private String kid_system_code;
	
	private String today;
	
	private String on_time;
	
	private String route_id_on;
	
	private String station_id_on;
	
	private String off_time;
	
	private String route_id_off;
	
	private String station_id_off;
	
	private String equipment_id;
	
	private String kid_pho;
	
	private String on_station_id;
	
	private String on_station_name;
	
	private String off_station_id;
	
	private String off_station_name;
	
	private String on_route_id;
	
	private String on_route_name;
	
	private String off_route_id;
	
	private String off_route_name;
	
	private String late_date;
	
	private String affiliation;
	
	private String late_abse_type;
	
	private String late_abse_degree;
	
	private String late_abse_cont;
	
	private boolean late_abse_check;
	
	private String route_type;
	
	private String on_type;
	
	private String off_type;
	
	private String route_name;
	
	public OnOffDto() {}

	public OnOffDto(String center_code, String station_id, String route_id, String beacon_id, String kid_name,
			String station_name, String par_id, String par_name, String par_phone, String kid_system_code, String today,
			String on_time, String route_id_on, String station_id_on, String off_time, String route_id_off,
			String station_id_off, String equipment_id, String kid_pho, String on_station_id, String on_station_name,
			String off_station_id, String off_station_name, String on_route_id, String on_route_name,
			String off_route_id, String off_route_name, String late_date, String affiliation, String late_abse_type,
			String late_abse_degree, String late_abse_cont, boolean late_abse_check, String route_type, String on_type,
			String off_type, String route_name) {
		super();
		this.center_code = center_code;
		this.station_id = station_id;
		this.route_id = route_id;
		this.beacon_id = beacon_id;
		this.kid_name = kid_name;
		this.station_name = station_name;
		this.par_id = par_id;
		this.par_name = par_name;
		this.par_phone = par_phone;
		this.kid_system_code = kid_system_code;
		this.today = today;
		this.on_time = on_time;
		this.route_id_on = route_id_on;
		this.station_id_on = station_id_on;
		this.off_time = off_time;
		this.route_id_off = route_id_off;
		this.station_id_off = station_id_off;
		this.equipment_id = equipment_id;
		this.kid_pho = kid_pho;
		this.on_station_id = on_station_id;
		this.on_station_name = on_station_name;
		this.off_station_id = off_station_id;
		this.off_station_name = off_station_name;
		this.on_route_id = on_route_id;
		this.on_route_name = on_route_name;
		this.off_route_id = off_route_id;
		this.off_route_name = off_route_name;
		this.late_date = late_date;
		this.affiliation = affiliation;
		this.late_abse_type = late_abse_type;
		this.late_abse_degree = late_abse_degree;
		this.late_abse_cont = late_abse_cont;
		this.late_abse_check = late_abse_check;
		this.route_type = route_type;
		this.on_type = on_type;
		this.off_type = off_type;
		this.route_name = route_name;
	}

	public String getCenter_code() {
		return center_code;
	}

	public void setCenter_code(String center_code) {
		this.center_code = center_code;
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

	public String getBeacon_id() {
		return beacon_id;
	}

	public void setBeacon_id(String beacon_id) {
		this.beacon_id = beacon_id;
	}

	public String getKid_name() {
		return kid_name;
	}

	public void setKid_name(String kid_name) {
		this.kid_name = kid_name;
	}

	public String getStation_name() {
		return station_name;
	}

	public void setStation_name(String station_name) {
		this.station_name = station_name;
	}

	public String getPar_id() {
		return par_id;
	}

	public void setPar_id(String par_id) {
		this.par_id = par_id;
	}

	public String getPar_name() {
		return par_name;
	}

	public void setPar_name(String par_name) {
		this.par_name = par_name;
	}

	public String getPar_phone() {
		return par_phone;
	}

	public void setPar_phone(String par_phone) {
		this.par_phone = par_phone;
	}

	public String getKid_system_code() {
		return kid_system_code;
	}

	public void setKid_system_code(String kid_system_code) {
		this.kid_system_code = kid_system_code;
	}

	public String getToday() {
		return today;
	}

	public void setToday(String today) {
		this.today = today;
	}

	public String getOn_time() {
		return on_time;
	}

	public void setOn_time(String on_time) {
		this.on_time = on_time;
	}

	public String getRoute_id_on() {
		return route_id_on;
	}

	public void setRoute_id_on(String route_id_on) {
		this.route_id_on = route_id_on;
	}

	public String getStation_id_on() {
		return station_id_on;
	}

	public void setStation_id_on(String station_id_on) {
		this.station_id_on = station_id_on;
	}

	public String getOff_time() {
		return off_time;
	}

	public void setOff_time(String off_time) {
		this.off_time = off_time;
	}

	public String getRoute_id_off() {
		return route_id_off;
	}

	public void setRoute_id_off(String route_id_off) {
		this.route_id_off = route_id_off;
	}

	public String getStation_id_off() {
		return station_id_off;
	}

	public void setStation_id_off(String station_id_off) {
		this.station_id_off = station_id_off;
	}

	public String getEquipment_id() {
		return equipment_id;
	}

	public void setEquipment_id(String equipment_id) {
		this.equipment_id = equipment_id;
	}

	public String getKid_pho() {
		return kid_pho;
	}

	public void setKid_pho(String kid_pho) {
		this.kid_pho = kid_pho;
	}

	public String getOn_station_id() {
		return on_station_id;
	}

	public void setOn_station_id(String on_station_id) {
		this.on_station_id = on_station_id;
	}

	public String getOn_station_name() {
		return on_station_name;
	}

	public void setOn_station_name(String on_station_name) {
		this.on_station_name = on_station_name;
	}

	public String getOff_station_id() {
		return off_station_id;
	}

	public void setOff_station_id(String off_station_id) {
		this.off_station_id = off_station_id;
	}

	public String getOff_station_name() {
		return off_station_name;
	}

	public void setOff_station_name(String off_station_name) {
		this.off_station_name = off_station_name;
	}

	public String getOn_route_id() {
		return on_route_id;
	}

	public void setOn_route_id(String on_route_id) {
		this.on_route_id = on_route_id;
	}

	public String getOn_route_name() {
		return on_route_name;
	}

	public void setOn_route_name(String on_route_name) {
		this.on_route_name = on_route_name;
	}

	public String getOff_route_id() {
		return off_route_id;
	}

	public void setOff_route_id(String off_route_id) {
		this.off_route_id = off_route_id;
	}

	public String getOff_route_name() {
		return off_route_name;
	}

	public void setOff_route_name(String off_route_name) {
		this.off_route_name = off_route_name;
	}

	public String getLate_date() {
		return late_date;
	}

	public void setLate_date(String late_date) {
		this.late_date = late_date;
	}

	public String getAffiliation() {
		return affiliation;
	}

	public void setAffiliation(String affiliation) {
		this.affiliation = affiliation;
	}

	public String getLate_abse_type() {
		return late_abse_type;
	}

	public void setLate_abse_type(String late_abse_type) {
		this.late_abse_type = late_abse_type;
	}

	public String getLate_abse_degree() {
		return late_abse_degree;
	}

	public void setLate_abse_degree(String late_abse_degree) {
		this.late_abse_degree = late_abse_degree;
	}

	public String getLate_abse_cont() {
		return late_abse_cont;
	}

	public void setLate_abse_cont(String late_abse_cont) {
		this.late_abse_cont = late_abse_cont;
	}

	public boolean isLate_abse_check() {
		return late_abse_check;
	}

	public void setLate_abse_check(boolean late_abse_check) {
		this.late_abse_check = late_abse_check;
	}

	public String getRoute_type() {
		return route_type;
	}

	public void setRoute_type(String route_type) {
		this.route_type = route_type;
	}

	public String getOn_type() {
		return on_type;
	}

	public void setOn_type(String on_type) {
		this.on_type = on_type;
	}

	public String getOff_type() {
		return off_type;
	}

	public void setOff_type(String off_type) {
		this.off_type = off_type;
	}

	public String getRoute_name() {
		return route_name;
	}

	public void setRoute_name(String route_name) {
		this.route_name = route_name;
	}

	
}
