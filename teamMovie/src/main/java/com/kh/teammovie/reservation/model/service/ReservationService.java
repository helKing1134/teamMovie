package com.kh.teammovie.reservation.model.service;

import java.util.ArrayList;
import java.util.List;


import com.kh.teammovie.movie.model.vo.Movie;
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
		
		//모든 영화가져오기
		ArrayList<Movie> movieAll();
		
		

}
