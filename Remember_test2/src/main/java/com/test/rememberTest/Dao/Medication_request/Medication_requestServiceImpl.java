package com.test.rememberTest.Dao.Medication_request;

import java.sql.Blob;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.rememberTest.Dto.Medication_requestDto;


@Service
public class Medication_requestServiceImpl implements Medication_requestService{

	 @Autowired
	    private Medication_requestDao medication_requestDao;

	@Override
	public List<Medication_requestDto> Medication_requestDao_select(String class_id, String date) {
		Map<String, Object> map = new HashMap<String, Object>();  
        map.put("class_id", class_id); 
        map.put("date", date); 
		return medication_requestDao.Medication_requestDao_select(map);
	}//Medication_requestDao 정보 select(투약 대조서 반별/월별 리스트 출력시),(투약일지상세정보 폼으로 페이지전환)

	@Override
	public List<Medication_requestDto> Medication_requestDao_requestselect(String request_id) {
		Map<String, Object> map = new HashMap<String, Object>();  
        map.put("request_id", request_id); 
		return medication_requestDao.Medication_requestDao_requestselect(map);
	}//Medication_requestDao 정보 select(대조서 상세보기)

	@Override
	public List<Medication_requestDto> Medication_requestDao_select_DownData(String[] request_id) {
		Map<String, Object> map = new HashMap<String, Object>();  
        map.put("request_id", request_id);
		return medication_requestDao.Medication_requestDao_select_DownData(map);
	}//Medication_request 정보 select(대조서 다운로드)

	@Override
	public List<Medication_requestDto> Medication_requestDao_select_diaryDown(String[] date, String class_id) {
		Map<String, Object> map = new HashMap<String, Object>();  
        map.put("date", date);
        map.put("class_id", class_id);
		return medication_requestDao.Medication_requestDao_select_diaryDown(map);
	}//Medication_request 정보 select(일지 다운로드)

	@Override
	public String Medication_requestDao_select_getByteImage(String request_id) {
		Map<String, Object> map = new HashMap<String, Object>();  
        map.put("request_id", request_id);
		return medication_requestDao.Medication_requestDao_select_getByteImage(map);
	}// Medication_request 의뢰서 사인 이미지 select

	@Override
	public List<Medication_requestDto> Medication_requestLatestList(String class_id,String center_code) {
		 Map<String, Object> map = new HashMap<String, Object>();  
        map.put("class_id", class_id);
        map.put("center_code", center_code);
		return medication_requestDao.Medication_requestLatestList(map);
	}//최근 3개

}
