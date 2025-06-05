package com.kh.teammovie.support.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.teammovie.support.model.vo.Inquiry;

@Repository
public class SupportDao {
	
	public int insertInquiry(SqlSessionTemplate sqlSession, Inquiry i) {
		
		return sqlSession.insert("inquiryMapper.insertInquiry",i);
	}
	
	public int insertAdmin(SqlSessionTemplate sqlSession, Inquiry i) {
		
		return sqlSession.insert("inquiryMapper.insertInquiry",i);
	}
	
	public ArrayList<Inquiry> inquiryList(SqlSessionTemplate sqlSession, Inquiry i) {
		
		ArrayList<Inquiry> list = (ArrayList)sqlSession.selectList("inquiryMapper.inquiryList",i);
		
		return list;
	}
	
}
