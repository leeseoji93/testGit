package com.test.rememberTest.Dao.Equipment;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.rememberTest.Dto.EquipmentDto;



@Repository
public class EquipmentImpl implements EquipmentDao{
	private final String NS = "com.test.rememberTest.Map.UserMapper";
	
	 @Autowired 
	    private SqlSessionTemplate sqlSession;
	
	 @Override
		public List<EquipmentDto> selectEquipment(Map<String, Object> map) {
			return sqlSession.selectList(NS+".select_equipment",map);
		}//장비 리스트 셀렉

	@Override
	public List<EquipmentDto> TabletList(Map<String, Object> map) {
		return sqlSession.selectList(NS+".TabletList",map);
	}

	@Override
	public List<EquipmentDto> DetailTablet(Map<String, Object> map) {
		return sqlSession.selectList(NS+".DetailTablet",map);
	}

	@Override
	public void UpdateEquipment(EquipmentDto equipmentDto) {
		sqlSession.update(NS+".UpdateEquipment", equipmentDto);
	}

	@Override
	public List<EquipmentDto> GateWayList(Map<String, Object> map) {
		return sqlSession.selectList(NS+".GateWayList",map);
	}

	@Override
	public int DeleteEquipment(Map<String, Object> map) {
		return sqlSession.delete(NS+".DeleteEquipment",map);
	}

	@Override
	public void installEquipmentUpdate(EquipmentDto equipmentDto) {
		sqlSession.update(NS+".installEquipmentUpdate",equipmentDto);
	}

	@Override
	public void busEquipmentUpdate(EquipmentDto equipmentDto) {
		sqlSession.update(NS+".busEquipmentUpdate",equipmentDto);
	}

	@Override
	public void busEquipmentUpdateT(EquipmentDto equipmentDto) {
		sqlSession.update(NS+".busEquipmentUpdateT",equipmentDto);
	}

	@Override
	public List<EquipmentDto> equipmentSearch(Map<String, Object> map) {
		return sqlSession.selectList(NS+".equipmentSearch",map);
	}

	@Override
	public List<EquipmentDto> dashboardEquiCount(Map<String, Object> map) {
		return sqlSession.selectList(NS+".dashboardEquiCount",map);
	}

	

}
