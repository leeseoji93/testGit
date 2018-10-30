package com.test.rememberTest.Dto;

import java.sql.Date;

public class KidDto {
private String kid_system_code;
	
	private String staff_id;
	
	private String center_code;
	
	private String class_id;
	
	private String kid_name;
	
	private String kid_sex;
	
	private String kid_enter;
	
	private String kid_retire_r;
	
	private String kid_blood;
	
	private String kid_addr;
	
	private String latitude;
	
	private String longitude;
	private String kid_pho;
	
	private String kid_birthday;
  	private String class_name;
  	private String kid_addr_rem;
  	private String maxcount;
  	private String par_name;
  	
  	private String kid_pho_temp;
  	
  	private int beaconCnt;
  	private int matchingKidsCnt;
  	private int totalBeaconCnt;
  	private int totalKidsCnt;
  	
  	private String par_id;
  	
  	private String fcm_token;
  	private String bloodRh;
  	
  	private String routeOnExists;
  	private String routeOffExists;
  	
	
	//private String class_id; 나중에 여기 사진이 들어간다??
	
	public String getBloodRh() {
		return bloodRh;
	}


	public void setBloodRh(String bloodRh) {
		this.bloodRh = bloodRh;
	}


	public KidDto() {}
	
	
	public KidDto(String kid_system_code, String staff_id, String center_code, String class_id, String kid_name,
			String kid_sex, String kid_enter, String kid_retire_r, String kid_blood, String kid_addr, String latitude,
			String longitude) {
		super();
		this.kid_system_code = kid_system_code;
		this.staff_id = staff_id;
		this.center_code = center_code;
		this.class_id = class_id;
		this.kid_name = kid_name;
		this.kid_sex = kid_sex;
		this.kid_enter = kid_enter;
		this.kid_retire_r = kid_retire_r;
		this.kid_blood = kid_blood;
		this.kid_addr = kid_addr;
		this.latitude = latitude;
		this.longitude = longitude;
	}

	public String getKid_system_code() {
		return kid_system_code;
	}

	public void setKid_system_code(String kid_system_code) {
		this.kid_system_code = kid_system_code;
	}

	public String getStaff_id() {
		return staff_id;
	}

	public void setStaff_id(String staff_id) {
		this.staff_id = staff_id;
	}

	public String getCenter_code() {
		return center_code;
	}

	public void setCenter_code(String center_code) {
		this.center_code = center_code;
	}

	public String getClass_id() {
		return class_id;
	}

	public void setClass_id(String class_id) {
		this.class_id = class_id;
	}

	public String getKid_name() {
		return kid_name;
	}

	public void setKid_name(String kid_name) {
		this.kid_name = kid_name;
	}

	public String getKid_sex() {
		return kid_sex;
	}

	public void setKid_sex(String kid_sex) {
		this.kid_sex = kid_sex;
	}

	public String getKid_enter() {
		return kid_enter;
	}

	public void setKid_enter(String kid_enter) {
		this.kid_enter = kid_enter;
	}

	public String getkid_retire_r() {
		return kid_retire_r;
	}

	public void setkid_retire_r(String kid_retire_r) {
		this.kid_retire_r = kid_retire_r;
	}

	public String getKid_blood() {
		return kid_blood;
	}

	public void setKid_blood(String kid_blood) {
		this.kid_blood = kid_blood;
	}

	public String getKid_addr() {
		return kid_addr;
	}

	public void setKid_addr(String kid_addr) {
		this.kid_addr = kid_addr;
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


	public String getKid_birthday() {
		return kid_birthday;
	}


	public void setKid_birthday(String kid_birthday) {
		this.kid_birthday = kid_birthday;
	}


	public String getClass_name() {
		return class_name;
	}


	public void setClass_name(String class_name) {
		this.class_name = class_name;
	}


	public String getKid_addr_rem() {
		return kid_addr_rem;
	}


	public void setKid_addr_rem(String kid_addr_rem) {
		this.kid_addr_rem = kid_addr_rem;
	}


	public String getMaxcount() {
		return maxcount;
	}


	public void setMaxcount(String maxcount) {
		this.maxcount = maxcount;
	}


	public String getPar_name() {
		return par_name;
	}


	public void setPar_name(String par_name) {
		this.par_name = par_name;
	}


	public String getKid_pho() {
		return kid_pho;
	}


	public void setKid_pho(String kid_pho) {
		this.kid_pho = kid_pho;
	}


	public String getKid_pho_temp() {
		return kid_pho_temp;
	}


	public void setKid_pho_temp(String kid_pho_temp) {
		this.kid_pho_temp = kid_pho_temp;
	}


	public int getBeaconCnt() {
		return beaconCnt;
	}


	public void setBeaconCnt(int beaconCnt) {
		this.beaconCnt = beaconCnt;
	}


	public int getMatchingKidsCnt() {
		return matchingKidsCnt;
	}


	public void setMatchingKidsCnt(int matchingKidsCnt) {
		this.matchingKidsCnt = matchingKidsCnt;
	}


	public int getTotalBeaconCnt() {
		return totalBeaconCnt;
	}


	public void setTotalBeaconCnt(int totalBeaconCnt) {
		this.totalBeaconCnt = totalBeaconCnt;
	}


	public int getTotalKidsCnt() {
		return totalKidsCnt;
	}


	public void setTotalKidsCnt(int totalKidsCnt) {
		this.totalKidsCnt = totalKidsCnt;
	}


	public String getPar_id() {
		return par_id;
	}


	public void setPar_id(String par_id) {
		this.par_id = par_id;
	}


	public String getFcm_token() {
		return fcm_token;
	}


	public void setFcm_token(String fcm_token) {
		this.fcm_token = fcm_token;
	}


	public String getRouteOnExists() {
		return routeOnExists;
	}


	public void setRouteOnExists(String routeOnExists) {
		this.routeOnExists = routeOnExists;
	}


	public String getRouteOffExists() {
		return routeOffExists;
	}


	public void setRouteOffExists(String routeOffExists) {
		this.routeOffExists = routeOffExists;
	}
	
}
