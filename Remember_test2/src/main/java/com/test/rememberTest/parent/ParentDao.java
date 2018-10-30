package com.test.rememberTest.parent;

import java.util.List;
import java.util.Map;

import com.test.rememberTest.Dto.BusRouteDto;
import com.test.rememberTest.Dto.ParentDto;


public interface ParentDao {

	List<ParentDto> getAllParent(Map<String, Object> map);

	int updateStater(Map<String, Object> map);

	List<ParentDto> getKidsParent(Map<String, Object> map);

	List<ParentDto> getAllParent_sort(Map<String, Object> map);

}
