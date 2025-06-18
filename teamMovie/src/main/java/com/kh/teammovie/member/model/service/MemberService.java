package com.kh.teammovie.member.model.service;

import java.util.ArrayList;

import com.kh.teammovie.member.model.vo.Member;

public interface MemberService {

	Member loginMember(Member m);

	int registerMember(Member m);

	int updateMember(Member m);

	int dupCheck(String memberId);

	int deleteMember(Member m);
	
	int updatePassword(Member loginUser);

	ArrayList<Member> adminMember();
}
