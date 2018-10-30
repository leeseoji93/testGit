package com.test.rememberTest.Dao.OnOff;

import java.util.List;
import java.util.Map;

import com.test.rememberTest.Dto.OnOffDto;

public interface OnOffService {	
	public List<OnOffDto> OnOff_select_onoffData(String firstDate,String route,String route_type
			,String station,String startDate,String endDate,boolean kidsort);//선택한 반 승차/하차 이력
	
	public List<OnOffDto> OnOff_select_onoffDataGroup(String firstDate,String route,String route_type
			,String station,String startDate,String endDate);//선택한 반 승차/하차 이력
	
	public List<OnOffDto> attendance_history_select_onoffData(String firstDate,String class_id,String startDate,String endDate);//선택한 반 등하원 이력
	
	public List<OnOffDto> attendance_history_select_onoffDataGroup(String firstDate,String class_id,String startDate,String endDate);//선택한 반 등하원 이력

	
}
