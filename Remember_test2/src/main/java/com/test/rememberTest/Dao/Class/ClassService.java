package com.test.rememberTest.Dao.Class;

import java.util.List;
import java.util.Map;

import com.test.rememberTest.Dto.BusRouteDto;
import com.test.rememberTest.Dto.ClassDto;
import com.test.rememberTest.Dto.KidDto;



public interface ClassService {

	void addClass(ClassDto classDto);

	List<ClassDto> selectMaxClass_id(String code);

	List<ClassDto> allClassList(String center_code);

	List<ClassDto> detailClass(String center_code, String class_id);

	int deleteClass(String center_code, String classId);

	List<ClassDto> searchClass(String searchName, String center_code);

	void updateClass(ClassDto classDto);

	List<KidDto> getKidAge(String center_code);
	
	public List<ClassDto> Class_Select_AllList(String center_code); //해당 센터 반 리스트 셀렉

	List<ClassDto> getMyClassInfo(String id);
}
