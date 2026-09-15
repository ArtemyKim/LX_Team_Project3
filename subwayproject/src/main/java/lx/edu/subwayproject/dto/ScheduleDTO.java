package lx.edu.subwayproject.dto;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

import lombok.Data;


@Data // lombok 사용
public class ScheduleDTO {

    private int scheduleId; // Primary key용
    private int userId; // 해당 스케쥴을 가진 유저의 ID
    private String scheduleName; // 스케쥴의 이름 예)출근길
    private LocalDate travelDate; // 날짜
    private LocalTime travelTime; // 시간(현재는 미사용)

    
    // 이 아래로는 DB에 저장되지는 않고 java에서만 사용됩니다..
    
    // 스케줄의 경로 목록
    private List<RouteDTO> routes;
    // 해당 날짜에 발생한 이례상황 목록
    private List<SubwayNoticeDTO> notices;
    
    
    
}