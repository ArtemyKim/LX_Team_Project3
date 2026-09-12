package lx.edu.subwayproject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PageController {

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
    

    // 사용자의 스케줄/이례상황 확인 페이지
    @GetMapping("/schedule/status")
    public String scheduleStatusPage() {
        return "scheduleStatus";
    }
}