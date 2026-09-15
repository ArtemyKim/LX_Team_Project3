package lx.edu.subwayproject.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import lx.edu.subwayproject.dto.RouteDTO;

@Component
public class SubwayRouteDAO {

	@Autowired
	private SqlSession sqlSession;
	
	// Route 등록, 등록시에 scheduleId가 포함되어야 함에 유의
	public void insertRoute(RouteDTO route) {
		
		sqlSession.insert("lx.edu.subwayproject.dao.SubwayRouteDAO.insertRoute", route);
	}
	
	
    // 특정 Schedule에 포함된 Route 목록 조회
    public List<RouteDTO> selectRoutesByScheduleId(int scheduleId) {
    	
    	// 디버깅용
    	System.out.println("Schedule에 포함된 Route 목록 조회(scheduleId:"+scheduleId+")");
    	System.out.println("목록 : "+sqlSession.selectList(
                "lx.edu.subwayproject.dao.SubwayRouteDAO.selectRoutesByScheduleId",scheduleId));
    	
        return sqlSession.selectList(
            "lx.edu.subwayproject.dao.SubwayRouteDAO.selectRoutesByScheduleId",
            scheduleId
        );
    }
}
