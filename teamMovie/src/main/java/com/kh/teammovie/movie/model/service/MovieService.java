package com.kh.teammovie.movie.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.teammovie.movie.model.vo.Movie;

public interface MovieService {

	ArrayList<Movie> movieListAll(int page);
	
	ArrayList<Movie> searchOfAllMovie(int page, HashMap<String, String> searchMap);

	ArrayList<Movie> screeningMovieList(int page);

	ArrayList<Movie> searchOfScreeningMovie(int page, HashMap<String, String> searchMap);

	ArrayList<Movie> comingMovieList(int page);

	ArrayList<Movie> searchOfComingMovie(int page, HashMap<String, String> searchMap);

	
	
	
	
	
	Movie movieDetail(int mvId);
	

	

}
