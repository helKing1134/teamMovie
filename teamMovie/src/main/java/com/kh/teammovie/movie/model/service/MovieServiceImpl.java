package com.kh.teammovie.movie.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.teammovie.movie.model.dao.MovieDao;
import com.kh.teammovie.movie.model.vo.Movie;

@Service
public class MovieServiceImpl implements MovieService{
	
	@Autowired
	private MovieDao dao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public ArrayList<Movie> movieAllList(int page) {
		
		return dao.movieAllList(sqlSession,page);
	}
	
	@Override
	public ArrayList<Movie> movieNowList(int page) {

		return dao.movieNowList(sqlSession,page);
	}
	
	@Override
	public ArrayList<Movie> movieSoonList(int page) {
		
		return dao.movieSoonList(sqlSession,page);
	}
	
	@Override
	public ArrayList<Movie> movieAllSearchList(int page, HashMap<String, String> map) {
		return dao.movieAllSearchList(sqlSession,page,map);
	}
	
	@Override
	public ArrayList<Movie> movieNowSearchList(int page, HashMap<String, String> map) {
		return dao.movieNowSearchList(sqlSession,page,map);
	}
	
	@Override
	public ArrayList<Movie> movieSoonSearchList(int page, HashMap<String, String> map) {
		return dao.movieSoonSearchList(sqlSession,page,map);
	}
	
	
	
	@Override
	public ArrayList<Movie> movieList(HashMap<String, Object> map) {
		return dao.movieList(sqlSession,map);
	}
	
}
