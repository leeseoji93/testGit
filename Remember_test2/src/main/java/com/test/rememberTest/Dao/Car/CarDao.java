package com.test.rememberTest.Dao.Car;

import java.util.List;
import java.util.Map;

import com.test.rememberTest.Dto.Car;


public interface CarDao {

	public List<Car> selectCar(Map<String, Object> map); //차량 정보 조회 전체 리스트 출력
	
	public List<Car> selectDetailCar(Map<String, Object> map);//차량 상세정보
	
	public void insertCar(Car car);	//차량 정보 입력
	
	public List<Car> keyWordSelect(Map<String, Object> map);//차량 정보 키워드 검색
	
	public void deleteCar(Map<String, Object> map); //차량 정보 삭제
	
	public List<Car> selectBaseData(Map<String, Object> map); //차량 정보 수정(기본데이터)
	
	public void updateCar(Car car); //차량 정보 수정(수정데이터)	

	public List<Car> selectMaxBus_id(Map<String, Object> map);//버스 아이디 MAX 값 찾기


}
