package com.test.rememberTest.Dto;

import java.sql.Date;

public class Car {
	private Date bus_insur;//종합보험 유효기간
	
	private Date createtime;//생성일자
	
	private Date updatetime;//수정 일자
	
	private int bus_borad;//버스 정원
	
	private boolean bus_use;//사용 여부
	
	private String bus_num;//버스 번호
	
	private String staff_id;//버스 기사
	
	private String registrant;//등록자
	
	private String bus_id;//버스 ID
	
	private String center_code;//소속 
	
	private String equipment_tablet_id;//테블릿ID 
	
	private String equipment_gate_id;//게이트ID 
	
	private String bus_name;//버스 이름
	
	private String bus_com;//운행사
	
	private String updateDateFormat;//변환되어 오는 날짜 받기위한 맴버 변수
	
	private String createDateFormat;//변환되어 오는 날짜 받기위한 맴버 변수 
	
	private String insurFormat;//변환되어 종합보험 유효기간 맴버 변수
	
	private String staff_name;//스테프 이름 받기위한 맴버변수(뷰에 뿌리기용)
	
	private String staff_phone;//스테프 폰번호 받기위한 맴버변수(뷰에 뿌리기용)
	
	private String routeExists;//노선 배치 여부 파악
	
	private String maxcount;//등록된 버스 수 파악
	
	private String staff_phot;
	
	private String equipment_tablet_name;//테블릿ID 
	
	private String equipment_gate_name;//게이트ID 
	
	public Car() {}

	public Car(Date bus_insur, Date createtime, Date updatetime, int bus_borad, boolean bus_use, String bus_num,
			String staff_id, String registrant, String bus_id, String center_code, String equipment_tablet_id,
			String equipment_gate_id, String bus_name, String bus_com, String updateDateFormat, String createDateFormat,
			String insurFormat, String staff_name, String staff_phone, String routeExists, String maxcount,
			String staff_phot, String equipment_tablet_name, String equipment_gate_name) {
		super();
		this.bus_insur = bus_insur;
		this.createtime = createtime;
		this.updatetime = updatetime;
		this.bus_borad = bus_borad;
		this.bus_use = bus_use;
		this.bus_num = bus_num;
		this.staff_id = staff_id;
		this.registrant = registrant;
		this.bus_id = bus_id;
		this.center_code = center_code;
		this.equipment_tablet_id = equipment_tablet_id;
		this.equipment_gate_id = equipment_gate_id;
		this.bus_name = bus_name;
		this.bus_com = bus_com;
		this.updateDateFormat = updateDateFormat;
		this.createDateFormat = createDateFormat;
		this.insurFormat = insurFormat;
		this.staff_name = staff_name;
		this.staff_phone = staff_phone;
		this.routeExists = routeExists;
		this.maxcount = maxcount;
		this.staff_phot = staff_phot;
		this.equipment_tablet_name = equipment_tablet_name;
		this.equipment_gate_name = equipment_gate_name;
	}

	public Date getBus_insur() {
		return bus_insur;
	}

	public void setBus_insur(Date bus_insur) {
		this.bus_insur = bus_insur;
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

	public int getBus_borad() {
		return bus_borad;
	}

	public void setBus_borad(int bus_borad) {
		this.bus_borad = bus_borad;
	}

	public boolean isBus_use() {
		return bus_use;
	}

	public void setBus_use(boolean bus_use) {
		this.bus_use = bus_use;
	}

	public String getBus_num() {
		return bus_num;
	}

	public void setBus_num(String bus_num) {
		this.bus_num = bus_num;
	}

	public String getStaff_id() {
		return staff_id;
	}

	public void setStaff_id(String staff_id) {
		this.staff_id = staff_id;
	}

	public String getRegistrant() {
		return registrant;
	}

	public void setRegistrant(String registrant) {
		this.registrant = registrant;
	}

	public String getBus_id() {
		return bus_id;
	}

	public void setBus_id(String bus_id) {
		this.bus_id = bus_id;
	}

	public String getCenter_code() {
		return center_code;
	}

	public void setCenter_code(String center_code) {
		this.center_code = center_code;
	}

	public String getEquipment_tablet_id() {
		return equipment_tablet_id;
	}

	public void setEquipment_tablet_id(String equipment_tablet_id) {
		this.equipment_tablet_id = equipment_tablet_id;
	}

	public String getEquipment_gate_id() {
		return equipment_gate_id;
	}

	public void setEquipment_gate_id(String equipment_gate_id) {
		this.equipment_gate_id = equipment_gate_id;
	}

	public String getBus_name() {
		return bus_name;
	}

	public void setBus_name(String bus_name) {
		this.bus_name = bus_name;
	}

	public String getBus_com() {
		return bus_com;
	}

	public void setBus_com(String bus_com) {
		this.bus_com = bus_com;
	}

	public String getUpdateDateFormat() {
		return updateDateFormat;
	}

	public void setUpdateDateFormat(String updateDateFormat) {
		this.updateDateFormat = updateDateFormat;
	}

	public String getCreateDateFormat() {
		return createDateFormat;
	}

	public void setCreateDateFormat(String createDateFormat) {
		this.createDateFormat = createDateFormat;
	}

	public String getInsurFormat() {
		return insurFormat;
	}

	public void setInsurFormat(String insurFormat) {
		this.insurFormat = insurFormat;
	}

	public String getStaff_name() {
		return staff_name;
	}

	public void setStaff_name(String staff_name) {
		this.staff_name = staff_name;
	}

	public String getStaff_phone() {
		return staff_phone;
	}

	public void setStaff_phone(String staff_phone) {
		this.staff_phone = staff_phone;
	}

	public String getRouteExists() {
		return routeExists;
	}

	public void setRouteExists(String routeExists) {
		this.routeExists = routeExists;
	}

	public String getMaxcount() {
		return maxcount;
	}

	public void setMaxcount(String maxcount) {
		this.maxcount = maxcount;
	}

	public String getStaff_phot() {
		return staff_phot;
	}

	public void setStaff_phot(String staff_phot) {
		this.staff_phot = staff_phot;
	}

	public String getEquipment_tablet_name() {
		return equipment_tablet_name;
	}

	public void setEquipment_tablet_name(String equipment_tablet_name) {
		this.equipment_tablet_name = equipment_tablet_name;
	}

	public String getEquipment_gate_name() {
		return equipment_gate_name;
	}

	public void setEquipment_gate_name(String equipment_gate_name) {
		this.equipment_gate_name = equipment_gate_name;
	}
	
	

}
