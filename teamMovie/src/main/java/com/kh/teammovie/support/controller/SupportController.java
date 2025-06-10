package com.kh.teammovie.support.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.teammovie.support.model.service.SupportService;
import com.kh.teammovie.support.model.vo.Inquiry;

	@Controller
	public class SupportController {
		
		@Autowired
		private SupportService service;

	
		@RequestMapping("support")// 클릭할떄 가는 jsp에서 지어진 url과 같은 것
		public String smain() {
			return "support/main"; //보낼 페이지(실제 페이지)jsp
		}
		
		@RequestMapping("support/faq")
		public String sfaq() {
			
			return "support/faq";
		}
		
		@RequestMapping("inquiryList")
		public String sinquiryList(Inquiry i, Model model) {
			
			ArrayList<Inquiry> list = service.inquiryList(i);
			model.addAttribute("list", list);
			
			//메인페이지로 보내기
			return "support/inquiryList";
		}
		
		@RequestMapping("inquiryAnswer")
		public String inquiryAnswer() {
			
			return "support/inquiryAnswer";
		}
		
		
		
		
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
		
		
		
		@RequestMapping("support/inquiry")
		public String sinquiry() {
			
			//메인페이지로 보내기
			return "support/inquiry";
		}
		
		@PostMapping("support/inquiry")
		public String sinquiry(Inquiry i
							,HttpSession session
							,Model model) {
			
			int result = service.insertInquiry(i);
			
			if(result>0) {
				session.setAttribute("alertMsg", "문의가 제출되었습니다.");
				return "redirect:/";
			}else {
				//회원가입 실패시 - 회원가입에 실패하였습니다. 메시지와 함께 에러페이지로 포워딩(위임) - model 객체 이용
				model.addAttribute("errorMsg","문의 제출에 실패하였습니다.");
				
				return "redirect:/";
			
			}
		}
	
	

}
