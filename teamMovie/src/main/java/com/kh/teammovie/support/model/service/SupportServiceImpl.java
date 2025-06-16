package com.kh.teammovie.support.model.service;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.teammovie.common.model.vo.PageInfo;
import com.kh.teammovie.support.model.dao.SupportDao;
import com.kh.teammovie.support.model.vo.Inquiry;
import com.kh.teammovie.support.model.vo.InquiryAnswer;

@Service
public class SupportServiceImpl implements SupportService {

	@Autowired
	private SupportDao dao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	//문의글 작성
	@Override
	public int insertInquiry(Inquiry i) {
		// TODO Auto-generated method stub
		return dao.insertInquiry(sqlSession,i);
	}
	
	@Override
	public List<Inquiry> findAllInquiries() {
	    return dao.selectAllInquiries(sqlSession);
	}

	@Override
	public List<Inquiry> selectInquiriesByStatuses(List<String> statuses) {
		// TODO Auto-generated method stub
		return dao.selectInquiriesByStatuses(statuses,sqlSession);
	}
	
	@Override
	public int deleteAnswer(int bno) {
		// TODO Auto-generated method stub
		return dao.deleteAnswer(sqlSession, bno);
	}

//	@Override
//	public int insertAdmin(Inquiry i) {
//		// TODO Auto-generated method stub
//		return 0;
//	}

	@Override
	public ArrayList<Inquiry> inquiryList(PageInfo pi) {
		// TODO Auto-generated method stub
		return dao.inquiryList(sqlSession,pi);
	}

	@Override
	public Inquiry inquiryDetail(int bno) {
		// TODO Auto-generated method stub
		return dao.inquiryDetail(sqlSession, bno);
	}

	@Override
	public InquiryAnswer answerDetail(int bno) {
		// TODO Auto-generated method stub
		return dao.answerDetail(sqlSession, bno);
	}

	@Override
	public int listCount() {
		// TODO Auto-generated method stub
		return dao.listCount(sqlSession);
	}

	@Override
	public int insertInquiryAnswer(InquiryAnswer a) {
		// TODO Auto-generated method stub
		return dao.insertInquiryAnswer(sqlSession,a);
	}

	@Override
	public int updateStatus(int inquiryId) {
		// TODO Auto-generated method stub
		return dao.updateStatus(sqlSession,inquiryId);
	}

	@Override
	public ArrayList<Inquiry> myInquiryList(int memberNo) {
		// TODO Auto-generated method stub
		return dao.myInquiryList(sqlSession,memberNo);
	}




	




}
