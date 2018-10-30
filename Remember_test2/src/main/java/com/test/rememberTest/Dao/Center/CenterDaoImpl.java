package com.test.rememberTest.Dao.Center;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.rememberTest.Dto.CenterDto;

@Repository
public class CenterDaoImpl implements CenterDao{
	
	private final String NS = "com.test.rememberTest.Map.UserMapper";
	
	@Autowired 
    private SqlSessionTemplate sqlSession;
	
	@Override
	public List<CenterDto> selectCenter_Addr(Map<String, Object> map) {
		System.out.println("111centerDaoImpl에서 selectCenter_Addr시작!!! : "+map);
		return sqlSession.selectList(NS+".selectCenterAddr",map);
	}

	@Override
	public List<CenterDto> Center_selectDataPosition(Map<String, Object> map) {
		return sqlSession.selectList(NS+".Center_selectDataPosition",map);
	}

	@Override
	public void insertCenter(CenterDto centerForm) {
		sqlSession.insert(NS+".insertCenter", centerForm);
	}

	@Override
	public void insertCenterCode(CenterDto centerForm) {
		sqlSession.insert(NS+".insertCenterCode", centerForm);
	}

	@Override
	public List<CenterDto> detailCenter(Map<String, Object> map) {
		return sqlSession.selectList(NS+".detailCenter",map);
	}

	@Override
	public void UpdateCenter(CenterDto centerDto) {
		sqlSession.update(NS+".UpdateCenter", centerDto);
	}

}
