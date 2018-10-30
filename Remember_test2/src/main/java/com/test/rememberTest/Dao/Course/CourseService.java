package com.test.rememberTest.Dao.Course;

import java.util.List;
import java.util.Map;

import com.test.rememberTest.Dto.CourseDto;


public interface CourseService {
	
	public void Course_insertCourse(String affiliation, String course_id, String course_name, Boolean course_use, String registrant);	//코스 정보 입력
	public List<CourseDto> Course_selectMaxCourse_id(String word);//코스 아이디 MAX 값 찾기
	public void Course_UpdateCourse(String course_id, String course_name, Boolean b);
	public void getCourseDelete(String course_id);



}
