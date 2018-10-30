package com.test.rememberTest.Dto;

import java.sql.Date;

public class Center_CodeDto {
	
	private int admin_area;
	private String center_code;
	private String center_name;
	private String affiliation;
	private String registrant;
	private Date createtime;
	private Date updatetime;
	
	public Center_CodeDto(){
		
	}
	
	public Center_CodeDto(int admin_area, String center_code, String center_name, String affiliation, String registrant,
			Date createtime, Date updatetime) {
		super();
		this.admin_area = admin_area;
		this.center_code = center_code;
		this.center_name = center_name;
		this.affiliation = affiliation;
		this.registrant = registrant;
		this.createtime = createtime;
		this.updatetime = updatetime;
	}

	public int getAdmin_area() {
		return admin_area;
	}

	public void setAdmin_area(int admin_area) {
		this.admin_area = admin_area;
	}

	public String getCenter_code() {
		return center_code;
	}

	public void setCenter_code(String center_code) {
		this.center_code = center_code;
	}

	public String getCenter_name() {
		return center_name;
	}

	public void setCenter_name(String center_name) {
		this.center_name = center_name;
	}

	public String getAffiliation() {
		return affiliation;
	}

	public void setAffiliation(String affiliation) {
		this.affiliation = affiliation;
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
