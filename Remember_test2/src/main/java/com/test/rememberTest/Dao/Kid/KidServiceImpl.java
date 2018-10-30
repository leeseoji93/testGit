package com.test.rememberTest.Dao.Kid;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.rememberTest.Dto.KidDto;

@Service
public class KidServiceImpl implements KidService {

	@Autowired
	private KidDao kidDao;

	@Override
	public List<KidDto> Kid_Selectdata(String center_code, String route_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("center_code", center_code);
		map.put("route_id", route_id);
		return kidDao.Kid_Selectdata(map);
	}// 원아 전체 목록 셀렉(노선입력-원아배치)

	@Override
	public List<KidDto> selectMaxKid_code(String code) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", code);
		return kidDao.MaxKid_code(map);
	}

	@Override
	public void addKidsInfo(KidDto kidDto) {
		 kidDao.addKidsInfo(kidDto);
	}

	@Override
	public List<KidDto> getKidsInfo(String center_code, String kid_system_code) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("center_code", center_code);
		map.put("kid_system_code", kid_system_code);
		return kidDao.KidsInfo(map);
	}

	@Override
	public List<KidDto> getAllKidList(String center_code) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("center_code", center_code);
		return kidDao.AllKidList(map);
	}

	@Override
	public List<KidDto> getAllKidListL(String center_code, int pageid, int total) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("center_code", center_code);
		map.put("pageid", pageid);
		map.put("total", total);
		return kidDao.AllKidListL(map);
	}

	@Override
	public void updateKidsInfo(KidDto kidDto) {
		kidDao.UpdateKidsInfo(kidDto);
	}

	@Override
	public List<KidDto> getkidsListInClass(String center_code, String class_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("center_code", center_code);
		map.put("class_id", class_id);
		return kidDao.KidsListInClass(map);
	}

	@Override
	public List<KidDto> getKidInfo(String center_code, String kidCode) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("center_code", center_code);
		map.put("kid_system_code", kidCode);
		return kidDao.KidInfo(map);
	}

	@Override
	public int deleteKid(String center_code, String kid_system_code) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("center_code", center_code);
		map.put("kid_system_code", kid_system_code);
		return kidDao.DeleteKid(map);
	}

	@Override
	public List<KidDto> allClassKidsList(String center_code, String class_id) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("center_code", center_code);
		map.put("class_id", class_id);
		return kidDao.allClassKidsList(map);
	}

	@Override
	public List<KidDto> getMatchingKids(String center_code, String search_Keyword, String search_ClassId,
			String search_ClassYear) {
		System.out.println("==getMatchingKids");
		System.out.println("=="+center_code+"//"+search_Keyword+"//"+search_ClassId+"//"+search_ClassYear+"//");
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("center_code", center_code);
		map.put("keyword", search_Keyword);
		map.put("class_id", search_ClassId);
		map.put("class_year", search_ClassYear);
		return kidDao.MatchingKids(map);
	}

	@Override
	public List<KidDto> notMatchingCount(String center_code) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("center_code", center_code);
		return kidDao.notMatchingCount(map);
	}

	@Override
	public List<KidDto> getParentList(String center_code) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("center_code", center_code);
		return kidDao.getParentList(map);
	}

	@Override
	public int updateRepreParentId(String kid_system_code, String par_id) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("kid_system_code", kid_system_code);
		map.put("par_id", par_id);
		return kidDao.updateRepreParentId(map);
	}

	@Override
	public List<KidDto> Kid_select_ClassKid(String class_id,String center_code) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("class_id", class_id);
		map.put("center_code", center_code);
		return kidDao.Kid_select_ClassKid(map);
	}//해당 클래스 원아를 셀렉

	@Override
	public List<KidDto> Kid_select_tokenData(String class_id, String center_code) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("class_id", class_id);
		map.put("center_code", center_code);
		return kidDao.Kid_select_tokenData(map);
	}//해당 클래스 원아들의 부모 토큰값 셀렉

	@Override
	public List<KidDto> getkidsSearchResult(String center_code, String keyWord) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("center_code", center_code);
		map.put("keyWord", keyWord);
		return kidDao.KidsSearchResult(map);
	}

	@Override
	public String checkParent(String kid_code) {
		return kidDao.checkParent(kid_code);
	}

	@Override
	public void updateParentId(String kid_code, String par_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("kid_code", kid_code);
		map.put("par_id", par_id);
		kidDao.updateParentId(map);
	}

	@Override
	public List<KidDto> getAllKidList_sort(String center_code, String orderBy_type, String th_type, String sortSelect) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("center_code", center_code);
		map.put("orderBy_type", orderBy_type);
		map.put("th_type", th_type);
		map.put("sortSelect", sortSelect);
		return kidDao.getAllKidList_sort(map);
	}
	
	@Override
	public List<KidDto> unidentified_Kid_select_tokenData(String communication_id,String center_code) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("communication_id", communication_id);
		map.put("center_code", center_code);
		return kidDao.unidentified_Kid_select_tokenData(map);
	}
}
