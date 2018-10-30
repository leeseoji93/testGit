package com.test.rememberTest.Dao.Home_communication;
import java.util.List;
import java.util.Map;

import com.test.rememberTest.Dto.Home_communicationDto;

public interface Home_communicationDao {

	//communication_tag 관련
	public List<Home_communicationDto> Home_communicationDao_select_communication_tagData(); //communication_tag 목록 셀렉
	
	//home_communication 관련
	public void Home_communicationDao_insert_home_communicationInsert(Home_communicationDto home_communicationDto); //home_communication insert
	
	public String Home_communicationDao_select_communication_Maxcount(String center_code);//home_communication max 값 검사
	
	public List<Home_communicationDto> Home_communicationDao_select_classCommunicationList(Map<String, Object> hmap);//해당 클래스 가정통신문 목록 셀렉
	
	public List<Home_communicationDto> Home_communicationDao_select_CommunicationDetailList(Map<String, Object> hmap);//선택된 가정 통신문 상세 정보
	
	public void Home_communicationDao_update_home_communicationUpdate(Home_communicationDto home_communicationDto); //home_communication update
	
	public void Home_communicationDao_delete_home_communicationDelete(String communication_id); //home_communication delete
	
	//communication_picture 관련
//	public void Home_communicationDao_insert_communication_pictureInsert(Home_communicationDto home_communicationDto); //communication_picture insert
	public void Home_communicationDao_insert_communication_pictureInsert(Map<String, Object> hmap); //communication_picture insert
	
	public List<Home_communicationDto>  Home_communication_select_CommunicationPicture(Map<String, Object> hmap);//선택된 가정통신문 이미지

	//file_attachement 관련
	public void Home_communicationDao_insert_communication_fileInsert(Map<String, Object> hmap); //file_attachement insert
	
	public List<Home_communicationDto>  Home_communication_select_CommunicationFile(Map<String, Object> hmap);//선택된 가정통신문 파일
	
	//homecommunication_trans 관련
	public void Home_communicationDao_insert_communication_transInsert(Map<String, Object> hmap); //homecommunication_trans insert
	
	public List<Home_communicationDto> Home_communication_select_transDetailList(Map<String, Object> hmap); //선택된 가정 통신문 확인여부 조회

	public List<Home_communicationDto> home_communi_LatestList(String class_id);
}
