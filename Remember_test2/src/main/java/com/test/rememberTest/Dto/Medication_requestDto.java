package com.test.rememberTest.Dto;

import java.sql.Blob;
import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

public class Medication_requestDto {
	private int request_id;
	
	private String kid_system_code;
	
	private String center_code;
	
	private String medication_check;
	
	private String uniqueness;
	
	private String keep;
	
	private String dosing_time;
	
	private String medication_date;
	
	private String count;
	
	private String volume;
	
	private String medication_kind;
	
	private String symptom;
	
	private String staff_id;
	
	private String kid_name;
	
	private String class_name;

	private String par_name;
	
	private String staff_name;
	
	private String uniqueness1;
	
	private String center_name;
	
	private String month;
	
	private String sign_url;
	
	public Medication_requestDto() {

	}

	public Medication_requestDto(int request_id, String kid_system_code, String center_code, String medication_check,
			String uniqueness, String keep, String dosing_time, String medication_date, String count, String volume,
			String medication_kind, String symptom, String staff_id, String kid_name, String class_name,
			String par_name, String staff_name, String uniqueness1, String center_name, String month,String sign_url) {
		super();
		this.request_id = request_id;
		this.kid_system_code = kid_system_code;
		this.center_code = center_code;
		this.medication_check = medication_check;
		this.uniqueness = uniqueness;
		this.keep = keep;
		this.dosing_time = dosing_time;
		this.medication_date = medication_date;
		this.count = count;
		this.volume = volume;
		this.medication_kind = medication_kind;
		this.symptom = symptom;
		this.staff_id = staff_id;
		this.kid_name = kid_name;
		this.class_name = class_name;
		this.par_name = par_name;
		this.staff_name = staff_name;
		this.uniqueness1 = uniqueness1;
		this.center_name = center_name;
		this.month = month;
		this.sign_url = sign_url;
	}

	public int getRequest_id() {
		return request_id;
	}

	public void setRequest_id(int request_id) {
		this.request_id = request_id;
	}

	public String getKid_system_code() {
		return kid_system_code;
	}

	public void setKid_system_code(String kid_system_code) {
		this.kid_system_code = kid_system_code;
	}

	public String getCenter_code() {
		return center_code;
	}

	public void setCenter_code(String center_code) {
		this.center_code = center_code;
	}

	public String getMedication_check() {
		return medication_check;
	}

	public void setMedication_check(String medication_check) {
		this.medication_check = medication_check;
	}

	public String getUniqueness() {
		return uniqueness;
	}

	public void setUniqueness(String uniqueness) {
		this.uniqueness = uniqueness;
	}

	public String getKeep() {
		return keep;
	}

	public void setKeep(String keep) {
		this.keep = keep;
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

	public String getCount() {
		return count;
	}

	public void setCount(String count) {
		this.count = count;
	}

	public String getVolume() {
		return volume;
	}

	public void setVolume(String volume) {
		this.volume = volume;
	}

	public String getMedication_kind() {
		return medication_kind;
	}

	public void setMedication_kind(String medication_kind) {
		this.medication_kind = medication_kind;
	}

	public String getSymptom() {
		return symptom;
	}

	public void setSymptom(String symptom) {
		this.symptom = symptom;
	}

	public String getStaff_id() {
		return staff_id;
	}

	public void setStaff_id(String staff_id) {
		this.staff_id = staff_id;
	}

	public String getKid_name() {
		return kid_name;
	}

	public void setKid_name(String kid_name) {
		this.kid_name = kid_name;
	}

	public String getClass_name() {
		return class_name;
	}

	public void setClass_name(String class_name) {
		this.class_name = class_name;
	}

	public String getPar_name() {
		return par_name;
	}

	public void setPar_name(String par_name) {
		this.par_name = par_name;
	}

	public String getStaff_name() {
		return staff_name;
	}

	public void setStaff_name(String staff_name) {
		this.staff_name = staff_name;
	}

	public String getUniqueness1() {
		return uniqueness1;
	}

	public void setUniqueness1(String uniqueness1) {
		this.uniqueness1 = uniqueness1;
	}

	public String getCenter_name() {
		return center_name;
	}

	public void setCenter_name(String center_name) {
		this.center_name = center_name;
	}

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public String getSign_url() {
		return sign_url;
	}

	public void setSign_url(String sign_url) {
		this.sign_url = sign_url;
	}

	
}
