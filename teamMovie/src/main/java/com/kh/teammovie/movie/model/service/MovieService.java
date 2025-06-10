package com.kh.teammovie.movie.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.teammovie.movie.model.vo.Movie;
import com.kh.teammovie.movie.model.vo.Review;
import com.kh.teammovie.movie.model.vo.StillCut;

public interface MovieService {

	ArrayList<Movie> movieListAll(int page);
	
	ArrayList<Movie> searchOfAllMovie(int page, HashMap<String, String> searchMap);

	ArrayList<Movie> screeningMovieList(int page);

	ArrayList<Movie> searchOfScreeningMovie(int page, HashMap<String, String> searchMap);

	ArrayList<Movie> comingMovieList(int page);

	ArrayList<Movie> searchOfComingMovie(int page, HashMap<String, String> searchMap);

	
	
	
	
	
	Movie movieDetail(int mvId);

	ArrayList<Review> getReviews(int mvId);

	ArrayList<StillCut> getStillCuts(int mvId);
	

	

}
