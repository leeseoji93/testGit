package com.test.rememberTest.Dao.Teach_bus_check;

import java.text.DateFormat;
import java.util.List;
import java.util.Map;

import com.test.rememberTest.Dto.BusRouteDto;
import com.test.rememberTest.Dto.Teach_bus_checkDto;



public interface Teach_bus_checkService {

	List<Teach_bus_checkDto> getTeachCheckList(String center_code, String checkDateYNM, String route_id);

	List<Teach_bus_checkDto> getCheckListContent(String center_code, int chk);

	List<Teach_bus_checkDto> getDailyCheckInfo( String route_name, String routeSelect);

	List<Teach_bus_checkDto> getCheckListContentAll(String center_code);

//	void updateAllCheckList(String[] typeArray, String[] contentArray, String[] dayArray, String[] checkArray,
//			String route_id, String teach_check_date, String center_code, String staff_id, String[] todayArray);

	void updateAllBusDailyCheck(String[] todayArray, String route_id, String year, String mon, String center_code);

	void deleteAllCheckList(String nowYNM, String center_code, String route_id);

	void deleteDailyAllCheckList(String nowYNM, String center_code, String route_id);

	void updateAllCheckList(int[] typeArray, int[] contentArray, String[] dayArray, int[] checkArray, String route_id,
			String teach_check_date, String center_code, String id, String[] todayArray);

	List<Teach_bus_checkDto> getDetailCarInfo(String route_id);
	
	List<Teach_bus_checkDto> Teach_bus_check_select_weekdata(String center_code, String route_id,String startDate,String endDate);

	List<Teach_bus_checkDto> getTeachCheckList2(String center_code, String checkDateYNM, String route_id);

	List<Teach_bus_checkDto> getLatestCheckList(String center_code); 
}
