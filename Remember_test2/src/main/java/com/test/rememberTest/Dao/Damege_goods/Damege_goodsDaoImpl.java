package com.test.rememberTest.Dao.Damege_goods;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.rememberTest.Dto.BusRouteDto;
import com.test.rememberTest.Dto.Damege_goodsDto;


@Repository
public class Damege_goodsDaoImpl implements Damege_goodsDao{
	private final String NS = "com.test.rememberTest.Map.UserMapper";
	
	 @Autowired  	
	    private SqlSessionTemplate sqlSession;

	@Override
	public void insertDamegeGoods(Damege_goodsDto damage_goodsDto) {
		sqlSession.insert(NS+".insertDamegeGoods", damage_goodsDto);
	}

	@Override
	public List<Damege_goodsDto> allDamegeGoodsList(Map<String, Object> map) {
		return sqlSession.selectList(NS+".allDamegeGoodsList",map);
	}

	@Override
	public List<Damege_goodsDto> damegeGoodsDetail(Map<String, Object> map) {
		return sqlSession.selectList(NS+".damegeGoodsDetail",map);
	}

	@Override
	public List<Damege_goodsDto> getDamageSearch(Map<String, Object> map) {
		return sqlSession.selectList(NS+".damageSearch",map);
	}	
}
