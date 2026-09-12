package lx.edu.subwayproject.dao;

import org.apache.ibatis.annotations.Mapper;

import lx.edu.subwayproject.dto.SubwayNoticeDTO;

@Mapper
public interface ScheduleDAO {

    void insertSchedule(SubwayNoticeDTO dto);

}