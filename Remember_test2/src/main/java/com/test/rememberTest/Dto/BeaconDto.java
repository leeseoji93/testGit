package com.test.rememberTest.Dto;

import java.sql.Time;
import java.util.Date;

public class BeaconDto {
	
	private String beacon_id;
	private String beacon_uuid;
	private String kid_system_code;
	private String beacon_com;
	private String beacon_phot;
	private String beacon_use;
	private String beacon_stat;
	private Date createtime;
	private Date updatetime;
	private String center_code;
	private String staff_id;
	private String beacon_mac;
	private int beacon_major;
	private int beacon_minor;
	
	private String staff_name;
	private String kid_name;
	private String kid_pho;
	private String class_year;
	private String class_id;
	
	
	
	public BeaconDto(){}
	
	public BeaconDto(String beacon_id, String beacon_uuid, String kid_system_code, String beacon_com, String beacon_phot,
			String beacon_use, String beacon_stat, Date createtime, Date updatetime, String center_code, String staff_id,
			String beacon_mac, int beacon_major, int beacon_minor) {
		super();
		this.beacon_id = beacon_id;
		this.beacon_uuid = beacon_uuid;
		this.kid_system_code = kid_system_code;
		this.beacon_com = beacon_com;
		this.beacon_phot = beacon_phot;
		this.beacon_use = beacon_use;
		this.beacon_stat = beacon_stat;
		this.createtime = createtime;
		this.updatetime = updatetime;
		this.center_code = center_code;
		this.staff_id = staff_id;
		this.beacon_mac = beacon_mac;
		this.beacon_major = beacon_major;
		this.beacon_minor = beacon_minor;
	}
	public String getBeacon_id() {
		return beacon_id;
	}
	public void setBeacon_id(String beacon_id) {
		this.beacon_id = beacon_id;
	}
	public String getBeacon_uuid() {
		return beacon_uuid;
	}
	public void setBeacon_uuid(String beacon_uuid) {
		this.beacon_uuid = beacon_uuid;
	}
	public String getKid_system_code() {
		return kid_system_code;
	}
	public void setKid_system_code(String kid_system_code) {
		this.kid_system_code = kid_system_code;
	}
	public String getBeacon_com() {
		return beacon_com;
	}
	public void setBeacon_com(String beacon_com) {
		this.beacon_com = beacon_com;
	}
	public String getBeacon_phot() {
		return beacon_phot;
	}
	public void setBeacon_phot(String beacon_phot) {
		this.beacon_phot = beacon_phot;
	}
	public String getBeacon_use() {
		return beacon_use;
	}
	public void setBeacon_use(String beacon_use) {
		this.beacon_use = beacon_use;
	}
	public String getBeacon_stat() {
		return beacon_stat;
	}
	public void setBeacon_stat(String beacon_stat) {
		this.beacon_stat = beacon_stat;
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
	public String getBeacon_mac() {
		return beacon_mac;
	}
	public void setBeacon_mac(String beacon_mac) {
		this.beacon_mac = beacon_mac;
	}
	public int getBeacon_major() {
		return beacon_major;
	}
	public void setBeacon_major(int beacon_major) {
		this.beacon_major = beacon_major;
	}
	public int getBeacon_minor() {
		return beacon_minor;
	}
	public void setBeacon_minor(int beacon_minor) {
		this.beacon_minor = beacon_minor;
	}

	public String getStaff_name() {
		return staff_name;
	}

	public void setStaff_name(String staff_name) {
		this.staff_name = staff_name;
	}

	public String getKid_name() {
		return kid_name;
	}

	public void setKid_name(String kid_name) {
		this.kid_name = kid_name;
	}

	public String getKid_pho() {
		return kid_pho;
	}

	public void setKid_pho(String kid_pho) {
		this.kid_pho = kid_pho;
	}

	public String getClass_year() {
		return class_year;
	}

	public void setClass_year(String class_year) {
		this.class_year = class_year;
	}

	public String getClass_id() {
		return class_id;
	}

	public void setClass_id(String class_id) {
		this.class_id = class_id;
	}
	
	
	
	
}
