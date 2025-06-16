package com.kh.teammovie.member.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Member {

	private int memberNo; //MEMBER_NO
	private int memberId; //MEMBER_ID
	private String memberName; //MEMBER_NAME
	private String password1; //PASSWORD
	private String newPassword; //비밀번호 변경시
	private String idNum; //AGE
	private String email; //EMAIL
	private String phone;//PHONE
	private String role; //ROLE
	private Date createdDate;//CREATED_AT
}
