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
            "lx.edu.subwayproject.dao.SubwayStationDAO.insertStation",
            station
        );
    }


    // stationId로 역 조회
    public StationDTO selectStationById(int stationId) {

        return sqlSession.selectOne(
            "lx.edu.subwayproject.dao.SubwayStationDAO.selectStationById",
            stationId
        );
    }

    /*
    // 호선명으로 역 목록 조회(일단 미사용)
    public List<StationDTO> getStationsByLine(String lineName) {

        return sqlSession.selectList(
            "lx.edu.subwayproject.dao.SubwayStationDAO.getStationsByLine",
            lineName
        );
    }
    */
    
    // 모든 호선명 조회
    public List<String> selectLineNames() {

        return sqlSession.selectList(
            "lx.edu.subwayproject.dao.SubwayStationDAO.selectLineNames"
        );
    }


    // 특정 호선의 역 목록 조회
    public List<StationDTO> selectStationByLineName(String lineName) {

        return sqlSession.selectList(
            "lx.edu.subwayproject.dao.SubwayStationDAO.selectStationByLineName",
            lineName
        );
    }
    

}