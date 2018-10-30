package com.test.rememberTest.Dao.Board_and_kid;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.rememberTest.Dto.Board_and_kidDto;


@Repository
public class Board_and_kidDaoImpl implements Board_and_kidDao{
	private final String NS = "com.test.rememberTest.Map.UserMapper";
	
	 @Autowired  	
	    private SqlSessionTemplate sqlSession;

	@Override
	public void Board_and_kid_insert(Map<String, Object> map) {
		sqlSession.insert(NS+".Board_and_kid_insert", map);		
	}

	@Override
	public void Board_and_kid_delete(Map<String, Object> map) {
		sqlSession.delete(NS+".Board_and_kid_delete", map);		
	}//Board_and_kid_delete 정보 삭제
	
	@Override
	public List<Board_and_kidDto> Board_and_kid_select_routeData(Map<String, Object> map) {
		return sqlSession.selectList(NS+".Board_and_kid_select_routeData", map);
	}//선택된 노선 Board_and_kid_insert 정보 셀렉
	
}
