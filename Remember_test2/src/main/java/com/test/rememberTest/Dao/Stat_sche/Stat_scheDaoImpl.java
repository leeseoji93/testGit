package com.test.rememberTest.Dao.Stat_sche;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class Stat_scheDaoImpl implements Stat_scheDao{
	private final String NS = "com.test.rememberTest.Map.UserMapper";
	
	 @Autowired 
	    private SqlSessionTemplate sqlSession;

	@Override
	public void Stat_sche_insert(Map<String, Object> map) {
		sqlSession.insert(NS+".Stat_scheDao_insert", map);		
	}//Stat_sche 정보 입력

	@Override
	public void Stat_sche_delete(Map<String, Object> map) {
		sqlSession.delete(NS+".Stat_sche_delete", map);		
	}//Stat_sche 정보 삭제

	
}
