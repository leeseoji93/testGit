package com.test.rememberTest.Dao.RealTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.rememberTest.Dto.BusRouteDto;
import com.test.rememberTest.Dto.RealTimeDto;


@Service
public class RealTimeServiceImpl implements RealTimeService{

	 @Autowired
	    private RealTimeDao realTimeDao;

	@Override
	public List<RealTimeDto> getRealTimeRoute(String center_code, String route_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("center_code", center_code); 
		map.put("route_id", route_id); 
		return realTimeDao.selectRealTimeRoute(map);
	}

	@Override
	public List<RealTimeDto> getRealTimeCar(String route_id, String center_code) {
		System.out.println("getRealTimeCar시작");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("center_code", center_code); 
		map.put("route_id", route_id); 
		return realTimeDao.selectRealTimeCar(map);
	}

}
