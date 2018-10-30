package com.test.rememberTest.Dao.Damege_goods;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.rememberTest.Dto.BusRouteDto;
import com.test.rememberTest.Dto.Damege_goodsDto;


@Service
public class Damege_goodsServiceImpl implements Damege_goodsService{

	 @Autowired
	    private Damege_goodsDao damage_goodsDao;

	@Override
	public void insertDamegeGoods(Damege_goodsDto damage_goodsDto) {
		damage_goodsDao.insertDamegeGoods(damage_goodsDto);
	}

	@Override
	public List<Damege_goodsDto> allDamegeGoodsList(String center_code) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("center_code", center_code);
		return damage_goodsDao.allDamegeGoodsList(map);
	}

	@Override
	public List<Damege_goodsDto> damegeGoodsDetail(String equipment_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("equipment_id", equipment_id);
		return damage_goodsDao.damegeGoodsDetail(map);
	}

	@Override
	public List<Damege_goodsDto> getDamageSearch(String center_code, String keyWord) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("center_code", center_code);
		map.put("keyWord", keyWord);
		return damage_goodsDao.getDamageSearch(map);
	}
}
