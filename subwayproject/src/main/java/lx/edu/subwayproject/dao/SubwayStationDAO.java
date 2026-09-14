package lx.edu.subwayproject.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import lx.edu.subwayproject.dto.StationDTO;

@Component
public class SubwayStationDAO {

    @Autowired
    private SqlSession sqlSession;


    // 역 추가
    public void insertStation(StationDTO station) {

        sqlSession.insert(
            "mapper-station.insertStation",
            station
        );
    }


    // stationId로 역 조회
    public StationDTO selectStationById(int stationId) {

        return sqlSession.selectOne(
            "mapper-station.selectStationById",
            stationId
        );
    }


    // 호선명으로 역 목록 조회
    public List<StationDTO> getStationsByLine(String lineName) {

        return sqlSession.selectList(
            "mapper-station.getStationsByLine",
            lineName
        );
    }
}