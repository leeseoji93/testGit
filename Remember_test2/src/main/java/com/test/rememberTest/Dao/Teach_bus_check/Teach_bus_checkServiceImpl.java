package com.test.rememberTest.Dao.Teach_bus_check;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.rememberTest.Dto.BusRouteDto;
import com.test.rememberTest.Dto.Teach_bus_checkDto;


@Service
public class Teach_bus_checkServiceImpl implements Teach_bus_checkService{

	 @Autowired
	    private Teach_bus_checkDao teach_bus_checkDao;

	@Override
	public List<Teach_bus_checkDto> getTeachCheckList(String center_code,String checkDateYNM,String route_id) {
		Map<String, Object> map = new HashMap<String, Object>();
        map.put("center_code", center_code);
        map.put("checkDateYNM", checkDateYNM);
        map.put("route_id", route_id);
		return teach_bus_checkDao.getTeachCheckList(map);
	}
	@Override
	public List<Teach_bus_checkDto> getTeachCheckList2(String center_code,String checkDateYNM,String route_id) {
		Map<String, Object> map = new HashMap<String, Object>();
        map.put("center_code", center_code);
        map.put("checkDateYNM", checkDateYNM);
        map.put("route_id", route_id);
		return teach_bus_checkDao.getTeachCheckList2(map);
	}

	@Override
	public List<Teach_bus_checkDto> getCheckListContent(String center_code,int chk) {
		Map<String, Object> map = new HashMap<String, Object>();
        map.put("center_code", center_code);
        map.put("chk", chk);
		return teach_bus_checkDao.getCheckistContent(map);
	}

	@Override
	public List<Teach_bus_checkDto> getDailyCheckInfo( String route_name, String routeSelect) {
		Map<String, Object> map = new HashMap<String, Object>();
        map.put("route_name", route_name);
        map.put("route_id", routeSelect);
		return teach_bus_checkDao.getDailyCheckInfo(map);
	}

	@Override
	public List<Teach_bus_checkDto> getCheckListContentAll(String center_code) {
		Map<String, Object> map = new HashMap<String, Object>();
        map.put("center_code", center_code);
		return teach_bus_checkDao.getCheckListContentAll(map);
	}

	@Override
	public void updateAllCheckList(int[] typeArray, int[] contentArray, String[] dayArray, int[] checkArray, String route_id,
			String teach_check_date, String center_code, String staff_id, String[] todayArray) {
		
		Map<String, Object> map = new HashMap<String, Object>();     
		Map<String, Object> dtomap;
		List<Map<String, Object>> dtoList = new ArrayList<Map<String, Object>>();
		 for(int i=0; i<typeArray.length; i++) {
			 dtomap = new HashMap<String, Object>();
			 dtomap.put("center_code", center_code);
			 dtomap.put("route_id", route_id);
			 dtomap.put("staff_id", staff_id);
			 dtomap.put("teach_buslist_type_order", typeArray[i]);
			 dtomap.put("teach_buslist_cont_order", contentArray[i]);
			 dtomap.put("teach_check", checkArray[i]);
			 dtomap.put("teach_check_date", teach_check_date);
			 dtomap.put("today", todayArray[i]);
//			 System.out.println("dtomap:"+center_code+"/"+route_id+"/"+
//					 route_id+"/"+staff_id+"/"+typeArray[i]+"/"+
//					 contentArray[i]+"/"+checkArray[i]+"/"+todayArray[i]);
			 dtoList.add(dtomap);
		}
		
		 map.put("dtoList", dtoList); 
		 System.out.println("map:"+map);
		 teach_bus_checkDao.updateAllCheckList(map);
	}

	@Override
	public void updateAllBusDailyCheck(String[] todayArray, String route_id, String year, String mon,
			String center_code) {
		Map<String, Object> map = new HashMap<String, Object>();     
		Map<String, Object> dtomap;
		List<Map<String, Object>> dtoList = new ArrayList<Map<String, Object>>();
		
		 for(int i=0; i<todayArray.length; i++) {
			 dtomap = new HashMap<String, Object>();
			 dtomap.put("today", todayArray[i]);
			 dtomap.put("route_id", route_id);
			 dtomap.put("center_code", center_code);
	
			 dtoList.add(dtomap);
		}
		 map.put("dtoList", dtoList); 
		 teach_bus_checkDao.updateAllBusDailyCheck(map);
	}

	@Override
	public void deleteAllCheckList(String nowYNM, String center_code, String route_id) {
		Map<String, Object> map = new HashMap<String, Object>();
        map.put("nowYNM", nowYNM);
        map.put("center_code", center_code);
        map.put("route_id", route_id);
		teach_bus_checkDao.deleteAllCheckList(map);
	}

	@Override
	public void deleteDailyAllCheckList(String nowYNM, String center_code, String route_id) {
		Map<String, Object> map = new HashMap<String, Object>();
        map.put("nowYNM", nowYNM);
        map.put("center_code", center_code);
        map.put("route_id", route_id);
		teach_bus_checkDao.deleteDailyAllCheckList(map);
	}

	@Override
	public List<Teach_bus_checkDto> getDetailCarInfo(String route_id) {
		Map<String, Object> map = new HashMap<String, Object>();
        map.put("route_id", route_id);
		return teach_bus_checkDao.getDetailCarInfo(map);
	}

	@Override
	public List<Teach_bus_checkDto> Teach_bus_check_select_weekdata(String center_code, String route_id, String startDate,
			String endDate) {
		Map<String, Object> map = new HashMap<String, Object>();
	    map.put("center_code", center_code);
	    map.put("startDate", startDate);
	    map.put("endDate", endDate);
	    map.put("route_id", route_id);
		return teach_bus_checkDao.Teach_bus_check_select_weekdata(map);
	}
	@Override
	public List<Teach_bus_checkDto> getLatestCheckList(String center_code) {
		return teach_bus_checkDao.getLatestCheckList(center_code);
	}
	
}
