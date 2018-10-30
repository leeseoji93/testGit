package com.test.rememberTest.Dao.Korea_admin_area;

import java.util.List;
import java.util.Map;

import com.test.rememberTest.Dto.BusRouteDto;
import com.test.rememberTest.Dto.korea_admin_areaDto;


public interface Korea_admin_areaDao {

	public List<korea_admin_areaDto> selectArea_cityName();

	public List<korea_admin_areaDto> selectArea_districtName(Map<String, Object> map);

	public List<korea_admin_areaDto> selectArea_townshipName(Map<String, Object> map);

	public List<korea_admin_areaDto> selectArea_gu(Map<String, Object> map);

	public List<korea_admin_areaDto> selectArea_dong(Map<String, Object> map);
	
}
