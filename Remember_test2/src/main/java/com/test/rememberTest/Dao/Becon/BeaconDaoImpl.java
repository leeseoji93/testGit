package com.test.rememberTest.Dao.Becon;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.rememberTest.Dto.BeaconDto;
import com.test.rememberTest.Dto.BusRouteDto;
import com.test.rememberTest.Dto.EquipmentDto;


@Repository
public class BeaconDaoImpl implements BeaconDao{
	private final String NS = "com.test.rememberTest.Map.UserMapper";
	
	@Autowired  	
	private SqlSessionTemplate sqlSession;

	@Override
	public List<BeaconDto> getBeaconList(Map<String, Object> map) {
		return sqlSession.selectList(NS+".BeaconList",map);
	}

	@Override
	public List<BeaconDto> DetailBeacon(Map<String, Object> map) {
		return sqlSession.selectList(NS+".DetailBeacon",map);
	}

	@Override
	public void UpdateBeancon(BeaconDto beaconDto) {
		sqlSession.update(NS+".UpdateBeancon", beaconDto);
	}

	@Override
	public List<BeaconDto> matchingBeaconList(Map<String, Object> map) {
		return sqlSession.selectList(NS+".matchingBeaconList", map);
	}

	@Override
	public int updateMatching(Map<String, Object> map) {
		return sqlSession.update(NS+".updateMatching", map);
	}
	@Override
	public List<BeaconDto> BeaconCondition(Map<String, Object> map) {
		System.out.println("DaoMap : "+map);
		return sqlSession.selectList(NS+".BeaconCondition",map);
	}

	@Override
	public int cutMatching(Map<String, Object> map) {
		System.out.println("chk:"+map.toString());
		return sqlSession.update(NS+".cutMatching", map);
	}

	@Override
	public int countBeacon(String center_code) {
		return sqlSession.selectOne(NS+".countBeacon", center_code);
	}

	@Override
	public int autoMatching(Map<String, Object> map) {
		return sqlSession.update(NS+".autoMatching", map);
	}

	@Override
	public List<BeaconDto> getBeaconSeach(Map<String, Object> map) {
		return sqlSession.selectList(NS+".BeaconSeach",map);
	}

	@Override
	public int getCutMatching(Map<String, Object> map) {
		return sqlSession.update(NS+".getCutMatching",map);
	}
}
