package lx.edu.subwayproject.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import lx.edu.subwayproject.dto.ScheduleDTO;

@Component
public class SubwayScheduleDAO {

    @Autowired
    private SqlSession sqlSession;

    public void insertSchedule(ScheduleDTO schedule) {

        sqlSession.insert(
            "lx.edu.subwayproject.dao.SubwayScheduleDAO.insertSchedule",
            schedule
        );
    }

    public List<ScheduleDTO> selectSchedulesByUserId(int userId) {

        return sqlSession.selectList(
            "lx.edu.subwayproject.dao.SubwayScheduleDAO.selectSchedulesByUserId",
            userId
        );
    }
    
    public void deleteSchedule(int scheduleId) {
    	sqlSession.delete("lx.edu.subwayproject.dao.SubwayScheduleDAO.deleteSchedule", scheduleId);
    }
    
    
}