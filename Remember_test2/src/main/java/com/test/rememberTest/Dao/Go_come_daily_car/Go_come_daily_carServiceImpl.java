package com.test.rememberTest.Dao.Go_come_daily_car;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.rememberTest.Dto.Go_come_daily_carDto;


@Service
public class Go_come_daily_carServiceImpl implements Go_come_daily_carService{

	 @Autowired
	    private Go_come_daily_carDao go_come_daily_carDao;


	@Override
	public void Go_come_daily_car_insert(Go_come_daily_carDto go_come_daily_carDto) {
        go_come_daily_carDao.Go_come_daily_car_insert(go_come_daily_carDto);
	}//등하원차량일지 이력 insert


	@Override
	public List<Go_come_daily_carDto> Go_come_daily_car_select(String route_id, String go_doc_start,
			String go_doc_end) {	
		Map<String, Object> map = new HashMap<String, Object>();  
		map.put("route_id", route_id);	
        map.put("go_doc_start", go_doc_start);     
        map.put("go_doc_end", go_doc_end);     
		return go_come_daily_carDao.Go_come_daily_car_select(map);
	}//해당 노선, 시작날짜~끝날짜에 해당하는 Go_come_daily_car 값 select

}
