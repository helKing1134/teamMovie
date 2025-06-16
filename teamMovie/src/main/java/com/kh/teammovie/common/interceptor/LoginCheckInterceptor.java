package com.kh.teammovie.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

public class LoginCheckInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        
        HttpSession session = request.getSession();
        if (session.getAttribute("loginUser") == null) {
        	
        	// 요청 URI + 쿼리 스트링 조합 (컨텍스트 루트 포함)
        	String contextPath = request.getContextPath();
        	String uri = request.getRequestURI();
        	String query = request.getQueryString();
        	String target = uri + (query != null ? "?" + query : "");
        	
        	// target에서 contextPath를 뺀 경로만 저장 (로그인 후 redirect용)
        	if (target.startsWith(contextPath)) {
        	    target = target.substring(contextPath.length());
        	}
        	
        	session.setAttribute("redirectAfterLogin", target);

            // Ajax 요청인 경우 401 응답
            if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
                response.setStatus(401); 
                return false;
            }

            // 비로그인 상태 → inquiry.jsp로 forward + 모달 표시용 속성 설정
            request.setAttribute("loginRequired", true);
            request.getRequestDispatcher("/WEB-INF/views/support/inquiry.jsp").forward(request, response);
            return false;
        }

        return true;
    }
}
