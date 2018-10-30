package com.test.rememberTest.Dao.Center;

import java.util.List;

import com.test.rememberTest.Dto.CenterDto;

public interface CenterService {

	public List<CenterDto> selectCenter_Addr(String code);

	public List<CenterDto> Center_selectDataPosition(String center_code);

	public void addCenter(CenterDto centerForm);

	public void addCenterCode(CenterDto centerForm);

	public List<CenterDto> detailCenter(String center_code);

	public void UpdateCenter(CenterDto centerDto);

}
