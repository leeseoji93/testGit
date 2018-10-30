package com.test.rememberTest.Dao.Kid;

import java.util.List;

import com.test.rememberTest.Dto.KidDto;


public interface KidService {

	public List<KidDto> Kid_Selectdata(String center_code, String route_id); //원아 전체 목록 셀렉(노선입력-원아배치)

	public List<KidDto> selectMaxKid_code(String code);

	public List<KidDto> getAllKidList(String center_code);

	public void addKidsInfo(KidDto kidDto);

	public List<KidDto> getKidsInfo(String center_code, String kid_system_code);

	public List<KidDto> getAllKidListL(String center_code, int pageid, int total);

	public void updateKidsInfo(KidDto kidDto);

	public List<KidDto> getkidsListInClass(String center_code, String class_id);

	public List<KidDto> getKidInfo(String center_code, String kidCode);

	public int deleteKid(String center_code, String kid_system_code);

	public List<KidDto> allClassKidsList(String center_code, String class_id);

	public List<KidDto> getMatchingKids(String center_code, String search_Keyword, String search_ClassId,
			String search_ClassYear);

	public List<KidDto> notMatchingCount(String center_code);

	public List<KidDto> getParentList(String center_code);

	public int updateRepreParentId(String kid_system_code, String par_id);
	
	public List<KidDto> Kid_select_ClassKid(String class_id,String center_code); //해당 클래스 원아를 셀렉
	
	public List<KidDto> Kid_select_tokenData(String class_id,String center_code); //해당 클래스 원아들의 부모 토큰값 셀렉

	public List<KidDto> getkidsSearchResult(String center_code, String keyWord);

	public String checkParent(String kid_code);

	public void updateParentId(String kid_code, String par_id);

	public List<KidDto> getAllKidList_sort(String center_code, String oderBy_type, String obj, String sortSelect);

	public List<KidDto> unidentified_Kid_select_tokenData(String communication_id, String center_code);
}
