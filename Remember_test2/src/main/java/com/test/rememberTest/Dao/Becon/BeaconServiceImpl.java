package com.test.rememberTest.Dao.Becon;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.rememberTest.Dto.BeaconDto;
import com.test.rememberTest.Dto.BusRouteDto;
import com.test.rememberTest.Dto.EquipmentDto;
import com.test.rememberTest.Dto.KidDto;


@Service
public class BeaconServiceImpl implements BeaconService{

	@Autowired
	private BeaconDao beconDao;

	@Override
	public List<BeaconDto> getBeaconList(String center_code) {
		Map<String, Object> map = new HashMap<String, Object>();       
        map.put("center_code", center_code);
		return beconDao.getBeaconList(map);
	}

	@Override
	public List<BeaconDto> getDetailBeacon(String beacon_id, String center_code) {
		Map<String, Object> map = new HashMap<String, Object>();       
        map.put("beacon_id", beacon_id);
        map.put("center_code", center_code);
		return beconDao.DetailBeacon(map);
	}

	@Override
	public void UpdateBeancon(BeaconDto beaconDto) {
		beconDao.UpdateBeancon(beaconDto);
	}

	@Override
	public List<BeaconDto> matchingBeaconList(String center_code) {
		Map<String, Object> map = new HashMap<String, Object>();       
        map.put("center_code", center_code);
		return beconDao.matchingBeaconList(map);
	}
	@Override
	public int updateMatching(String center_code, String[] beacon_id, String[] kid_system_code) {
		Map<String, Object> map = new HashMap<String, Object>();  
	      
		Map<String, Object> dtomap;
		List<Map<String, Object>> dtoList = new ArrayList<Map<String, Object>>();
	       
	      for(int i=0; i<beacon_id.length; i++) {
	         dtomap = new HashMap<String, Object>();
	         
	         dtomap.put("center_code", center_code);
	         dtomap.put("beacon_id", beacon_id[i]);
	         dtomap.put("kid_system_code", kid_system_code[i]);
	           
	         dtoList.add(dtomap);
	      }
	      map.put("dtoList", dtoList); 
	      System.out.println("dtoList:"+map);
	      return beconDao.updateMatching(map);
	      
	}
	
	@Override
	public List<BeaconDto> getBeaconCondition(String center_code, String search_Keyword, String search_ClassId,
			String search_ClassYear) {
		Map<String, Object> map = new HashMap<String, Object>();  
		map.put("center_code", center_code); 
        map.put("keyWord", search_Keyword); 
        map.put("class_id", search_ClassId); 
        map.put("class_year", search_ClassYear); 
        System.out.println("map:"+map);
		return beconDao.BeaconCondition(map);
	}

	@Override
	public int cutMatching(String center_code, String[] checkArray, String[] beacon_idArray,
			String[] kid_system_codeArray) {
		Map<String, Object> map = new HashMap<String, Object>();  
		
		Map<String, Object> dtomap;
		List<Map<String, Object>> dtoList = new ArrayList<Map<String, Object>>();
		
		for(int i=0;i<beacon_idArray.length;i++){
			dtomap = new HashMap<String, Object>();
	         
			dtomap.put("chk", checkArray[i]);
			dtomap.put("center_code", center_code);
	        dtomap.put("beacon_id",beacon_idArray[i]);
	        dtomap.put("kid_system_code",kid_system_codeArray[i]);
	           
	        System.out.println("chk:"+ checkArray[i]);
	        System.out.println("center_code:"+ center_code);
	        System.out.println("beacon_id:"+ beacon_idArray[i]);
	        System.out.println("kid_system_code:"+ kid_system_codeArray[i]);
	        dtoList.add(dtomap);
		}
		map.put("dtoList", dtoList);
		System.out.println("map:"+map);
		return beconDao.cutMatching(map);
	}

	@Override
	public int getcountBeacon(String center_code) {
		return beconDao.countBeacon(center_code);
	}

	@Override
	public int autoMatching(String center_code, List<BeaconDto> allBeacon, List<KidDto> allKids) {
		System.out.println("***********************");
		
		Map<String, Object> map = new HashMap<String, Object>();  
		
		Map<String, Object> dtomap;
		List<Map<String, Object>> dtoList = new ArrayList<Map<String, Object>>();
		int beaconCnt = allBeacon.size();
		int kidCnt = allKids.size();
		int arrayLength;
		
		System.out.println("all:"+allBeacon.get(0).getBeacon_id());
		
		if(beaconCnt<kidCnt){arrayLength=beaconCnt;}
		else{arrayLength=kidCnt;}
		for(int i=0;i<arrayLength;i++){
			dtomap = new HashMap<String, Object>();
	         
			dtomap.put("beacon_id", allBeacon.get(i).getBeacon_id());
			dtomap.put("center_code", center_code);
	        dtomap.put("kid_system_code",allKids.get(i).getKid_system_code());
	           
	        System.out.println("allBeacon"+  allBeacon.get(i).getBeacon_id());
	        System.out.println("kid_system_code:"+ allKids.get(i).getKid_system_code());
	        dtoList.add(dtomap);
		}
		map.put("dtoList", dtoList);  
		return beconDao.autoMatching(map);
	}

	@Override
	public List<BeaconDto> getBeaconSeach(String center_code, String keyWord) {
		Map<String, Object> map = new HashMap<String, Object>();       
        map.put("center_code", center_code);
        map.put("keyWord", keyWord);
		return beconDao.getBeaconSeach(map);
	}

	@Override
	public int getCutMatching(String center_code, String[] checkArray, String[] beacon_idArray,
			String[] kid_system_codeArray) {
Map<String, Object> map = new HashMap<String, Object>();  
		
		Map<String, Object> dtomap;
		List<Map<String, Object>> dtoList = new ArrayList<Map<String, Object>>();
		
		for(int i=0;i<kid_system_codeArray.length;i++){
			dtomap = new HashMap<String, Object>();
	         
			dtomap.put("beacon_id", beacon_idArray[i]);
			dtomap.put("center_code", center_code);
	        dtomap.put("kid_system_code",kid_system_codeArray[i]);
	        dtomap.put("chk",checkArray[i]);
	           
	        dtoList.add(dtomap);
	        
		}
		map.put("dtoList", dtoList);
		System.out.println("map:"+map);
		return beconDao.getCutMatching(map);
	}

	

}
