package lx.edu.subwayproject.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import lx.edu.subwayproject.dto.RouteDTO;

@Component
public class SubwayRouteDAO {

	@Autowired
	private SqlSession sqlSession;
	
	public void insertRoute(RouteDTO route) {
		
		sqlSession.insert("lx.edu.subwayproject.dao.SubwayRouteDAO.insertRoute", route);
	}
}
