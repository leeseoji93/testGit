package com.test.rememberTest.Dao.Course_and_station;

import java.util.List;
import java.util.Map;



public interface Course_and_stationService {

	public void course_and_station_delete(String course_id);

	public void course_and_station_insert(String course_id, List<String> station_id);
}
