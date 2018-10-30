package com.test.rememberTest.Dao.Becon;

import java.util.List;
import java.util.Map;

import com.test.rememberTest.Dto.BeaconDto;
import com.test.rememberTest.Dto.BusRouteDto;
import com.test.rememberTest.Dto.KidDto;



public interface BeaconService {

	List<BeaconDto> getBeaconList(String center_code);
	List<BeaconDto> getDetailBeacon(String beacon_id, String center_code);
	void UpdateBeancon(BeaconDto beaconDto);
	List<BeaconDto> matchingBeaconList(String center_code);
	int updateMatching(String center_code, String[] beacon_idArray, String[] kid_Array);
	List<BeaconDto> getBeaconCondition(String center_code, String search_Keyword, String search_ClassId,
			String search_ClassYear);
	int cutMatching(String center_code, String[] checkArray, String[] beacon_idArray, String[] kid_system_codeArray);
	int getcountBeacon(String center_code);
	int autoMatching(String center_code, List<BeaconDto> allBeacon, List<KidDto> allKids);
	List<BeaconDto> getBeaconSeach(String center_code, String keyWord);
	int getCutMatching(String center_code, String[] checkArray, String[] beacon_idArray, String[] kid_system_codeArray);
}
