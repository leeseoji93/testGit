package com.test.rememberTest.Dao.Class;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.rememberTest.Dto.BusRouteDto;
import com.test.rememberTest.Dto.ClassDto;
import com.test.rememberTest.Dto.KidDto;


@Service
public class ClassServiceImpl implements ClassService{

	 @Autowired
	    private ClassDao classDao;

	@Override
	public void addClass(ClassDto classDto) {
		classDao.addClass(classDto);
	}

	@Override
	public List<ClassDto> selectMaxClass_id(String code) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", code);
		return classDao.MaxClass_id(map);
	}

	@Override
	public List<ClassDto> allClassList(String center_code) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("center_code", center_code);
		return classDao.allClassList(map);
	}

	@Override
	public List<ClassDto> detailClass(String center_code, String class_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("center_code", center_code);
		map.put("class_id", class_id);
		return classDao.detailClass(map);
	}

	@Override
	public int deleteClass(String center_code, String classId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("center_code", center_code);
		map.put("class_id", classId);
		return classDao.deleteClass(map);
	}

	@Override
	public List<ClassDto> searchClass(String keyWord, String center_code) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("keyWord", keyWord);
		map.put("center_code", center_code);
		return classDao.searchClass(map);
	}

	@Override
	public void updateClass(ClassDto classDto) {
		classDao.updateClass(classDto);
	}

	@Override
	public List<KidDto> getKidAge(String center_code) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("center_code", center_code);
		return classDao.selectKidAge(map);
	}
	
	@Override
	public List<ClassDto> Class_Select_AllList(String center_code) {
		Map<String, Object> map = new HashMap<String, Object>();       
        map.put("center_code", center_code);	

		return classDao.Class_Select_AllList(map);
	} //해당 센터 반 리스트 셀렉

	@Override
	public List<ClassDto> getMyClassInfo(String id) {

		return classDao.getMyClassInfo(id);
	}

		

}
