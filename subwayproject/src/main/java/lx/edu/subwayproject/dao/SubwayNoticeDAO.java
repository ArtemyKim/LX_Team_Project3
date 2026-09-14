package lx.edu.subwayproject.dao;

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
}