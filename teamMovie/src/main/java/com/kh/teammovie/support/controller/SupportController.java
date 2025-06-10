package com.kh.teammovie.support.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


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
			
			return "support/detail";
		}
		
//		//관리자 문의 게시판 리스트
//		@RequestMapping("inquiryList")
//		public String inquiryList(Inquiry i, Model model) {
//			
//			ArrayList<Inquiry> list = service.inquiryList(i);
//			model.addAttribute("list", list);
//			
//			//메인페이지로 보내기
//			return "support/inquiryList";
//		}
//		
		//관리자 문의 게시판 리스트
		@RequestMapping("inquiryList")
		public String inquiryList(@RequestParam(value="currentPage",defaultValue="1")
		int currentPage
		,Model model) throws Exception {
			
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
		
		
		
		
		
//		//관리자 문의 답변
//		@RequestMapping("inquiryAnswer")
//		public String inquiryAnswer() {
//			
//			return "support/inquiryAnswer";
//		}
//		
		
		
		
//		@PostMapping("inquiryAdmin")
//		public String sinquiryAdmin(Inquiry i
//									,HttpSession session
//									,Model model) {
//			int result = service.insertAdmin(i);
//			
//			if(result>0) {
//				session.setAttribute("alertMsg", "문의가 제출되었습니다.");
//				return "redirect:/";
//			}else {
//				//회원가입 실패시 - 회원가입에 실패하였습니다. 메시지와 함께 에러페이지로 포워딩(위임) - model 객체 이용
//				model.addAttribute("errorMsg","문의 제출에 실패하였습니다.");
//				return "redirect:/";}
//		}
		
		
		//1대1 문의 get
		@RequestMapping("support/inquiry")
		public String inquiry() {
			
			return "support/inquiry";
		}
		
		//1대1 문의 get
		@PostMapping("support/inquiry")
		public String inquiry(Inquiry i
							,HttpSession session
							,Model model) {
			
		    Member loginUser = (Member) session.getAttribute("loginUser");

		    if (loginUser != null) {
		        i.setInquiryWriter(loginUser.getMemberNo());  // ★ 외래키 직접 설정
		    } else {
		        model.addAttribute("errorMsg", "로그인이 필요한 서비스입니다.");
		        return "common/errorPage";
		    }
		    
			int result = service.insertInquiry(i);
			
			
			if(result>0) {
				session.setAttribute("alertMsg", "문의가 제출되었습니다.");
				return "redirect:/";
			}else {
				model.addAttribute("errorMsg","문의 제출에 실패하였습니다.");
				
				return "redirect:/";
			
			}
		}

		
		//메소드명 boardDetail() - SELECT
		//조회수 증가 메소드명 increaseCount() - DML  
		//조회수 증가가 성공이라면 게시글 조회해서 상세페이지로 전달 및 이동 
		//실패시 오류발생 메시지를 담고 에러페이지로 위임처리하기
		@RequestMapping("detail")
		public String inquiryDetail(int bno,
								Model model) {
			
				Inquiry i = service.inquiryDetail(bno);
				
				model.addAttribute("i",i);

				return "support/detail";
			
		}
		
		
		//문의 답변
		@PostMapping("detail")
		public String Answer(InquiryAnswer a
							,HttpSession session
							,Model model) {
		    
			int result = service.insertInquiryAnswer(a);
			
			if(result>0) {
				session.setAttribute("alertMsg", "답변이 제출되었습니다.");
				return "redirect:/";
			}else {
				model.addAttribute("errorMsg","답변에 실패하였습니다.");
				
				return "redirect:/";
			
			}
		}
		
		
		

	

}
