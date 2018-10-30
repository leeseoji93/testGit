package com.test.rememberTest.Dao.Staff;


import java.util.List;
import java.util.Map;

import com.test.rememberTest.Dto.StaffDto;



public interface StaffDao {

	public List<StaffDto> selectDriver(Map<String, Object> map);//운전기사 정보 검색(차량 정보 입력/수정시 연락처 동기화용)

	public List<StaffDto> selectStaff(Map<String, Object> map);
	
	public List<StaffDto> selectDriverPList(Map<String, Object> map);//운전기사 정보 검색(차량 정보 입력/수정시 연락처 동기화용)
	public List<StaffDto> Staff_selectTeacher(Map<String, Object> map);//보육교사 정보 검색(노선 입력(인솔교사 배치 스탭)선생님 리스트)

	public void insertStaff(StaffDto adminForm);

	public void all_staff_insert(StaffDto staffDto);

	public void insertStaffRoles(StaffDto adminForm);

	public void insertStaffRoles_List(Map<String, Object> map);

	public List<StaffDto> selectStaffIdCheck(Map<String, Object> map);

	public List<StaffDto> selectCenterCode(Map<String, Object> map);

	public List<StaffDto> selectAllStaff(Map<String, Object> map);

	public List<StaffDto> getAllClassList(Map<String, Object> map);

	public List<StaffDto> getStaffAccount(Map<String, Object> map);

	public void updateStaffInfo(StaffDto staffDto);

	public List<StaffDto> selectStaffInfo(Map<String, Object> map);

	public void all_staff_update(Map<String, Object> map);

	public void updateStaffRoles(Map<String, Object> map);

	public List<StaffDto> selectDetailInfo(Map<String, Object> map);

	public List<StaffDto> checkPassWord(Map<String, Object> map);

	public void changePassWord(Map<String, Object> map);

	public int getsignOut(Map<String, Object> map);

	public List<StaffDto> findStaffId(Map<String, Object> map);

	public List<StaffDto> findStaffPw(Map<String, Object> map);

	public List<StaffDto> getChkStaff(Map<String, Object> map);

	public int deleteStaff(Map<String, Object> map);

	public List<StaffDto> dashboardAccountCount(Map<String, Object> map);

	public void updateChangeStaffInClass(StaffDto staffDto);

	public void updateChangeStaffInClass2(StaffDto staffDto);

	public void staffDownRoles(Map<String, Object> map);

	public List<StaffDto> selectAllStaff_sort(Map<String, Object> map);

	public List<StaffDto> positionType(Map<String, Object> map);
	
	public List<StaffDto> staffList_notAdmin(Map<String, Object> map);//원장 제외 모든 스태프 리스트

	public List<StaffDto> staffList_notAdmin_group(Map<String, Object> map);
	
	public List<StaffDto> staffList_StaffRoles(Map<String, Object> map); //해당 스태프 Role 셀렉트
}
