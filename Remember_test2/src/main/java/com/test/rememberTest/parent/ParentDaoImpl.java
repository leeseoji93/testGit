package com.test.rememberTest.parent;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.rememberTest.Dto.BusRouteDto;
import com.test.rememberTest.Dto.ParentDto;


@Repository
public class ParentDaoImpl implements ParentDao{
	private final String NS = "com.test.rememberTest.Map.UserMapper";
	
	 @Autowired  	
	    private SqlSessionTemplate sqlSession;

	@Override
	public List<ParentDto> getAllParent(Map<String, Object> map) {
		return sqlSession.selectList(NS+".AllParentList", map);
	}

	@Override
	public int updateStater(Map<String, Object> map) {
		return sqlSession.update(NS+".updateStater", map);
	}

	@Override
	public List<ParentDto> getKidsParent(Map<String, Object> map) {
		return sqlSession.selectList(NS+".getKidsParent", map);
	}

	@Override
	public List<ParentDto> getAllParent_sort(Map<String, Object> map) {
		return sqlSession.selectList(NS+".getAllParent_sort", map);
	}

	
	
}
