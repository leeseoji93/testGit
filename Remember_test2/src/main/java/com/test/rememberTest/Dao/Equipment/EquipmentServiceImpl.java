package com.test.rememberTest.Dao.Equipment;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.rememberTest.Dto.EquipmentDto;


@Service
public class EquipmentServiceImpl implements EquipmentService{

	 @Autowired
	    private EquipmentDao equipmentDao;
	
	 @Override
		public List<EquipmentDto> selectEquipment(String word) {
			Map<String, Object> map = new HashMap<String, Object>();       
	        map.put("word", word); 
			return equipmentDao.selectEquipment(map);
		}//장비 리스트

	@Override
	public List<EquipmentDto> getTabletList(String center_code) {
		Map<String, Object> map = new HashMap<String, Object>();       
        map.put("center_code", center_code); 
		return equipmentDao.TabletList(map);
	}

	@Override
	public List<EquipmentDto> getDetailTablet(String equipment_id, String center_code) {
		Map<String, Object> map = new HashMap<String, Object>();       
        map.put("equipment_id", equipment_id); 
        map.put("center_code", center_code); 
		return equipmentDao.DetailTablet(map);
	}

	@Override
	public void UpdateEquipment(EquipmentDto equipmentDto) {
		equipmentDao.UpdateEquipment(equipmentDto);
	}

	@Override
	public List<EquipmentDto> getGateWayList(String center_code) {
		Map<String, Object> map = new HashMap<String, Object>();       
        map.put("center_code", center_code); 
		return equipmentDao.GateWayList(map);
	}

	@Override
	public int getDeleteEquipment(String center_code, String[] equipmentArray) {
		Map<String, Object> map = new HashMap<String, Object>();     
		Map<String, Object> dtomap;
		List<Map<String, Object>> dtoList = new ArrayList<Map<String, Object>>();	
		 for(int i=0; i<equipmentArray.length; i++) {
			 dtomap = new HashMap<String, Object>();
//			 dtomap.put("center_code", center_code);
			 dtomap.put("equipment_id", equipmentArray[i]);
	
			 dtoList.add(dtomap);
		 }
//		System.out.println("dtoList"+dtoList.get(0));
//		System.out.println("dtoList"+dtoList.get(1));
        map.put("dtoList", dtoList); 
	
		return equipmentDao.DeleteEquipment(map);
	}

	@Override
	public void installEquipmentUpdate(EquipmentDto equipmentDto) {
		equipmentDao.installEquipmentUpdate(equipmentDto);
	}

	@Override
	public void busEquipmentUpdate(EquipmentDto equipmentDto) {
		equipmentDao.busEquipmentUpdate(equipmentDto);
	}

	@Override
	public void busEquipmentUpdateT(EquipmentDto equipmentDto) {
		equipmentDao.busEquipmentUpdateT(equipmentDto);
	}

	@Override
	public List<EquipmentDto> equipmentSearch(String center_code, String keyWord,String equipment_type) {
		Map<String, Object> map = new HashMap<String, Object>();       
        map.put("center_code", center_code); 
        map.put("keyWord", keyWord);
        map.put("equipment_type", equipment_type);
        
		return equipmentDao.equipmentSearch(map);
	}

	@Override
	public List<EquipmentDto> getDashboardEquiCount(String center_code) {
		Map<String, Object> map = new HashMap<String, Object>();       
        map.put("center_code", center_code); 
        
		return equipmentDao.dashboardEquiCount(map);
	}

	

}
