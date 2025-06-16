package com.kh.teammovie.reservation.model.service;

import java.util.ArrayList;
import java.util.List;


import com.kh.teammovie.movie.model.vo.Movie;
import com.kh.teammovie.refund.model.dto.ReqRefundDTO;
import com.kh.teammovie.schedule.model.vo.Schedule;
import com.kh.teammovie.screen.model.vo.Screen;
import com.kh.teammovie.seat.model.vo.ReservedSeat;
import com.kh.teammovie.seat.model.vo.Seat;

public interface ReservationService {
	
	//현재 상영중인 영화 목록 가져오기
		ArrayList<Movie> movieSelect(String status);
		
		//영화 아이디를 가지고스케줄 목록 가져오기 (날짜별로 가져오는 기능 추가전)
		ArrayList<Schedule> schSelect(int movieId);

		List<Schedule> getSchByMvId(int movieId);
		
		// 선택한 영화를 객체데이터로 가져오기
		Movie getMovieById(int movieId);
		
		//아이디로 상영정보 객체 가져오기 
		Schedule getSchById(int scheduleId);
		
		//아이디로 상영관 객체 가져오기
		Screen getScreenById(int screenId);
		
		// 상영관 아이디를 가지고 좌석 목록 가져오기
		ArrayList<Seat> getStListBySchId(int screenId);
		
		// 좌석 아이디 리스트를 통해 좌석 목록 가져오기
		List<Seat> getStListByStId(List<Integer> seatIds);
		
		//예약 좌석에 초기 등록
		int insertRsInit(List<Integer> seatIds, int scheduleId, int memberId);
		
		//결제 검증 메소드
		boolean tempSeatExists(int scheduleId, int memberNo);

		boolean insertRefund(ReqRefundDTO dto);
		// 예약좌석 즉시삭제 메소드
		int cancelReservSeat(int scheduleId, int memberId);
		
		//예약 좌석 리스트를 가져오는 메소드 
		List<ReservedSeat> rsSelect();
		
		// 스케줄에 대한 예약좌석 리스트만을 가져오는 메소드
		List<ReservedSeat> getRSeatsBySchedule(int scheduleId);
		
		//모든 영화가져오기
		ArrayList<Movie> movieAll();

}
