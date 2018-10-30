package com.test.rememberTest.Dto;

import java.sql.Date;

public class CourseDto {	
	private String affiliation;
	
	private String course_id;
	
	private String registrant;
	
	private Date createtime;
	
	private Date updatetime;
	
	private String course_name;
	
	private boolean course_use;
	
	private String maxcount;//등록된 코스 수 파악

	public CourseDto() {}

	public CourseDto(String affiliation, String course_id, String registrant, Date createtime, Date updatetime,
			String course_name, boolean course_use, String maxcount) {
		super();
		this.affiliation = affiliation;
		this.course_id = course_id;
		this.registrant = registrant;
		this.createtime = createtime;
		this.updatetime = updatetime;
		this.course_name = course_name;
		this.course_use = course_use;
		this.maxcount = maxcount;
	}

	public String getAffiliation() {
		return affiliation;
	}

	public void setAffiliation(String affiliation) {
		this.affiliation = affiliation;
	}

	public String getCourse_id() {
		return course_id;
	}

	public void setCourse_id(String course_id) {
		this.course_id = course_id;
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

	public String getCourse_name() {
		return course_name;
	}

	public void setCourse_name(String course_name) {
		this.course_name = course_name;
	}

	public boolean isCourse_use() {
		return course_use;
	}

	public void setCourse_use(boolean course_use) {
		this.course_use = course_use;
	}

	public String getMaxcount() {
		return maxcount;
	}

	public void setMaxcount(String maxcount) {
		this.maxcount = maxcount;
	}

	
}
