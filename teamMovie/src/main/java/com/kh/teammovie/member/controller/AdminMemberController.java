package com.kh.teammovie.member.controller;

import com.kh.teammovie.member.model.vo.Member;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin")  // 반드시 유지!
public class AdminMemberController {

    @GetMapping("/home")
    public String adminHome(HttpSession session, Model model) {
        Member loginUser = (Member) session.getAttribute("loginUser");

        // 관리자 권한 확인
        if (loginUser == null || !"ADMIN".equalsIgnoreCase(loginUser.getRole().trim())) {
            model.addAttribute("errorMsg", "관리자만 접근할 수 있습니다.");
            return "common/errorPage";  // 또는 "redirect:/"
        }

        session.removeAttribute("alertMsg");
        
        return "admin/home";  // views/admin/home.jsp
    }
}