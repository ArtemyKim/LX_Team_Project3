package lx.edu.subwayproject.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
	
	
//	“이 반환값을 JSP 이름으로 해석하지 말고, HTTP 응답 데이터로 직접 보내” 
//	전에는 역 목록을 조회한 뒤 JSP로 이동했고, 지금은 역 목록을 조회한 뒤 JSON 데이터 자체를 브라우저에 반환하게 바꾼 거야.
	@ResponseBody
	@RequestMapping("/stationsByLine.do")
	public List<StationDTO> stationsByLine(@RequestParam("lineName") String lineName) {
		List<StationDTO> stations = stationService.selectStationByLineName(lineName);
		System.out.println("stationByLine.do 호출됨 : "+stations);
	return stations;
	}
	
}

