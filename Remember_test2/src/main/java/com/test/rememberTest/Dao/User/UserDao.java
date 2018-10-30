package com.test.rememberTest.Dao.User;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.test.rememberTest.Dto.MemberInfo;

@Repository
public interface UserDao {

	public int deleteUser(MemberInfo memberInfo);

	public MemberInfo selectUserByIdAndPw(MemberInfo memberInfo);

	public int selectTotalCount();

	public int insertUser(MemberInfo memberInfo);

	public List<MemberInfo> selectUserList(Map<String, Object> map);

	public MemberInfo selectCheckId(String chk_id);
	
	public List<MemberInfo> selectTest(Map<String, Object> map);

	public int insertTest(MemberInfo memberInfo);

}
