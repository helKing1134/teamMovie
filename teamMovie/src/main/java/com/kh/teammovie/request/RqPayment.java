package com.kh.teammovie.request;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class RqPayment {
	
	//영화 아이디
	private int movieId;
	// 상영관 아이디
	private int screenId;
	// 상영정보 아이디
	private int scheduleId;
	// 멤버 번호
	private int memberId;
	// 좌석 아이디 List
	private List<Integer> seatIds;
	

}
