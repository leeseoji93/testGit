package com.test.rememberTest.Dao.Go_come_daily_car;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.rememberTest.Dto.Go_come_daily_carDto;


@Repository
public class Go_come_daily_carDaoImpl implements Go_come_daily_carDao{
	private final String NS = "com.test.rememberTest.Map.UserMapper";
	
	 @Autowired 
	    private SqlSessionTemplate sqlSession;

	@Override
	public void Go_come_daily_car_insert(Go_come_daily_carDto go_come_daily_carDto) {
		sqlSession.insert(NS + ".Go_come_daily_car_insert", go_come_daily_carDto);
		
	}//등하원차량일지 이력 insert

	@Override
	public List<Go_come_daily_carDto> Go_come_daily_car_select(Map<String, Object> map) {
		return sqlSession.selectList(NS + ".Go_come_daily_car_select", map);
	}//해당 노선, 시작날짜~끝날짜에 해당하는 Go_come_daily_car 값 select
	
}
