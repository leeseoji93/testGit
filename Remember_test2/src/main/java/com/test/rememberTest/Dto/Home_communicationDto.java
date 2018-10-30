package com.test.rememberTest.Dto;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

public class Home_communicationDto {
	//communication_tag 관련 맴버
	private int tag_id;
	
	private String tag_name;
	
	//home_communication 관련 맴버
	private String communication_id;
	
	private String center_code;
	
	private String content;
	
	private String title;
	
	private String staff_id;
	
	private String staff_name;
	
	private String create_time;
	
	private String update_time;
	
	private String communication_MaxCount;
	
	private String kid_pho;
	
	//homecommunication_trans 관련
	private String kid_system_code;
	
	private String kid_name;
	
	private String state;
	
	//communication_picture 관련 맴버
	private int communication_picture_id;
	
//	private List<MultipartFile> picture_url;
	
	private String picture_url;
	
	//file_attachement 관련 맴버 
	private int file_attachement_id;
	
	private String file_title;
	
//	private List<MultipartFile> file_url;
	
	private String file_url;

	//class 관련
	private String class_id;

	public Home_communicationDto() {

	}

	public Home_communicationDto(int tag_id, String tag_name, String communication_id, String center_code,
			String content, String title, String staff_id, String staff_name, String create_time, String update_time,
			String communication_MaxCount, String kid_pho, String kid_system_code, String kid_name, String state,
			int communication_picture_id, String picture_url, int file_attachement_id, String file_title,
			String file_url, String class_id) {
		super();
		this.tag_id = tag_id;
		this.tag_name = tag_name;
		this.communication_id = communication_id;
		this.center_code = center_code;
		this.content = content;
		this.title = title;
		this.staff_id = staff_id;
		this.staff_name = staff_name;
		this.create_time = create_time;
		this.update_time = update_time;
		this.communication_MaxCount = communication_MaxCount;
		this.kid_pho = kid_pho;
		this.kid_system_code = kid_system_code;
		this.kid_name = kid_name;
		this.state = state;
		this.communication_picture_id = communication_picture_id;
		this.picture_url = picture_url;
		this.file_attachement_id = file_attachement_id;
		this.file_title = file_title;
		this.file_url = file_url;
		this.class_id = class_id;
	}

	public int getTag_id() {
		return tag_id;
	}

	public void setTag_id(int tag_id) {
		this.tag_id = tag_id;
	}

	public String getTag_name() {
		return tag_name;
	}

	public void setTag_name(String tag_name) {
		this.tag_name = tag_name;
	}

	public String getCommunication_id() {
		return communication_id;
	}

	public void setCommunication_id(String communication_id) {
		this.communication_id = communication_id;
	}

	public String getCenter_code() {
		return center_code;
	}

	public void setCenter_code(String center_code) {
		this.center_code = center_code;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getStaff_id() {
		return staff_id;
	}

	public void setStaff_id(String staff_id) {
		this.staff_id = staff_id;
	}

	public String getStaff_name() {
		return staff_name;
	}

	public void setStaff_name(String staff_name) {
		this.staff_name = staff_name;
	}

	public String getCreate_time() {
		return create_time;
	}

	public void setCreate_time(String create_time) {
		this.create_time = create_time;
	}

	public String getUpdate_time() {
		return update_time;
	}

	public void setUpdate_time(String update_time) {
		this.update_time = update_time;
	}

	public String getCommunication_MaxCount() {
		return communication_MaxCount;
	}

	public void setCommunication_MaxCount(String communication_MaxCount) {
		this.communication_MaxCount = communication_MaxCount;
	}

	public String getKid_pho() {
		return kid_pho;
	}

	public void setKid_pho(String kid_pho) {
		this.kid_pho = kid_pho;
	}

	public String getKid_system_code() {
		return kid_system_code;
	}

	public void setKid_system_code(String kid_system_code) {
		this.kid_system_code = kid_system_code;
	}

	public String getKid_name() {
		return kid_name;
	}

	public void setKid_name(String kid_name) {
		this.kid_name = kid_name;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public int getCommunication_picture_id() {
		return communication_picture_id;
	}

	public void setCommunication_picture_id(int communication_picture_id) {
		this.communication_picture_id = communication_picture_id;
	}

	public String getPicture_url() {
		return picture_url;
	}

	public void setPicture_url(String picture_url) {
		this.picture_url = picture_url;
	}

	public int getFile_attachement_id() {
		return file_attachement_id;
	}

	public void setFile_attachement_id(int file_attachement_id) {
		this.file_attachement_id = file_attachement_id;
	}

	public String getFile_title() {
		return file_title;
	}

	public void setFile_title(String file_title) {
		this.file_title = file_title;
	}

	public String getFile_url() {
		return file_url;
	}

	public void setFile_url(String file_url) {
		this.file_url = file_url;
	}

	public String getClass_id() {
		return class_id;
	}

	public void setClass_id(String class_id) {
		this.class_id = class_id;
	}

	
}
