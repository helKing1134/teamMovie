package com.kh.teammovie.movie.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.HashMap;

import com.kh.teammovie.movie.model.vo.Movie;
import com.kh.teammovie.movie.model.vo.Review;
import com.kh.teammovie.movie.model.vo.StillCut;

import com.kh.teammovie.schedule.model.vo.Schedule;
import com.kh.teammovie.screen.model.vo.Screen;
import com.kh.teammovie.seat.model.vo.Seat;

public interface MovieService {
	
	//영화 전체목록 가져오기
	ArrayList<Movie> movieListAll(int page);
	//영화 전체목록 중 필터링된 목록 가져오기
	ArrayList<Movie> searchOfAllMovie(int page, HashMap<String, String> searchMap);
	//상영중인 영화 목록 가져오기
	ArrayList<Movie> screeningMovieList(int page);
	//상영중인 영화 목록 중 필터링된 목록 가져오기 
	ArrayList<Movie> searchOfScreeningMovie(int page, HashMap<String, String> searchMap);
	//상영예정인 영화 목록 가져오기
	ArrayList<Movie> comingMovieList(int page);
	//상영예정인 영화 목록 중 필터링된 목록 가져오기
	ArrayList<Movie> searchOfComingMovie(int page, HashMap<String, String> searchMap);

	
	
	
	Movie movieDetail(int mvId);

	ArrayList<Review> getReviews(int mvId);

	ArrayList<StillCut> getStillCuts(int mvId);
	




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
	
	

}
