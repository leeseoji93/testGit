package com.test.rememberTest.Security;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.jdbc.JdbcDaoImpl;

import com.test.rememberTest.Dto.MemberInfo;

public class CustomJdbcDaoImpl extends JdbcDaoImpl{

	@Override
    protected List<UserDetails> loadUsersByUsername(String username) {
        // TODO Auto-generated method stub
        return getJdbcTemplate().query(getUsersByUsernameQuery(), new String[] {username}, new RowMapper<UserDetails>() {
            public UserDetails mapRow(ResultSet rs, int rowNum) throws SQLException {
                System.out.println("CustomJdbcDaoImpl 시작");
            	String username = rs.getString(1);
                String password = rs.getString(2);
                String name = rs.getString(3);
                
                return new MemberInfo(username, password, name, AuthorityUtils.NO_AUTHORITIES);
            }
 
        });
    }
}