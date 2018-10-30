package com.test.rememberTest.Dao.BusRoute;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.rememberTest.Dto.BusRouteDto;


@Repository
public class BusRouteDaoImpl implements BusRouteDao{
	private final String NS = "com.test.rememberTest.Map.UserMapper";
	
	 @Autowired  	
	    private SqlSessionTemplate sqlSession;

	@Override
	public void Route_insertData(BusRouteDto route) {
		sqlSession.insert(NS+".Route_insertData", route);		
	}//노선 정보 insert

	@Override
	public List<BusRouteDto> Route_selectData(Map<String, Object> map) {
		
		return sqlSession.selectList(NS+".Route_selectDataBus",map);
	}//노선 입력(차량배치 스탭) 배치여부 판단 select	
	
	@Override
	public List<BusRouteDto> Route_selectData1(Map<String, Object> map) {
		return sqlSession.selectList(NS+".Route_selectData1",map);
	}//차량이 배치된 노선 셀렉

	@Override
	public List<BusRouteDto> Route_selectDataTeacher(Map<String, Object> map) {
		return sqlSession.selectList(NS+".Route_selectDataTeacher",map);
	}// 노선 입력(인솔교사 스탭) 배치여부 판단 select

	@Override
	public List<BusRouteDto> seleceRouteList(Map<String, Object> map) {
		return sqlSession.selectList(NS+".seleceRouteList",map);
	}

	@Override
	public List<BusRouteDto> seleceRouteInfoAll(Map<String, Object> map) {
		return sqlSession.selectList(NS+".seleceRouteInfoAll", map);
	}

	@Override
	public List<BusRouteDto> seleceRouteKidsAll(Map<String, Object> map) {
		return sqlSession.selectList(NS+".seleceRouteKidsAll", map);
	}

	@Override
	public List<BusRouteDto> selectRouteDetail(String route_id) {
		return sqlSession.selectList(NS+".selectRouteDetail",route_id);
	}

	@Override
	public List<BusRouteDto> selecstationInRoute(Map<String, Object> map) {
		return sqlSession.selectList(NS+".selecstationInRoute", map);
	}

	@Override
	public List<BusRouteDto> seleckidsInStation(Map<String, Object> map) {
		return sqlSession.selectList(NS+".seleckidsInStation", map);
	}

	@Override
	public List<BusRouteDto> selecAllKidInRoute(Map<String, Object> map) {
		return sqlSession.selectList(NS+".selecAllKidInRoute", map);
	}

	@Override
	public List<BusRouteDto> selecUseRouteAll(Map<String, Object> map) {
		return sqlSession.selectList(NS+".selecUseRouteAll", map);
	}

	@Override
	public List<BusRouteDto> selecrealTimeInfo(Map<String, Object> map) {
		return sqlSession.selectList(NS+".selecrealTimeInfo", map);
	}

	@Override
	public List<BusRouteDto> Route_selectMaxRoute_id(Map<String, Object> map) {
		return sqlSession.selectList(NS+".Route_selectMaxRoute_id",map);
	}

	@Override
	public List<BusRouteDto> routeBoardKid(Map<String, Object> map) {
		return sqlSession.selectList(NS+".routeBoardKid",map);
	}

	@Override
	public List<BusRouteDto> searchRoute(Map<String, Object> map) {
		return sqlSession.selectList(NS+".searchRoute", map);
	}

	@Override
	public int routeUseCheck(Map<String, Object> map) {
		return sqlSession.update(NS+".routeUseCheck",map);
	}

	@Override
	public List<BusRouteDto> Route_selectUpdateBaseData(Map<String, Object> map) {
		return sqlSession.selectList(NS+".Route_selectUpdateBaseData",map);
	}//노선 수정 기본 베이스값 select

	@Override
	public List<BusRouteDto> Route_selectDataList(Map<String, Object> map) {
		return sqlSession.selectList(NS+".Route_selectDataList",map);
	}//노선 리스트 select

	@Override
	public void Route_updateData(BusRouteDto route) {
		sqlSession.update(NS+".Route_updateData", route);		
	}//Route 수정

	@Override
	public void RouteDelete(Map<String, Object> map) {
		sqlSession.delete(NS+".RouteDelete", map);
	}//Route 삭제

	@Override
	public List<BusRouteDto> stationNameInRoute(Map<String, Object> map) {
		return sqlSession.selectList(NS+".stationNameInRoute",map);
	}//노선에 배치된 정류장 알기 위함

	@Override
	public List<BusRouteDto> selectRouteName(Map<String, Object> map) {
		return sqlSession.selectList(NS+".selectRouteName",map);
	}

	@Override
	public List<BusRouteDto> Route_select_AllData(Map<String, Object> map) {
		return sqlSession.selectList(NS+".Route_select_AllData", map);
	}//노선 모든 정보 셀렉

	@Override
	public List<BusRouteDto> Route_select_RouteStationData(Map<String, Object> map) {
		return sqlSession.selectList(NS+".Route_select_RouteStationData", map);
	}// 노선에 대치된 정류장 정보를 select

	@Override
	public List<BusRouteDto> BusRoute_select_RouteBusData(Map<String, Object> map) {
		return sqlSession.selectList(NS+".BusRoute_select_RouteBusData", map);
	}// 해당 노선, 노선에 배치된 차량에대한 정보 select

	@Override
	public List<BusRouteDto> carNStationCount(Map<String, Object> map) {
		return sqlSession.selectList(NS+".carNStationCount", map);
	}// 대쉬보드 , 차량 및 정류장 개수

	@Override
	public List<BusRouteDto> routeLatestList(Map<String, Object> map) {
		return sqlSession.selectList(NS+".routeLatestList", map);
	}// 대쉬보드 , 노선 3개
	
	
}
