package com.test.rememberTest.Dao.Center_Code;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.rememberTest.Dto.Center_CodeDto;



@Repository
public class Center_CodeDaoImpl implements Center_CodeDao{
	private final String NS = "com.test.rememberTest.Map.UserMapper";
	
	 @Autowired  	
	    private SqlSessionTemplate sqlSession;

	@Override
	public List<Center_CodeDto> selectCode(Map<String, Object> map) {
		return sqlSession.selectList(NS+".selectCode",map);
	}

	
}
