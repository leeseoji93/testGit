package com.test.rememberTest.Dao.Staff;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.rememberTest.Dto.StaffDto;



@Service
public class StaffServiceImpl implements StaffService{

	 @Autowired
	    private StaffDao staffDao;

		@Override
		public List<StaffDto> getDriverList(String center_code) {
			Map<String, Object> map = new HashMap<String, Object>();       
	        map.put("center_code", center_code);
			 return staffDao.selectDriver(map);
		}

		@Override
		public List<StaffDto> getStaffList(String code) {
			System.out.println("staffservice에서 getStaffList시작");
			Map<String, Object> map = new HashMap<String, Object>();       
	        map.put("code", code); 
			return staffDao.selectStaff(map);
		}

		@Override
		public List<StaffDto> getDriverPList(String center_code,String word) {
			Map<String, Object> map = new HashMap<String, Object>(); 
			 map.put("center_code", center_code);
	        map.put("word", word); 
			return staffDao.selectDriverPList(map);
		}

		@Override
		public List<StaffDto> Staff_selectTeacher(String center_code) {
			Map<String, Object> map = new HashMap<String, Object>(); 
			 map.put("center_code", center_code);
			 return staffDao.Staff_selectTeacher(map);
		}//보육교사 정보 검색(노선 입력(인솔교사 배치 스탭)선생님 리스트)

		@Override
		public void addStaff(StaffDto adminForm) {
			staffDao.insertStaff(adminForm);
		}

		@Override
		public void InsertStaff(StaffDto staffDto) {
		      staffDao.all_staff_insert(staffDto);
		}

		@Override
		public void addRoles(StaffDto adminForm) {
			staffDao.insertStaffRoles(adminForm);
		}

		@Override
		public void addRoles(String center_code, List<String> staff_id, List<String> role) {
				Map<String, Object> map = new HashMap<String, Object>();  
			      
				Map<String, Object> dtomap;
				List<Map<String, Object>> dtoList = new ArrayList<Map<String, Object>>();
			       
			      for(int i=0; i<staff_id.size(); i++) {
			         dtomap = new HashMap<String, Object>();
			         
			         dtomap.put("center_code", center_code);
			         dtomap.put("staff_id", staff_id.get(i));
			         dtomap.put("role", role.get(i));
			           
			         dtoList.add(dtomap);
			         
			         System.out.println("center_code:"+center_code
			        		 +"\n staff_id: "+staff_id.get(i)
			        		 +"\n role: "+role.get(i));
			      }
			      map.put("dtoList", dtoList);      
			      staffDao.insertStaffRoles_List(map);
		}

		@Override
		public List<StaffDto> getStaffIdCheck(String staffId_chk) {
			Map<String, Object> map = new HashMap<String, Object>();
	        map.put("staffId_chk", staffId_chk);
	        System.out.println("map : "+map);
	        return staffDao.selectStaffIdCheck(map);
		}

		@Override
		public List<StaffDto> getCenterCode(String name) {
			Map<String, Object> map = new HashMap<String, Object>();
	        map.put("name", name);
			return staffDao.selectCenterCode(map);
		}

		@Override
		public List<StaffDto> getAllStaffList(String center_code) {
			System.out.println("staffservice에서 getStaffList시작");
			Map<String, Object> map = new HashMap<String, Object>();       
	        map.put("center_code", center_code); 
			return staffDao.selectAllStaff(map);
		}

		@Override
		public List<StaffDto> getAllClassList(String center_code) {
			Map<String, Object> map = new HashMap<String, Object>();       
	        map.put("center_code", center_code); 
			return staffDao.getAllClassList(map);
		}

		@Override
		public List<StaffDto> getStaffAccount(String center_code, String staff_id) {
			Map<String, Object> map = new HashMap<String, Object>();       
	        map.put("center_code", center_code); 
	        map.put("staff_id", staff_id); 
			return staffDao.getStaffAccount(map);
		}

		@Override
		public void updateStaffInfo(StaffDto staffDto) {
			staffDao.updateStaffInfo(staffDto);
		}

		@Override
		public List<StaffDto> getStaffInfo(String center_code, String staffId) {
			Map<String, Object> map = new HashMap<String, Object>();       
	        map.put("center_code", center_code);
	        map.put("staff_id", staffId);
			 return staffDao.selectStaffInfo(map);
		}

		@Override
		public void UpdateStaff(String center_code, String registrant, List<String> staff_id, List<String> staff_name,
				List<String> staff_type, List<String> staff_phone, List<String> staff_email,
				List<String> staff_position) {
			
			Map<String, Object> map = new HashMap<String, Object>();  
			Map<String, Object> dtomap;
			List<Map<String, Object>> dtoList = new ArrayList<Map<String, Object>>();
		       
		      for(int i=0; i<staff_id.size(); i++) {
		         dtomap = new HashMap<String, Object>();
		         
		         dtomap.put("center_code", center_code);
		         dtomap.put("registrant", registrant);
		         dtomap.put("staff_id", staff_id.get(i));
		         dtomap.put("staff_name", staff_name.get(i));
		         dtomap.put("staff_type", staff_type.get(i));
		         dtomap.put("staff_email", staff_email.get(i));
		         dtomap.put("staff_phone", staff_phone.get(i));
		         dtomap.put("staff_position", staff_position.get(i));
		           
		         dtoList.add(dtomap);
		      }
		      System.out.println("center_code:"+center_code);
		      System.out.println("registrant:"+registrant);
		      System.out.println("staff_id:"+staff_id);
		      map.put("dtoList", dtoList);      
		      staffDao.all_staff_update(map);
		}

		@Override
		public void UpdateRoles(String center_code, List<String> staff_id, List<String> role) {
			
			Map<String, Object> map = new HashMap<String, Object>();
			
			Map<String, Object> dtomap;
			List<Map<String, Object>> dtoList = new ArrayList<Map<String, Object>>();
		       
		      for(int i=0; i<staff_id.size(); i++) {
		         dtomap = new HashMap<String, Object>();
		         
		         dtomap.put("center_code", center_code);
		         dtomap.put("staff_id", staff_id.get(i));
		         dtomap.put("role", role.get(i));
		           
		         dtoList.add(dtomap);
		         
		         System.out.println("center_code:"+center_code
		        		 +"\n staff_id: "+staff_id.get(i)
		        		 +"\n role: "+role.get(i));
		      }
		      map.put("dtoList", dtoList);      
		      staffDao.updateStaffRoles(map);
		      
		      
		}

		@Override
		public List<StaffDto> getDetailInfo(String center_code,String saffId) {
			Map<String, Object> map = new HashMap<String, Object>();       
	        map.put("center_code", center_code);
	        map.put("staff_id", saffId);
			return staffDao.selectDetailInfo(map);
		}

		@Override
		public List<StaffDto> checkPassWord(String staff_pw,String staff_id) {
			Map<String, Object> map = new HashMap<String, Object>();       
	        map.put("staff_pw", staff_pw);
	        map.put("staff_id", staff_id);
			return staffDao.checkPassWord(map);
		}

		@Override
		public void changePassWord(String center_code,String staff_pw, String staff_id) {
			Map<String, Object> map = new HashMap<String, Object>();       
	        map.put("staff_pw", staff_pw);
	        map.put("staff_id", staff_id);
	        map.put("center_code", center_code);
			staffDao.changePassWord(map);
		}

		@Override
		public int getsignOut(String center_code,String staff_id,String staff_name) {
			Map<String, Object> map = new HashMap<String, Object>();       
	        map.put("center_code", center_code);
	        map.put("staff_id", staff_id);
	        map.put("staff_name", staff_name);
			return staffDao.getsignOut(map);
		}

		@Override
		public List<StaffDto> findStaffId(String staff_name, String staff_phone) {
			Map<String, Object> map = new HashMap<String, Object>();       
	        map.put("staff_name", staff_name);
	        map.put("staff_phone", staff_phone);
			return staffDao.findStaffId(map);
		}

		@Override
		public List<StaffDto> findStaffPw(String staff_id, String staff_name, String staff_phone) {
			Map<String, Object> map = new HashMap<String, Object>();       
			map.put("staff_id", staff_id);
			map.put("staff_name", staff_name);
	        map.put("staff_phone", staff_phone);
			return staffDao.findStaffPw(map);
		}

		@Override
		public List<StaffDto> getChkStaff(String chk, String center_code,String staff_id,String sem) {
			Map<String, Object> map = new HashMap<String, Object>();       
			map.put("chk", chk);
			map.put("center_code", center_code);
			map.put("staff_id", staff_id);
			map.put("sem", sem);
			System.out.println("ma[p:"+map);
			return staffDao.getChkStaff(map);
		}

		@Override
		public int deleteStaff(String center_code, String staff_id,String staff_name) {
			Map<String, Object> map = new HashMap<String, Object>();       
			map.put("center_code", center_code);
			map.put("staff_id", staff_id);
			map.put("staff_name", staff_name);
			return staffDao.deleteStaff(map);
		}

		@Override
		public List<StaffDto> getDashboardAccountCount(String center_code) {
			Map<String, Object> map = new HashMap<String, Object>();       
			map.put("center_code", center_code);
			return staffDao.dashboardAccountCount(map);
		}

		@Override
		public void updateChangeStaffInClass(StaffDto staffDto) {
			staffDao.updateChangeStaffInClass(staffDto);
		}

		@Override
		public void updateChangeStaffInClass2(StaffDto staffDto) {
			staffDao.updateChangeStaffInClass2(staffDto);
		}

		@Override
		public void staffDownRoles(String center_code, String staff_id, String downRoles) {
			Map<String, Object> map = new HashMap<String, Object>();       
			map.put("center_code", center_code);
			map.put("staff_id", staff_id);
			map.put("downRoles", downRoles);
			staffDao.staffDownRoles(map);
		}

		@Override
		public List<StaffDto> selectAllStaff_sort(String center_code, String orderBy_type, String th_type,String sortSelect) {
			Map<String, Object> map = new HashMap<String, Object>(); 
			map.put("center_code", center_code);
			map.put("orderBy_type", orderBy_type);
			map.put("th_type", th_type);
			map.put("sortSelect", sortSelect);
			return staffDao.selectAllStaff_sort(map);
		}

		@Override
		public List<StaffDto> positionType(String center_code) {
			Map<String, Object> map = new HashMap<String, Object>(); 
			map.put("center_code", center_code);
			return staffDao.positionType(map);
		}

		@Override
		public List<StaffDto> staffList_notAdmin(String center_code) {
			Map<String, Object> map = new HashMap<String, Object>(); 
			map.put("center_code", center_code);
			return staffDao.staffList_notAdmin(map);
		}//원장 제외 모든 스태프 리스트

		@Override
		public List<StaffDto> staffList_notAdmin_group(String center_code) {
			Map<String, Object> map = new HashMap<String, Object>(); 
			map.put("center_code", center_code);
			return staffDao.staffList_notAdmin_group(map);
		}

		@Override
		public List<StaffDto> staffList_StaffRoles(String center_code, String staff_id) {
			Map<String, Object> map = new HashMap<String, Object>(); 
			map.put("center_code", center_code);
			map.put("staff_id", staff_id);
			return staffDao.staffList_StaffRoles(map);
		}
		 
}
