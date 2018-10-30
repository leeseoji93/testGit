package com.test.rememberTest.Dao.Course;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.rememberTest.Dto.CourseDto;


@Service
public class CourseServiceImpl implements CourseService{

	 @Autowired
	    private CourseDao courseDao;

	@Override
	public List<CourseDto> Course_selectMaxCourse_id(String word) {
		Map<String, Object> map = new HashMap<String, Object>();       
        map.put("word", word); 
		return courseDao.Course_selectMaxCourse_id(map);
	}//코스 아이디 MAX 값 찾기

	@Override
	public void Course_insertCourse(String affiliation, String course_id, String course_name, Boolean course_use,
			String registrant) {
		Map<String, Object> map = new HashMap<String, Object>();       
        map.put("affiliation", affiliation);	
        map.put("course_id", course_id);
        map.put("course_name", course_name);
        map.put("course_use", course_use);
        map.put("registrant", registrant);
        courseDao.Course_insertCourse(map);
	}//코스 정보 입력


	@Override
	public void Course_UpdateCourse(String course_id, String course_name, Boolean course_use) {
		Map<String, Object> map = new HashMap<String, Object>();       	
        map.put("course_id", course_id);
        map.put("course_name", course_name);
        map.put("course_use", course_use);
        courseDao.Course_UpdateCourse(map);
		
	}//코스 정보 수정

	@Override
	public void getCourseDelete(String course_id) {
		Map<String, Object> map = new HashMap<String, Object>();       	
        map.put("course_id", course_id);
        courseDao.CourseDelete(map);
	}


		
}
