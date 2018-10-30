package com.test.rememberTest.parent;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.rememberTest.Dto.BusRouteDto;
import com.test.rememberTest.Dto.ParentDto;


@Service
public class ParentServiceImpl implements ParentService{

	 @Autowired
	    private ParentDao parentDao;

	@Override
	public List<ParentDto> getAllParent(String center_code) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("center_code", center_code);
		return parentDao.getAllParent(map);
	}

	@Override
	public int updateStater(String center_code, String par_id, String stater,String kid_code) {
		System.out.println("center_code:"+center_code+"/par_id:"+par_id+"/stater"+stater+"/kid_code"+kid_code);
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("center_code", center_code);
		map.put("par_id", par_id);
		map.put("check_stater", stater);
		map.put("kid_system_code", kid_code);
		return parentDao.updateStater(map);
	}

	@Override
	public List<ParentDto> getKidsParent(String center_code, String kidCode) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("center_code", center_code);
		map.put("kidCode", kidCode);
		return parentDao.getKidsParent(map);
	}

	@Override
	public List<ParentDto> getAllParent_sort(String center_code, String orderBy_type, String obj) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("center_code", center_code);
		map.put("orderBy_type", orderBy_type);
		map.put("th_type", obj);
		return parentDao.getAllParent_sort(map);
	}

	

}
