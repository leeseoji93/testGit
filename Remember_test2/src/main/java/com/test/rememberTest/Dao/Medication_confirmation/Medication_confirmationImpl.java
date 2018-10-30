package com.test.rememberTest.Dao.Medication_confirmation;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.rememberTest.Dto.Medication_confirmationDto;
import com.test.rememberTest.Dto.Medication_requestDto;


@Repository
public class Medication_confirmationImpl implements Medication_confirmationDao{
	private final String NS = "com.test.rememberTest.Map.UserMapper";
	
	 @Autowired 
	    private SqlSessionTemplate sqlSession;

	@Override
	public List<Medication_confirmationDto> Medication_confirmation_select(Map<String, Object> map) {
		return sqlSession.selectList(NS+".Medication_confirmation_select", map);
	}//Medication_confirmation 정보 select(투약 확인서 셀렉(대조서 상세보기))

	@Override
	public String Medication_confirmation_select_getByteImage(Map<String, Object> map) {
		return sqlSession.selectOne(NS+".Medication_confirmation_select_getByteImage", map);
	}// Medication_request 의뢰서 사인 이미지 select

	
}
