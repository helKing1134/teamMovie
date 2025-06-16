package com.kh.teammovie.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

public class LoginInterceptor implements HandlerInterceptor{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession(); // 로그인 정보(loginUser)가 세션에 담겨 있는지 확인하려는 목적
		if(session.getAttribute("loginUser")==null) {  //로그인 안 한 상태
			session.setAttribute("alertMsg", "로그인 후 이용 가능한 서비스입니다.");
			response.sendRedirect(request.getContextPath()); // 메인페이지로 이동 
			return false; // 기존 요청흐름 중지 
		}
		
		//return true 으로 로그인 한 상태일 경우 요청흐름 유지
		return HandlerInterceptor.super.preHandle(request, response, handler);
	}
}
