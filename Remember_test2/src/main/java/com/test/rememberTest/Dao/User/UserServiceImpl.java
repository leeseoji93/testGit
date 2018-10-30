package com.test.rememberTest.Dao.User;
 
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.rememberTest.Dto.MemberInfo;
import com.test.rememberTest.Dto.PageHelper;


@Service
public class UserServiceImpl implements UserService {
    private final int LINE_PER_PAGE = 10;
    @Autowired
    private UserDao userDao;
   
    @Override
    public int removeUser(MemberInfo memberInfo) {
        return userDao.deleteUser(memberInfo);
    }
   
    @Override
    public MemberInfo getUserByIdAndPw(MemberInfo memberInfo) {
        return userDao.selectUserByIdAndPw(memberInfo);
    }
   
    @Override
    public int getLastPage() {
        return (int)(Math.ceil((double)userDao.selectTotalCount()/LINE_PER_PAGE));
    }
   
    @Override
    public int addUser(MemberInfo memberInfo) {
        return userDao.insertUser(memberInfo);
    }
   
    @Override
    public List<MemberInfo> getUserList(int page, String word) {
        PageHelper pageHelper = new PageHelper(page,LINE_PER_PAGE);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("pageHelper", pageHelper);
        map.put("word", word);
        return userDao.selectUserList(map);
    }

	@Override
	public void logOut(HttpSession session) {
		session.invalidate();
	}

	@Override
	public MemberInfo GetCheckId(String chk_id) {
		return userDao.selectCheckId(chk_id);
	}

	@Override
	public List<MemberInfo> GetTest(int code) {
		// TODO Auto-generated method stub
		System.out.println("service에서 GetTest시작!!!!!!!!!!!!!!!!!");
		System.out.println("keyWord 값은 : "+code);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", code);
		return userDao.selectTest(map);
	}

	@Override
	public int addTest(MemberInfo memberInfo) {
		return userDao.insertTest(memberInfo);
	}

}