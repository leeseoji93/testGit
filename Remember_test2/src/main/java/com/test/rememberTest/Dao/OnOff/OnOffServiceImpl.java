package com.test.rememberTest.Dao.OnOff;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.rememberTest.Dto.EquipmentDto;
import com.test.rememberTest.Dto.OnOffDto;


@Service
public class OnOffServiceImpl implements OnOffService{

	 @Autowired
	    private OnOffDao onOffDao;


	@Override
	public List<OnOffDto> OnOff_select_onoffData(String firstDate,String route,String route_type,String station
			,String startDate,String endDate,boolean kidsort) {
		Map<String, Object> map = new HashMap<String, Object>(); 
		map.put("firstDate", firstDate);
		map.put("route", route);
		map.put("route_type", route_type);
		map.put("station", station);
        map.put("startDate", startDate);
        map.put("endDate", endDate);
        map.put("kidsort", kidsort);
		return onOffDao.OnOff_select_onoffData(map);
	}//선택한 반 승차/하차 이력


	@Override
	public List<OnOffDto> attendance_history_select_onoffData(String firstDate, String class_id, String startDate,
			String endDate) {
		Map<String, Object> map = new HashMap<String, Object>(); 
		map.put("firstDate", firstDate);
		map.put("class_id", class_id);
		map.put("startDate", startDate);
        map.put("endDate", endDate);
		return onOffDao.attendance_history_select_onoffData(map);
	}//선택한 반 등하원 이력


	@Override
	public List<OnOffDto> attendance_history_select_onoffDataGroup(String firstDate, String class_id, String startDate,
			String endDate) {
		Map<String, Object> map = new HashMap<String, Object>(); 
		map.put("firstDate", firstDate);
		map.put("class_id", class_id);
		map.put("startDate", startDate);
        map.put("endDate", endDate);
		return onOffDao.attendance_history_select_onoffDataGroup(map);
	}


	@Override
	public List<OnOffDto> OnOff_select_onoffDataGroup(String firstDate, String route, String route_type,
			String station, String startDate, String endDate) {
		Map<String, Object> map = new HashMap<String, Object>(); 
		map.put("firstDate", firstDate);
		map.put("route", route);
		map.put("route_type", route_type);
		map.put("station", station);
        map.put("startDate", startDate);
        map.put("endDate", endDate);
		return onOffDao.OnOff_select_onoffDataGroup(map);
	}
}
