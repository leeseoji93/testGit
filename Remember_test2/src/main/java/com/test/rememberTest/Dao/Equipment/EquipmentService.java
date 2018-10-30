package com.test.rememberTest.Dao.Equipment;

import java.util.ArrayList;
import java.util.List;

import com.test.rememberTest.Dto.EquipmentDto;

public interface EquipmentService {
	
	public List<EquipmentDto> selectEquipment(String word);//장비 리스트

	public List<EquipmentDto> getTabletList(String center_code);

	public List<EquipmentDto> getDetailTablet(String equipment_id, String center_code);

	public void UpdateEquipment(EquipmentDto equipmentDto);

	public List<EquipmentDto> getGateWayList(String center_code);

	public int getDeleteEquipment(String center_code, String[] equipmentArray);

	public void installEquipmentUpdate(EquipmentDto equipmentDto);

	public void busEquipmentUpdate(EquipmentDto equipmentDto);

	public void busEquipmentUpdateT(EquipmentDto equipmentDto);

	public List<EquipmentDto> equipmentSearch(String center_code, String keyWord, String equipment_type);

	public List<EquipmentDto> getDashboardEquiCount(String center_code);
}
