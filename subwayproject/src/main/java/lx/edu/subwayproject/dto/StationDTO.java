package lx.edu.subwayproject.dto;

import java.time.LocalDate;
import java.time.LocalTime;

import lombok.Data;

@Data // lombok 사용
public class StationDTO {
	
	private int stationId; // DB에서의 primary key로 쓰임
    private String stationCode; // 역 코드. 예시) 0329 
    private String stationName; // 역 이름. 예시) 청라언덕
    private String lineName; // 역 호선. 예시) 4호선
    private String stationManager; // 역 운영기관. 예시) 한국철도공사
    
}
