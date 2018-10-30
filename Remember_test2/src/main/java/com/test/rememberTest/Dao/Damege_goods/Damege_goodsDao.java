package com.test.rememberTest.Dao.Damege_goods;

import java.util.List;
import java.util.Map;

import com.test.rememberTest.Dto.BusRouteDto;
import com.test.rememberTest.Dto.Damege_goodsDto;


public interface Damege_goodsDao {

	void insertDamegeGoods(Damege_goodsDto damage_goodsDto);

	List<Damege_goodsDto> allDamegeGoodsList(Map<String, Object> map);

	List<Damege_goodsDto> damegeGoodsDetail(Map<String, Object> map);

	List<Damege_goodsDto> getDamageSearch(Map<String, Object> map);
	
}
