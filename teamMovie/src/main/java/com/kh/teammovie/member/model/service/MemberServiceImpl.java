package com.kh.teammovie.member.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.teammovie.member.model.dao.MemberDao;
import com.kh.teammovie.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService  {
	
	@Autowired
	private MemberDao dao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public Member loginMember(Member m) {
		Member loginUser = dao.loginMember(sqlSession,m);
		return loginUser;
	}

	@Override
	public int registerMember(Member m) {		
		return dao.registerMember(sqlSession, m);
	}

	@Override
	public int updateMember(Member m) {	
		return dao.updateMember(sqlSession,m);
	}

	@Override
	public int dupCheck(String memberId) {
		return dao.dupCheck(sqlSession, memberId);
	}

	@Override
	public int deleteMember(Member m) {
		return dao.deleteMebmer(sqlSession,m);
	}

	@Override
	public int updatePassword(Member loginUser) {
		
		return dao.updatePassword(sqlSession,loginUser);
	}

}
