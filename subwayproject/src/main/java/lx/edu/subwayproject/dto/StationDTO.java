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
    private String stationManager; // 역 코드 충돌 시 구별용 

    private int lineOrderId; // 실제 역 순서, 4자릿수, 맨 첫번째 번호는 역 노선과 동일 - 예를들어 4호선은 4XXX 
    
    
    
    // 주의할 점으로, 한 역이 여러 호선에 속하는 경우에는(예: 1호선, 4호선에 속하는 경우)
    // 이름은 같고 코드는 다른 새로운 StationDTO 객체가 만들어져야 할 것

}
