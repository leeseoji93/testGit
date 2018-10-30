package com.test.rememberTest.Dao.Go_come_daily;

import java.util.List;
import java.util.Map;

import com.test.rememberTest.Dto.Go_come_dailyDto;
import com.test.rememberTest.Dto.Go_come_daily_carDto;

public interface Go_come_dailyService {

	public void Go_come_daily_insert(Go_come_dailyDto go_come_dailyDto);//등하원 일지 이력 insert
	
	public List<Go_come_dailyDto> Go_come_daily_select(String class_id, String doc_start,String doc_end);//해당 반,시작날짜~끝날짜에 해당하는 Go_come_daily_car 값 select

	public List<Go_come_dailyDto> Go_come_daily_selectMonth(String class_id, String Month); //해당 반,달 에 해당하는 Go_come_daily_car 값 select
}


