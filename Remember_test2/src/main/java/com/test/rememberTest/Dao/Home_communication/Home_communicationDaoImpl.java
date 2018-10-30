package com.test.rememberTest.Dao.Home_communication;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.rememberTest.Dto.Home_communicationDto;
import com.test.rememberTest.Dto.KidDto;

@Repository
public class Home_communicationDaoImpl implements Home_communicationDao {
	private final String NS = "com.test.rememberTest.Map.UserMapper";

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<Home_communicationDto> Home_communicationDao_select_communication_tagData() {		
		return sqlSession.selectList(NS + ".Home_communicationDao_select_communication_tagData");
	}//communication_tag 목록 셀렉

	@Override
	public void Home_communicationDao_insert_home_communicationInsert(Home_communicationDto home_communicationDto) {		
		sqlSession.insert(NS + ".Home_communicationDao_insert_home_communicationInsert",home_communicationDto);
	}//home_communication insert

	@Override
	public void Home_communicationDao_insert_communication_pictureInsert(Map<String, Object> hmap) {
		sqlSession.insert(NS + ".Home_communicationDao_insert_communication_pictureInsert",hmap);
	}//communication_picture insert

	@Override
	public String Home_communicationDao_select_communication_Maxcount(String center_code) {		
		return sqlSession.selectOne(NS + ".Home_communicationDao_select_communication_Maxcount",center_code);
	}//home_communication max 값 검사

	@Override
	public void Home_communicationDao_insert_communication_fileInsert(Map<String, Object> hmap) {		
		sqlSession.insert(NS + ".Home_communicationDao_insert_communication_fileInsert",hmap);
	}//file_attachement insert

	@Override
	public void Home_communicationDao_insert_communication_transInsert(Map<String, Object> hmap) {
		sqlSession.insert(NS + ".Home_communicationDao_insert_communication_transInsert",hmap);		
	}//homecommunication_trans insert

	@Override
	public List<Home_communicationDto> Home_communicationDao_select_classCommunicationList(Map<String, Object> hmap) {
		return sqlSession.selectList(NS + ".Home_communicationDao_select_classCommunicationList",hmap);		
	}//해당 클래스 가정통신문 목록 셀렉

	@Override
	public List<Home_communicationDto> Home_communicationDao_select_CommunicationDetailList(Map<String, Object> hmap) {
		return sqlSession.selectList(NS + ".Home_communicationDao_select_CommunicationDetailList",hmap);
	}//선택된 가정 통신문 상세 정보

	@Override
	public List<Home_communicationDto> Home_communication_select_CommunicationPicture(Map<String, Object> hmap) {
		return sqlSession.selectList(NS + ".Home_communication_select_CommunicationPicture",hmap);
	}//선택된 가정통신문 이미지

	@Override
	public List<Home_communicationDto> Home_communication_select_CommunicationFile(Map<String, Object> hmap) {
		return sqlSession.selectList(NS + ".Home_communication_select_CommunicationFile",hmap);
	}//선택된 가정통신문 파일

	@Override
	public List<Home_communicationDto> Home_communication_select_transDetailList(Map<String, Object> hmap) {
		return sqlSession.selectList(NS + ".Home_communication_select_transDetailList",hmap);
	} //선택된 가정 통신문 확인여부 조회

	@Override
	public void Home_communicationDao_update_home_communicationUpdate(Home_communicationDto home_communicationDto) {
		sqlSession.insert(NS + ".Home_communicationDao_update_home_communicationUpdate",home_communicationDto);
	}//home_communication update

	@Override
	public void Home_communicationDao_delete_home_communicationDelete(String communication_id) {
		sqlSession.delete(NS + ".Home_communicationDao_delete_home_communicationDelete",communication_id);
	}//home_communication delete

	@Override
	public List<Home_communicationDto> home_communi_LatestList(String class_id) {
		return sqlSession.selectList(NS + ".home_communi_LatestList",class_id);
	}


}
