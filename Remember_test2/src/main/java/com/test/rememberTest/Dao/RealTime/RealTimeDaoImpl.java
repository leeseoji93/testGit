package com.test.rememberTest.Dao.RealTime;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.rememberTest.Dto.BusRouteDto;
import com.test.rememberTest.Dto.RealTimeDto;


@Repository
public class RealTimeDaoImpl implements RealTimeDao{
	private final String NS = "com.test.rememberTest.Map.UserMapper";
	
	 @Autowired  	
	    private SqlSessionTemplate sqlSession;

	@Override
	public List<RealTimeDto> selectRealTimeRoute(Map<String, Object> map) {
		return sqlSession.selectList(NS+".selectRealTimeRoute",map);
	}

	@Override
	public List<RealTimeDto> selectRealTimeCar(Map<String, Object> map) {
		System.out.println("selectRealTimeCar에서 : "+map);
		return sqlSession.selectList(NS+".selectRealTimeCar",map);
	}
	 
	
}
