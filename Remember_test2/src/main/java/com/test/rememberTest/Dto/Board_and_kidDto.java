package com.test.rememberTest.Dto;

import java.util.List;

public class Board_and_kidDto {
	private String route_id;
	
	private String station_id;
	
	private String center_code;
	
	private String kid_system_code;
	
	private List<Board_and_kidDto> board_and_kidDto;

	public Board_and_kidDto() {

	}

	public Board_and_kidDto(String route_id, String station_id, String center_code, String kid_system_code,
			List<Board_and_kidDto> board_and_kidDto) {
		super();
		this.route_id = route_id;
		this.station_id = station_id;
		this.center_code = center_code;
		this.kid_system_code = kid_system_code;
		this.board_and_kidDto = board_and_kidDto;
	}

	public String getRoute_id() {
		return route_id;
	}

	public void setRoute_id(String route_id) {
		this.route_id = route_id;
	}

	public String getStation_id() {
		return station_id;
	}

	public void setStation_id(String station_id) {
		this.station_id = station_id;
	}

	public String getCenter_code() {
		return center_code;
	}

	public void setCenter_code(String center_code) {
		this.center_code = center_code;
	}

	public String getKid_system_code() {
		return kid_system_code;
	}

	public void setKid_system_code(String kid_system_code) {
		this.kid_system_code = kid_system_code;
	}

	public List<Board_and_kidDto> getBoard_and_kidDto() {
		return board_and_kidDto;
	}

	public void setBoard_and_kidDto(List<Board_and_kidDto> board_and_kidDto) {
		this.board_and_kidDto = board_and_kidDto;
	}
	
	

}
