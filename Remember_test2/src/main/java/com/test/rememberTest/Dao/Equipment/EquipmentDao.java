package com.test.rememberTest.Dao.Equipment;

import java.util.List;
import java.util.Map;

import com.test.rememberTest.Dto.EquipmentDto;


public interface EquipmentDao {

	public List<EquipmentDto> selectEquipment(Map<String, Object> map);//장비 리스트

	public List<EquipmentDto> TabletList(Map<String, Object> map);

	public List<EquipmentDto> DetailTablet(Map<String, Object> map);

	public void UpdateEquipment(EquipmentDto equipmentDto);

	public List<EquipmentDto> GateWayList(Map<String, Object> map);

	public int DeleteEquipment(Map<String, Object> map);

	public void installEquipmentUpdate(EquipmentDto equipmentDto);

	public void busEquipmentUpdate(EquipmentDto equipmentDto);

	public void busEquipmentUpdateT(EquipmentDto equipmentDto);

	public List<EquipmentDto> equipmentSearch(Map<String, Object> map);

	public List<EquipmentDto> dashboardEquiCount(Map<String, Object> map);

	
}
