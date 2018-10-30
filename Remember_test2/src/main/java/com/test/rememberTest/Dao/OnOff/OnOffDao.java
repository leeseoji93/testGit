package com.test.rememberTest.Dao.OnOff;

import java.util.List;
import java.util.Map;

import com.test.rememberTest.Dto.EquipmentDto;
import com.test.rememberTest.Dto.OnOffDto;


public interface OnOffDao {
	public List<OnOffDto> OnOff_select_onoffData(Map<String, Object> map);//선택한 노선 승차/하차 이력
	
	public List<OnOffDto> OnOff_select_onoffDataGroup(Map<String, Object> map);//선택한 노선 승차/하차 이력
	
	public List<OnOffDto> attendance_history_select_onoffData(Map<String, Object> map);//선택한 반 등하원 이력
	
	public List<OnOffDto> attendance_history_select_onoffDataGroup(Map<String, Object> map);//선택한 반 등하원 이력
}
