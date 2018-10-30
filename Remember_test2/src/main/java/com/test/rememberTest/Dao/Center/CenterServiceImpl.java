package com.test.rememberTest.Dao.Center;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.rememberTest.Dto.CenterDto;

@Service
public class CenterServiceImpl implements CenterService{
	
	@Autowired
	private CenterDao centerDao;
	
	@Override
	public List<CenterDto> selectCenter_Addr(String code) {
		System.out.println("centerServiceImpl122에서 selectCenter_Addr시작 :"+code);
		Map<String, Object> map = new HashMap<String, Object>();       
        map.put("word", code); 
		return centerDao.selectCenter_Addr(map);
	}

	@Override
	public List<CenterDto> Center_selectDataPosition(String code) {
		Map<String, Object> map = new HashMap<String, Object>();       
        map.put("code", code);       
        return centerDao.Center_selectDataPosition(map);        		
	}

	@Override
	public void addCenter(CenterDto centerForm) {
		System.out.println("Latitude:"+centerForm.getLatitude());
		System.out.println("Longitude:"+centerForm.getLongitude());
		centerDao.insertCenter(centerForm);	
	}

	@Override
	public void addCenterCode(CenterDto centerForm) {
		centerDao.insertCenterCode(centerForm);
	}

	@Override
	public List<CenterDto> detailCenter(String center_code) {
		Map<String, Object> map = new HashMap<String, Object>();       
        map.put("center_code", center_code);       
        return centerDao.detailCenter(map);   
	}

	@Override
	public void UpdateCenter(CenterDto centerDto) {
		centerDao.UpdateCenter(centerDto);
	}

}
