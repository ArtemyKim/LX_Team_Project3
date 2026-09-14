package lx.edu.subwayproject.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import lx.edu.subwayproject.dto.StationDTO;

@Mapper
public interface SubwayStationDAO {
	void insertStation(StationDTO station);
	
	StationDTO selectStationById(int StationId);
	
	//selectLineNames를 호출해서 List<String>을 반환하는 메서드
	List<String> selectLineNames();
	
	
	List<StationDTO> selectStationByLineName(
			@Param("lineName") String lineName
);
	
}
