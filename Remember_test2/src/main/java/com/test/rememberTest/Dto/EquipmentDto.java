package com.test.rememberTest.Dto;

import java.sql.Date;

public class EquipmentDto {
	private String equipment_id;
	private String equipment_type;
	private String equipment_name;
	private String equipment_com;
	private String equipment_install;
	private String equipment_use;
	private String equipment_stat;
	private Date equipment_install_date;
	private String equipment_install_loc;
	private String equipment_install_man;
	private String center_code;
	private String staff_id;
	private Date createtime;
	private Date updatetime;
	private String install_place;
	private String center_code_1;
	private int admin_area;
	
	private String staff_name;
	private String CREATEDATEFORMAT;
	private String UPDATEDATEFORMAT;
	private String INSTALLDATEFORMAT;
	private String bus_id;
	private String bus_name;
	
	private int beacon_AllCount;
	private int tablet_AllCount;
	private int gateway_AllCount;
	private int beacon_Use_AllCount;
	private int gateway_Use_AllCount;
	private int tablet_Use_AllCount;
	private int damage_gateway_AllCount;
	private int damage_tablet_AllCount;
	private int damage_beacon_AllCount;
	
	
	public EquipmentDto(){}

	public EquipmentDto(String equipment_id, String equipment_type, String equipment_name, String equipment_com,
			String equipment_install, String equipment_use, String equipment_stat, Date equipment_install_date,
			String equipment_install_loc, String equipment_install_man, String center_code, String staff_id,
			Date createtime, Date updatetime, String install_place, String center_code_1, int admin_area,
			String staff_name) {
		super();
		this.equipment_id = equipment_id;
		this.equipment_type = equipment_type;
		this.equipment_name = equipment_name;
		this.equipment_com = equipment_com;
		this.equipment_install = equipment_install;
		this.equipment_use = equipment_use;
		this.equipment_stat = equipment_stat;
		this.equipment_install_date = equipment_install_date;
		this.equipment_install_loc = equipment_install_loc;
		this.equipment_install_man = equipment_install_man;
		this.center_code = center_code;
		this.staff_id = staff_id;
		this.createtime = createtime;
		this.updatetime = updatetime;
		this.install_place = install_place;
		this.center_code_1 = center_code_1;
		this.admin_area = admin_area;
		this.staff_name = staff_name;
	}

	public String getEquipment_id() {
		return equipment_id;
	}

	public void setEquipment_id(String equipment_id) {
		this.equipment_id = equipment_id;
	}

	public String getEquipment_type() {
		return equipment_type;
	}

	public void setEquipment_type(String equipment_type) {
		this.equipment_type = equipment_type;
	}

	public String getEquipment_name() {
		return equipment_name;
	}

	public void setEquipment_name(String equipment_name) {
		this.equipment_name = equipment_name;
	}

	public String getEquipment_com() {
		return equipment_com;
	}

	public void setEquipment_com(String equipment_com) {
		this.equipment_com = equipment_com;
	}

	public String getEquipment_install() {
		return equipment_install;
	}

	public void setEquipment_install(String equipment_install) {
		this.equipment_install = equipment_install;
	}

	public String getEquipment_use() {
		return equipment_use;
	}

	public void setEquipment_use(String equipment_use) {
		this.equipment_use = equipment_use;
	}

	public String getEquipment_stat() {
		return equipment_stat;
	}

	public void setEquipment_stat(String equipment_stat) {
		this.equipment_stat = equipment_stat;
	}

	public Date getEquipment_install_date() {
		return equipment_install_date;
	}

	public void setEquipment_install_date(Date equipment_install_date) {
		this.equipment_install_date = equipment_install_date;
	}

	public String getEquipment_install_loc() {
		return equipment_install_loc;
	}

	public void setEquipment_install_loc(String equipment_install_loc) {
		this.equipment_install_loc = equipment_install_loc;
	}

	public String getEquipment_install_man() {
		return equipment_install_man;
	}

	public void setEquipment_install_man(String equipment_install_man) {
		this.equipment_install_man = equipment_install_man;
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

	public String getInstall_place() {
		return install_place;
	}

	public void setInstall_place(String install_place) {
		this.install_place = install_place;
	}

	public String getCenter_code_1() {
		return center_code_1;
	}

	public void setCenter_code_1(String center_code_1) {
		this.center_code_1 = center_code_1;
	}

	public int getAdmin_area() {
		return admin_area;
	}

	public void setAdmin_area(int admin_area) {
		this.admin_area = admin_area;
	}

	public String getStaff_name() {
		return staff_name;
	}

	public void setStaff_name(String staff_name) {
		this.staff_name = staff_name;
	}

	public String getCREATEDATEFORMAT() {
		return CREATEDATEFORMAT;
	}

	public void setCREATEDATEFORMAT(String cREATEDATEFORMAT) {
		CREATEDATEFORMAT = cREATEDATEFORMAT;
	}

	public String getUPDATEDATEFORMAT() {
		return UPDATEDATEFORMAT;
	}

	public void setUPDATEDATEFORMAT(String uPDATEDATEFORMAT) {
		UPDATEDATEFORMAT = uPDATEDATEFORMAT;
	}

	public String getINSTALLDATEFORMAT() {
		return INSTALLDATEFORMAT;
	}

	public void setINSTALLDATEFORMAT(String iNSTALLDATEFORMAT) {
		INSTALLDATEFORMAT = iNSTALLDATEFORMAT;
	}

	public String getBus_id() {
		return bus_id;
	}

	public void setBus_id(String bus_id) {
		this.bus_id = bus_id;
	}

	public String getBus_name() {
		return bus_name;
	}

	public void setBus_name(String bus_name) {
		this.bus_name = bus_name;
	}

	public int getBeacon_AllCount() {
		return beacon_AllCount;
	}

	public void setBeacon_AllCount(int beacon_AllCount) {
		this.beacon_AllCount = beacon_AllCount;
	}

	public int getTablet_AllCount() {
		return tablet_AllCount;
	}

	public void setTablet_AllCount(int tablet_AllCount) {
		this.tablet_AllCount = tablet_AllCount;
	}

	public int getGateway_AllCount() {
		return gateway_AllCount;
	}

	public void setGateway_AllCount(int gateway_AllCount) {
		this.gateway_AllCount = gateway_AllCount;
	}

	public int getBeacon_Use_AllCount() {
		return beacon_Use_AllCount;
	}

	public void setBeacon_Use_AllCount(int beacon_Use_AllCount) {
		this.beacon_Use_AllCount = beacon_Use_AllCount;
	}

	public int getGateway_Use_AllCount() {
		return gateway_Use_AllCount;
	}

	public void setGateway_Use_AllCount(int gateway_Use_AllCount) {
		this.gateway_Use_AllCount = gateway_Use_AllCount;
	}

	public int getTablet_Use_AllCount() {
		return tablet_Use_AllCount;
	}

	public void setTablet_Use_AllCount(int tablet_Use_AllCount) {
		this.tablet_Use_AllCount = tablet_Use_AllCount;
	}

	public int getDamage_gateway_AllCount() {
		return damage_gateway_AllCount;
	}

	public void setDamage_gateway_AllCount(int damage_gateway_AllCount) {
		this.damage_gateway_AllCount = damage_gateway_AllCount;
	}

	public int getDamage_tablet_AllCount() {
		return damage_tablet_AllCount;
	}

	public void setDamage_tablet_AllCount(int damage_tablet_AllCount) {
		this.damage_tablet_AllCount = damage_tablet_AllCount;
	}

	public int getDamage_beacon_AllCount() {
		return damage_beacon_AllCount;
	}

	public void setDamage_beacon_AllCount(int damage_beacon_AllCount) {
		this.damage_beacon_AllCount = damage_beacon_AllCount;
	}

}
