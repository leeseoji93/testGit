package com.test.rememberTest.Dao.Becon;

import java.util.List;
import java.util.Map;

import com.test.rememberTest.Dto.BeaconDto;
import com.test.rememberTest.Dto.BusRouteDto;


public interface BeaconDao {

	List<BeaconDto> getBeaconList(Map<String, Object> map);

	List<BeaconDto> DetailBeacon(Map<String, Object> map);

	void UpdateBeancon(BeaconDto beaconDto);

	List<BeaconDto> matchingBeaconList(Map<String, Object> map);

	int updateMatching(Map<String, Object> map);

	List<BeaconDto> BeaconCondition(Map<String, Object> map);

	int cutMatching(Map<String, Object> map);

	int countBeacon(String center_code);

	int autoMatching(Map<String, Object> map);

	List<BeaconDto> getBeaconSeach(Map<String, Object> map);

	int getCutMatching(Map<String, Object> map);

}
