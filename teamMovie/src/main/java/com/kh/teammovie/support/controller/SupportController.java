package com.kh.teammovie.support.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
		public String main() {
			return "support/main"; //jsp
		}
		
		//자주묻는질문
		@RequestMapping("support/faq")
		public String faq() {
			
			return "support/faq";
		}
		
		//자주묻는질문
		@RequestMapping("admin")
		public String admin() {
			
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
		
		
		//1대1 문의(get)
		@RequestMapping("support/inquiry")
		public String inquiry(HttpSession session, HttpServletRequest request, RedirectAttributes ra) {

//		    // 로그인한 사용자 객체를 세션에서 가져옴
//		    Object loginUser = session.getAttribute("loginUser");
//
//		    if (loginUser == null) {
//		        // 비로그인 상태: 로그인 알림 메시지 전달 + 로그인 모달 유도
//		        ra.addFlashAttribute("alertMsg", "로그인 후 이용 가능합니다.");
//		        return "redirect:/"; // 홈으로 리다이렉트 (모달이 뜨도록 처리)
//		    }
		    
			return "support/inquiry";
		}
		
		//1대1 문의(post)
		@PostMapping("support/inquiry")
		public String inquiry(Inquiry i
							,HttpSession session
							,Model model) {
			
		    Member loginUser = (Member) session.getAttribute("loginUser");
		    
		    System.out.println(i);

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
				
				model.addAttribute("i",i);

				return "support/detail";
		}
		
		
		//관리자 문의 답변(post)
		@PostMapping("detail")
		public String Answer(InquiryAnswer a
							,HttpSession session
							,Model model) {
		    
			int result = service.insertInquiryAnswer(a);
			
			if(result>0) {
				session.setAttribute("alertMsg", "답변이 제출되었습니다.");
				return "redirect:/inquiryList";
			}else {
				model.addAttribute("errorMsg","답변에 실패하였습니다.");
				return "redirect:/inquiryList";
			}
		}
		
		
		

	

}
