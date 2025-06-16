package com.kh.teammovie.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.teammovie.member.model.vo.Member;

public class RoleInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession(false);
        String uri = request.getRequestURI();

        if (uri.startsWith(request.getContextPath() + "/admin")) {
            // 관리자 페이지 접근 권한 체크
            if (session == null || session.getAttribute("loginUser") == null) {
                response.sendRedirect(request.getContextPath() + "/login"); // 로그인 페이지
                return false;
            }
            Member user = (Member) session.getAttribute("loginUser");
            if (!"ADMIN".equals(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/accessDenied"); // 권한없음 페이지
                return false;
            }
        }

        // 필요시 일반 회원 전용 페이지 체크도 가능
        return true;
    }
}
