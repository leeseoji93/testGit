package com.test.rememberTest.Dao.Center;

import java.util.Map;

import com.test.rememberTest.Dto.CenterDto;

import java.util.List;
public interface CenterDao {

	public List<CenterDto> selectCenter_Addr(Map<String, Object> map);

	public List<CenterDto> Center_selectDataPosition(Map<String, Object> map);

	public void insertCenter(CenterDto centerForm);

	public void insertCenterCode(CenterDto centerForm);

	public List<CenterDto> detailCenter(Map<String, Object> map);

	public void UpdateCenter(CenterDto centerDto);

}
