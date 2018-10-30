package com.test.rememberTest.Dao.Car;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.rememberTest.Dto.Car;
import com.test.rememberTest.Dto.StationInfo;

@Repository
public class CarDaoImpl implements CarDao{
	private final String NS = "com.test.rememberTest.Map.UserMapper";
	
	 @Autowired 
	    private SqlSessionTemplate sqlSession;

	@Override
	public List<Car> selectCar(Map<String, Object> map) {	
		return sqlSession.selectList(NS+".selectCar",map);		
	}
	@Override
	public void insertCar(Car car) {		
		sqlSession.insert(NS+".insertCar", car);
	}
	@Override
	public List<Car> keyWordSelect(Map<String, Object> map) {		
		return sqlSession.selectList(NS+".keyWordSelect", map);
	}
	@Override
	public List<Car> selectDetailCar(Map<String, Object> map) {
		return sqlSession.selectList(NS+".selectDetailCar", map);
	}
	@Override
	public void deleteCar(Map<String, Object> map) {
		sqlSession.delete(NS+".deleteCar", map)	;	
	}
	@Override
	public void updateCar(Car car) {
		sqlSession.update(NS+".updateCar",car);
		
	}
	@Override
	public List<Car> selectBaseData(Map<String, Object> map) {		
		return sqlSession.selectList(NS+".selectBaseData",map);
	}

	@Override
	public List<Car> selectMaxBus_id(Map<String, Object> map) {
		return sqlSession.selectList(NS+".selectMaxBus_id",map);
	}//버스 아이디 MAX 값 찾기
	
	
}
