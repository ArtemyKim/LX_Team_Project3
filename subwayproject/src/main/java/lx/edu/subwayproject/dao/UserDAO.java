package lx.edu.subwayproject.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import lx.edu.subwayproject.dto.UserDTO;

@Component
public class UserDAO {

    @Autowired
    private SqlSession sqlSession;

    public int addUser(UserDTO user) {

        return sqlSession.insert(
            "lx.edu.subwayproject.dao.UserDAO.addUser",
            user
        );
    }

    public UserDTO selectUserByUserName(String userName) {

        return sqlSession.selectOne(
            "lx.edu.subwayproject.dao.UserDAO.selectUserByUserName",
            userName
        );
    }
}