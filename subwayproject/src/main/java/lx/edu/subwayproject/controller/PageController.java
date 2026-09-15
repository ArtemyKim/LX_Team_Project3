package lx.edu.subwayproject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.ui.Model;
import jakarta.servlet.http.HttpSession;
import lx.edu.subwayproject.dto.UserDTO;
import lx.edu.subwayproject.dto.ScheduleDTO;
import lx.edu.subwayproject.service.ScheduleService;

@Controller
public class PageController {
	
    @Autowired
    private ScheduleService service; 

    // 로그인 페이지
    @GetMapping("/login")
    public String loginPage() {
        return "login"; // login.jsp로 이동
    }

    // 스케줄 입력 페이지
    @GetMapping("/schedule/input")
    public String scheduleInputPage() {
        return "schedule_input"; // schedule_input.jsp로 이동
    }

    
    // (테스트)스케쥴 추가
    @GetMapping("/schedule/inputTest")
    public String scheduleInputPageTest() {
        return "input_test";
    }

    // 사용자의 스케줄 확인 페이지
    @GetMapping("/schedules.do")
    public String scheduleStatusPage(
            HttpSession session,
            Model model) {

        // 현재 로그인한 사용자
        UserDTO loginUser =
                (UserDTO) session.getAttribute("loginUser");


        // 로그인되지 않은 경우
        if (loginUser == null) {

            return "redirect:/login";
        }


        // 현재 사용자의 스케줄 목록 조회
        List<ScheduleDTO> scheduleList =
                service.selectSchedulesByUserId(
                        loginUser.getUserId()
                );


        // JSP에 전달
        model.addAttribute(
                "scheduleList",
                scheduleList
        );

        return "output_test";
    }    
    
    @GetMapping("/schedule/status/{scheduleId}/notices")
    public String scheduleNoticePage(
            @PathVariable("scheduleId") int scheduleId,
            HttpSession session,
            Model model) {

        UserDTO loginUser =
                (UserDTO) session.getAttribute("loginUser");

        if (loginUser == null) {
            return "redirect:/login";
        }

        List<ScheduleDTO> scheduleList =
                service.selectSchedulesByUserId(
                        loginUser.getUserId()
                );

        ScheduleDTO targetSchedule = null;

        for (ScheduleDTO schedule : scheduleList) {

            if (schedule.getScheduleId() == scheduleId) {

                targetSchedule = schedule;
                break;
            }
        }

        if (targetSchedule == null) {
            return "redirect:/schedules.do";
        }

        model.addAttribute(
                "schedule",
                targetSchedule
        );

        return "notice_test";
    }
}