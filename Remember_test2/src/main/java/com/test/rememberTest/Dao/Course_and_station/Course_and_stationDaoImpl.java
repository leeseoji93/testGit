package com.test.rememberTest.Dao.Course_and_station;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class Course_and_stationDaoImpl implements Course_and_stationDao{
	private final String NS = "com.test.rememberTest.Map.UserMapper";
	
	 @Autowired  	
	    private SqlSessionTemplate sqlSession;


	 @Override
		public void course_and_station_delete(Map<String, Object> map) {
			sqlSession.delete(NS+".course_and_station_delete", map);
			
		}//course_and_station 정보 삭제


	 @Override
		public void course_and_station_insert(Map<String, Object> map) {
			sqlSession.insert(NS+".course_and_station_insert", map);		
		}//course_and_station_insert 정보 입력

}
