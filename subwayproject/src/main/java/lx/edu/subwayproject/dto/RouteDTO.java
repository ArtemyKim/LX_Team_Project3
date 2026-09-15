package lx.edu.subwayproject.dto;

import java.time.LocalDate;
import java.time.LocalTime;

import lombok.Data;


@Data // lombok 사용
public class RouteDTO {

    private int routeId; // Primary key용
    private int scheduleId; // 해당 루트를 가지는 스케쥴의 ID
    private int departureStationId; // 출발역의 ID
    private int arrivalStationId; // 도착역의 ID
    
    // ROUTE 테이블의 순서
    private int routeSeq;
    
    // 조회 화면 출력용
    private String departureStationName;
    private String arrivalStationName;
    

}