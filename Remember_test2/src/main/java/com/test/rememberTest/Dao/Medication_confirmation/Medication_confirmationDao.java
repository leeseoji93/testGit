package com.test.rememberTest.Dao.Medication_confirmation;

import java.util.List;
import java.util.Map;

import com.test.rememberTest.Dto.Medication_confirmationDto;


public interface Medication_confirmationDao {

	public List<Medication_confirmationDto> Medication_confirmation_select(Map<String, Object> map);//Medication_confirmation 정보 select(투약 확인서 셀렉(대조서 상세보기))
	
	public String Medication_confirmation_select_getByteImage(Map<String, Object> map);// Medication_request 의뢰서 사인 이미지 select
}
