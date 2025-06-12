package com.kh.teammovie.movie.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.teammovie.movie.model.dao.MovieDAO;
import com.kh.teammovie.movie.model.vo.Actor;
import com.kh.teammovie.movie.model.vo.Genre;
import com.kh.teammovie.movie.model.vo.Movie;
import com.kh.teammovie.movie.model.vo.Review;
import com.kh.teammovie.movie.model.vo.StillCut;
import com.kh.teammovie.movie.model.vo.Type;
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
	
	//확인중...(필요없어지면 지우겠습니다 by 이수한)
	@Override
	public ArrayList<Actor> findActors(String keyword) {
		return mvDAO.findActors(sqlSession,keyword);
	}
	
	@Override
	public ArrayList<Actor> getActorList() {
		return mvDAO.getActorList(sqlSession);
	}
	
	@Override
	public ArrayList<Type> getTypeList() {
		return mvDAO.getTypeList(sqlSession);
	}
	
	@Override
	public ArrayList<Genre> getGenreList() {
		return mvDAO.getGenreList(sqlSession);
	}
	
	
	@Transactional
	@Override
	public int registerMovie(Movie movie, String[] actorNames, String[] genreNames, ArrayList<StillCut> stillCuts) {
		
		int movieId = mvDAO.getMovieIdForRegister(sqlSession); //영화 등록을 위해 movieId값 받아오기
		movie.setMovieId(movieId);
		
		int result = 0; //MOVIE 테이블에 영화 등록을 위한 판별용 result값
		if(movieId > 0) {//MOVIE 테이블에 영화 등록을 위한 식별용 MOVIE_ID값을 정상적으로 받아온 상황
			result = mvDAO.registerMovie(movie);
			
			if(result > 0) { //MOVIE 테이블에 영화가 정상적으로 등록
				//ACTOR 테이블에 등록 처리
				//동일한 배우 존재 가능하므로 그에 따른 로직 처리
				//단, 동명이인 배우는 없다고 가정
				//그것까지 고려하면 관리자가 배우 등록할때 식별자도 같이 등록해야함(관리자가 배우마다 식별자를 같이 등록해야함)
				for(String actorName : actorNames) {
					if(mvDAO.checkEqualActor(actorName) == 0){ //배우가 ACTOR 테이블에 존재하지 않을시
						int result2 = mvDAO.registerActor(actorName); 
						if(result2 > 0) { //배우가 ACTOR 테이블에 정상적으로 등록
							//MOVIE_ACTOR 테이블에도 추가해야함
							int actorId = mvDAO.getActorIdForRegister(sqlSession,actorName);
							
							if(actorId > 0){//MOVIE_ACTOR 테이블에 등록을 위한 식별용 ACTOR_ID값을 정상적으로 받아온 상황
								int result3 = mvDAO.registerMovieActor(sqlSession,movieId,actorId);
								
							}else {//MOVIE_ACTOR 테이블에 등록을 하기 위한 식별용 ACTOR_ID값조차 제대로 안 구해진 상황
								return actorId;
								
							}
						}else { //ACTOR 테이블에 배우 등록 실패
							return result2;
						}
					}else {//배우가 ACTOR 테이블에 이미 존재할시
					}
					
				}
			}else { //MOVIE 테이블에 영화 등록 실패
				return result;
			}
			
		}else {//영화 등록을 위한 식별용 MOVIE_ID값조차 제대로 안 구해진 상황
			return movieId; 
		}
		
		
		
		
		//return mvDAO.registerMovie(sqlSession,movie,actorNames,genreNames,stillCuts);
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
