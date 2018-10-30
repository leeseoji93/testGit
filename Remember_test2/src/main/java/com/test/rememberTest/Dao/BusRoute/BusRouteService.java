package com.test.rememberTest.Dao.BusRoute;

import java.util.List;
import java.util.Map;

import com.test.rememberTest.Dto.BusRouteDto;



public interface BusRouteService {
	public List<BusRouteDto> Route_select_AllData(String center_code);//노선 모든 정보 셀렉
	public List<BusRouteDto> Route_selectData(String carName,String startTime,String endTime);//노선 입력(차량배치 스탭) 배치여부 판단 select
	public List<BusRouteDto> Route_selectDataTeacher(String staff_id,String route_start,String route_arrive);// 노선 입력(인솔교사 스탭) 배치여부 판단 select
	
	public List<BusRouteDto> Route_selectData1(String word);//차량이 배치된 노선 셀렉(차량 관리 상세 정보)
	public void  Route_insertData(BusRouteDto busRouteDto);//노선 정보 입력
	public List<BusRouteDto> getRouteList(String center_code);
	public List<BusRouteDto> getRouteInfoAll(String code);
	public List<BusRouteDto> getRouteKidsAll(String code);
	public List<BusRouteDto> getRouteDetail(String route_id);
	public List<BusRouteDto> getstationInRoute(String route_id);
	public List<BusRouteDto> getKidInStation(String route_id);
	public List<BusRouteDto> getAllKidInRoute(String route_id);
	public List<BusRouteDto> getUseRouteAll(String center_code);
	public List<BusRouteDto> getrealTimeInfo(String center_code, String route_id);
	public List<BusRouteDto> Route_selectMaxRoute_id(String code);
	public List<BusRouteDto> getrouteBoardKid(String center_code, String route_id);
	public List<BusRouteDto> searchRoute(String searchName, String center_code);
	public int routeUseCheck(String route_id, boolean route_use);
	public List<BusRouteDto> Route_selectUpdateBaseData(String route_id);
	public List<BusRouteDto> Route_selectDataList(String center_code);
	public void Route_updateData(BusRouteDto busRouteDto);
	public void getRouteDelete(String route_id);
	public List<BusRouteDto> stationNameInRoute(String station_id);
	public List<BusRouteDto> getRouteName(String route_id);
	
	public List<BusRouteDto> Route_select_RouteStationData(String route_id);// 노선에 대치된 정류장 정보를 select
	public List<BusRouteDto> BusRoute_select_RouteBusData(String route_id);// 해당 노선, 노선에 배치된 차량에대한 정보 select
	public List<BusRouteDto> getCarNStationCount(String center_code);
	public List<BusRouteDto> getRouteLatestList(String center_code);
	
	
}

