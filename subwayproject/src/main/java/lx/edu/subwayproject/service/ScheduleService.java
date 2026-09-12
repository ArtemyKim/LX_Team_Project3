package lx.edu.subwayproject.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lx.edu.subwayproject.dao.ScheduleDAO;
import lx.edu.subwayproject.dao.SubwayNoticeDAO;
import lx.edu.subwayproject.dto.ScheduleDTO;
import lx.edu.subwayproject.dto.SubwayNoticeDTO;

@Service
public class ScheduleService {

    @Autowired
    private ScheduleDAO dao;
    
    // 스케쥴을 DB에 저장하는 코드
    public void insertSchedule(ScheduleDTO schedule) throws Exception {

            dao.insertSchedule(schedule);

        }
    
}
