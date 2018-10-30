package com.test.rememberTest.Dao.Record;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.rememberTest.Dto.BusRouteDto;
import com.test.rememberTest.Dto.RecordDto;


@Service
public class RecordServiceImpl implements RecordService{

	 @Autowired
	    private RecordDao recordDao;

	@Override
	public List<RecordDto> getRecordRoute(String route_id, String selectYM, String center_code) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("route_id", route_id);
		map.put("selectYM", selectYM);
		map.put("center_code", center_code);
		return recordDao.selectRecordRoute(map);
	}

	@Override
	public List<RecordDto> getRecordDriv_Doc(String route_id, String selectYM, String center_code) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("route_id", route_id);
		map.put("selectYM", selectYM);
		map.put("center_code", center_code);
		return recordDao.selectRecordDriv_Doc(map);
	}

	@Override
	public List<RecordDto> getDetailRecordList(String route_id, String day) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("route_id", route_id);
		map.put("day", day);
		return recordDao.selectDetailRecordList(map);
	}

	@Override
	public List<RecordDto> selectRecord_DownData(String route_id, String[] driv_doc) {
		Map<String, Object> map = new HashMap<String, Object>();     
		Map<String, Object> dtomap;
		
		List<Map<String, Object>> dtoList = new ArrayList<Map<String, Object>>();
		 for(int i=0; i<driv_doc.length; i++) {
			 dtomap = new HashMap<String, Object>();
			 dtomap.put("driv_doc", driv_doc[i]);
//			 System.out.println("dtomap:"+center_code+"/"+route_id+"/"+
//					 route_id+"/"+staff_id+"/"+typeArray[i]+"/"+
//					 contentArray[i]+"/"+checkArray[i]+"/"+todayArray[i]);
			 dtoList.add(dtomap);
		
		  
		 }
		 map.put("route_id", route_id);
		 map.put("dtoList", dtoList);
		 
		 System.out.println("map:"+map);
		 return recordDao.selectRecord_DownData(map);
	}

	@Override
	public List<RecordDto> getLatest_RecordDriv_Doc(String center_code) {
		return recordDao.latest_RecordDriv_Doc(center_code);	//최근 5개 
	}


}
