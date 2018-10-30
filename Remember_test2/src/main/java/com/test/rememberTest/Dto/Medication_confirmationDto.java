package com.test.rememberTest.Dto;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

public class Medication_confirmationDto {
	private int request_id;
	
	private int confirmation_id;
	
	private String center_code;
	
	private String confirmation_check;
	
	private String uniqueness;
	
	private String staff_id;
	
	private String dosing_time;
	
	private String medication_date;
	
	private String volume;
	
	private String staff_name;
	
	private String count;
	
	private String center_name;
	
	private String sing_url;
	
	public Medication_confirmationDto() {

	}

	public Medication_confirmationDto(int request_id, int confirmation_id, String center_code,
			String confirmation_check, String uniqueness, String staff_id, String dosing_time, String medication_date,
			String volume, String staff_name, String count, String center_name, String sing_url) {
		super();
		this.request_id = request_id;
		this.confirmation_id = confirmation_id;
		this.center_code = center_code;
		this.confirmation_check = confirmation_check;
		this.uniqueness = uniqueness;
		this.staff_id = staff_id;
		this.dosing_time = dosing_time;
		this.medication_date = medication_date;
		this.volume = volume;
		this.staff_name = staff_name;
		this.count = count;
		this.center_name = center_name;
		this.sing_url = sing_url;
	}

	public int getRequest_id() {
		return request_id;
	}

	public void setRequest_id(int request_id) {
		this.request_id = request_id;
	}

	public int getConfirmation_id() {
		return confirmation_id;
	}

	public void setConfirmation_id(int confirmation_id) {
		this.confirmation_id = confirmation_id;
	}

	public String getCenter_code() {
		return center_code;
	}

	public void setCenter_code(String center_code) {
		this.center_code = center_code;
	}

	public String getConfirmation_check() {
		return confirmation_check;
	}

	public void setConfirmation_check(String confirmation_check) {
		this.confirmation_check = confirmation_check;
	}

	public String getUniqueness() {
		return uniqueness;
	}

	public void setUniqueness(String uniqueness) {
		this.uniqueness = uniqueness;
	}

	public String getStaff_id() {
		return staff_id;
	}

	public void setStaff_id(String staff_id) {
		this.staff_id = staff_id;
	}

	public String getDosing_time() {
		return dosing_time;
	}

	public void setDosing_time(String dosing_time) {
		this.dosing_time = dosing_time;
	}

	public String getMedication_date() {
		return medication_date;
	}

	public void setMedication_date(String medication_date) {
		this.medication_date = medication_date;
	}

	public String getVolume() {
		return volume;
	}

	public void setVolume(String volume) {
		this.volume = volume;
	}

	public String getStaff_name() {
		return staff_name;
	}

	public void setStaff_name(String staff_name) {
		this.staff_name = staff_name;
	}

	public String getCount() {
		return count;
	}

	public void setCount(String count) {
		this.count = count;
	}

	public String getCenter_name() {
		return center_name;
	}

	public void setCenter_name(String center_name) {
		this.center_name = center_name;
	}

	public String getSing_url() {
		return sing_url;
	}

	public void setSing_url(String sing_url) {
		this.sing_url = sing_url;
	}

	
	
}
