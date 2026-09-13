package lx.edu.subwayproject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import jakarta.servlet.http.HttpSession;
import lx.edu.subwayproject.dto.UserDTO;
import lx.edu.subwayproject.service.LoginService;

@Controller
public class LoginController {

	@Autowired
	LoginService loginservice;
	
	// 로그인 화면을 보여주는 메서드
	@RequestMapping(value="/login.do", method=RequestMethod.GET)
	public String loginForm() {
	    return "login";
	}
	
	//로그인 버튼 눌렀을 때 처리하는 메서드
	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	public String login(UserDTO user, HttpSession session) {
		UserDTO loginUser = loginservice.login(user);
		
		if(loginUser != null) {
			session.setAttribute("loginUser", loginUser);
			return "redirect:/main.do";
		}
		return "redirect:/login.do";
	}	
}
