package com.test.rememberTest.Dao.Center_Code;

import java.util.List;
import java.util.Map;

import com.test.rememberTest.Dto.BusRouteDto;
import com.test.rememberTest.Dto.Center_CodeDto;


public interface Center_CodeDao {

	public List<Center_CodeDto> selectCode(Map<String, Object> map);
	
}

