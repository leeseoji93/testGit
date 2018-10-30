package com.test.rememberTest.Dao.Center_Code;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.rememberTest.Dto.BusRouteDto;
import com.test.rememberTest.Dto.Center_CodeDto;


@Service
public class Center_CodeServiceImpl implements Center_CodeService{

	@Autowired
	private Center_CodeDao center_CodeDao;

	@Override
	public List<Center_CodeDto> selectCode(String adminArea) {
		Map<String, Object> map = new HashMap<String, Object>();       
        map.put("adminArea", adminArea);
		return center_CodeDao.selectCode(map);
	}
}
