package lx.edu.subwayproject.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lx.edu.subwayproject.dao.SubwayRouteDAO;
import lx.edu.subwayproject.dao.SubwayScheduleDAO;
import lx.edu.subwayproject.dto.RouteDTO;
import lx.edu.subwayproject.dto.ScheduleDTO;

@Service
public class ScheduleService {

    @Autowired
    private SubwayScheduleDAO dao;

    @Autowired
    private SubwayRouteDAO routeDao;


    // =========================
    // Schedule 등록
    // =========================
    public void insertSchedule(ScheduleDTO schedule)
            throws Exception {


        // Schedule 테이블에 먼저 저장
        dao.insertSchedule(schedule);


        // INSERT 후 생성된 Schedule ID
        int scheduleId =
                schedule.getScheduleId();


        // 사용자가 입력한 Route 목록
        List<RouteDTO> routes =
                schedule.getRoutes();


        int routeSeq = 1;


        // Route 각각 저장
        for (RouteDTO route : routes) {

            route.setScheduleId(scheduleId);

            route.setRouteSeq(routeSeq);

            routeDao.insertRoute(route);

            routeSeq++;
        }
    }


    // =========================
    // 특정 유저의 Schedule 조회
    // =========================
    public List<ScheduleDTO> selectSchedulesByUserId(
            int userId) {


        // Schedule 목록 조회
        List<ScheduleDTO> scheduleList =
                dao.selectSchedulesByUserId(userId);


        // 각각의 Schedule에 해당하는 Route 조회
        for (ScheduleDTO schedule : scheduleList) {


            List<RouteDTO> routes =
                    routeDao.selectRoutesByScheduleId(
                            schedule.getScheduleId()
                    );


            schedule.setRoutes(routes);
        }


        return scheduleList;
    }
}