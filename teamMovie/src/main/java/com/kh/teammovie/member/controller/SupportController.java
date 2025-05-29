package com.kh.teammovie.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

	@Controller
	public class SupportController {

	
	@RequestMapping("support")
	public String smain() {
		
		//메인페이지로 보내기
		return "member/support/smain";
	}
	
	@RequestMapping("support/faq")
	public String sfaq() {
		
		//메인페이지로 보내기
		return "member/support/sfaq";
	}
	
	@RequestMapping("support/inquiry")
	public String sinquiry() {
		
		//메인페이지로 보내기
		return "member/support/sinquiry";
	}
	

}
