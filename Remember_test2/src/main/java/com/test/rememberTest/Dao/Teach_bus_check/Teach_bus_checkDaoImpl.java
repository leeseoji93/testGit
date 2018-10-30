package com.test.rememberTest.Dao.Teach_bus_check;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.rememberTest.Dto.BusRouteDto;
import com.test.rememberTest.Dto.Teach_bus_checkDto;


@Repository
public class Teach_bus_checkDaoImpl implements Teach_bus_checkDao{
	private final String NS = "com.test.rememberTest.Map.UserMapper";
	
	 @Autowired  	
	    private SqlSessionTemplate sqlSession;

	@Override
	public List<Teach_bus_checkDto> getTeachCheckList(Map<String, Object> map) {
		return sqlSession.selectList(NS+".selectTeachCheckList", map);
	}
	
	@Override
	public List<Teach_bus_checkDto> getTeachCheckList2(Map<String, Object> map) {
		return sqlSession.selectList(NS+".selectTeachCheckList2", map);
	}

	@Override
	public List<Teach_bus_checkDto> getCheckistContent(Map<String, Object> map) {
		return sqlSession.selectList(NS+".selectCheckistContent", map);
	}

	@Override
	public List<Teach_bus_checkDto> getDailyCheckInfo(Map<String, Object> map) {
		return sqlSession.selectList(NS+".selectDailyCheckInfo", map);
	}

	@Override
	public List<Teach_bus_checkDto> getCheckListContentAll(Map<String, Object> map) {
		return sqlSession.selectList(NS+".selectCheckListContentAll", map);
	}

	@Override
	public void updateAllCheckList(Map<String, Object> map) {
		sqlSession.insert(NS+".updateAllCheckList", map);
	}

	@Override
	public void updateAllBusDailyCheck(Map<String, Object> map) {
		sqlSession.insert(NS+".updateAllBusDailyCheck", map);
	}

	@Override
	public void deleteAllCheckList(Map<String, Object> map) {
		sqlSession.delete(NS+".deleteAllCheckList", map);
	}

	@Override
	public void deleteDailyAllCheckList(Map<String, Object> map) {
		sqlSession.delete(NS+".deleteDailyAllCheckList", map);
	}

	@Override
	public List<Teach_bus_checkDto> getDetailCarInfo(Map<String, Object> map) {
		return sqlSession.selectList(NS+".getDetailCarInfo", map);
	}
	
	@Override
	public List<Teach_bus_checkDto> Teach_bus_check_select_weekdata(Map<String, Object> map) {
		return sqlSession.selectList(NS+".Teach_bus_check_select_weekdata", map);
	}

	@Override
	public List<Teach_bus_checkDto> getLatestCheckList(String center_code) {
		return sqlSession.selectList(NS+".getLatestCheckList", center_code);
	}
}
