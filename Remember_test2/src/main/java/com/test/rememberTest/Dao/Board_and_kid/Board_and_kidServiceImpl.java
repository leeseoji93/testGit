package com.test.rememberTest.Dao.Board_and_kid;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.rememberTest.Dto.Board_and_kidDto;

@Service
public class Board_and_kidServiceImpl implements Board_and_kidService{

	 @Autowired
	    private Board_and_kidDao board_and_kidDao;

	@Override
	public void Board_and_kid_delete(String route_id) {
		Map<String, Object> map = new HashMap<String, Object>();       
        map.put("route_id", route_id);	
		board_and_kidDao.Board_and_kid_delete(map);	
	}	//Board_and_kid_delete 정보 삭제

	@Override
	public void Board_and_kid_insert(Board_and_kidDto board_and_kidDto,String center_code) {

		Map<String, Object> map = new HashMap<String, Object>();  
		
		Map<String, Object> dtomap;
		 List<Map<String, Object>> dtoList = new ArrayList<Map<String, Object>>();
		 
		for(int i=0; i<board_and_kidDto.getBoard_and_kidDto().size(); i++) {
			String ksc = board_and_kidDto.getBoard_and_kidDto().get(i).getKid_system_code();
			String[] array = ksc.split(",");
			for (int j = 0; j < array.length; j++) {
				dtomap = new HashMap<String, Object>();
				
				dtomap.put("route_id", board_and_kidDto.getRoute_id());	
				dtomap.put("station_id", board_and_kidDto.getBoard_and_kidDto().get(i).getStation_id());
				dtomap.put("affiliation", center_code);
				dtomap.put("kid_system_code", array[j]);			
					        
				dtoList.add(dtomap);
			}
			
		}
		map.put("dtoList", dtoList);
		board_and_kidDao.Board_and_kid_insert(map);		
	}//Board_and_kid_insert 정보 입력
	
	@Override
	public List<Board_and_kidDto> Board_and_kid_select_routeData(String route_id) {
		Map<String, Object> map = new HashMap<String, Object>();       
        map.put("route_id", route_id);	
		return board_and_kidDao.Board_and_kid_select_routeData(map);
	}//선택된 노선 Board_and_kid_insert 정보 셀렉
}
