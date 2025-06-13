package com.kh.teammovie.movie.model.service;

import java.util.List;
import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.teammovie.movie.model.vo.Movie;
import com.kh.teammovie.movie.model.vo.Review;
import com.kh.teammovie.movie.model.vo.StillCut;
import com.kh.teammovie.movie.model.dao.MovieDAO;
import com.kh.teammovie.schedule.model.vo.Schedule;
import com.kh.teammovie.screen.model.vo.Screen;
import com.kh.teammovie.seat.model.vo.Seat;

@Service
public class MovieServiceImpl implements MovieService {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private MovieDAO mvDAO;
	
	@Override
	public ArrayList<Movie> movieListAll(int page) {
		
		return mvDAO.movieListAll(sqlSession,page);
	}
	
	@Override
	public ArrayList<Movie> searchOfAllMovie(int page, HashMap<String, String> searchMap) {
		return mvDAO.searchOfAllMovie(sqlSession,page,searchMap);
	}
	
	@Override
	public ArrayList<Movie> screeningMovieList(int page) {
		return mvDAO.screeningMovieList(sqlSession,page);
	}
	
	@Override
	public ArrayList<Movie> searchOfScreeningMovie(int page, HashMap<String, String> searchMap) {
		return mvDAO.searchOfScreeningMovie(sqlSession,page,searchMap);
	}
	
	@Override
	public ArrayList<Movie> comingMovieList(int page) {
		return mvDAO.comingMovieList(sqlSession,page);
	}
	
	@Override
	public ArrayList<Movie> searchOfComingMovie(int page, HashMap<String, String> searchMap) {
		return mvDAO.searchOfComingMovie(sqlSession,page,searchMap);
	}
	
	
	
	
	
	
	@Override
	public Movie movieDetail(int mvId) {
		return mvDAO.movieDetail(sqlSession,mvId);
	}
	
	@Override
	public ArrayList<Review> getReviews(int mvId) {
		return mvDAO.getReviews(sqlSession,mvId);
	}
	
	@Override
	public ArrayList<StillCut> getStillCuts(int mvId) {
		return mvDAO.getStillCuts(sqlSession,mvId);
	}


	@Override
	//현재 상영중인 영화목록 가져오기
	public ArrayList<Movie> movieSelect(String status) {

		return mvDAO.movieSelect(sqlSession, status);
	}

	@Override
	// 스케줄 목록 가져오기
	public ArrayList<Schedule> schSelect(int movieId) {
		// TODO Auto-generated method stub
		return mvDAO.schSelect(sqlSession, movieId);
	}

	@Override
	public List<Schedule> getSchByMvId(int movieId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
//	선택한 영화 데이터 가져오기 
	public Movie getMovieById(int movieId) {
		// TODO Auto-generated method stub
		return mvDAO.getMovieById(sqlSession, movieId);
	}

	@Override
	// 아이디로 상영정보 객체 가져오기 
	public Schedule getSchById(int scheduleId) {
		// TODO Auto-generated method stub
		return mvDAO.getSchById(sqlSession, scheduleId);
	}

	@Override
	//아이디로 상영관 객체 가져오기
	public Screen getScreenById(int screenId) {
		// TODO Auto-generated method stub
		return mvDAO.getScreenById(sqlSession, screenId);
	}

	@Override
	// 상영관 아이디를 가지고 좌석 목록 가져오기
	public ArrayList<Seat> getStListBySchId(int screenId) {
		// TODO Auto-generated method stub
		return mvDAO.getStListBySchId(sqlSession, screenId);
	}
	
	

}
