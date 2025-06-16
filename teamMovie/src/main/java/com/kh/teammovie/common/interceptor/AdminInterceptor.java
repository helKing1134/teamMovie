package com.kh.teammovie.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.teammovie.member.model.vo.Member;
import org.springframework.web.servlet.HandlerInterceptor;

public class AdminInterceptor implements HandlerInterceptor {
	@Override
	public boolean preHandle(HttpServletRequest request,
	                         HttpServletResponse response,
	                         Object handler) throws Exception {

	    HttpSession session = request.getSession();
	    Member loginUser = (Member) session.getAttribute("loginUser");

	    System.out.println("🚨 AdminInterceptor 작동!");
	    System.out.println("로그인 유저: " + loginUser);
	    System.out.println("유저 권한: " + (loginUser != null ? loginUser.getRole() : "null"));

	    if (loginUser == null || !"ADMIN".equals(loginUser.getRole())) {
	        System.out.println("⛔ 접근 차단: 일반 유저 또는 비로그인 상태");
	        response.sendRedirect(request.getContextPath() + "/");
	        return false;
	    }

	    System.out.println("✅ 접근 허용: 관리자");
	    return true;
	}
}