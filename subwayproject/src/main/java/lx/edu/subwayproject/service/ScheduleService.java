package lx.edu.subwayproject.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lx.edu.subwayproject.dao.SubwayScheduleDAO;
import lx.edu.subwayproject.dto.ScheduleDTO;

@Service
public class ScheduleService {

    @Autowired
    private SubwayScheduleDAO dao;
    
    // 1. 스케줄을 DB에 저장하는 메서드
    public void insertSchedule(ScheduleDTO schedule) {
        dao.insertSchedule(schedule);
    }
    
    // 2. 유저 ID로 저장된 스케줄 목록을 불러오는 메서드 (DAO에 맞춰서 추가)
    public List<ScheduleDTO> getSchedulesByUserId(int userId) {
        return dao.selectSchedulesByUserId(userId); 
    }
}