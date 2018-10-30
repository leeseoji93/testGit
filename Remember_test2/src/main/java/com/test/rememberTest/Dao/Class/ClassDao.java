package com.test.rememberTest.Dao.Class;

import java.util.List;
import java.util.Map;

import com.test.rememberTest.Dto.BusRouteDto;
import com.test.rememberTest.Dto.ClassDto;
import com.test.rememberTest.Dto.KidDto;


public interface ClassDao {

	void addClass(ClassDto classDto);

	List<ClassDto> MaxClass_id(Map<String, Object> map);

	List<ClassDto> allClassList(Map<String, Object> map);

	List<ClassDto> detailClass(Map<String, Object> map);

	int deleteClass(Map<String, Object> map);

	List<ClassDto> searchClass(Map<String, Object> map);

	void updateClass(ClassDto classDto);

	List<KidDto> selectKidAge(Map<String, Object> map);
	
	public List<ClassDto> Class_Select_AllList(Map<String, Object> map); //해당 센터 반 리스트 셀렉

	List<ClassDto> getMyClassInfo(String id);

}
