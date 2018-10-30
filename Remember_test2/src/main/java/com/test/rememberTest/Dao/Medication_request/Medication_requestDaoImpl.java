package com.test.rememberTest.Dao.Medication_request;

import java.sql.Blob;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.rememberTest.Dto.Medication_requestDto;


@Repository
public class Medication_requestDaoImpl implements Medication_requestDao{
	private final String NS = "com.test.rememberTest.Map.UserMapper";
	
	 @Autowired 
	    private SqlSessionTemplate sqlSession;

	@Override
	public List<Medication_requestDto> Medication_requestDao_select(Map<String, Object> map) {
		return sqlSession.selectList(NS+".Medication_requestDao_select", map);		
	}//Medication_requestDao 정보 select(투약 대조서 반별/월별 리스트 출력시),(투약일지상세정보 폼으로 페이지전환)

	@Override
	public List<Medication_requestDto> Medication_requestDao_requestselect(Map<String, Object> map) {		
		return sqlSession.selectList(NS+".Medication_requestDao_requestselect", map);
	}//Medication_requestDao 정보 select(대조서 상세보기)

	@Override
	public List<Medication_requestDto> Medication_requestDao_select_DownData(Map<String, Object> map) {
		
		return sqlSession.selectList(NS+".Medication_requestDao_select_DownData", map);
	}//Medication_request 정보 select(대조서 다운로드)

	@Override
	public List<Medication_requestDto> Medication_requestDao_select_diaryDown(Map<String, Object> map) {
		return sqlSession.selectList(NS+".Medication_requestDao_select_diaryDown", map);
	}//Medication_request 정보 select(일지 다운로드)

	@Override
	public String Medication_requestDao_select_getByteImage(Map<String, Object> map) {
		return sqlSession.selectOne(NS+".Medication_requestDao_select_getByteImage", map);
	}// Medication_request 의뢰서 사인 이미지 select

	@Override
	public List<Medication_requestDto> Medication_requestLatestList(Map<String, Object> map) {
		return sqlSession.selectList(NS+".Medication_requestLatestList", map);
	}//Medication_request 대쉬보드 최근3개
}
