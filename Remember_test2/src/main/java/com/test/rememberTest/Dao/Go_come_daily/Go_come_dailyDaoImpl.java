package com.test.rememberTest.Dao.Go_come_daily;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.rememberTest.Dto.Go_come_dailyDto;
import com.test.rememberTest.Dto.Go_come_daily_carDto;


@Repository
public class Go_come_dailyDaoImpl implements Go_come_dailyDao{
	private final String NS = "com.test.rememberTest.Map.UserMapper";
	
	 @Autowired 
	    private SqlSessionTemplate sqlSession;

	@Override
	public void Go_come_daily_insert(Go_come_dailyDto go_come_dailyDto) {
		sqlSession.insert(NS + ".Go_come_daily_insert", go_come_dailyDto);
		
	}//등하원 일지 이력 insert

	@Override
	public List<Go_come_dailyDto> Go_come_daily_select(Map<String, Object> map) {
		return sqlSession.selectList(NS + ".Go_come_daily_select", map);
	}//해당 반,시작날짜~끝날짜에 해당하는 Go_come_daily_car 값 select

	@Override
	public List<Go_come_dailyDto> Go_come_daily_selectMonth(Map<String, Object> map) {
		return sqlSession.selectList(NS + ".Go_come_daily_selectMonth", map);
	}//해당 반,달 에 해당하는 Go_come_daily_car 값 select



}
