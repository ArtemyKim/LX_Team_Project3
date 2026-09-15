package lx.edu.subwayproject.service;

import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
    
    // 이례상황 조회용
    @Autowired
    private SubwayNoticeService noticeService;

    // 새 스케쥴 등록
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


    	 // 1. 사용자의 Schedule 목록 조회
        List<ScheduleDTO> scheduleList =
                dao.selectSchedulesByUserId(userId);


        // 2. 각각의 Schedule 처리
        for (ScheduleDTO schedule : scheduleList) {


            // -------------------------
            // Route 조회
            // -------------------------

            List<RouteDTO> routes =
                    routeDao.selectRoutesByScheduleId(
                            schedule.getScheduleId()
                    );

            schedule.setRoutes(routes);


            // -------------------------
            // 같은 날짜의 이례상황 조회
            // -------------------------

            List<SubwayNoticeDTO> notices =
                    noticeService.getNoticeListByDate(
                            schedule.getTravelDate()
                    );


            // 조회한 이례상황을 ScheduleDTO에 저장
            schedule.setNotices(notices);
        }


        return scheduleList;
    }
}
