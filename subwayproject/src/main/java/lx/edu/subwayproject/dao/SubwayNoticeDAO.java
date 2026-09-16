package lx.edu.subwayproject.dao;

import java.time.LocalDate;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import lx.edu.subwayproject.dto.SubwayNoticeDTO;

@Component
public class SubwayNoticeDAO {

    @Autowired
    private SqlSession sqlSession;

    public void insertNotice(SubwayNoticeDTO dto) {

        sqlSession.insert(
            "lx.edu.subwayproject.dao.SubwayNoticeDAO.insertNotice",
            dto
        );
    }
    
    
    // 날짜에 따라 이례상황 가져오기
    public List<SubwayNoticeDTO> getNoticeListByDate(
            LocalDate scheduleDate) {

        return sqlSession.selectList(
            "lx.edu.subwayproject.dao.SubwayNoticeDAO.getNoticeListByDate",
            scheduleDate
        );
    }
    
    public void truncateNoticeList() {
    	
    	sqlSession.delete(
    			"lx.edu.subwayproject.dao.SubwayNoticeDAO.truncateNoticeList"
            );
    }
}