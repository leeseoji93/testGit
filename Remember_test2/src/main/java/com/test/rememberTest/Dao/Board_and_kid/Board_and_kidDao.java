package com.test.rememberTest.Dao.Board_and_kid;

import java.util.List;
import java.util.Map;

import com.test.rememberTest.Dto.Board_and_kidDto;

public interface Board_and_kidDao {
	public void Board_and_kid_insert(Map<String, Object> map);	//Board_and_kid_insert 정보 입력

	public void Board_and_kid_delete(Map<String, Object> map);

	public List<Board_and_kidDto> Board_and_kid_select_routeData(Map<String, Object> map);
}
