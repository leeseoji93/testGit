package com.test.rememberTest.Dao.Station;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.rememberTest.Dto.StationInfo;

@Repository
public class StationDaoImpl implements StationDao{
	private final String NS = "com.test.rememberTest.Map.UserMapper";
    @Autowired 
    private SqlSessionTemplate sqlSession;

	@Override
	public Object insertStation(StationInfo stationInfo) {
		return sqlSession.insert(NS+".insertStation", stationInfo);
	}
	
	@Override
	public List<StationInfo> selectStationUseList(Map<String, Object> map) {
		return sqlSession.selectList(NS+".selectStationUseList",map);
	}
	
	@Override
	public List<StationInfo> selectStationList(Map<String, Object> map) {
		 return sqlSession.selectList(NS+".selectStationList",map);
	}

	@Override
	public StationInfo selectDetailStation(String station_id) {
		return sqlSession.selectOne(NS+".selectDetailStation",station_id);
	}

	@Override
	public int deleteStation(String station_id) {
		return sqlSession.delete(NS+".deleteStation", station_id);
	}

	@Override
	public Object updateStation(StationInfo stationInfo) {
		return sqlSession.insert(NS+".updateStation", stationInfo);
	}

	@Override
	public List<StationInfo> searchStation(Map<String, Object> map) {
		return sqlSession.selectList(NS+".searchStation", map);
	}

	@Override
	public StationInfo chkStName(String stName) {
		return sqlSession.selectOne(NS+".chkStName",stName);
	}

	@Override
	public int stationCount(int stationCnt) {
		return sqlSession.selectOne(NS+".stationCount",stationCnt);
	}

	@Override
	public List<StationInfo> selectMaxStation_id(Map<String, Object> map) {
		return sqlSession.selectList(NS+".selectMaxStation_id",map);
	}

	



//	@Override
//	public int insertStation(String stName, String stWriter, String stload1, String stload2) {
//		// TODO Auto-generated method stub
//		return sqlSession.insert(NS+".insertStation", stName,stWriter,stload1,stload1,);
//	}

}
