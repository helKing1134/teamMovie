package com.kh.teammovie.support.model.service;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;
import com.kh.teammovie.support.model.vo.Inquiry;

public interface SupportService {
	
		int insertInquiry(Inquiry i);
		
		int insertAdmin(Inquiry i);

		ArrayList<Inquiry> inquiryList(Inquiry i);

}
