package com.kh.teammovie.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.teammovie.member.model.service.MemberService;
import com.kh.teammovie.member.model.vo.Member;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService service;
	
	@Autowired
	private BCryptPasswordEncoder bcrypt;
	
	
	@RequestMapping("login.me")
	public String loginMember(Member m, HttpSession session, Model model) {
		//System.out.println(bcrypt.encode(m.getPassword1()));
		Member loginUser = service.loginMember(m);
		//System.out.println(loginUser.getPassword1());
		
		
		if (loginUser != null && bcrypt.matches(m.getPassword1(),loginUser.getPassword1())) {
			session.setAttribute("loginUser", loginUser);
			session.setAttribute("alertMsg", "성공적으로 로그인 하였습니다.");
			
			return "redirect:/";
			
			
		} else {
			model.addAttribute("errorMsg", "잘못 입력하셨습니다. 다시 로그인을 시도하여 주세요.");
			//viewResolver가 WEB-INF/views/ 와 .jsp를 붙여서 경로를 완성해준다
			return "common/errorPage";
		}
	}
	@RequestMapping("logout.me")
	public String logoutMember(HttpSession session) {
		session.removeAttribute("loginUser");
		session.setAttribute("alertMsg","로그아웃하였습니다.");
		
		return "redirect:/";
	}
	
	@GetMapping("register.me")   // 회원가입 버튼 누르면 회원가입 페이지로 이동
	public String registerMember() {
		return "member/registrationPage";  
	}
	
	@PostMapping("register.me") //회원가입 정보 받아서 DB 에 insert 하는 구문
	public String registerMember(Member m, HttpSession session, Model model) {
		
	
		String encPwd = bcrypt.encode(m.getPassword1()); //평문 암호문으로 변경 
		System.out.println(encPwd);
		m.setPassword1(encPwd);//객체에 암호문 비밀번호 넣기
		int result = service.registerMember(m);
		try {
		if(result>0) {
			session.setAttribute("alertMsg", m.getMemberId()+" 님의 회원가입이 완료되었습니다.\\n메인화면으로 이동합니다.");
		} } catch(Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMsg","회원가입이 정상적으로 처리되지 않았습니다. 다시 시도해 주십시오.");
			return "common/errorPage";
		}
		return "redirect:/";
	}
	
	//마이페이지로 단순 이동
	@RequestMapping("mypage.me")
	public String myPage(Member m) {
		return "member/myPage";
		
	}
	    
	@RequestMapping("update.me")
	public String updateMember(Member m, HttpSession session, Model model) {

		int result = service.updateMember(m);

		if (result > 0) {

			session.setAttribute("alertMsg", "회원정보가 정상적으로 수정되었습니다.");

			// 새로 업데이트 된 정보를 Member 객체에 새로 담아야함! select 구문을 가져오기
			Member updateMember = service.loginMember(m);
			session.setAttribute("loginUser", updateMember);

			return "redirect:/mypage.me"; // 성공시
		} else {
			model.addAttribute("errorMsg", "정보 수정 중 에러가 발생하였습니다. 다시 시도해 주십시오.");
			return "common/errorPage";

		}

	}
	
	@ResponseBody
	@RequestMapping("dupCheck.me")
	public String dupCheck(String memberId) {
		//ajax 구문 내에서 작성한 userId 변수 매개변수로 받아오기 
		int count = service.dupCheck(memberId);
		if(count>0) {
			return "NNNNN";
		} else {
			return "NNNNY";
		}
		
	}
	
	@RequestMapping("delete.me")
	public String deleteMember(Member m,@RequestParam("passwordForDelete")String passwordForDelete, HttpSession session, Model model) {
		Member loginUser = service.loginMember(m);
		
		
		if(bcrypt.matches(passwordForDelete,loginUser.getPassword1())){	
		int result= service.deleteMember(m);
			if(result>0) {
				session.setAttribute("alertMsg", "회원탈퇴 되었습니다.");
				return "redirect:/";
			} else {
				model.addAttribute("errorMsg","에러가 발생하였습니다. 다시 시도하여 주십시오.");
				return "common/errorPage";
			}
		}else {
			model.addAttribute("errorMsg","비밀번호가 일치하지 않습니다. 다시 입력하여 주십시오");
			return "redirect:/mypage.me";
		}
	};
	
	@ResponseBody
	@PostMapping("checkcurrentpwd.me")
	public String checkPassword(@RequestParam("password") String Password, HttpSession session) {
		
		Member loginUser = (Member) session.getAttribute("loginUser");
		System.out.println(loginUser);
		System.out.println(Password);
		System.out.println(loginUser.getPassword1());
		if(loginUser!=null &&  bcrypt.matches(Password,loginUser.getPassword1())){
			return "true";
		}else {
		return "false";
		}}

}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

