package lx.edu.subwayproject.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import lx.edu.subwayproject.dto.StationDTO;

@Component
public class SubwayStationDAO {

    @Autowired
    private SqlSession sqlSession;

    public void insertStation(StationDTO station) {

        sqlSession.insert(
            "lx.edu.subwayproject.dao.SubwayStationDAO.insertStation",
            station
        );
    }

    public StationDTO selectStationById(int stationId) {

        return sqlSession.selectOne(
            "lx.edu.subwayproject.dao.SubwayStationDAO.selectStationById",
            stationId
        );
    }
}