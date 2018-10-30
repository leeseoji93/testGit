package com.test.rememberTest.Dao.Teach_bus_check;

import java.util.List;
import java.util.Map;

import com.test.rememberTest.Dto.BusRouteDto;
import com.test.rememberTest.Dto.Teach_bus_checkDto;


public interface Teach_bus_checkDao {

	List<Teach_bus_checkDto> getTeachCheckList(Map<String, Object> map);

	List<Teach_bus_checkDto> getCheckistContent(Map<String, Object> map);

	List<Teach_bus_checkDto> getDailyCheckInfo(Map<String, Object> map);

	List<Teach_bus_checkDto> getCheckListContentAll(Map<String, Object> map);

	void updateAllCheckList(Map<String, Object> map);

	void updateAllBusDailyCheck(Map<String, Object> map);

	void deleteAllCheckList(Map<String, Object> map);

	void deleteDailyAllCheckList(Map<String, Object> map);

	List<Teach_bus_checkDto> getDetailCarInfo(Map<String, Object> map);

	List<Teach_bus_checkDto> Teach_bus_check_select_weekdata(Map<String, Object> map);

	List<Teach_bus_checkDto> getTeachCheckList2(Map<String, Object> map);

	List<Teach_bus_checkDto> getLatestCheckList(String center_code); 
}
