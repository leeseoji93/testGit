package com.test.rememberTest.Dao.Stat_sche;

import java.util.List;

public interface Stat_scheService {
	public void Stat_sche_insert(String affiliation
			,String route_id,List<String> station_id,List<String> arrive_time,String registrant);//Stat_sche 정보 입력

	public void Stat_sche_delete(String route_id);
}


