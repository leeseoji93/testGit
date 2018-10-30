package com.test.rememberTest.Dto;

import java.sql.Date;

public class Damege_goodsDto {
	
	private String beacon_id;
	private String center_code;
	private Date createtime;
	private int damege_charge;
	private int damege_id;
	private StringBuffer damege_manage;
	private String damege_photo;
	private String damege_reason;
	private String damege_type;
	private String equipment_id;
	private String staff_id;
	private Date updatetime;
	
	private String staff_email;
	private String staff_name;
	
	private String subject;
	private String content;
	private String receiver;
	private String regdate;
	
	private String equipment_com;
	private String equipment_type;
	
	public Damege_goodsDto(){}
	
	

	public Damege_goodsDto(String beacon_id, String center_code, Date createtime, int damege_charge, int damege_id,
			StringBuffer damege_manage, String damege_photo, String damege_reason, String damege_type,
			String equipment_id, String staff_id, Date updatetime, String staff_email, String staff_name,
			String subject, String content, String receiver, String regdate, String equipment_com) {
		super();
		this.beacon_id = beacon_id;
		this.center_code = center_code;
		this.createtime = createtime;
		this.damege_charge = damege_charge;
		this.damege_id = damege_id;
		this.damege_manage = damege_manage;
		this.damege_photo = damege_photo;
		this.damege_reason = damege_reason;
		this.damege_type = damege_type;
		this.equipment_id = equipment_id;
		this.staff_id = staff_id;
		this.updatetime = updatetime;
		this.staff_email = staff_email;
		this.staff_name = staff_name;
		this.subject = subject;
		this.content = content;
		this.receiver = receiver;
		this.regdate = regdate;
		this.equipment_com = equipment_com;
	}



	public String getBeacon_id() {
		return beacon_id;
	}

	public void setBeacon_id(String beacon_id) {
		this.beacon_id = beacon_id;
	}

	public String getCenter_code() {
		return center_code;
	}

	public void setCenter_code(String center_code) {
		this.center_code = center_code;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public int getDamege_charge() {
		return damege_charge;
	}

	public void setDamege_charge(int damege_charge) {
		this.damege_charge = damege_charge;
	}

	public int getDamege_id() {
		return damege_id;
	}

	public void setDamege_id(int damege_id) {
		this.damege_id = damege_id;
	}

	public StringBuffer getDamege_manage() {
		return damege_manage;
	}

	public void setDamege_manage(StringBuffer damege_manage) {
		this.damege_manage = damege_manage;
	}

	public String getDamege_photo() {
		return damege_photo;
	}

	public void setDamege_photo(String damege_photo) {
		this.damege_photo = damege_photo;
	}

	public String getdamege_reason() {
		return damege_reason;
	}

	public void setdamege_reason(String damege_reason) {
		this.damege_reason = damege_reason;
	}

	public String getDamege_type() {
		return damege_type;
	}

	public void setDamege_type(String damege_type) {
		this.damege_type = damege_type;
	}

	public String getEquipment_id() {
		return equipment_id;
	}

	public void setEquipment_id(String equipment_id) {
		this.equipment_id = equipment_id;
	}

	public String getStaff_id() {
		return staff_id;
	}

	public void setStaff_id(String staff_id) {
		this.staff_id = staff_id;
	}

	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public String getStaff_email() {
		return staff_email;
	}

	public void setStaff_email(String staff_email) {
		this.staff_email = staff_email;
	}

	public String getStaff_name() {
		return staff_name;
	}

	public void setStaff_name(String staff_name) {
		this.staff_name = staff_name;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getReceiver() {
		return receiver;
	}

	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getEquipment_com() {
		return equipment_com;
	}

	public void setEquipment_com(String equipment_com) {
		this.equipment_com = equipment_com;
	}



	public String getEquipment_type() {
		return equipment_type;
	}



	public void setEquipment_type(String equipment_type) {
		this.equipment_type = equipment_type;
	}
	
	
	
	
	
}
