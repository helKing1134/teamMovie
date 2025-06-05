package com.kh.teammovie.movie.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.teammovie.movie.model.vo.Movie;

public interface MovieService {

	ArrayList<Movie> movieListAll(int page);
	
	ArrayList<Movie> searchOfAllMovie(int page, HashMap<String, String> searchMap);
	
	/*
	ArrayList<Movie> movieNowList(int page);

	ArrayList<Movie> movieSoonList(int page);

	ArrayList<Movie> movieAllSearchList(int page, HashMap<String, String> map);

	ArrayList<Movie> movieNowSearchList(int page, HashMap<String, String> map);

	ArrayList<Movie> movieSoonSearchList(int page, HashMap<String, String> map);

	ArrayList<Movie> movieList(HashMap<String, Object> map);

	int movieCount();
	*/

	

}
