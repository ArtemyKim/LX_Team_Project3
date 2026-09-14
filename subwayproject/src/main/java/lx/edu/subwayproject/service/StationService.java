package lx.edu.subwayproject.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lx.edu.subwayproject.dao.StationDAO;
import lx.edu.subwayproject.dto.StationDTO;


@Service
public class StationService {

    @Autowired
    private StationDAO stationDAO;


    public List<StationDTO> getStationsByLine(
            String lineName) {

        return stationDAO.getStationsByLine(
            lineName
        );
    }
}