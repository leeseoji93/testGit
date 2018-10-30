package com.test.rememberTest.Dao.Go_come_daily;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.rememberTest.Dto.Go_come_dailyDto;
import com.test.rememberTest.Dto.Go_come_daily_carDto;


@Service
public class Go_come_dailyServiceImpl implements Go_come_dailyService{

	 @Autowired
	    private Go_come_dailyDao go_come_dailyDao;

	@Override
	public void Go_come_daily_insert(Go_come_dailyDto go_come_dailyDto) {
		go_come_dailyDao.Go_come_daily_insert(go_come_dailyDto);		
	}//등하원 일지 이력 insert

	@Override
	public List<Go_come_dailyDto> Go_come_daily_select(String class_id, String doc_start, String doc_end) {
		Map<String, Object> map = new HashMap<String, Object>(); 
		map.put("class_id", class_id);
		map.put("doc_start", doc_start);
		map.put("doc_end", doc_end);
		return go_come_dailyDao.Go_come_daily_select(map);
	}//해당 반,시작날짜~끝날짜에 해당하는 Go_come_daily_car 값 select

	@Override
	public List<Go_come_dailyDto> Go_come_daily_selectMonth(String class_id, String Month) {
		Map<String, Object> map = new HashMap<String, Object>(); 
		map.put("class_id", class_id);
		map.put("Month", Month);
		return go_come_dailyDao.Go_come_daily_selectMonth(map);
	}//해당 반,달 에 해당하는 Go_come_daily_car 값 select



}
