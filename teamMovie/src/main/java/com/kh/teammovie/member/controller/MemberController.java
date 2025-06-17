package com.kh.teammovie.member.controller;


import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.teammovie.member.model.service.MemberService;
import com.kh.teammovie.member.model.vo.Member;
import com.kh.teammovie.movie.model.vo.Movie;
import com.kh.teammovie.payment.model.service.PaymentService;
import com.kh.teammovie.payment.model.vo.Payment;
import com.kh.teammovie.refund.model.vo.Refund;
import com.kh.teammovie.reservation.controller.ReservationController;
import com.kh.teammovie.reservation.model.service.ReservationService;
import com.kh.teammovie.schedule.model.vo.Schedule;
import com.kh.teammovie.screen.model.vo.Screen;
import com.kh.teammovie.seat.model.vo.Seat;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService service;
	
	@Autowired
	private BCryptPasswordEncoder bcrypt;
	
	@Autowired
	private PaymentService pmService; // 환불 id 로 환불 데이터를 가져오는 로직을 담을 서비스  by sh.k
	
	@Autowired
	private ReservationService rvService;
	

	@PostMapping("/saveRedirectUrl")
	@ResponseBody
	public void saveRedirectUrl(@RequestBody Map<String, String> data, HttpSession session) {
		session.setAttribute("redirectAfterLogin", data.get("redirect"));
	}

	
	@RequestMapping("login.me")
	public String loginMember(Member m, HttpSession session, Model model) {
	    Member loginUser = service.loginMember(m);

	    if (loginUser != null && bcrypt.matches(m.getPassword1(), loginUser.getPassword1())) {
	        session.setAttribute("loginUser", loginUser);
	        session.setAttribute("memRole", loginUser.getRole());
	        session.setAttribute("alertMsg", "성공적으로 로그인 하였습니다.");

	        // 이전 URL로 리다이렉트
	        String redirectUrl = (String) session.getAttribute("redirectAfterLogin");
	        if (redirectUrl != null) {
	            session.removeAttribute("redirectAfterLogin");
	            return "redirect:" + redirectUrl;
	        }

	        return "redirect:/";  // fallback
	    } else {
	        model.addAttribute("errorMsg", "로그인 실패");
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
	public String myPage(
						HttpSession session,
						Model model ) {
		
		Member mem = (Member) session.getAttribute("loginUser");
		
		List<Refund> rfList = pmService.getRefundByMemberNo(mem.getMemberNo());
		
		
		model.addAttribute("rfList", rfList);
		
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
				session.removeAttribute("loginUser"); //회원탈퇴 후 로그인 안한 상태의 마이페이지 보여주기
				return "redirect:/";
			} else {
				model.addAttribute("errorMsg","에러가 발생하였습니다. 다시 시도하여 주십시오.");
				return "common/errorPage";
			}
		}else {
			model.addAttribute("errorMsg","비밀번호가 일치하지 않습니다. 다시 입력하여 주십시오");
			return "member/myPage";
		}
	}
	
	@ResponseBody
	@PostMapping("checkcurrentpwd.me")
	public String checkPassword(@RequestParam("password") String Password, HttpSession session) {

		Member loginUser = (Member) session.getAttribute("loginUser");
		if (loginUser != null && bcrypt.matches(Password, loginUser.getPassword1())) {
			return "true";
		} else {
			return "false";
		}
	}
	
	//비밀번호 수정시 현재 비밀번호 입력 후 일치하는지 확인
	@ResponseBody
	@PostMapping("/confirmpassword.me")
	public String confirmPassword(@RequestParam("confirmPassword") String confirmPassword,
			@RequestParam("newPassword") String newPassword, HttpSession session) {
		Member loginUser = (Member) session.getAttribute("loginUser");
		System.out.println(loginUser);
		
		if (confirmPassword.equals(newPassword)) {
			
			loginUser.setPassword1(bcrypt.encode(confirmPassword));
			int result = service.updatePassword(loginUser);
			if(result>0) {
				session.setAttribute("alertMsg", "메인 화면으로 돌아갑니다");
				return "true";
			} else {
				return "false";
			}
	
		} else {
			return "false";
		}

	}
	
	//회원가입시 비밀번호 & 비밀번호 확인 일치하는지 확인
	@ResponseBody
	@PostMapping("/passwordCheck.me")
	public String passwordCheck (@RequestParam("password1") String password1, @RequestParam("password2") String password2) {
		if(password1.equals(password2)) {  
			return "NNNNY";
		} else {
			return "NNNNN";
		}
	}
	
	
//	사용자 > 마이페이지 > 환불현황 2025.06.12 by SH.k
	@GetMapping("refund.me")
	public String forwardRefund(int refundId,
								Model model ) {
		
		System.out.println("refundId : " +refundId);
		
		//환불 객체 가져오기
		Refund rf = pmService.getRefundByRfId(refundId);
		
		//결제 객체
		Payment p = pmService.findById(rf.getPaymentId());
		
		//상영정보 객체
		Schedule sch = rvService.getSchById(p.getScheduleId());
		
		//영화
		Movie m = rvService.getMovieById(sch.getMovieId());
		
		//상영관 객체
		Screen s = rvService.getScreenById(sch.getScreenId());
		
		//좌석 리스트
		List<Seat> stList = pmService.getStListByPmId(rf.getPaymentId());
		
		//시작시간, 종료시간
		Map<String, String> timeMap = new ReservationController().timeCalculator(sch, m);
		
		//결제 금액
		int totalPrice = p.getAmount() *15000;
		
		model.addAttribute("rf", rf);
		model.addAttribute("p", p);
		model.addAttribute("sch", sch);
		model.addAttribute("m", m);
		model.addAttribute("s", s);
		model.addAttribute("stList", stList);
		model.addAttribute("timeMap", timeMap);
		model.addAttribute("totalPrice", totalPrice);
		
		return "member/refundStatus";
	}
	
	
	
	@RequestMapping("adminMember")
	public String adminMember(Model model) {
		ArrayList<Member> members = service.adminMember(); // 전체 회원 목록 조회
	    model.addAttribute("members", members);
	    System.out.println(members);
		return "support/adminMember";
	}
	
	@PostMapping("/admin/updateRole")
	public String updateMemberRole(@RequestParam("memberNo") int memberNo,
	                               @RequestParam("role") String role) {
	    service.updateMemberRole(memberNo, role);
	    return "redirect:/admin/adminMember"; // 권한 수정 후 다시 목록으로
	}


}
	

