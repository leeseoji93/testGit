package com.test.rememberTest.Dao.Station;

import java.util.List;

import com.test.rememberTest.Dto.StationInfo;

public interface StationService {
	public void addStation(StationInfo stationInfo);

	public int getLastPage(int stationCnt);

	public List<StationInfo> getStationList(String center_code);

	public StationInfo getDetailStation(String stationNo);

	int getDeleteStation(String station_id);

	public void updateStation(StationInfo stationInfo);

	public List<StationInfo> searchStation(String center_code,String keyWord);

	public StationInfo chkStName(String stName);
	
	public List<StationInfo> selectMaxStation_id(String code);

	public List<StationInfo> getStationUseList(String center_code);
}
