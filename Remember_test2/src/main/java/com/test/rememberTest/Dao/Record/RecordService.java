package com.test.rememberTest.Dao.Record;

import java.util.List;
import java.util.Map;

import com.test.rememberTest.Dto.BusRouteDto;
import com.test.rememberTest.Dto.RecordDto;



public interface RecordService {

	List<RecordDto> getRecordRoute(String route_id, String selectYM, String center_code);

	List<RecordDto> getRecordDriv_Doc(String route_id, String selectYM, String center_code);

	List<RecordDto> getDetailRecordList(String route_id, String day);

	List<RecordDto> selectRecord_DownData(String route_id, String[] day);

	List<RecordDto> getLatest_RecordDriv_Doc(String center_code);
	
}
