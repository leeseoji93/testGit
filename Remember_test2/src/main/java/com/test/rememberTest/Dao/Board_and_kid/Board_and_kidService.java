package com.test.rememberTest.Dao.Board_and_kid;

import java.util.List;
import java.util.Map;

import com.test.rememberTest.Dto.Board_and_kidDto;


public interface Board_and_kidService {

	public void Board_and_kid_delete(String route_id);

	public void Board_and_kid_insert(Board_and_kidDto board_and_kidDto, String center_code);
	
	public List<Board_and_kidDto> Board_and_kid_select_routeData(String route_id);//선택된 노선 Board_and_kid_insert 정보 셀렉
}
