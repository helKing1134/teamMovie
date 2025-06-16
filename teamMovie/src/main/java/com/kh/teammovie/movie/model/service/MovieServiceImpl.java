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
import com.kh.teammovie.movie.model.vo.Criterion;
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
	
	@Override
	public int getNextMovieId() {
		return mvDAO.getNextMovieId(sqlSession);
	}
	
	
	@Transactional
	@Override
	public void registerMovie(Movie movie, int[] actorIds, int[] genreIds, ArrayList<StillCut> stillCuts) {
		
		//1.MOVIE 테이블 등록부터 하기!
		//이후 성공하면 MOVIE_ACTOR,MOVIE_GENRE,STILLCUT 테이블 등록하는 흐름
		int movieId = movie.getMovieId(); //등록될 영화의 movieId
		
		int result = mvDAO.insertMovie(sqlSession,movie); //MOVIE 테이블 등록용
		if(result > 0) { //MOVIE 테이블에 등록 성공
			
			int result2 = 1; //MOVIE_ACTOR 테이블 등록용
			for(int actorId : actorIds) { //저장할 배우 수만큼 반복
				result2 *= mvDAO.insertMovieActor(sqlSession,movieId,actorId);
				if(result2 == 0) {
					throw new RuntimeException("MOVIE_ACTOR 등록 실패");
				}
			}
			
			int result3 = 1; //MOVIE_GENRE 테이블 등록용
			for(int genreId : genreIds) {
				result3 *= mvDAO.insertMovieGenre(sqlSession,movieId,genreId);
				if(result3 == 0) {
					throw new RuntimeException("MOVIE_GENRE 등록 실패");
				}
			}
			
			int result4 = 1; //STILLCUT 테이블 등록용
			for(StillCut stillCut : stillCuts) {
				result4 *= mvDAO.insertStillCut(sqlSession,movieId,stillCut);
				if(result4 == 0) {
					throw new RuntimeException("MOVIE_STILLCUT 등록 실패");
				}
			}
			
			
			//모두 정상 등록된 경우(예외 발생 X)
			
			
		}else { //MOVIE 테이블에 등록 실패
			
		    throw new RuntimeException("MOVIE 등록 실패");
		}
		
		
	}
	
	@Override
	public int registerActor(Actor actor) {
		return mvDAO.registerActor(sqlSession,actor);
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
	
	//리뷰 등록하기 전 아이디값 가져오기
	@Override
	public int getReviewId() {
		return mvDAO.getReviewId(sqlSession);
	}
	
	
	//리뷰 등록하기
	//REVIEW_CRITERIA 테이블,REVIEW 테이블 모두 등록
	@Transactional
	@Override
	public int registerReview(Review review,int[] selectedCriterionId) {
		
		int result = mvDAO.insertReview(sqlSession,review); //REVIEW 테이블 등록
		int reviewId = review.getReviewId();
		if(result > 0) { //REVIEW 테이블 등록 성공
			
			int result2 = 1;
			for(int criterionId : selectedCriterionId) {
				
				result2 *= mvDAO.insertReviewCriteria(sqlSession,reviewId,criterionId); //REVIEW_CRITERIA 테이블 등록
				if(result2 == 0) {
					throw new RuntimeException("REVIEW_CRITERIA 등록 실패");
				}
			}
			
			return result;
			
		}else { //REVIEW 테이블 등록 실패
			throw new RuntimeException("REVIEW 등록 실패");
		}
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
	
	@Override
	public List<Movie> selectTop4Movies() {
	    return mvDAO.selectTop4Movies(sqlSession); // ✅ 이렇게!
	}
	
	
	
	

	
	
	



//	@Override
//	//현재 상영중인 영화목록 가져오기
//	public ArrayList<Movie> movieSelect(String status) {
//
//		return mvDAO.movieSelect(sqlSession, status);
//	}
//
//	@Override
//	// 스케줄 목록 가져오기
//	public ArrayList<Schedule> schSelect(int movieId) {
//		// TODO Auto-generated method stub
//		return mvDAO.schSelect(sqlSession, movieId);
//	}
//
//	@Override
//	public List<Schedule> getSchByMvId(int movieId) {
//		// TODO Auto-generated method stub
//		return null;
//	}
//
//	@Override
////	선택한 영화 데이터 가져오기 
//	public Movie getMovieById(int movieId) {
//		// TODO Auto-generated method stub
//		return mvDAO.getMovieById(sqlSession, movieId);
//	}
//
//	@Override
//	// 아이디로 상영정보 객체 가져오기 
//	public Schedule getSchById(int scheduleId) {
//		// TODO Auto-generated method stub
//		return mvDAO.getSchById(sqlSession, scheduleId);
//	}
//
//	@Override
//	//아이디로 상영관 객체 가져오기
//	public Screen getScreenById(int screenId) {
//		// TODO Auto-generated method stub
//		return mvDAO.getScreenById(sqlSession, screenId);
//	}
//
//	@Override
//	// 상영관 아이디를 가지고 좌석 목록 가져오기
//	public ArrayList<Seat> getStListBySchId(int screenId) {
//		// TODO Auto-generated method stub
//		return mvDAO.getStListBySchId(sqlSession, screenId);
//	}
	
	

}
