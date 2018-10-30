package com.test.rememberTest.Dao.Class;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.rememberTest.Dto.BusRouteDto;
import com.test.rememberTest.Dto.ClassDto;
import com.test.rememberTest.Dto.KidDto;


@Repository
public class ClassDaoImpl implements ClassDao{
	private final String NS = "com.test.rememberTest.Map.UserMapper";
	
	 @Autowired  	
	    private SqlSessionTemplate sqlSession;

	@Override
	public void addClass(ClassDto classDto) {
		System.out.println("addClass DaoImpl~~");
		sqlSession.insert(NS+".addClass", classDto);
	}

	@Override
	public List<ClassDto> MaxClass_id(Map<String, Object> map) {
		return sqlSession.selectList(NS + ".MaxClass_id", map);
	}

	@Override
	public List<ClassDto> allClassList(Map<String, Object> map) {
		return sqlSession.selectList(NS + ".allClassList", map);
	}

	@Override
	public List<ClassDto> detailClass(Map<String, Object> map) {
		return sqlSession.selectList(NS + ".detailClass", map);
	}

	@Override
	public int deleteClass(Map<String, Object> map) {
		return sqlSession.delete(NS+ ".deleteClass", map);
	}

	@Override
	public List<ClassDto> searchClass(Map<String, Object> map) {
		return sqlSession.selectList(NS+".searchClass", map);
	}

	@Override
	public void updateClass(ClassDto classDto) {
		sqlSession.update(NS+".updateClass", classDto);
	}

	@Override
	public List<KidDto> selectKidAge(Map<String, Object> map) {
		return sqlSession.selectList(NS+".selectKidAge", map);
	}

	@Override
	public List<ClassDto> Class_Select_AllList(Map<String, Object> map) {
		return sqlSession.selectList(NS+".Class_Select_AllList",map);
	}//해당 센터 반 리스트 셀렉

	@Override
	public List<ClassDto> getMyClassInfo(String id) {
		return sqlSession.selectList(NS+".getMyClassInfo",id);
	}
	
}
