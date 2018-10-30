package com.test.rememberTest.Dto;

import java.sql.Date;

public class CenterDto {
	
	private int admin_area;
	private String center_code;
	private String center_name;
	private String center_repn;
	private String center_dirn;
	private String center_type;
	private Date center_dest;
	private Date center_open;
	private String center_adma;
	private String center_phon;
	private String center_web;
	private String center_otim;
	private String center_addr;
	private String center_eval;
	private Date createtime;
	private Date updatetime;
	private String latitude;
	private String longitude;
	private String center_pho;
	
	private String center_addr_si;
	private String center_addr_gu;
	private String center_addr_dong;
	private String center_addr_rem;
	private String openTime;
	private String closeTime;
	
	private String center_num;
	
	public CenterDto(){
		
	}
	
	public CenterDto(int admin_area, String center_code, String center_name, String center_repn, String center_dirn,
			String center_type, Date center_dest, Date center_open, String center_adma, String center_phon,
			String center_web, String center_otim, String center_addr, String center_eval, Date createtime,
			Date updatetime, String latitude, String longitude, String center_pho, String center_addr_si,
			String center_addr_gu, String center_addr_dong, String center_addr_rem, String openTime, String closeTime,
			String center_num) {
		super();
		this.admin_area = admin_area;
		this.center_code = center_code;
		this.center_name = center_name;
		this.center_repn = center_repn;
		this.center_dirn = center_dirn;
		this.center_type = center_type;
		this.center_dest = center_dest;
		this.center_open = center_open;
		this.center_adma = center_adma;
		this.center_phon = center_phon;
		this.center_web = center_web;
		this.center_otim = center_otim;
		this.center_addr = center_addr;
		this.center_eval = center_eval;
		this.createtime = createtime;
		this.updatetime = updatetime;
		this.latitude = latitude;
		this.longitude = longitude;
		this.center_pho = center_pho;
		this.center_addr_si = center_addr_si;
		this.center_addr_gu = center_addr_gu;
		this.center_addr_dong = center_addr_dong;
		this.center_addr_rem = center_addr_rem;
		this.openTime = openTime;
		this.closeTime = closeTime;
		this.center_num = center_num;
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
	public String getCenter_repn() {
		return center_repn;
	}
	public void setCenter_repn(String center_repn) {
		this.center_repn = center_repn;
	}
	public String getCenter_dirn() {
		return center_dirn;
	}
	public void setCenter_dirn(String center_dirn) {
		this.center_dirn = center_dirn;
	}
	public String getCenter_type() {
		return center_type;
	}
	public void setCenter_type(String center_type) {
		this.center_type = center_type;
	}
	public Date getCenter_dest() {
		return center_dest;
	}
	public void setCenter_dest(Date center_dest) {
		this.center_dest = center_dest;
	}
	public Date getCenter_open() {
		return center_open;
	}
	public void setCenter_open(Date center_open) {
		this.center_open = center_open;
	}
	public String getCenter_adma() {
		return center_adma;
	}
	public void setCenter_adma(String center_adma) {
		this.center_adma = center_adma;
	}
	public String getCenter_phon() {
		return center_phon;
	}
	public void setCenter_phon(String center_phon) {
		this.center_phon = center_phon;
	}
	public String getCenter_web() {
		return center_web;
	}
	public void setCenter_web(String center_web) {
		this.center_web = center_web;
	}
	public String getCenter_otim() {
		return center_otim;
	}
	public void setCenter_otim(String center_otim) {
		this.center_otim = center_otim;
	}
	public String getCenter_addr() {
		return center_addr;
	}
	public void setCenter_addr(String center_addr) {
		this.center_addr = center_addr;
	}
	public String getCenter_eval() {
		return center_eval;
	}
	public void setCenter_eval(String center_eval) {
		this.center_eval = center_eval;
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
	public String getCenter_pho() {
		return center_pho;
	}
	public void setCenter_pho(String center_pho) {
		this.center_pho = center_pho;
	}


	public String getCenter_addr_si() {
		return center_addr_si;
	}


	public void setCenter_addr_si(String center_addr_si) {
		this.center_addr_si = center_addr_si;
	}


	public String getCenter_addr_gu() {
		return center_addr_gu;
	}


	public void setCenter_addr_gu(String center_addr_gu) {
		this.center_addr_gu = center_addr_gu;
	}


	public String getCenter_addr_dong() {
		return center_addr_dong;
	}


	public void setCenter_addr_dong(String center_addr_dong) {
		this.center_addr_dong = center_addr_dong;
	}


	public String getCenter_addr_rem() {
		return center_addr_rem;
	}


	public void setCenter_addr_rem(String center_addr_rem) {
		this.center_addr_rem = center_addr_rem;
	}


	public String getOpenTime() {
		return openTime;
	}


	public void setOpenTime(String openTime) {
		this.openTime = openTime;
	}


	public String getCloseTime() {
		return closeTime;
	}


	public void setCloseTime(String closeTime) {
		this.closeTime = closeTime;
	}

	public String getCenter_num() {
		return center_num;
	}

	public void setCenter_num(String center_num) {
		this.center_num = center_num;
	}

	
	
	
}
