package com.test.rememberTest.Dto;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

public class Singleton {
	
	private static Singleton singleton;
	private String center_code;
	private String id;
	private String name;
	private String s_email;
	
	
	private Singleton(){}
	//synchronized
	public static Singleton getInstance(){
		if(singleton == null){
			singleton = new Singleton();			
		}		
		return singleton;		
	}

	public String getCenter_code() {
		return center_code;
	}

	public synchronized void setCenter_code(String center_code) {
		this.center_code = center_code;
	}
	public String getId() {
		return id;
	}
	public synchronized void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public synchronized void setName(String name) {
		this.name = name;
	}
	public String getS_email() {
		return s_email;
	}
	public synchronized void setS_email(String s_email) {
		this.s_email = s_email;
	}

	
}
