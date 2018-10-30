package com.test.rememberTest.Dao.Record;

import java.util.List;
import java.util.Map;

import com.test.rememberTest.Dto.BusRouteDto;
import com.test.rememberTest.Dto.RecordDto;


public interface RecordDao {

	List<RecordDto> selectRecordRoute(Map<String, Object> map);

	List<RecordDto> selectRecordDriv_Doc(Map<String, Object> map);

	List<RecordDto> selectDetailRecordList(Map<String, Object> map);

	List<RecordDto> selectRecord_DownData(Map<String, Object> map);

	List<RecordDto> latest_RecordDriv_Doc(String center_code);

}
