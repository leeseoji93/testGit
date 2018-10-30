package com.test.rememberTest.Dao.Station;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.rememberTest.Dto.PageHelper;
import com.test.rememberTest.Dto.StationInfo;

@Service
public class StationServiceImpl implements StationService{
private final int LINE_PER_PAGE = 10;
	
	@Autowired
	private StationDao stationDao;
	
	@Override
	public void addStation(StationInfo stationInfo) {
		 stationDao.insertStation(stationInfo);	
	}
	
	@Override
	public List<StationInfo> getStationUseList(String center_code) {
		Map<String, Object> map = new HashMap<String, Object>();       
        map.put("center_code", center_code);
        return stationDao.selectStationUseList(map);
	}
	
	@Override
	public List<StationInfo> getStationList(String center_code) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("center_code", center_code);
        System.out.println("map : "+map);
        return stationDao.selectStationList(map);
	}

	@Override
	public int getLastPage(int stationCnt) {
		return stationDao.stationCount(stationCnt);
	}

	@Override
	public StationInfo getDetailStation(String stationNo) {
		return stationDao.selectDetailStation(stationNo);
	}

	@Override
	public int getDeleteStation(String station_id) {
		return stationDao.deleteStation(station_id);
	}

	@Override
	public void updateStation(StationInfo stationInfo) {
		stationDao.updateStation(stationInfo);
		
	}

	@Override
	public List<StationInfo> searchStation(String center_code,String keyWord) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("center_code", center_code);
		map.put("keyWord", keyWord);
		return stationDao.searchStation(map);
	}

	@Override
	public StationInfo chkStName(String stName) {
		return stationDao.chkStName(stName);
	}

	@Override
	public List<StationInfo> selectMaxStation_id(String word) {
		Map<String, Object> map = new HashMap<String, Object>();       
        map.put("word", word); 
		return stationDao.selectMaxStation_id(map);
	}

	


}
