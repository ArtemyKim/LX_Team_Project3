package lx.edu.subwayproject.service;

import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lx.edu.subwayproject.dao.SubwayNoticeDAO;
import lx.edu.subwayproject.dao.SubwayRouteDAO;
import lx.edu.subwayproject.dao.SubwayScheduleDAO;
import lx.edu.subwayproject.dto.RouteDTO;
import lx.edu.subwayproject.dto.ScheduleDTO;
import lx.edu.subwayproject.dto.SubwayNoticeDTO;

@Service
public class ScheduleService {

    @Autowired
    private SubwayScheduleDAO dao;
    @Autowired
    private SubwayRouteDAO routeDao;
    
    // 스케쥴을 스케쥴 DB/ route DB에 저장하는 코드
    // 여기가 쬑끔 어려움 공부 필요 ㅋㅋ 자세히 설명 필요하면 말하셈
    public void insertSchedule(ScheduleDTO schedule) throws Exception {
    		//스케쥴 테이블에 스케쥴 저장       
            dao.insertSchedule(schedule);
            
            //생성된 스케쥴 번호 가져옴
            int scheduledId = schedule.getScheduleId();
            //사용자가 입력한 경로(루트) 꺼냄
            List<RouteDTO> routes = schedule.getRoutes();
            
            //첫번째 경로부터 1번으로 시작
            int routeSeq = 1;
            
            //여러개 경로 for문으로 하나씩 꺼내서 저장
            for (RouteDTO route : routes) {
            	route.setScheduleId(scheduledId);
            	route.setRouteSeq(routeSeq);
            	routeDao.insertRoute(route);
            	
            // 다음 경로를 위해 순서 +1	
            	routeSeq++;
            }     
        }
}

	