package com.test.rememberTest.Dao.Staff;


import java.util.List;
import java.util.Map;

import com.test.rememberTest.Dto.MemberInfo;
import com.test.rememberTest.Dto.StaffDto;



public interface StaffService {
	
	public List<StaffDto> getStaffList(String code );
	
	public List<StaffDto> getDriverList(String center_code);//운전기사 정보 검색(차량 정보 입력시 사용)
	public List<StaffDto> getDriverPList(String center_code,String word);//운전기사 정보 검색(차량 정보 입력시 사용(연락처 받기용))
	public List<StaffDto> Staff_selectTeacher(String center_code);//보육교사 정보 검색(노선 입력(인솔교사 배치 스탭)선생님 리스트)

	public void addStaff(StaffDto adminForm);
	public void InsertStaff(StaffDto staffDto);
	public void addRoles(StaffDto adminForm);

	public void addRoles(String center_code, List<String> staff_id, List<String> role);

	public List<StaffDto> getStaffIdCheck(String staffId_chk);

	public List<StaffDto> getCenterCode(String name);

	public List<StaffDto> getAllStaffList(String center_code);

	public List<StaffDto> getAllClassList(String center_code);

	public List<StaffDto> getStaffAccount(String center_code, String staff_id);

	public void updateStaffInfo(StaffDto staffDto);

	public List<StaffDto> getStaffInfo(String center_code, String staffId);

	public void UpdateStaff(String center_code, String registrant, List<String> staff_id, List<String> staff_name,
			List<String> staff_type, List<String> staff_phone, List<String> staff_email, List<String> staff_position);

	public void UpdateRoles(String center_code, List<String> staff_id, List<String> role);

	public List<StaffDto> getDetailInfo(String center_code, String staffId);

	public List<StaffDto> checkPassWord(String staff_pw, String staff_id);

	public void changePassWord(String staff_pw, String staff_id, String staff_id2);

	public int getsignOut(String center_code,String staff_id, String staff_name);

	public List<StaffDto> findStaffId(String staff_name, String staff_phone);

	public List<StaffDto> findStaffPw(String staff_id, String staff_name, String staff_phone);

	public List<StaffDto> getChkStaff(String chk,String center_code, String staff_id, String sem);

	public int deleteStaff(String center_code, String staff_id, String staff_name);

	public List<StaffDto> getDashboardAccountCount(String center_code);

	public void updateChangeStaffInClass(StaffDto staffDto);

	public void updateChangeStaffInClass2(StaffDto staffDto);

	public void staffDownRoles(String center_code, String staff_id, String downRoles);

	public List<StaffDto> selectAllStaff_sort(String center_code, String orderBy_type, String th_type, String sortSelect);

	public List<StaffDto> positionType(String center_code);

	public List<StaffDto> staffList_notAdmin(String center_code);//원장 제외 모든 스태프 리스트

	public List<StaffDto> staffList_notAdmin_group(String center_code);
	
	public List<StaffDto> staffList_StaffRoles(String center_code, String staff_id); //해당 스태프 Role 셀렉트
	
	
}
