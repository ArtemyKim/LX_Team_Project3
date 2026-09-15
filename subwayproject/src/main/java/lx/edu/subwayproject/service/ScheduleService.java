package lx.edu.subwayproject.service;

import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lx.edu.subwayproject.dao.SubwayRouteDAO;
import lx.edu.subwayproject.dao.SubwayScheduleDAO;
import lx.edu.subwayproject.dto.RouteDTO;
import lx.edu.subwayproject.dto.ScheduleDTO;
import lx.edu.subwayproject.dto.StationDTO;
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
    
    // 역 코드 조회용
    @Autowired
    private StationService stationService;

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
    public List<ScheduleDTO> selectSchedulesByUserId(int userId) {

        // 사용자의 Schedule 목록 조회
        List<ScheduleDTO> scheduleList =
                dao.selectSchedulesByUserId(userId);


        for (ScheduleDTO schedule : scheduleList) {


            // =========================
            // Route 조회
            // =========================

            List<RouteDTO> routes =
                    routeDao.selectRoutesByScheduleId(
                            schedule.getScheduleId()
                    );

            schedule.setRoutes(routes);


            // =========================
            // 해당 날짜 Notice 조회
            // =========================

            List<SubwayNoticeDTO> notices =
                    noticeService.getNoticeListByDate(
                            schedule.getTravelDate()
                    );

            schedule.setNotices(notices);


            // =========================
            // 문제 여부
            // =========================

            boolean problem = false;


            for (SubwayNoticeDTO notice : notices) {

                String sectionCodes =
                        notice.getStationSectionCodeList();


                // ---------------------------------
                // 1. 역 구간 정보 없음
                // ---------------------------------
                if (sectionCodes == null
                        || sectionCodes.isBlank()) {

                    continue;
                }


                // ---------------------------------
                // 2. 전구간
                // ---------------------------------
                if ("전구간".equals(sectionCodes.trim())) {

                    for (RouteDTO route : routes) {

                        if (isWholeLineAffected(route, notice)) {

                            problem = true;
                            break;
                        }
                    }

                }


                // ---------------------------------
                // 3. 특정 역 코드
                // ---------------------------------
                else {

                    List<String> stationCodes =
                            Arrays.stream(
                                    sectionCodes.split("\\s*,\\s*")
                            )
                            .toList();


                    List<StationDTO> affectedStations =
                            stationService.selectStationsByCodes(
                                    stationCodes
                            );


                    for (RouteDTO route : routes) {

                        if (isRouteAffected(
                                route,
                                affectedStations)) {

                            problem = true;
                            break;
                        }
                    }
                }


                // 이미 문제가 확인됐으면
                // 다른 Notice를 더 검사할 필요 없음
                if (problem) {
                    break;
                }
            }


            // ScheduleDTO에 최종 결과 저장
            schedule.setProblem(problem);
        }


        return scheduleList;
    }
    
    // 해당 루트가 영향받았는지를 return하는 것
    private boolean isRouteAffected(
            RouteDTO route,
            List<StationDTO> affectedStations) {


        int start =
                route.getDepartureLineOrderId();

        int end =
                route.getArrivalLineOrderId();


        // 어느 방향으로 이동하든 처리
        int min =
                Math.min(start, end);

        int max =
                Math.max(start, end);


        // Route의 노선 번호
        int routeLine =
                start / 1000;


        for (StationDTO station : affectedStations) {

            int noticeOrder =
                    station.getLineOrderId();


            // LINE_ORDER_ID가 없는 데이터 방지
            if (noticeOrder == 0) {
                continue;
            }


            int noticeLine =
                    noticeOrder / 1000;


            // 다른 노선이면 무시
            if (routeLine != noticeLine) {
                continue;
            }


            // 실제 이용 구간 안에 Notice 역이 존재하는가?
            if (noticeOrder >= min
                    && noticeOrder <= max) {

                return true;
            }
        }


        return false;
    }
    
    // '전구간' 처리용입니다
    private boolean isWholeLineAffected(
            RouteDTO route,
            SubwayNoticeDTO notice) {


        String lineNameList =
                notice.getLineNameList();


        if (lineNameList == null
                || lineNameList.isBlank()) {

            return false;
        }


        // 출발역 LINE_ORDER_ID의 천의 자리 = 호선
        int routeLine =
                route.getDepartureLineOrderId()
                     / 1000;


        String routeLineName =
                routeLine + "호선";


        return lineNameList.contains(routeLineName);
    }
}
