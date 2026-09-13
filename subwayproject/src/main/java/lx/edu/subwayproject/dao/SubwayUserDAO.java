package lx.edu.subwayproject.dao;

import org.apache.ibatis.annotations.Mapper;
import lx.edu.subwayproject.dto.UserDTO;

@Mapper
public interface SubwayUserDAO {

	void insertUser(UserDTO user);	
	UserDTO selectUserwithSchdules(int userId);
	
}
