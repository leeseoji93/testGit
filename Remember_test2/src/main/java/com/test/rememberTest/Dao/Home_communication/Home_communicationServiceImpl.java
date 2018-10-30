package com.test.rememberTest.Dao.Home_communication;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.rememberTest.Dto.Home_communicationDto;
import com.test.rememberTest.Dto.KidDto;

@Service
public class Home_communicationServiceImpl implements Home_communicationService {

	@Autowired
	private Home_communicationDao home_communicationDao;

	@Override
	public List<Home_communicationDto> Home_communicationDao_select_communication_tagData() {
		return home_communicationDao.Home_communicationDao_select_communication_tagData();
	}//communication_tag 목록 셀렉

	@Override
	public void Home_communicationDao_insert_home_communicationInsert(Home_communicationDto home_communicationDto) {
		home_communicationDao.Home_communicationDao_insert_home_communicationInsert(home_communicationDto);
	}//home_communication insert

	@Override
	public void Home_communicationDao_insert_communication_pictureInsert(List<String> image_url, String communication_id) {
		Map<String, Object> map = new HashMap<String, Object>();       
        map.put("image_url", image_url);
        map.put("communication_id", communication_id);
		home_communicationDao.Home_communicationDao_insert_communication_pictureInsert(map);
	}//communication_picture insert

	@Override
	public String Home_communicationDao_select_communication_Maxcount(String center_code) {
		return home_communicationDao.Home_communicationDao_select_communication_Maxcount(center_code);
	}//home_communication max 값 검사

	@Override
	public void Home_communicationDao_insert_communication_fileInsert(List<String> file_url, String communication_id,
			List<String> title) {
//		Map<String, Object> map = new HashMap<String, Object>();       
//        map.put("file_url", file_url);
//        map.put("communication_id", communication_id);
//        map.put("title", title);
        
		Map<String, Object> map = new HashMap<String, Object>();  
		
		Map<String, Object> dtomap;
		 List<Map<String, Object>> dtoList = new ArrayList<Map<String, Object>>();
		 
		for(int i=0; i<file_url.size(); i++) {
			dtomap = new HashMap<String, Object>();
			
			dtomap.put("file_url", file_url.get(i));	
			dtomap.put("communication_id", communication_id);
			dtomap.put("title", title.get(i));			
				        
			dtoList.add(dtomap);			
		}
		map.put("dtoList", dtoList);        
		home_communicationDao.Home_communicationDao_insert_communication_fileInsert(map);
	}
	//file_attachement insert

	@Override
	public void Home_communicationDao_insert_communication_transInsert(List<KidDto> KidList, String communication_id,
			String center_code) {		
		Map<String, Object> map = new HashMap<String, Object>();       
        map.put("KidList", KidList);
        map.put("communication_id", communication_id);
        map.put("center_code", center_code);
		home_communicationDao.Home_communicationDao_insert_communication_transInsert(map);
	}//homecommunication_trans insert

	@Override
	public List<Home_communicationDto> Home_communicationDao_select_classCommunicationList(String class_id,String date) {
		Map<String, Object> map = new HashMap<String, Object>();       
        map.put("class_id", class_id);
        map.put("date", date);
		return home_communicationDao.Home_communicationDao_select_classCommunicationList(map);
	}//해당 클래스 가정통신문 목록 셀렉

	@Override
	public List<Home_communicationDto> Home_communicationDao_select_CommunicationDetailList(String communication_id) {
		Map<String, Object> map = new HashMap<String, Object>();       
        map.put("communication_id", communication_id);
		return home_communicationDao.Home_communicationDao_select_CommunicationDetailList(map);
	}//선택된 가정 통신문 상세 정보

	@Override
	public List<Home_communicationDto> Home_communication_select_CommunicationPicture(String communication_id) {
		Map<String, Object> map = new HashMap<String, Object>();       
        map.put("communication_id", communication_id);
		return home_communicationDao.Home_communication_select_CommunicationPicture(map);
	}//선택된 가정통신문 이미지

	@Override
	public List<Home_communicationDto> Home_communication_select_CommunicationFile(String communication_id) {
		Map<String, Object> map = new HashMap<String, Object>();       
        map.put("communication_id", communication_id);
        return home_communicationDao.Home_communication_select_CommunicationFile(map);
	}//선택된 가정통신문 파일

	@Override
	public List<Home_communicationDto> Home_communication_select_transDetailList(String communication_id) {
		Map<String, Object> map = new HashMap<String, Object>();       
        map.put("communication_id", communication_id);
		return home_communicationDao.Home_communication_select_transDetailList(map);
	}//선택된 가정 통신문 확인여부 조회

	@Override
	public void Home_communicationDao_update_home_communicationUpdate(Home_communicationDto home_communicationDto) {
		home_communicationDao.Home_communicationDao_update_home_communicationUpdate(home_communicationDto);
	}//home_communication update

	@Override
	public void Home_communicationDao_delete_home_communicationDelete(String communication_id) {
		home_communicationDao.Home_communicationDao_delete_home_communicationDelete(communication_id);
	}//home_communication delete

	@Override
	public List<Home_communicationDto> home_communi_LatestList(String class_id) {
		return home_communicationDao.home_communi_LatestList(class_id);
	}
}
