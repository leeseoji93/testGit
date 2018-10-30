package com.test.rememberTest.Dao.Medication_request;

import java.sql.Blob;
import java.util.List;
import java.util.Map;

import com.test.rememberTest.Dto.Medication_requestDto;

public interface Medication_requestService {
	public List<Medication_requestDto> Medication_requestDao_select(String class_id, String date);	//Medication_requestDao 정보 select(투약 대조서 반별/월별 리스트 출력시),(투약일지상세정보 폼으로 페이지전환)
	
	public List<Medication_requestDto> Medication_requestDao_requestselect(String request_id);	//Medication_requestDao 정보 select(대조서의 투약의뢰서 정보(상세정보))
	
	public List<Medication_requestDto> Medication_requestDao_select_DownData(String[] request_id);//Medication_request 정보 select(대조서 다운로드)
	
	public List<Medication_requestDto> Medication_requestDao_select_diaryDown(String[] date,String class_id);//Medication_request 정보 select(일지 다운로드)
	
	public String Medication_requestDao_select_getByteImage(String request_id);// Medication_request 의뢰서 사인 이미지 select

	public List<Medication_requestDto> Medication_requestLatestList(String class_id,String center_code);
}


