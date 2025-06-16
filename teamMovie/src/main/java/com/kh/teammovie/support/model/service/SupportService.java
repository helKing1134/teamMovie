package com.kh.teammovie.support.model.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kh.teammovie.common.model.vo.PageInfo;
import com.kh.teammovie.support.model.vo.Inquiry;
import com.kh.teammovie.support.model.vo.InquiryAnswer;

public interface SupportService {
	
		//문의글 작성	
		int insertInquiry(Inquiry i);
		
//		int insertAdmin(Inquiry i);
		
		
		//관리자 문의 게시판 목록 
		ArrayList<Inquiry> inquiryList(PageInfo pi);
		//나의 문의내역
		List<Inquiry> myInquiryList(int memberId);
		
		List<Inquiry> findAllInquiries();
		List<Inquiry> selectInquiriesByStatuses(@Param("statuses") List<String> statuses);
		
		
		//관리자 문의 게시판 상세조회
		Inquiry inquiryDetail(int bno);
		InquiryAnswer answerDetail(int bno);
		
		//게시글 개수 조회 메소드
		int listCount();
		
		//관리자 답변
		int insertInquiryAnswer(InquiryAnswer a);

		int updateStatus(int inquiryId);

		int deleteAnswer(int bno);



		
}
