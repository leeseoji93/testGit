package com.test.rememberTest.Dao.User;
 
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.rememberTest.Dto.MemberInfo;
 
@Repository
public class UserDaoImpl implements UserDao {
    private final String NS = "com.test.rememberTest.Map.UserMapper";
    @Autowired 
    private SqlSessionTemplate sqlSession;
   
    @Override
    public int deleteUser(MemberInfo user) {
        return sqlSession.delete(NS+".deleteUser", user);
    }
   
    @Override
    public MemberInfo selectUserByIdAndPw(MemberInfo user) {
        return sqlSession.selectOne(NS+".selectUserByIdAndPw",user);
    }
   
    @Override
    public int selectTotalCount() {
        return sqlSession.selectOne(
                NS+".selectTotalCount");
    }
    @Override
    public int insertUser(MemberInfo user) {
        return sqlSession.insert(
                NS+".insertUser", user);
    }
    @Override
    public List<MemberInfo> selectUserList(Map<String, Object> map) {
        return sqlSession.selectList(
                NS+".selectUserList",map);
    }

	@Override
	public MemberInfo selectCheckId(String chk_id) {
		System.out.println("UserDaoIm 에서 chk_id:"+chk_id);
		System.out.println("sqlSession.selectOne :"+sqlSession.selectOne(NS+".selectCheckId",chk_id));
		return sqlSession.selectOne(NS+".selectCheckId",chk_id);
		
		
	}

	@Override
	public List<MemberInfo> selectTest(Map<String, Object> map) {
		System.out.println("UserDaoIm 에서 selectTest:"+map);
		return sqlSession.selectList(NS+".selectTest",map);
	}

	@Override
	public int insertTest(MemberInfo memberInfo) {
        return sqlSession.insert(NS+".insertTest", memberInfo);
	}	
}