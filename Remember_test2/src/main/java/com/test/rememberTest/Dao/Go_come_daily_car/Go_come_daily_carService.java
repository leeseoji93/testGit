package com.test.rememberTest.Dao.Go_come_daily_car;

import java.util.List;
import java.util.Map;

import com.test.rememberTest.Dto.Go_come_daily_carDto;

public interface Go_come_daily_carService {
	public void Go_come_daily_car_insert(Go_come_daily_carDto go_come_daily_carDto);//등하원차량일지 이력 insert
	
	public List<Go_come_daily_carDto> Go_come_daily_car_select(String route_id, String go_doc_start,String go_doc_end); 
	//해당 노선, 시작날짜~끝날짜에 해당하는 Go_come_daily_car 값 select
}


