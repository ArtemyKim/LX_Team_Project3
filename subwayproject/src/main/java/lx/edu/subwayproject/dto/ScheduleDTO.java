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

    private List<RouteDTO> routes; //루트 내용
}