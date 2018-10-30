package com.test.rememberTest.Dao.Kid;
import java.util.List;
import java.util.Map;

import com.test.rememberTest.Dto.KidDto;


public interface KidDao {

	public List<KidDto> Kid_Selectdata(Map<String, Object> map); //원아 전체 목록 셀렉(노선입력-원아배치)

	public List<KidDto> MaxKid_code(Map<String, Object> map);

	public List<KidDto> AllKidList(Map<String, Object> map);

	public void addKidsInfo(KidDto kidDto);

	public List<KidDto> KidsInfo(Map<String, Object> map);

	public List<KidDto> AllKidListL(Map<String, Object> map);

	public void UpdateKidsInfo(KidDto kidDto);

	public List<KidDto> KidsListInClass(Map<String, Object> map);

	public List<KidDto> KidInfo(Map<String, Object> map);

	public int DeleteKid(Map<String, Object> map);

	public List<KidDto> allClassKidsList(Map<String, Object> map);

	public List<KidDto> MatchingKids(Map<String, Object> map);

	public List<KidDto> notMatchingCount(Map<String, Object> map);

	public List<KidDto> getParentList(Map<String, Object> map);

	public int updateRepreParentId(Map<String, Object> map);
	
	public List<KidDto> Kid_select_ClassKid(Map<String, Object> map); //해당 클래스 원아를 셀렉
	
	public List<KidDto> Kid_select_tokenData(Map<String, Object> map); //해당 클래스 원아들의 부모 토큰값 셀렉

	public List<KidDto> KidsSearchResult(Map<String, Object> map);

	public String checkParent(String kid_code);

	public void updateParentId(Map<String, Object> map);

	public List<KidDto> getAllKidList_sort(Map<String, Object> map);

	public List<KidDto> unidentified_Kid_select_tokenData(Map<String, Object> map);
}
