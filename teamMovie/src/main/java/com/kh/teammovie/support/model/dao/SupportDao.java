package com.kh.teammovie.support.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.teammovie.common.model.vo.PageInfo;
import com.kh.teammovie.support.model.vo.Inquiry;
import com.kh.teammovie.support.model.vo.InquiryAnswer;

@Repository
public class SupportDao {
	
	public int insertInquiry(SqlSessionTemplate sqlSession, Inquiry i) {
	    
		return sqlSession.insert("inquiryMapper.insertInquiry",i);
	}
	
	
	public ArrayList<Inquiry> inquiryList(SqlSessionTemplate sqlSession, PageInfo pi) {

		//페이징 처리를 위한 rowBounds 객체 준비 
		//마이바티스에서 페이징처리를 도와주는 객체 
		
		int limit = pi.getBoardLimit(); //몇개씩 보여줄건지 (조회개수)
		//몇개를 건너뛰고 조회할것인지
		//한페이지에서 5개씩 보여준다고 가정 
		//1페이지에선 1-5 보여주고 
		//2페이지에선 6-10 보여주고 
		int offset = (pi.getCurrentPage()-1)*limit;
		
		RowBounds rowBounds = new RowBounds(offset,limit);
		
		//페이징처리를 위해 rowbounds 객체를 전달할때 두번째 매개변수 위치에 전달할 파라미터 값이 없더라도 
		//형식을 유지해야되기때문에 null을 전달하고 rowbounds 객체는 3번째 매개변수로 전달해야한다.
		ArrayList<Inquiry> list = (ArrayList)sqlSession.selectList("inquiryMapper.inquiryList",null,rowBounds);

		return list;
	}
	
	public ArrayList<Inquiry> myInquiryList(SqlSessionTemplate sqlSession,int memberNo) {
		// TODO Auto-generated method stub
		ArrayList<Inquiry> list = (ArrayList)sqlSession.selectList("inquiryMapper.myInquiryList",memberNo);
		return list;
	}

	public Inquiry inquiryDetail(SqlSessionTemplate sqlSession, int bno) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("inquiryMapper.inquiryDetail",bno);
	}
	public InquiryAnswer answerDetail(SqlSessionTemplate sqlSession, int bno) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("inquiryMapper.answerDetail",bno);
	}
	
	
	
	

	public int listCount(SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("inquiryMapper.listCount");
	}

	public int insertInquiryAnswer(SqlSessionTemplate sqlSession, InquiryAnswer a) {
		// TODO Auto-generated method stub
		
		return sqlSession.insert("inquiryMapper.insertInquiryAnswer",a);
	}
	
	
	public int updateStatus(SqlSessionTemplate sqlSession, int inquiryId) {
	    return sqlSession.update("inquiryMapper.updateStatus", inquiryId);
	}


	public int deleteAnswer(SqlSessionTemplate sqlSession, int bno) {
		// TODO Auto-generated method stub
		return sqlSession.delete("inquiryMapper.deleteAnswer",bno);		
	}


	public List<Inquiry> selectAllInquiries(SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("inquiryMapper.selectAllInquiries");
	}


	public List<Inquiry> selectInquiriesByStatuses(List<String> statuses,SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("inquiryMapper.selectInquiriesByStatuses",statuses);
	}


	public int countInquiries(SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("inquiryMapper.countInquiries");
	}


	public int deleteStatus(SqlSessionTemplate sqlSession, int bno) {
	    return sqlSession.update("inquiryMapper.deleteStatus", bno);
	}




	
}
