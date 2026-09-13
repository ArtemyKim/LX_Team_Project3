package lx.edu.subwayproject.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import lx.edu.subwayproject.dto.ScheduleDTO;

@Mapper
public interface SubwayScheduleDAO {

	
	void insertSchedule(ScheduleDTO schedule);	
	List<ScheduleDTO> selectScedulesByUserId(int userId);
}
