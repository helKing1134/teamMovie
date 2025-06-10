package com.kh.teammovie.movie.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.teammovie.movie.model.vo.Movie;
import com.kh.teammovie.movie.model.vo.Review;
import com.kh.teammovie.movie.model.vo.StillCut;

@Repository
public class MovieDao {

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
	
	

	
	
	

}
