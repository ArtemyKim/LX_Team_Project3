package lx.edu.subwayproject.controller;

import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import lx.edu.subwayproject.service.SubwayNoticeService;
import lx.edu.subwayproject.dto.SubwayNoticeDTO;


@RestController
public class SubwayNoticeController {
	
    // 날짜를 기준으로 이례상황 목록 조회, Get방식
    @GetMapping(value="/api/getByDate")
    public List<SubwayNoticeDTO> getNoticeListByDate(
            @RequestParam LocalDate scheduleDate) {
    		
    	
    	System.out.println(service.getNoticeListByDate(scheduleDate));
        return service.getNoticeListByDate(scheduleDate);
    }

	
	// API키 보관용
	private String apiKey = "51567962453330333938434c734e6b";

    @Autowired
    private SubwayNoticeService service;

    @GetMapping(
        value="/api/test",
        produces="application/json;charset=UTF-8"
    )
    public String test() throws Exception {


        String url =
        "http://openapi.seoul.go.kr:8088/" + apiKey + "/json/getNtceList/1/200/";


        RestTemplate restTemplate = new RestTemplate();


        byte[] response =
            restTemplate.getForObject(
                url,
                byte[].class
            );


        String result =
            new String(
                response,
                StandardCharsets.UTF_8
            );


        System.out.println(result);
        

        // JSON 파싱 후 DB 저장
        service.saveNotice(result);


        return result;

    }
}