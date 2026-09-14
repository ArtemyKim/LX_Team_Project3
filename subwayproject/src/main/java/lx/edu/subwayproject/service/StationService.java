package lx.edu.subwayproject.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lx.edu.subwayproject.dao.SubwayStationDAO;
import lx.edu.subwayproject.dto.StationDTO;

@Service
public class StationService {

	@Autowired
	SubwayStationDAO stationDao;	
	
	public List<String> selectLineNames() {
		List<String> lineNames = stationDao.selectLineNames();
		return lineNames;
	}
	
	public List<StationDTO> selectStationByLineName(String lineName) {
		List<StationDTO> stations = stationDao.selectStationByLineName(lineName);				
		return stations;				
	}		
}
