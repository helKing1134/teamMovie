package com.kh.teammovie.support.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.teammovie.support.model.dao.SupportDao;
import com.kh.teammovie.support.model.vo.Inquiry;

@Service
public class SupportServiceImpl implements SupportService {

	@Autowired
	private SupportDao dao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int insertInquiry(Inquiry i) {
		// TODO Auto-generated method stub
		return dao.insertInquiry(sqlSession,i);
	}

	@Override
	public int insertAdmin(Inquiry i) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public ArrayList<Inquiry> inquiryList(Inquiry i) {
		// TODO Auto-generated method stub
		return dao.inquiryList(sqlSession,i);
	}

}
