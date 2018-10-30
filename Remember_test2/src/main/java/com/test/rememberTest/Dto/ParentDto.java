package com.test.rememberTest.Dto;

import java.sql.Date;

public class ParentDto {
	
	private String center_code;
	private String par_id;
	private String par_name;
	private String par_email;
	private String par_phone;
	private String par_type;
	private String par_memo;
	private String staff_id;
	private String createtime;
	private String updatetime;
	private String par_division;
	
	private String kid_system_code;
	private String check_stater;
	private String kid_name;
	
	private String kid_sex;
	
	public ParentDto(){}
	
	public ParentDto(String center_code, String par_id, String par_name, String par_email, String par_phone,
			String par_type, String par_memo, String staff_id, String createtime, String updatetime,
			String par_division, String kid_system_code, String check_stater) {
		super();
		this.center_code = center_code;
		this.par_id = par_id;
		this.par_name = par_name;
		this.par_email = par_email;
		this.par_phone = par_phone;
		this.par_type = par_type;
		this.par_memo = par_memo;
		this.staff_id = staff_id;
		this.createtime = createtime;
		this.updatetime = updatetime;
		this.par_division = par_division;
		this.kid_system_code = kid_system_code;
		this.check_stater = check_stater;
	}

	public String getCenter_code() {
		return center_code;
	}
	public void setCenter_code(String center_code) {
		this.center_code = center_code;
	}
	public String getPar_id() {
		return par_id;
	}
	public void setPar_id(String par_id) {
		this.par_id = par_id;
	}
	public String getPar_name() {
		return par_name;
	}
	public void setPar_name(String par_name) {
		this.par_name = par_name;
	}
	public String getPar_email() {
		return par_email;
	}
	public void setPar_email(String par_email) {
		this.par_email = par_email;
	}
	public String getPar_phone() {
		return par_phone;
	}
	public void setPar_phone(String par_phone) {
		this.par_phone = par_phone;
	}
	public String getPar_type() {
		return par_type;
	}
	public void setPar_type(String par_type) {
		this.par_type = par_type;
	}
	public String getPar_memo() {
		return par_memo;
	}
	public void setPar_memo(String par_memo) {
		this.par_memo = par_memo;
	}
	public String getStaff_id() {
		return staff_id;
	}
	public void setStaff_id(String staff_id) {
		this.staff_id = staff_id;
	}
	public String getCreatetime() {
		return createtime;
	}
	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}
	public String getUpdatetime() {
		return updatetime;
	}
	public void setUpdatetime(String updatetime) {
		this.updatetime = updatetime;
	}
	public String getPar_division() {
		return par_division;
	}
	public void setPar_division(String par_division) {
		this.par_division = par_division;
	}
	public String getKid_system_code() {
		return kid_system_code;
	}
	public void setKid_system_code(String kid_system_code) {
		this.kid_system_code = kid_system_code;
	}
	public String getCheck_stater() {
		return check_stater;
	}
	public void setCheck_stater(String check_stater) {
		this.check_stater = check_stater;
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
	
	
  	

	
}
