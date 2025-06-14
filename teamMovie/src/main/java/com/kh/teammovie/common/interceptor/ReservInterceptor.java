package com.kh.teammovie.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

/**
 * @author user1
 * 좌석선택 페이지 인터셉터
 *
 */
public class ReservInterceptor implements HandlerInterceptor {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession(false); //
		if (session == null || session.getAttribute("loginUser") == null) {
			response.setContentType("text/html;charset=UTF-8");
			response.getWriter().write("<script>alert('로그인이 필요한 서비스입니다.');location.href='/teammovie/'</script>");
			
			return false;
		
		}
		
		return true;
		
	}

}
