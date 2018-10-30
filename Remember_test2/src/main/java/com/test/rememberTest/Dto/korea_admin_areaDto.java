package com.test.rememberTest.Dto;

public class korea_admin_areaDto {
	
	private int city_code;
	private String city_name;
	private int district_code;
	private String district_name;
	private int township_code;
	private String township_name;
	
	
	public korea_admin_areaDto(){}
	
	public korea_admin_areaDto(int city_code, String city_name, int district_code, String district_name,
			int township_code, String township_name) {
		super();
		this.city_code = city_code;
		this.city_name = city_name;
		this.district_code = district_code;
		this.district_name = district_name;
		this.township_code = township_code;
		this.township_name = township_name;
	}
	public int getCity_code() {
		return city_code;
	}
	public void setCity_code(int city_code) {
		this.city_code = city_code;
	}
	public String getCity_name() {
		return city_name;
	}
	public void setCity_name(String city_name) {
		this.city_name = city_name;
	}
	public int getDistrict_code() {
		return district_code;
	}
	public void setDistrict_code(int district_code) {
		this.district_code = district_code;
	}
	public String getDistrict_name() {
		return district_name;
	}
	public void setDistrict_name(String district_name) {
		this.district_name = district_name;
	}
	public int getTownship_code() {
		return township_code;
	}
	public void setTownship_code(int township_code) {
		this.township_code = township_code;
	}
	public String getTownship_name() {
		return township_name;
	}
	public void setTownship_name(String township_name) {
		this.township_name = township_name;
	}
	
	
}
