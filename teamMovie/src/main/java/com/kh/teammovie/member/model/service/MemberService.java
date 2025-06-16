package com.kh.teammovie.member.model.service;

import com.kh.teammovie.member.model.vo.Member;

public interface MemberService {

	Member loginMember(Member m);

	int registerMember(Member m);

	int updateMember(Member m);

	int dupCheck(int memberId);

	int deleteMember(Member m);
	
	int updatePassword(Member loginUser);

}
