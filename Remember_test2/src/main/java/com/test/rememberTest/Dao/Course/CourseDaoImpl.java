package com.test.rememberTest.Dao.Course;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.rememberTest.Dto.CourseDto;


@Repository
public class CourseDaoImpl implements CourseDao{
	private final String NS = "com.test.rememberTest.Map.UserMapper";
	
	 @Autowired 
	    private SqlSessionTemplate sqlSession;

	@Override
	public List<CourseDto> Course_selectMaxCourse_id(Map<String, Object> map) {
		return sqlSession.selectList(NS+".Course_selectMaxCourse_id",map);
	}//코스 아이디 MAX 값 찾기

	@Override
	public void Course_insertCourse(Map<String, Object> map) {
		sqlSession.insert(NS+".Course_insertCourse", map);		
	}	//코스 정보 입력

	@Override
	public void Course_UpdateCourse(Map<String, Object> map) {
		sqlSession.update(NS+".Course_UpdateCourse", map);
		
	}//코스 정보 수정

	@Override
	public void CourseDelete(Map<String, Object> map) {
		sqlSession.delete(NS+".CourseDelete", map);
		
	}//코스 정보 삭제

	
}
