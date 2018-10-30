package com.test.rememberTest.Dao.Medication_confirmation;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.rememberTest.Dto.Medication_confirmationDto;
import com.test.rememberTest.Dto.Medication_requestDto;


@Service
public class Medication_confirmationServiceImpl implements Medication_confirmationService{

	 @Autowired
	    private Medication_confirmationDao medication_confirmationDao;

	@Override
	public List<Medication_confirmationDto> Medication_confirmation_select(String request_id) {
		Map<String, Object> map = new HashMap<String, Object>();  
        map.put("request_id", request_id); 
		return medication_confirmationDao.Medication_confirmation_select(map);
	}//Medication_confirmation 정보 select(투약 확인서 셀렉(대조서 상세보기))

	@Override
	public String Medication_confirmation_select_getByteImage(String request_id) {
		Map<String, Object> map = new HashMap<String, Object>();  
        map.put("request_id", request_id); 
        return medication_confirmationDao.Medication_confirmation_select_getByteImage(map);
	}// Medication_request 의뢰서 사인 이미지 select

}
