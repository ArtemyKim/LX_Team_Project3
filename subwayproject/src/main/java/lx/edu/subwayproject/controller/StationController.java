package lx.edu.subwayproject.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletRequest;
import lx.edu.subwayproject.dto.StationDTO;
import lx.edu.subwayproject.service.StationService;

@Controller
public class StationController {

	@Autowired
	StationService stationService;
	
	@RequestMapping("/station.do")
	public String station(HttpServletRequest req) {
		List<String> lineNames = stationService.selectLineNames();
		req.setAttribute("lineNames", lineNames);
		System.out.println("station.do 호출됨 : "+lineNames);
		return "station";
	}
	
	@RequestMapping("/stationsByLine.do")
	public String stationsByLine(@RequestParam("lineName") String lineName, HttpServletRequest req) {
		List<StationDTO> stations = stationService.selectStationByLineName(lineName);
		req.setAttribute("stations", stations);
		System.out.println("stationByLine.do 호출됨 : "+stations);
	return "stationsByLine";
	}
	
}

