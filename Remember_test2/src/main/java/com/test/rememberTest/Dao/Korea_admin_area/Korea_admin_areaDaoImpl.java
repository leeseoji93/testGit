package com.test.rememberTest.Dao.Korea_admin_area;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.rememberTest.Dto.BusRouteDto;
import com.test.rememberTest.Dto.korea_admin_areaDto;


@Repository
public class Korea_admin_areaDaoImpl implements Korea_admin_areaDao{
	private final String NS = "com.test.rememberTest.Map.UserMapper";
	
	 @Autowired  	
	    private SqlSessionTemplate sqlSession;

	@Override
	public List<korea_admin_areaDto> selectArea_cityName() {
		return sqlSession.selectList(NS+".selectArea_cityName");
	}

	@Override
	public List<korea_admin_areaDto> selectArea_districtName(Map<String, Object> map) {
		return sqlSession.selectList(NS+".selectArea_districtName",map);
	}

	@Override
	public List<korea_admin_areaDto> selectArea_townshipName(Map<String, Object> map) {
		return sqlSession.selectList(NS+".selectArea_townshipName",map);
	}

	@Override
	public List<korea_admin_areaDto> selectArea_gu(Map<String, Object> map) {
		return sqlSession.selectList(NS+".selectArea_gu",map);
	}

	@Override
	public List<korea_admin_areaDto> selectArea_dong(Map<String, Object> map) {
		return sqlSession.selectList(NS+".selectArea_dong",map);
	}

}
