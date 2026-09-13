package lx.edu.subwayproject.dao;

import org.apache.ibatis.annotations.Mapper;

import lx.edu.subwayproject.dto.StationDTO;

@Mapper
public interface SubwayStationDAO {
	void insertStation(StationDTO station);
	
	StationDTO selectStationById(int StationId);
}
