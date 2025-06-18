package com.kh.teammovie.member.model.dao;

import java.util.ArrayList;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.teammovie.member.model.vo.Member;

@Repository
public class MemberDao {

	public Member loginMember(SqlSessionTemplate sqlSession, Member m) {
		Member loginUser = sqlSession.selectOne("memberMapper.loginMember", m);
		return loginUser;
	}
	
	public int registerMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.insert("memberMapper.registerMember", m);
	}

	public int updateMember(SqlSessionTemplate sqlSession, Member m) {
		
		return sqlSession.update("memberMapper.updateMember",m);
	}

	public int dupCheck(SqlSessionTemplate sqlSession, String memberId) {
		return sqlSession.selectOne("memberMapper.dupCheck",memberId);
	}

	public int deleteMebmer(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("memberMapper.deleteMember",m);
	}
	
	public int updatePassword(SqlSessionTemplate sqlSession, Member loginUser) {
		
		return sqlSession.update("memberMapper.updatePassword", loginUser);
	}
	
	public ArrayList<Member> adminMember(SqlSessionTemplate sqlSession) {
		ArrayList<Member> list = (ArrayList)sqlSession.selectList("memberMapper.adminMember");
		return list;
	}
	
	public void updateMemberRole(int memberNo, String role,SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		 sqlSession.update("memberMapper.updateMemberRole", Map.of("memberNo", memberNo, "role", role));
	}
	

	

}
