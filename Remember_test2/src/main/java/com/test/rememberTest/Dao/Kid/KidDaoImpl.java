package com.test.rememberTest.Dao.Kid;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.rememberTest.Dto.KidDto;

@Repository
public class KidDaoImpl implements KidDao {
	private final String NS = "com.test.rememberTest.Map.UserMapper";

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<KidDto> Kid_Selectdata(Map<String, Object> map) {
		return sqlSession.selectList(NS + ".Kid_Selectdata", map);
	}// 원아 전체 목록 셀렉(노선입력-원아배치)

	@Override
	public List<KidDto> MaxKid_code(Map<String, Object> map) {
		return sqlSession.selectList(NS + ".MaxKid_code", map);
	}

	@Override
	public List<KidDto> AllKidList(Map<String, Object> map) {
		return sqlSession.selectList(NS + ".AllKidsList", map);
	}

	@Override
	public void addKidsInfo(KidDto kidDto) {
		sqlSession.insert(NS + ".insertKidsInfo", kidDto);
	}

	@Override
	public List<KidDto> KidsInfo(Map<String, Object> map) {
		return sqlSession.selectList(NS + ".KidsInfo", map);
	}

	@Override
	public List<KidDto> AllKidListL(Map<String, Object> map) {
		return sqlSession.selectList(NS + ".AllKidList", map);
	}

	@Override
	public void UpdateKidsInfo(KidDto kidDto) {
		sqlSession.update(NS+ ".UpdateKidsInfo", kidDto);
	}

	@Override
	public List<KidDto> KidsListInClass(Map<String, Object> map) {
		return sqlSession.selectList(NS + ".KidsListInClass", map);
	}

	@Override
	public List<KidDto> KidInfo(Map<String, Object> map) {
		return sqlSession.selectList(NS + ".KidInfo", map);
	}

	@Override
	public int DeleteKid(Map<String, Object> map) {
		return sqlSession.delete(NS + ".DeleteKid", map);
	}

	@Override
	public List<KidDto> allClassKidsList(Map<String, Object> map) {
		return sqlSession.selectList(NS + ".allClassKidsList", map);
	}

	@Override
	public List<KidDto> MatchingKids(Map<String, Object> map) {
		System.out.println("map:"+map);
		return sqlSession.selectList(NS + ".MatchingKids", map);
	}

	@Override
	public List<KidDto> notMatchingCount(Map<String, Object> map) {
		return sqlSession.selectList(NS+".notMatchingCount", map);
	}

	@Override
	public List<KidDto> getParentList(Map<String, Object> map) {
		return sqlSession.selectList(NS+".getParentList", map);
	}

	@Override
	public int updateRepreParentId(Map<String, Object> map) {
		return sqlSession.update(NS+ ".updateRepreParentId", map);
	}
	
	@Override
	public List<KidDto> Kid_select_ClassKid(Map<String, Object> map) {		
		return sqlSession.selectList(NS + ".Kid_select_ClassKid", map);
	}//해당 클래스 원아를 셀렉

	@Override
	public List<KidDto> Kid_select_tokenData(Map<String, Object> map) {	
		return sqlSession.selectList(NS + ".Kid_select_tokenData", map);
	}//해당 클래스 원아들의 부모 토큰값 셀렉

	@Override
	public List<KidDto> KidsSearchResult(Map<String, Object> map) {
		return sqlSession.selectList(NS + ".KidsSearchResult", map);
	}

	@Override
	public String checkParent(String kid_code) {
		return sqlSession.selectOne(NS + ".checkParent", kid_code);
	}

	@Override
	public void updateParentId(Map<String, Object> map) {
		sqlSession.update(NS + ".updateParentId", map);
	}

	@Override
	public List<KidDto> getAllKidList_sort(Map<String, Object> map) {
		System.out.println("map : "+map);
		return sqlSession.selectList(NS + ".getAllKidList_sort", map);
	}
	
	@Override
	public List<KidDto> unidentified_Kid_select_tokenData(Map<String, Object> map) {
		return sqlSession.selectList(NS + ".unidentified_Kid_select_tokenData", map);
	}
}
