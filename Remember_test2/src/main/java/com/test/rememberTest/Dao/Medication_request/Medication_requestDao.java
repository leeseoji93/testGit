package com.test.rememberTest.Dao.Medication_request;

import java.sql.Blob;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.test.rememberTest.Dto.Medication_requestDto;


public interface Medication_requestDao {

	public List<Medication_requestDto> Medication_requestDao_select(Map<String, Object> map);//Medication_requestDao 정보 select(투약 대조서 반별/월별 리스트 출력시),(투약일지상세정보 폼으로 페이지전환)
	
	public List<Medication_requestDto> Medication_requestDao_requestselect(Map<String, Object> map);	//Medication_request 정보 select(대조서의 투약의뢰서 정보(상세정보))
	
	public List<Medication_requestDto> Medication_requestDao_select_DownData(Map<String, Object> map);//Medication_request 정보 select(대조서 다운로드)
	
	public List<Medication_requestDto> Medication_requestDao_select_diaryDown(Map<String, Object> map);//Medication_request 정보 select(일지 다운로드)

	public String Medication_requestDao_select_getByteImage(Map<String, Object> map);// Medication_request 의뢰서 사인 이미지 select

	public List<Medication_requestDto> Medication_requestLatestList(Map<String, Object> map);

}