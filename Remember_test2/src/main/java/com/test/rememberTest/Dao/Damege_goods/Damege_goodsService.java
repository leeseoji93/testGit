package com.test.rememberTest.Dao.Damege_goods;

import java.util.List;
import java.util.Map;

import com.test.rememberTest.Dto.BusRouteDto;
import com.test.rememberTest.Dto.Damege_goodsDto;



public interface Damege_goodsService {

	void insertDamegeGoods(Damege_goodsDto damage_goodsDto);

	List<Damege_goodsDto> allDamegeGoodsList(String center_code);

	List<Damege_goodsDto> damegeGoodsDetail(String equipment_id);

	List<Damege_goodsDto> getDamageSearch(String center_code, String keyWord);
	
}
