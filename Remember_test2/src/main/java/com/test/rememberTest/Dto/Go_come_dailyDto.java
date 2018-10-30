package com.test.rememberTest.Dto;

import java.sql.Date;

public class Go_come_dailyDto {
	//Go_come_daily_car 관련
	private int doc_id;
	
	private String class_id;
	
	private String center_code;
	
	private String staff_id;
	
	private String doc_year;
	
	private String doc_mon;
	
	private String doc_start;
	
	private String doc_end;
	
	private String class_name;
	
	private String kid_system_code;
	
	private String kid_name;
	
	private String today;
	
	private String on_type;

	public Go_come_dailyDto() {
	}

	public Go_come_dailyDto(int doc_id, String class_id, String center_code, String staff_id, String doc_year,
			String doc_mon, String doc_start, String doc_end, String class_name, String kid_system_code,
			String kid_name, String today, String on_type) {
		super();
		this.doc_id = doc_id;
		this.class_id = class_id;
		this.center_code = center_code;
		this.staff_id = staff_id;
		this.doc_year = doc_year;
		this.doc_mon = doc_mon;
		this.doc_start = doc_start;
		this.doc_end = doc_end;
		this.class_name = class_name;
		this.kid_system_code = kid_system_code;
		this.kid_name = kid_name;
		this.today = today;
		this.on_type = on_type;
	}

	public int getDoc_id() {
		return doc_id;
	}

	public void setDoc_id(int doc_id) {
		this.doc_id = doc_id;
	}

	public String getClass_id() {
		return class_id;
	}

	public void setClass_id(String class_id) {
		this.class_id = class_id;
	}

	public String getCenter_code() {
		return center_code;
	}

	public void setCenter_code(String center_code) {
		this.center_code = center_code;
	}

	public String getStaff_id() {
		return staff_id;
	}

	public void setStaff_id(String staff_id) {
		this.staff_id = staff_id;
	}

	public String getDoc_year() {
		return doc_year;
	}

	public void setDoc_year(String doc_year) {
		this.doc_year = doc_year;
	}

	public String getDoc_mon() {
		return doc_mon;
	}

	public void setDoc_mon(String doc_mon) {
		this.doc_mon = doc_mon;
	}

	public String getDoc_start() {
		return doc_start;
	}

	public void setDoc_start(String doc_start) {
		this.doc_start = doc_start;
	}

	public String getDoc_end() {
		return doc_end;
	}

	public void setDoc_end(String doc_end) {
		this.doc_end = doc_end;
	}

	public String getClass_name() {
		return class_name;
	}

	public void setClass_name(String class_name) {
		this.class_name = class_name;
	}

	public String getKid_system_code() {
		return kid_system_code;
	}

	public void setKid_system_code(String kid_system_code) {
		this.kid_system_code = kid_system_code;
	}

	public String getKid_name() {
		return kid_name;
	}

	public void setKid_name(String kid_name) {
		this.kid_name = kid_name;
	}

	public String getToday() {
		return today;
	}

	public void setToday(String today) {
		this.today = today;
	}

	public String getOn_type() {
		return on_type;
	}

	public void setOn_type(String on_type) {
		this.on_type = on_type;
	}


}
