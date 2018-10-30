package com.test.rememberTest.Dao.Course;

import java.util.List;
import java.util.Map;

import com.test.rememberTest.Dto.CourseDto;


public interface CourseDao {
	
	public void Course_insertCourse(Map<String, Object> map);	//코스 정보 입력
	public List<CourseDto> Course_selectMaxCourse_id(Map<String, Object> map);//코스 아이디 MAX 값 찾기
	public void Course_UpdateCourse(Map<String, Object> map);
	public void CourseDelete(Map<String, Object> map);
}
