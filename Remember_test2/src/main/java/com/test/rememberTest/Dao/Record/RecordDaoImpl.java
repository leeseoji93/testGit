package com.test.rememberTest.Dao.Record;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.rememberTest.Dto.BusRouteDto;
import com.test.rememberTest.Dto.RecordDto;


@Repository
public class RecordDaoImpl implements RecordDao{
	private final String NS = "com.test.rememberTest.Map.UserMapper";
	
	 @Autowired  	
	    private SqlSessionTemplate sqlSession;

	@Override
	public List<RecordDto> selectRecordRoute(Map<String, Object> map) {
		return sqlSession.selectList(NS+".selectRecordRoute",map);
	}

	@Override
	public List<RecordDto> selectRecordDriv_Doc(Map<String, Object> map) {
		return sqlSession.selectList(NS+".selectRecordDriv_Doc",map);
	}

	@Override
	public List<RecordDto> selectDetailRecordList(Map<String, Object> map) {
		return sqlSession.selectList(NS+".selectDetailRecordList",map);
	}

	@Override
	public List<RecordDto> selectRecord_DownData(Map<String, Object> map) {
		return sqlSession.selectList(NS+".selectRecord_DownData",map);
	}

	@Override
	public List<RecordDto> latest_RecordDriv_Doc(String center_code) {
		return sqlSession.selectList(NS+".latest_RecordDriv_Doc",center_code);
	}

	
}
