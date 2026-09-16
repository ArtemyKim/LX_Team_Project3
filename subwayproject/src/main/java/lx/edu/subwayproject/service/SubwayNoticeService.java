package lx.edu.subwayproject.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate; // API 호출을 위해 추가

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.annotation.PostConstruct; // 자동 실행을 위해 추가
import lx.edu.subwayproject.dao.SubwayNoticeDAO;
import lx.edu.subwayproject.dto.SubwayNoticeDTO;

@Service
public class SubwayNoticeService {

    @Autowired
    private SubwayNoticeDAO dao;

    @PostConstruct
    public void fetchApiDataOnStartup() {
        System.out.println("🚀 [시스템] 서버 기동 완료! 백그라운드에서 지하철 API 수집을 시작합니다...");
        dao.truncateNoticeList();
        
        new Thread(() -> {
            try {
                String apiUrl = "http://openapi.seoul.go.kr:8088/51567962453330333938434c734e6b/json/getNtceList/1/999/";
                
                // Spring에서 제공하는 HTTP 통신 템플릿으로 API 호출
                RestTemplate restTemplate = new RestTemplate();
                String jsonResult = restTemplate.getForObject(apiUrl, String.class);
                
               
                if(jsonResult != null && !jsonResult.isEmpty()) {
                    saveNotice(jsonResult); 
                    System.out.println("✅ [백그라운드] API 데이터 파싱 및 DB 저장 성공!");
                }
                
            } catch (Exception e) {
                System.out.println("❌ [백그라운드] API 수집 중 오류: " + e.getMessage());
                e.printStackTrace();
            }
        }).start(); 
    }
    
    // =========================================================
    // 기존 작성 코드 유지
    // =========================================================
    
    // 날짜를 기준으로 이례상황 목록 조회
    public List<SubwayNoticeDTO> getNoticeListByDate(LocalDate scheduleDate) {
        return dao.getNoticeListByDate(scheduleDate);
    }
    
    // 전처리된 JSON데이터를 DB에 저장하는 코드.
    public void saveNotice(String json) throws Exception {
        List<SubwayNoticeDTO> list = parseNotice(json);
        for (SubwayNoticeDTO dto : list) {
            dao.insertNotice(dto);
        }
    }

    // API로부터 받은 JSON 데이터를 전처리하는 코드.
    public List<SubwayNoticeDTO> parseNotice(String json) throws Exception {
        ObjectMapper mapper = new ObjectMapper();
        JsonNode root = mapper.readTree(json);
        
        JsonNode items = root.path("response").path("body").path("items").path("item");
        List<SubwayNoticeDTO> list = new ArrayList<>();

        for (JsonNode item : items) {
            SubwayNoticeDTO dto = new SubwayNoticeDTO();

            dto.setNoticeTitle(item.path("noftTtl").asText());
            dto.setNoticeContent(item.path("noftCn").asText());
            dto.setNoticeTypeCode(item.path("noftSeCd").asText());

            String noticeTime = item.path("noftOcrnDt").asText(null);
            if (noticeTime != null && !noticeTime.isEmpty()) {
                dto.setNoticeTime(LocalDateTime.parse(noticeTime));
            }

            dto.setLineNameList(item.path("lineNmLst").asText());
            dto.setStationSectionCodeList(item.path("stnSctnCdLst").asText());
            dto.setReferenceDate(item.path("crtrYmd").asText());

            String startTime = item.path("xcseSitnBgngDt").asText(null);
            if (startTime != null && !startTime.isEmpty()) {
                dto.setAbnormalStartTime(LocalDateTime.parse(startTime));
            }

            String endTime = item.path("xcseSitnEndDt").asText(null);
            if (endTime != null && !endTime.isEmpty()) {
                dto.setAbnormalEndTime(LocalDateTime.parse(endTime));
            }

            dto.setNonstopYn(item.path("nonstopYn").asText());

            list.add(dto);
        }
        return list;
    }
}