package lx.edu.subwayproject.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import lx.edu.subwayproject.dto.UserDTO;


@Mapper
public interface UserDAO {

    int addUser(UserDTO user);

    UserDTO selectUserByUserName(
        @Param("userName") String userName
    );
}