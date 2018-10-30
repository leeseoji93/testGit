package com.test.rememberTest.Dao.User;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.test.rememberTest.Dto.MemberInfo;
import com.test.rememberTest.Dto.StationInfo;


public interface UserService {

	public int removeUser(MemberInfo memberInfo);

	public MemberInfo getUserByIdAndPw(MemberInfo memberInfo);

	public int getLastPage();

	public int addUser(MemberInfo memberInfo);

	public List<MemberInfo> getUserList(int page, String word);
	
	public void logOut(HttpSession session);

	public MemberInfo GetCheckId(String chk_id);

	public List<MemberInfo> GetTest(int code);

	public int addTest(MemberInfo memberInfo);

}
