package com.kh.teammovie.support.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.teammovie.common.model.vo.PageInfo;
import com.kh.teammovie.common.template.Pagination;
import com.kh.teammovie.member.model.vo.Member;
import com.kh.teammovie.support.model.service.SupportService;
import com.kh.teammovie.support.model.vo.Inquiry;
import com.kh.teammovie.support.model.vo.InquiryAnswer;

	@Controller
	public class SupportController {
		
		@Autowired
		private SupportService service;

		
		//문의하기 메인
		@RequestMapping("support") //url이름
		public String main(@RequestParam(value="loginRequired", required=false) String loginRequired,
                HttpSession session, Model model) {

		    // 로그인한 사용자 객체를 세션에서 가져옴
		    Object loginUser = session.getAttribute("loginUser");
		    model.addAttribute("loginUser", loginUser); // null일 수도 있음
		    model.addAttribute("loginRequired", loginRequired); // 로그인 모달 띄울지 판단용
			return "support/main"; //jsp
		}
		
		//나의 문의 내역
		@RequestMapping("/myInquiryList")
		public String myInquiryList(HttpSession session, Model model) {
		    Member loginUser = (Member) session.getAttribute("loginUser");
		    if (loginUser == null) {
		        model.addAttribute("errorMsg", "로그인이 필요한 서비스입니다.");
		        return "common/errorPage";
		        }

		    ArrayList<Inquiry> list = service.myInquiryList(loginUser.getMemberNo());
		    System.out.println(list);
		    model.addAttribute("list", list);
		    return "support/myInquiryList";
		}

		
//		@GetMapping("/filterInquiries")
//		@ResponseBody
//		public List<Inquiry> filterInquiries(@RequestParam(required = false) 
//		List<String> statuses) {
//		    if (statuses == null || statuses.isEmpty()) {
//		        return service.findAllInquiries(); // 모든 문의글 반환
//		    }
//		    return service.selectInquiriesByStatuses(statuses); // 상태에 따라 필터링
//		}

		
		//자주묻는질문
		@RequestMapping("support/faq")
		public String faq() {
			
			return "support/faq";
		}
		
		//자주묻는질문
		@RequestMapping("admin")
		public String admin(HttpSession session, Model model) {
			
			// member의 권한 정보 추가 
			Member loginUser = (Member) session.getAttribute("loginUser");
			String memRole  = loginUser.getRole();
			model.addAttribute("memRole", memRole);
			
			return "support/admin";
		}

		//관리자 문의 게시판 리스트
		@RequestMapping("inquiryList")
		public String inquiryList(@RequestParam(value="currentPage",defaultValue="1")
		int currentPage,Model model) throws Exception {
			
			//추가적으로 필요한 값 
			int listCount = service.listCount(); //총 게시글 개수
			int boardLimit = 10; //게시글 보여줄 개수
			int pageLimit = 10; //페이징바 개수
			
			PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
			
			ArrayList<Inquiry> list = service.inquiryList(pi);

			
			model.addAttribute("list", list);
			model.addAttribute("pi", pi);
			
			return "support/inquiryList";
		}
		
		@RequestMapping("deleteAnswer")
		public String deleteAnswer(int bno,HttpSession session) {
			
			
			int result = service.deleteAnswer(bno);
			int result2 = service.updateStatus(bno);
			
			
			if(result>0 && result2>0) {
				session.setAttribute("alertMsg", "답변이 삭제되었습니다.");
				
				return "redirect:/inquiryList";
				
			}else {
				session.setAttribute("alertMsg", "답변 삭제에 실패하였습니다.");
				
				return "redirect:/inquiryList";
			}
			
		}
		
		//1대1 문의(get)
		@RequestMapping("support/inquiry")
		public String inquiry(@RequestParam(value="loginRequired", required=false) String loginRequired,
                HttpSession session, Model model) {

		    // 로그인한 사용자 객체를 세션에서 가져옴
		    Object loginUser = session.getAttribute("loginUser");
		    model.addAttribute("loginUser", loginUser); // null일 수도 있음
		    model.addAttribute("loginRequired", loginRequired); // 로그인 모달 띄울지 판단용
		    
			return "support/inquiry";
		}
		
		//1대1 문의(post)
		@PostMapping("support/inquiry")
		public String inquiry(Inquiry i
							,HttpSession session
							,Model model) {
			
		    Member loginUser = (Member) session.getAttribute("loginUser");
		    
		    if (loginUser != null) {
		        i.setInquiryWriter(loginUser.getMemberNo());  
		    } else {
		        model.addAttribute("errorMsg", "로그인이 필요한 서비스입니다.");
		        return "common/errorPage";
		    }
		    
			int result = service.insertInquiry(i);

		    System.out.println(i);
			
			if(result>0) {
				session.setAttribute("alertMsg", "문의가 제출되었습니다.");
				return "redirect:/";
			}else {
				model.addAttribute("errorMsg","문의 제출에 실패하였습니다.");
				return "redirect:/";
			
			}
		}

		
		//관리자 문의 확인(get)
		@RequestMapping("detail")
		public String inquiryDetail(int bno, Model model) {
			
				Inquiry i = service.inquiryDetail(bno);
				InquiryAnswer a = service.answerDetail(bno);
				model.addAttribute("a",a);
				model.addAttribute("i",i);

				return "support/detail";
		}
		
		
		//관리자 문의 답변(post)
		@PostMapping("detail")
		public String Answer(InquiryAnswer a
							,HttpSession session
							,Model model) {
		    
			int result = service.insertInquiryAnswer(a);
			int result2 = service.updateStatus(a.getInquiryId()); // 상태 업데이트
			System.out.println("컨트롤러");
			
			if(result>0 && result2>0) {
				session.setAttribute("alertMsg", "답변이 제출되었습니다.");
				return "redirect:/inquiryList";
			}else {
				model.addAttribute("errorMsg","답변에 실패하였습니다.");
				return "redirect:/inquiryList";
			}
		}
		
		
		

	

}
