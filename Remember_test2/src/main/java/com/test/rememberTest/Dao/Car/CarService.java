package com.test.rememberTest.Dao.Car;

import java.util.List;

import com.test.rememberTest.Dto.Car;

public interface CarService {
	
	public List<Car> getCarList(String center_code);//차량 리스트 출력
	public void  setCarList(Car car);//차량 등록
	public List<Car> keyWordSearchList(String center_code,String word);//키워드 검색
	public List<Car> getDetailCarList(String word);//상세정보 조회
	public void setDeleteCar(String word);//차량 정보 삭제
	
	public List<Car> getBaseData(String word);//차량 정보 수정(기본데이터)
	public void setUpdateCar(Car car);//차량 정보 수정(수정데이터)

	public List<Car> selectMaxBus_id(String word);//버스 아이디 MAX 값 찾기
	
}
