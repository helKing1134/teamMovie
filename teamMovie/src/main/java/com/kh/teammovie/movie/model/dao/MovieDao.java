package com.kh.teammovie.movie.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.teammovie.movie.model.vo.Movie;

@Repository
public class MovieDao {

	public ArrayList<Movie> movieListAll(SqlSessionTemplate sqlSession,int page) {
		
		int limit = 4;
		int offset = (page-1) * limit;
		
		return (ArrayList)sqlSession.selectList("movieMapper.movieListAll",null,new RowBounds(offset, limit));
	}
	
	public ArrayList<Movie> searchOfAllMovie(SqlSessionTemplate sqlSession, int page, HashMap<String, String> searchMap) {
		
		int limit = 4;
		int offset = (page-1) * limit;
		return (ArrayList)sqlSession.selectList("movieMapper.searchOfAllMovie",searchMap,new RowBounds(offset,limit));
	}
	
	/*
	public ArrayList<Movie> movieNowList(SqlSessionTemplate sqlSession, int page) {
		
		int limit = 6;
		int offset = (page-1) * limit;
		
		return (ArrayList)sqlSession.selectList("movieMapper.movieNowList",null,new RowBounds(offset,limit));
	}

	public ArrayList<Movie> movieSoonList(SqlSessionTemplate sqlSession, int page) {
		
		int limit = 6;
		int offset = (page-1) * limit;
		
		return (ArrayList)sqlSession.selectList("movieMapper.movieSoonList", null, new RowBounds(offset,limit));
		
	}

	public ArrayList<Movie> movieAllSearchList(SqlSessionTemplate sqlSession, int page, HashMap<String, String> map) {
		
		int limit = 6;
		int offset = (page-1) * limit;
		
		return (ArrayList)sqlSession.selectList("movieMapper.movieAllSearchList",map,new RowBounds(offset,limit));
	}

	public ArrayList<Movie> movieNowSearchList(SqlSessionTemplate sqlSession, int page, HashMap<String, String> map) {
		
		int limit = 6;
		int offset = (page-1) * limit;
		
		return (ArrayList)sqlSession.selectList("movieMapper.movieNowSearchList",map,new RowBounds(offset,limit));
	}

	public ArrayList<Movie> movieSoonSearchList(SqlSessionTemplate sqlSession, int page, HashMap<String, String> map) {
		
		int limit = 6;
		int offset = (page-1) * limit;
		
		return (ArrayList)sqlSession.selectList("movieMapper.movieSoonSearchList",map,new RowBounds(offset,limit));
	}

	public ArrayList<Movie> movieList(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		
		System.out.println("map의 conditon : " + map.get("condition"));
		System.out.println("map의 keyword : " + map.get("keyword"));
		return (ArrayList)sqlSession.selectList("movieMapper.movieList",map);
	}

	public int movieCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("movieMapper.movieCount");
	}
	*/

	
	
	

}
