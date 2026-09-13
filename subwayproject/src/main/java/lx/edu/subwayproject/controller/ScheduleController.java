package lx.edu.subwayproject.controller;

import java.nio.charset.StandardCharsets;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import lx.edu.subwayproject.dto.ScheduleDTO;
import lx.edu.subwayproject.service.ScheduleService;
import lx.edu.subwayproject.service.SubwayNoticeService;


@RestController
@RequestMapping("/schedules") // 경로 매핑
public class ScheduleController {
	
    @Autowired
    private ScheduleService service; 

    @PostMapping // 추가하는 기능이므로 Post방식
    public void insertSchedule(
            @ModelAttribute ScheduleDTO dto) throws Exception {
    	
    	System.out.println("받은 ScheduleDTO = " + dto);

        service.insertSchedule(dto);
    }
    
	
}
