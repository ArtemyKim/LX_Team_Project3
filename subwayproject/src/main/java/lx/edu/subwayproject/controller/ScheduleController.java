package lx.edu.subwayproject.controller;

import java.io.IOException;
import java.nio.charset.StandardCharsets;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpServletResponse;
import lx.edu.subwayproject.dto.ScheduleDTO;
import lx.edu.subwayproject.dto.UserDTO;
import lx.edu.subwayproject.service.ScheduleService;
import lx.edu.subwayproject.service.SubwayNoticeService;




@RestController
@RequestMapping("/schedules") // 경로 매핑
public class ScheduleController {
	
    @Autowired
    private ScheduleService service; 

    @PostMapping // 추가하는 기능이므로 Post방식
    public void insertSchedule(
        @ModelAttribute ScheduleDTO dto, HttpSession session ,HttpServletResponse res) throws Exception {
   	
    	UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
    	dto.setUserId(loginUser.getUserId());
    	
    	System.out.println("받은 ScheduleDTO = " + dto);

        service.insertSchedule(dto);
        

        res.sendRedirect(
            "/subwayproject/schedules.do"
        );
    }
        
        @PostMapping("/delete")
        public void deleteSchedule(@RequestParam("scheduleId") int scheduleId, HttpServletResponse res) throws IOException {
        	service.deleteSchedule(scheduleId);
        	
        	res.sendRedirect(
                    "/subwayproject/schedules.do"
                );
        }
     
        
        
    
    
}
