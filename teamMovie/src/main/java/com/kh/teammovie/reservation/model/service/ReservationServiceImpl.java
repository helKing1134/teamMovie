package com.kh.teammovie.reservation.model.service;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.teammovie.movie.model.vo.Movie;
import com.kh.teammovie.reservation.model.dao.ReservationDAO;
import com.kh.teammovie.schedule.model.vo.Schedule;
import com.kh.teammovie.screen.model.vo.Screen;
import com.kh.teammovie.seat.model.vo.ReservedSeat;
import com.kh.teammovie.seat.model.vo.Seat;

@Service
public class ReservationServiceImpl implements ReservationService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private ReservationDAO rvDAO;

	@Override
	//현재 상영중인 영화목록 가져오기
	public ArrayList<Movie> movieSelect(String status) {

		return rvDAO.movieSelect(sqlSession, status);
	}

	@Override
	// 스케줄 목록 가져오기
	public ArrayList<Schedule> schSelect(int movieId) {
		// TODO Auto-generated method stub
		return rvDAO.schSelect(sqlSession, movieId);
	}

	
	@Override
//	선택한 영화 데이터 가져오기 
	public Movie getMovieById(int movieId) {
		// TODO Auto-generated method stub
		return rvDAO.getMovieById(sqlSession, movieId);
	}

	@Override
	public List<Schedule> getSchByMvId(int movieId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ArrayList<Movie> movieAll() {
		// TODO Auto-generated method stub
		return rvDAO.movieAll(sqlSession);
	}

	

	

	
	
}
