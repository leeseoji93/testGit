package com.test.rememberTest.Dao.RealTime;

import java.util.List;
import java.util.Map;

import com.test.rememberTest.Dto.BusRouteDto;
import com.test.rememberTest.Dto.RealTimeDto;


public interface RealTimeDao {
	List<RealTimeDto> selectRealTimeRoute(Map<String, Object> map);

	List<RealTimeDto> selectRealTimeCar(Map<String, Object> map);

}
