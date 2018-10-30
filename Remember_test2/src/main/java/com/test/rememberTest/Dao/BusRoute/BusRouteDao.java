package com.test.rememberTest.Dao.BusRoute;

import java.util.List;
import java.util.Map;

import com.test.rememberTest.Dto.BusRouteDto;


public interface BusRouteDao {

	public List<BusRouteDto> Route_selectData(Map<String, Object> map);//노선 입력(차량배치 스탭) 배치여부 판단 select
	public List<BusRouteDto> Route_selectDataTeacher(Map<String, Object> map);// 노선 입력(인솔교사 스탭) 배치여부 판단 select
	
	public List<BusRouteDto> Route_selectData1(Map<String, Object> map);// 차량이 배치된 노선 셀렉(차량 관리 상세 정보)	
	public void Route_insertData(BusRouteDto route);	//노선 입력
	public List<BusRouteDto> seleceRouteList(Map<String, Object> map);
	public List<BusRouteDto> seleceRouteInfoAll(Map<String, Object> map);
	public List<BusRouteDto> seleceRouteKidsAll(Map<String, Object> map);
	public List<BusRouteDto> selectRouteDetail(String route_id);
	public List<BusRouteDto> selecstationInRoute(Map<String, Object> map);
	public List<BusRouteDto> seleckidsInStation(Map<String, Object> map);
	public List<BusRouteDto> selecAllKidInRoute(Map<String, Object> map);
	public List<BusRouteDto> selecUseRouteAll(Map<String, Object> map);
	public List<BusRouteDto> selecrealTimeInfo(Map<String, Object> map);
	public List<BusRouteDto> Route_selectMaxRoute_id(Map<String, Object> map);
	public List<BusRouteDto> routeBoardKid(Map<String, Object> map);
	public List<BusRouteDto> searchRoute(Map<String, Object> map);
	public int routeUseCheck(Map<String, Object> map);
	public List<BusRouteDto> Route_selectUpdateBaseData(Map<String, Object> map);
	public List<BusRouteDto> Route_selectDataList(Map<String, Object> map);
	public void Route_updateData(BusRouteDto busRouteDto);
	public void RouteDelete(Map<String, Object> map);
	public List<BusRouteDto> stationNameInRoute(Map<String, Object> map);
	public List<BusRouteDto> selectRouteName(Map<String, Object> map);
	public List<BusRouteDto> Route_select_AllData(Map<String, Object> map);
	public List<BusRouteDto> Route_select_RouteStationData(Map<String, Object> map);
	public List<BusRouteDto> BusRoute_select_RouteBusData(Map<String, Object> map);
	public List<BusRouteDto> carNStationCount(Map<String, Object> map);
	public List<BusRouteDto> routeLatestList(Map<String, Object> map);
	
}
