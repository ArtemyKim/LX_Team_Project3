package lx.edu.subwayproject.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import lx.edu.subwayproject.dto.StationDTO;


@Component
public class StationDAO {

    @Autowired
    private SqlSession sqlSession;

    public List<StationDTO> getStationsByLine(
            String lineName) {

        return sqlSession.selectList(
            "stationMapper.getStationsByLine",
            lineName
        );
    }
}