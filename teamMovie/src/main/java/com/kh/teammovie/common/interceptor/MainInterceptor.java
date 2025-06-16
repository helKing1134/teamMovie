package com.kh.teammovie.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

public class MainInterceptor implements HandlerInterceptor{
	
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
	        throws Exception {
	    System.out.println("[MainInterceptor] 요청 URI : " + request.getRequestURI());
	    System.out.println("오 된다 대박");
	    return true;  // 꼭 true 리턴해야 계속 진행됨
	}
}
