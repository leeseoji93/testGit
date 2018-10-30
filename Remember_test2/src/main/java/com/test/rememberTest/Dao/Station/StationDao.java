package com.test.rememberTest.Dao.Station;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.test.rememberTest.Dto.StationInfo;

@Repository
public interface StationDao {
	public Object insertStation(StationInfo stationInfo);

	public List<StationInfo> selectStationList(Map<String, Object> map);

	public StationInfo selectDetailStation(String station_id);

//	public int deleteStation(String stationNo);

	int deleteStation(String station_id);

	public Object updateStation(StationInfo stationInfo);

	public List<StationInfo> searchStation(Map<String, Object> map);

	public StationInfo chkStName(String stName);
	
	int stationCount(int stationCnt);

	public List<StationInfo> selectMaxStation_id(Map<String, Object> map);

	public List<StationInfo> selectStationUseList(Map<String, Object> map);
}
