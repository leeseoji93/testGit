package com.test.rememberTest.Dao.Staff;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.rememberTest.Dto.StaffDto;


@Repository
public class StaffDaoImpl implements StaffDao{
	private final String NS = "com.test.rememberTest.Map.UserMapper";
	
	 @Autowired 
	    private SqlSessionTemplate sqlSession;
	
	@Override
	public List<StaffDto> selectDriver(Map<String, Object> map) {
		
		return sqlSession.selectList(NS+".selectDriver",map);
	}
	@Override
	public List<StaffDto> selectStaff(Map<String, Object> map) {
		return sqlSession.selectList(NS+".selectStaff",map);
	}
	@Override
	public List<StaffDto> selectDriverPList(Map<String, Object> map) {
		
		return sqlSession.selectList(NS+".selectDriverP",map);
	}
	@Override
	public List<StaffDto> Staff_selectTeacher(Map<String, Object> map) {
		return sqlSession.selectList(NS+".Staff_selectTeacher",map);		
	}//보육교사 정보 검색(노선 입력(인솔교사 배치 스탭)선생님 리스트)
	@Override
	public void insertStaff(StaffDto adminForm) {
		sqlSession.insert(NS+".insertStaff", adminForm);
	}
	@Override
	public void all_staff_insert(StaffDto staffDto) {
		sqlSession.insert(NS+".insertAllStaff", staffDto);
	}
	@Override
	public void insertStaffRoles(StaffDto adminForm) {
		sqlSession.insert(NS+".insertStaffRoles", adminForm);
	}
	@Override
	public void insertStaffRoles_List(Map<String, Object> map) {
		sqlSession.insert(NS+".insertStaffRoles_List", map);
	}
	@Override
	public List<StaffDto> selectStaffIdCheck(Map<String, Object> map) {
		return sqlSession.selectList(NS+".selectStaffIdCheck", map);
	}
	@Override
	public List<StaffDto> selectCenterCode(Map<String, Object> map) {
		return sqlSession.selectList(NS+".selectCenterCode", map);
	}
	@Override
	public List<StaffDto> selectAllStaff(Map<String, Object> map) {
		return sqlSession.selectList(NS+".selectAllStaff",map);
	}
	@Override
	public List<StaffDto> getAllClassList(Map<String, Object> map) {
		return sqlSession.selectList(NS+".selectAllClassList",map);
	}
	@Override
	public List<StaffDto> getStaffAccount(Map<String, Object> map) {
		return sqlSession.selectList(NS+".selectStaffAccount",map);
	}
	@Override
	public void updateStaffInfo(StaffDto staffDto) {
		sqlSession.update(NS+".updateStaffInfo", staffDto);
	}
	@Override
	public List<StaffDto> selectStaffInfo(Map<String, Object> map) {
		return sqlSession.selectList(NS+".selectStaffInfo",map);
	}
	@Override
	public void all_staff_update(Map<String, Object> map) {
		sqlSession.update(NS+".allStaffUpdate", map);
	}
	@Override
	public void updateStaffRoles(Map<String, Object> map) {
		sqlSession.update(NS+".updateStaffRoles", map);
	}
	@Override
	public List<StaffDto> selectDetailInfo(Map<String, Object> map) {
		return sqlSession.selectList(NS+".selectDetailInfo",map);	//마이페이지 
	}
	@Override
	public List<StaffDto> checkPassWord(Map<String, Object> map) {
		return sqlSession.selectList(NS+".checkPassWord",map);
	}
	@Override
	public void changePassWord(Map<String, Object> map) {
		sqlSession.update(NS+".changePassWord", map);
	}
	@Override
	public int getsignOut(Map<String, Object> map) {
		return sqlSession.update(NS+".signOut", map);
	}
	@Override
	public List<StaffDto> findStaffId(Map<String, Object> map) {
		return sqlSession.selectList(NS+".findStaffId", map);
	}
	@Override
	public List<StaffDto> findStaffPw(Map<String, Object> map) {
		return sqlSession.selectList(NS+".findStaffPw", map);
	}
	@Override
	public List<StaffDto> getChkStaff(Map<String, Object> map) {
		return sqlSession.selectList(NS+".getChkStaff", map);
	}
	@Override
	public int deleteStaff(Map<String, Object> map) {
		return sqlSession.delete(NS+".deleteStaff", map);
	}
	@Override
	public List<StaffDto> dashboardAccountCount(Map<String, Object> map) {
		return sqlSession.selectList(NS+".dashboardAccountCount", map);
	}
	@Override
	public void updateChangeStaffInClass(StaffDto staffDto) {
		sqlSession.update(NS+".updateChangeStaffInClass", staffDto);
	}
	@Override
	public void updateChangeStaffInClass2(StaffDto staffDto) {
		sqlSession.update(NS+".updateChangeStaffInClass2", staffDto);
	}
	@Override
	public void staffDownRoles(Map<String, Object> map) {
		sqlSession.update(NS+".staffDownRoles", map);
	}
	@Override
	public List<StaffDto> selectAllStaff_sort(Map<String, Object> map) {
		System.out.println("selectAllStaff_sort:"+map);
		return sqlSession.selectList(NS+".selectAllStaff_sort", map);
	}
	@Override
	public List<StaffDto> positionType(Map<String, Object> map) {
		return sqlSession.selectList(NS+".positionType", map);
	}
	@Override
	public List<StaffDto> staffList_notAdmin(Map<String, Object> map) {
		return sqlSession.selectList(NS+".staffList_notAdmin", map);
	}//원장 제외 모든 스태프 리스트
	@Override
	public List<StaffDto> staffList_notAdmin_group(Map<String, Object> map) {
		return sqlSession.selectList(NS+".staffList_notAdmin_group", map);
	}
	@Override
	public List<StaffDto> staffList_StaffRoles(Map<String, Object> map) {
		return sqlSession.selectList(NS+".staffList_StaffRoles", map);
	}
}
