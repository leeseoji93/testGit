package com.test.rememberTest.Dto;

public class Course_and_stationDto {
	private String station_id;
	
	private String course_id;	
	
	private int order;
	
	public Course_and_stationDto() {}

	public Course_and_stationDto(String station_id, String course_id, int order) {
		super();
		this.station_id = station_id;
		this.course_id = course_id;
		this.order = order;
	}

	public String getStation_id() {
		return station_id;
	}

	public void setStation_id(String station_id) {
		this.station_id = station_id;
	}

	public String getCourse_id() {
		return course_id;
	}

	public void setCourse_id(String course_id) {
		this.course_id = course_id;
	}

	public int getOrder() {
		return order;
	}

	public void setOrder(int order) {
		this.order = order;
	}
	
	

}
