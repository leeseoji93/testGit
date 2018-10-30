package com.test.rememberTest.Dao.OnOff;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.rememberTest.Dto.EquipmentDto;
import com.test.rememberTest.Dto.OnOffDto;



@Repository
public class OnOffImpl implements OnOffDao{
	private final String NS = "com.test.rememberTest.Map.UserMapper";
	
	 @Autowired 
	    private SqlSessionTemplate sqlSession;
	 
	@Override
	public List<OnOffDto> OnOff_select_onoffData(Map<String, Object> map) {		
		return sqlSession.selectList(NS+".OnOff_select_onoffData", map);
	}//선택한 노선의 승차/하차 이력

	@Override
	public List<OnOffDto> attendance_history_select_onoffData(Map<String, Object> map) {
		return sqlSession.selectList(NS+".attendance_history_select_onoffData", map);
	}//선택한 반 등하원 이력

	@Override
	public List<OnOffDto> attendance_history_select_onoffDataGroup(Map<String, Object> map) {
		return sqlSession.selectList(NS+".attendance_history_select_onoffDataGroup", map);
	}

	@Override
	public List<OnOffDto> OnOff_select_onoffDataGroup(Map<String, Object> map) {
		System.out.println(map);
		return sqlSession.selectList(NS+".OnOff_select_onoffDataGroup", map);
	}

}
