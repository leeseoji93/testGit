package com.test.rememberTest.Dto;

import java.sql.Date;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.Set;
import java.util.SortedSet;
import java.util.TreeSet;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.SpringSecurityCoreVersion;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.util.Assert;

public class ClassDto {
	
	private String class_id;
	private String staff_id_1;
	private String staff_id_2;
	private String class_name;
	private int class_year;
	private String class_sem;
	private String center_code;
	
	private String maxcount;
	private int cnt_kid;
	private String staff_name_1;
	private String staff_name_2;
	
	private int totalKidsCnt;
	public ClassDto(){}
	
	public ClassDto(String class_id, String staff_id_1, String staff_id_2, String class_name, int class_year,
			String class_sem, String center_code) {
		super();
		this.class_id = class_id;
		this.staff_id_1 = staff_id_1;
		this.staff_id_2 = staff_id_2;
		this.class_name = class_name;
		this.class_year = class_year;
		this.class_sem = class_sem;
		this.center_code = center_code;
	}
	public String getClass_id() {
		return class_id;
	}
	public void setClass_id(String class_id) {
		this.class_id = class_id;
	}
	public String getStaff_id_1() {
		return staff_id_1;
	}
	public void setStaff_id_1(String staff_id_1) {
		this.staff_id_1 = staff_id_1;
	}
	public String getStaff_id_2() {
		return staff_id_2;
	}
	public void setStaff_id_2(String staff_id_2) {
		this.staff_id_2 = staff_id_2;
	}
	public String getClass_name() {
		return class_name;
	}
	public void setClass_name(String class_name) {
		this.class_name = class_name;
	}
	public int getClass_year() {
		return class_year;
	}
	public void setClass_year(int class_year) {
		this.class_year = class_year;
	}
	public String getClass_sem() {
		return class_sem;
	}
	public void setClass_sem(String class_sem) {
		this.class_sem = class_sem;
	}
	public String getCenter_code() {
		return center_code;
	}
	public void setCenter_code(String center_code) {
		this.center_code = center_code;
	}

	public String getMaxcount() {
		return maxcount;
	}

	public void setMaxcount(String maxcount) {
		this.maxcount = maxcount;
	}

	public int getCnt_kid() {
		return cnt_kid;
	}

	public void setCnt_kid(int cnt_kid) {
		this.cnt_kid = cnt_kid;
	}

	public String getStaff_name_1() {
		return staff_name_1;
	}

	public void setStaff_name_1(String staff_name_1) {
		this.staff_name_1 = staff_name_1;
	}

	public String getStaff_name_2() {
		return staff_name_2;
	}

	public void setStaff_name_2(String staff_name_2) {
		this.staff_name_2 = staff_name_2;
	}

	public int getTotalKidsCnt() {
		return totalKidsCnt;
	}

	public void setTotalKidsCnt(int totalKidsCnt) {
		this.totalKidsCnt = totalKidsCnt;
	}
	
	
	

}
