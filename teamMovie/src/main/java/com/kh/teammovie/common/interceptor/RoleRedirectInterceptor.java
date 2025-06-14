package com.kh.teammovie.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

public class RoleRedirectInterceptor implements HandlerInterceptor {
	
	
	/**
	 * 사용자 권한별 화면을 다르게 해주는 인터셉터 by sh.k 06.14
	 */
	@Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {

        HttpSession session = request.getSession(false);
        
        //로그인 안한 경우
        if (session == null) return true; 
        
        //주소와 사용자 권한을 가져옴
        String uri = request.getRequestURI();
        String memRole = (String) session.getAttribute("memRole"); // 세션에 저장된 권한값 (예: "admin" or "member")
        
        // 관리자 영화 페이지 백오피스로 이동
        if ("/teammovie/movies".equals(uri) && "admin".equalsIgnoreCase(memRole)) {
            response.sendRedirect(request.getContextPath() + "/movies/adjustment");
            return false; 
        }

        return true; // 일반 사용자 그대로 진행
    }
	
	

}
