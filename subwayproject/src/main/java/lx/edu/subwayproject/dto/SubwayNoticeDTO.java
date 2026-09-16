package lx.edu.subwayproject.dto;

import java.time.LocalDateTime;
import java.util.List;

import lombok.Data;

@Data // lombok 사용
public class SubwayNoticeDTO {

    private int noticeId; // Primary key용

    private String noticeTitle; // 알림 제목

    private String noticeContent; // 알림 내용

    private String noticeTypeCode; // 알림구분코드(현재 미사용)

    private LocalDateTime noticeTime; // 알림 발생 일시

    private String lineNameList; // 호선명목록

    private String stationSectionCodeList; // 역구간코드목록

    private String referenceDate; // 이례상황 발생 날짜(연월일)

    private LocalDateTime abnormalStartTime; // 이례상황 시작시각

    private LocalDateTime abnormalEndTime; // 이례상황 종료시각

    private String nonstopYn; // 무정차 여부
    
    // 이 아래도 DB에는 저장되지 않어요
    
    private List<String> affectedStationNames; // 이례상황 발생한 역 이름 저장용
 
}