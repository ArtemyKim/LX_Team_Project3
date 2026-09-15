package lx.edu.subwayproject.dto;

import lombok.Data;


@Data // lombok 사용
public class RouteDTO {

    private int routeId; // Primary key용
    private int routeSeq; //스케쥴 속 경로
    private int scheduleId; // 해당 루트를 가지는 스케쥴의 ID
    private int departureStationId; // 출발역의 ID
    private int arrivalStationId; // 도착역의 ID
    
    
    // 이 아래는 DB에 추가되지 않습니다..
    
    // 조회 화면 출력용
    private String departureStationName;
    private String arrivalStationName;
    
    // 실제 노선상의 역 순서
    private int departureLineOrderId;
    private int arrivalLineOrderId;
    

}