package com.test.rememberTest.Dao.Course_and_station;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class Course_and_stationServiceImpl implements Course_and_stationService{

	 @Autowired
	    private Course_and_stationDao course_and_stationDao;


	@Override
	public void course_and_station_delete(String course_id) {
		Map<String, Object> map = new HashMap<String, Object>();       
        map.put("course_id", course_id);	
        course_and_stationDao.course_and_station_delete(map);		
	}//course_and_station 정보 삭제

	@Override
	public void course_and_station_insert(String course_id,List<String> station_id) {		
		Map<String, Object> map = new HashMap<String, Object>();  
		map.put("station_id", station_id);	
        map.put("course_id", course_id);       
        course_and_stationDao.course_and_station_insert(map);
	}
}
