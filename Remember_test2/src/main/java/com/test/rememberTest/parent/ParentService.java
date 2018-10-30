package com.test.rememberTest.parent;

import java.util.List;
import java.util.Map;

import com.test.rememberTest.Dto.BusRouteDto;
import com.test.rememberTest.Dto.ParentDto;



public interface ParentService {

	List<ParentDto> getAllParent(String center_code);

	int updateStater(String center_code, String par_id, String stater, String kid_code);

	List<ParentDto> getKidsParent(String center_code, String kidCode);

	List<ParentDto> getAllParent_sort(String center_code, String orderBy_type, String obj);
	
}
