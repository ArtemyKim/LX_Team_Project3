package lx.edu.subwayproject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.stereotype.Controller;

import lx.edu.subwayproject.dto.StationDTO;
import lx.edu.subwayproject.service.StationService;


@Controller
public class StationController {

    @Autowired
    private StationService stationService;


    @GetMapping("/stations/by-line")
    @ResponseBody
    public List<StationDTO> getStationsByLine(
            @RequestParam String lineName) {

        return stationService.getStationsByLine(lineName);
    }
}