package com.test.rememberTest.Dao.RealTime;

import java.util.List;
import java.util.Map;

import com.test.rememberTest.Dto.BusRouteDto;
import com.test.rememberTest.Dto.RealTimeDto;



public interface RealTimeService {

	List<RealTimeDto> getRealTimeRoute(String center_code, String route_id);

	List<RealTimeDto> getRealTimeCar(String route_id, String center_code);
	
}
