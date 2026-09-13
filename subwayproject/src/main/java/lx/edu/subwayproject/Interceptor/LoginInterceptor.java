package lx.edu.subwayproject.Interceptor;

import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class LoginInterceptor implements HandlerInterceptor {

	
	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse res, Object handler)
			throws Exception {
		
		HttpSession session = req.getSession();
		Object loginUser = session.getAttribute("loginUser");
		
		if(loginUser == null) {
			res.sendRedirect(req.getContextPath() + "/login.do");
			return false;
		}
		
		return true;
	}
}

//main.do
//schedule
//mypage? 등등에 인터셉터 연결하면 될것같습니당~~~ 아직 등록은 안햇어용