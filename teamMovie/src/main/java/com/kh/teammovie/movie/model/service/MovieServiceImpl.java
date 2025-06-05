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
	public ArrayList<Movie> movieListAll(int page) {
		
		return dao.movieListAll(sqlSession,page);
	}
	
	@Override
	public ArrayList<Movie> searchOfAllMovie(int page, HashMap<String, String> searchMap) {
		return dao.searchOfAllMovie(sqlSession,page,searchMap);
	}
	
	@Override
	public ArrayList<Movie> screeningMovieList(int page) {
		return dao.screeningMovieList(sqlSession,page);
	}
	
	@Override
	public ArrayList<Movie> searchOfScreeningMovie(int page, HashMap<String, String> searchMap) {
		return dao.searchOfScreeningMovie(sqlSession,page,searchMap);
	}
	
	@Override
	public ArrayList<Movie> comingMovieList(int page) {
		return dao.comingMovieList(sqlSession,page);
	}
	
	@Override
	public ArrayList<Movie> searchOfComingMovie(int page, HashMap<String, String> searchMap) {
		return dao.searchOfComingMovie(sqlSession,page,searchMap);
	}
	
	
	
	
	
	
	@Override
	public Movie movieDetail(int mvId) {
		return dao.movieDetail(sqlSession,mvId);
	}
	
}
