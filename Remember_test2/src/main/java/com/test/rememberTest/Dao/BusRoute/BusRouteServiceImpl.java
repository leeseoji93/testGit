package com.test.rememberTest.Dao.BusRoute;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.rememberTest.Dto.BusRouteDto;


@Service
public class BusRouteServiceImpl implements BusRouteService{

	 @Autowired
	    private BusRouteDao busRouteDao;

	
	@Override
	public void Route_insertData(BusRouteDto busRouteDto) {
		busRouteDao.Route_insertData(busRouteDto);		
	}//노선 정보 insert

	@Override
	public List<BusRouteDto> Route_selectData(String bus_id,String route_start,String route_arrive) {
		Map<String, Object> map = new HashMap<String, Object>();       
        map.put("bus_id", bus_id);
        map.put("route_start", route_start);
        map.put("route_arrive", route_arrive);
        return busRouteDao.Route_selectData(map);
	}//노선 입력(차량배치 스탭) 배치여부 판단 select	 	
	
	@Override
	public List<BusRouteDto> Route_selectData1(String word) {
		Map<String, Object> map = new HashMap<String, Object>();       
        map.put("word", word); 
		return busRouteDao.Route_selectData1(map);
	}//차량이 배치된 노선 셀렉(차량 관리 상세 정보)


	@Override
	public List<BusRouteDto> Route_selectDataTeacher(String staff_id,String route_start,String route_arrive) {
		Map<String, Object> map = new HashMap<String, Object>();       
		map.put("staff_id", staff_id);
        map.put("route_start", route_start);
        map.put("route_arrive", route_arrive);
		return busRouteDao.Route_selectDataTeacher(map);
	}// 노선 입력(인솔교사 스탭) 배치여부 판단 select

	@Override
	public List<BusRouteDto> getRouteList(String center_code) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("center_code", center_code);
		return busRouteDao.seleceRouteList(map);
	}

	@Override
	public List<BusRouteDto> getRouteInfoAll(String center_code) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("center_code", center_code);
		return busRouteDao.seleceRouteInfoAll(map);
	}

	@Override
	public List<BusRouteDto> getRouteKidsAll(String code) {
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println("getRouteKidsAll code: "+code);
		map.put("code", code); 
		return busRouteDao.seleceRouteKidsAll(map);
	}

	@Override
	public List<BusRouteDto> getRouteDetail(String route_id) {
		return busRouteDao.selectRouteDetail(route_id);
	}

	@Override
	public List<BusRouteDto> getstationInRoute(String route_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("route_id", route_id); 
		return busRouteDao.selecstationInRoute(map);
	}

	@Override
	public List<BusRouteDto> getKidInStation(String route_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("route_id", route_id); 
		return busRouteDao.seleckidsInStation(map);
	}

	@Override
	public List<BusRouteDto> getAllKidInRoute(String route_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", route_id); 
		return busRouteDao.selecAllKidInRoute(map);
	}

	@Override
	public List<BusRouteDto> getUseRouteAll(String center_code) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("center_code", center_code); 
		return busRouteDao.selecUseRouteAll(map);
	}

	@Override
	public List<BusRouteDto> getrealTimeInfo(String center_code, String route_id) {
		System.out.println("ServiceImpl에서 getrealTimeInfo 시작!!!!!");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("center_code", center_code); 
		map.put("route_id", route_id); 
		return busRouteDao.selecrealTimeInfo(map);
	}

	@Override
	public List<BusRouteDto> Route_selectMaxRoute_id(String word) {
		Map<String, Object> map = new HashMap<String, Object>();       
		map.put("word", word);      
		return busRouteDao.Route_selectMaxRoute_id(map);
	}//Route 아이디 MAX 값 찾기

	@Override
	public List<BusRouteDto> getrouteBoardKid(String center_code, String route_id) {
		Map<String, Object> map = new HashMap<String, Object>();       
		map.put("center_code", center_code); 
		map.put("route_id", route_id); 
		return busRouteDao.routeBoardKid(map);
	}

	@Override
	public List<BusRouteDto> searchRoute(String keyWord,String center_code) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("keyWord", keyWord);
		map.put("center_code", center_code);
		return busRouteDao.searchRoute(map);
	}

	@Override
	public int routeUseCheck(String route_id,boolean route_use) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("route_id", route_id);
		map.put("route_use", route_use);
		return busRouteDao.routeUseCheck(map);
	}

	@Override
	public List<BusRouteDto> Route_selectUpdateBaseData(String route_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("route_id", route_id);
		return busRouteDao.Route_selectUpdateBaseData(map);
	}

	@Override
	public List<BusRouteDto> Route_selectDataList(String center_code) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("center_code", center_code);
		return busRouteDao.Route_selectDataList(map);
	}

	@Override
	public void Route_updateData(BusRouteDto busRouteDto) {
		
		if(busRouteDto.getSub_staff_id()==""){
			busRouteDto.setSub_staff_id(null);
		}		
		busRouteDao.Route_updateData(busRouteDto);
	}//Route 수정

	@Override
	public void getRouteDelete(String route_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("route_id", route_id);
		busRouteDao.RouteDelete(map);
	}

	@Override
	public List<BusRouteDto> stationNameInRoute(String station_id) {
		Map<String, Object> map = new HashMap<String, Object>();       
        map.put("station_id", station_id); 
		return busRouteDao.stationNameInRoute(map);
	}

	@Override
	public List<BusRouteDto> getRouteName(String route_id) {
		Map<String, Object> map = new HashMap<String, Object>();       
        map.put("route_id", route_id); 
		return busRouteDao.selectRouteName(map);
	}

	@Override
	public List<BusRouteDto> Route_select_AllData(String center_code) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("center_code", center_code);
		return busRouteDao.Route_select_AllData(map);
	}//노선 모든 정보 셀렉

	@Override
	public List<BusRouteDto> Route_select_RouteStationData(String route_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("route_id", route_id);
		return busRouteDao.Route_select_RouteStationData(map);
	}// 노선에 대치된 정류장 정보를 select

	@Override
	public List<BusRouteDto> BusRoute_select_RouteBusData(String route_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("route_id", route_id);
		return busRouteDao.BusRoute_select_RouteBusData(map);
	}// 해당 노선, 노선에 배치된 차량에대한 정보 select

	@Override
	public List<BusRouteDto> getCarNStationCount(String center_code) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("center_code", center_code);
		return busRouteDao.carNStationCount(map);
	}// 대쉬보드 , 차량 및 정류장 개수

	@Override
	public List<BusRouteDto> getRouteLatestList(String center_code) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("center_code", center_code);
		return busRouteDao.routeLatestList(map);
	}// 대쉬보드 , 노선 3개


}
