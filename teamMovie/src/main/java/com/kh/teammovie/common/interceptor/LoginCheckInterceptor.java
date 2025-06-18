package com.kh.teammovie.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

public class LoginCheckInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
    	System.out.println("ㄹ호롷로로로로로로로");
        HttpSession session = request.getSession();

        if (session.getAttribute("loginUser") == null) {
            // 요청된 URI + 쿼리스트링
            String contextPath = request.getContextPath();
            String uri = request.getRequestURI();
            String query = request.getQueryString();
            String target = uri + (query != null ? "?" + query : "");
            

            // contextPath 제거 (redirect 시 상대경로로 쓸 수 있도록)
            if (target.startsWith(contextPath)) {
                target = target.substring(contextPath.length());
            }

            // 나중에 로그인 후 되돌아오기 위해 세션에 저장
            session.setAttribute("redirectAfterLogin", target);

            // Ajax 요청은 상태 코드만 응답
            if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
                response.setStatus(401);
                return false;
            }

            // 일반 요청은 로그인 페이지로 리다이렉트
            response.sendRedirect(contextPath + "/member/login");
            return false;
        }

        return true; // 로그인 되어 있으면 통과
    }
}
