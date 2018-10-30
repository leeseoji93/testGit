package com.test.rememberTest.Dao.Stat_sche;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class Stat_scheServiceImpl implements Stat_scheService{

	 @Autowired
	    private Stat_scheDao stat_scheDao;

	@Override
	public void Stat_sche_delete(String route_id) {
		Map<String, Object> map = new HashMap<String, Object>();  
        map.put("route_id", route_id); 
        stat_scheDao.Stat_sche_delete(map);		
	}//Stat_sche 정보 삭제

	@Override
	public void Stat_sche_insert(String affiliation, String route_id, List<String> station_id, List<String> arrive_time,
			String registrant) {
		Map<String, Object> map = new HashMap<String, Object>();  
		
		Map<String, Object> dtomap;
		 List<Map<String, Object>> dtoList = new ArrayList<Map<String, Object>>();
		 
		for(int i=0; i<station_id.size(); i++) {
			dtomap = new HashMap<String, Object>();
			
			dtomap.put("affiliation", affiliation);
			dtomap.put("route_id", route_id);
			dtomap.put("station_id", station_id.get(i));
			dtomap.put("arrive_time", arrive_time.get(i));
			dtomap.put("registrant", registrant);
	        
			dtoList.add(dtomap);
		}
		map.put("dtoList", dtoList);		
        stat_scheDao.Stat_sche_insert(map);		
	}//Stat_sche 정보 입력

}
