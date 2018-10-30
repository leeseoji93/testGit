package com.test.rememberTest.Dao.Car;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.rememberTest.Dto.Car;

@Service
public class CarServiceImpl implements CarService{

	 @Autowired
	    private CarDao carDao;
	
	 @Override
	    public List<Car> getCarList(String center_code) {
		 	Map<String, Object> map = new HashMap<String, Object>();       
	        map.put("center_code", center_code);
	        return carDao.selectCar(map);
	    }

	@Override
	public void setCarList(Car car) {
		carDao.insertCar(car);		
	}

	@Override
	public List<Car> keyWordSearchList(String center_code,String word) {
		
		Map<String, Object> map = new HashMap<String, Object>(); 
		 map.put("center_code", center_code);
        map.put("keyWord", word);
        return carDao.keyWordSelect(map);
	}

	@Override
	public List<Car> getDetailCarList(String word) {
		Map<String, Object> map = new HashMap<String, Object>();       
        map.put("word", word);
        return carDao.selectDetailCar(map);
	}

	@Override
	public void setDeleteCar(String word) {
		Map<String, Object> map = new HashMap<String, Object>();  
		
        map.put("word", word);       
		carDao.deleteCar(map);
		
	}

	@Override
	public void setUpdateCar(Car car) {		
		carDao.updateCar(car);		
	}

	@Override
	public List<Car> getBaseData(String word) {
		Map<String, Object> map = new HashMap<String, Object>();       
        map.put("word", word); 
		return carDao.selectBaseData(map);
	}

	@Override
	public List<Car> selectMaxBus_id(String word) {		
		Map<String, Object> map = new HashMap<String, Object>();       
        map.put("word", word); 
		return carDao.selectMaxBus_id(map);
	}//버스 아이디 MAX 값 찾기

	
	
}
