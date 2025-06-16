package com.kh.teammovie.movie.model.dao;

import java.util.ArrayList;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.teammovie.movie.model.vo.Actor;
import com.kh.teammovie.movie.model.vo.Criterion;
import com.kh.teammovie.movie.model.vo.Genre;
import com.kh.teammovie.movie.model.vo.Movie;
import com.kh.teammovie.schedule.model.vo.Schedule;
import com.kh.teammovie.screen.model.vo.Screen;
import com.kh.teammovie.seat.model.vo.Seat;
import com.kh.teammovie.movie.model.vo.Review;
import com.kh.teammovie.movie.model.vo.StillCut;
import com.kh.teammovie.movie.model.vo.Type;

import org.apache.ibatis.session.RowBounds;
import java.util.HashMap;
import java.util.ArrayList;

@Repository
public class MovieDAO {
	
	
	public ArrayList<Movie> movieListAll(SqlSessionTemplate sqlSession,int page) {
		
		int limit = 4;
		int offset = (page - 1) * limit;
		
		return (ArrayList)sqlSession.selectList("movieMapper.movieListAll",null,new RowBounds(offset, limit));
	}
	
	public ArrayList<Movie> searchOfAllMovie(SqlSessionTemplate sqlSession, int page, HashMap<String, String> searchMap) {
		
		int limit = 4;
		int offset = (page - 1) * limit;
		return (ArrayList)sqlSession.selectList("movieMapper.searchOfAllMovie",searchMap,new RowBounds(offset,limit));
	}

	public ArrayList<Movie> screeningMovieList(SqlSessionTemplate sqlSession, int page) {
		
		int limit = 4;
		int offset = (page - 1) * limit;
		return (ArrayList)sqlSession.selectList("movieMapper.screeningMovieList",null,new RowBounds(offset, limit));
	}

	public ArrayList<Movie> searchOfScreeningMovie(SqlSessionTemplate sqlSession,int page,HashMap<String, String> searchMap) {
		
		int limit = 4;
		int offset = (page - 1) * limit;
		return (ArrayList)sqlSession.selectList("movieMapper.searchOfScreeningMoive",searchMap,new RowBounds(offset,limit));
	}

	public ArrayList<Movie> comingMovieList(SqlSessionTemplate sqlSession, int page) {
		
		int limit = 4;
		int offset = (page -1) * limit;
		return (ArrayList)sqlSession.selectList("movieMapper.comingMovieList",null,new RowBounds(offset, limit));
	}

	public ArrayList<Movie> searchOfComingMovie(SqlSessionTemplate sqlSession,int page,HashMap<String, String> searchMap) {
		
		int limit = 4;
		int offset = (page -1) * limit;
		return (ArrayList)sqlSession.selectList("movieMapper.searchOfComingMovie", searchMap, new RowBounds(offset, limit));
	}

	public Movie movieDetail(SqlSessionTemplate sqlSession, int mvId) {
		
		return sqlSession.selectOne("movieMapper.movieDetail", mvId);
	}

	public ArrayList<Review> getReviews(SqlSessionTemplate sqlSession, int mvId) {
		return (ArrayList)sqlSession.selectList("movieMapper.getReviews", mvId);
	}

	public ArrayList<StillCut> getStillCuts(SqlSessionTemplate sqlSession, int mvId) {
		return (ArrayList)sqlSession.selectList("movieMapper.getStillCuts", mvId);
	}
		
	public ArrayList<Actor> findActors(SqlSessionTemplate sqlSession, String keyword) {
		return (ArrayList)sqlSession.selectList("movieMapper.findActors",keyword);
	}
		
		
		

	


	public ArrayList<Movie> movieSelect(SqlSessionTemplate sqlSession, String status) {
		// TODO Auto-generated method stub
		
		ArrayList<Movie> mList = new ArrayList<>();
		
		mList = (ArrayList) sqlSession.selectList("movieMapper.movieSelect", status);
		
		return mList;
	}

	public ArrayList<Schedule> schSelect(SqlSessionTemplate sqlSession, int movieId) {

		return (ArrayList) sqlSession.selectList("movieMapper.schSelect", movieId);
	}

	public Movie getMovieById(SqlSessionTemplate sqlSession, int movieId) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("movieMapper.getMovieById", movieId);
	}

	public Schedule getSchById(SqlSessionTemplate sqlSession, int scheduleId) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("movieMapper.getSchById", scheduleId);
	}

	public Screen getScreenById(SqlSessionTemplate sqlSession, int screenId) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("screenMapper.getScreenById", screenId);
	}

	public ArrayList<Seat> getStListBySchId(SqlSessionTemplate sqlSession, int screenId) {
		// TODO Auto-generated method stub
		return (ArrayList) sqlSession.selectList("seatMapper.getStListBySchId", screenId);
	}

	
	// 현재 배우 목록 조회해오기
	public ArrayList<Actor> getActorList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("movieMapper.getActorList");
	}
	
	// 현재 영화 타입 목록 조회해오기
	public ArrayList<Type> getTypeList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("movieMapper.getTypeList");
	}
	
	// 현재 영화 장르 목록 조회해오기
	public ArrayList<Genre> getGenreList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("movieMapper.getGenreList");
	}
	
	// 등록될 영화 아이디값 조회해오기
	public int getNextMovieId(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("movieMapper.getNextMovieId");
	}

	// MOVIE 테이블에 영화 1개 등록하기
	public int insertMovie(SqlSessionTemplate sqlSession, Movie movie) {
		return sqlSession.insert("movieMapper.insertMovie",movie);
	}
	
	//MOVIE_ACTOR 테이블에 영화 1개에 해당하는 배우 1명 등록하기(service에서 반복수행됨)
	public int insertMovieActor(SqlSessionTemplate sqlSession, int movieId, int actorId) {
		
		HashMap<String,Integer> movieActorMap = new HashMap<>();
		movieActorMap.put("movieId", movieId);
		movieActorMap.put("actorId", actorId);
		
		return sqlSession.insert("movieMapper.insertMovieActor",movieActorMap);
	}
	
	//MOVIE_GENRE 테이블에 영화 1개에 해당하는 장르 1개 등록하기(service에서 반복수행됨)
	public int insertMovieGenre(SqlSessionTemplate sqlSession, int movieId, int genreId) {
		
		HashMap<String,Integer> movieGenreMap = new HashMap<>();
		movieGenreMap.put("movieId", movieId);
		movieGenreMap.put("genreId", genreId);
		
		return sqlSession.insert("movieMapper.insertMovieGenre",movieGenreMap);
	}
	
	//STILLCUT 테이블에 영화 1개에 해당하는 스틸컷 1개 등록하기(service에서 반복수행됨)
	public int insertStillCut(SqlSessionTemplate sqlSession, int movieId, StillCut stillCut) {
		
		HashMap<String,Object> stillCutMap = new HashMap<>();
		stillCutMap.put("movieId", movieId);
		stillCutMap.put("stillCut", stillCut);
		
		return sqlSession.insert("movieMapper.insertStillCut",stillCutMap);
	}
	
	//REVIEW 테이블에 리뷰 1개 등록
	public int insertReview(SqlSessionTemplate sqlSession,Review review) {
		return sqlSession.insert("movieMapper.insertReview",review);
	}
	
	//REVIEW_CRITERIA 테이블에 리뷰 1개당 기준 여러개 등록
	public int insertReviewCriteria(SqlSessionTemplate sqlSession,int reviewId,int criterionId) {
		HashMap<String,Integer> reviewCriteriaMap = new HashMap<>();
		reviewCriteriaMap.put("reviewId", reviewId);
		reviewCriteriaMap.put("criterionId", criterionId);
		return sqlSession.insert("movieMapper.insertReviewCriteria",reviewCriteriaMap);
	}

	public int getReviewId(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("movieMapper.getReviewId");
	}

	public int registerActor(SqlSessionTemplate sqlSession, Actor actor) {
		return sqlSession.insert("movieMapper.registerActor", actor);


	}
	
	
		
	
		

	



	

	


	
	
	
	

	
	
	

}
