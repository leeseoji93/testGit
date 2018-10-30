package com.test.rememberTest.Dao.Korea_admin_area;

import java.util.List;
import java.util.Map;

import com.test.rememberTest.Dto.BusRouteDto;
import com.test.rememberTest.Dto.korea_admin_areaDto;



public interface Korea_admin_areaService {

	public List<korea_admin_areaDto> selectArea_cityName();

	public List<korea_admin_areaDto> selectArea_districtName(String cityCode);

	public List<korea_admin_areaDto> selectArea_townshipName(String districtCode);

	public List<korea_admin_areaDto> selectArea_gu(String si);

	public List<korea_admin_areaDto> selectArea_dong(String string);
	
}
