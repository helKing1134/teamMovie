package com.kh.teammovie.movie.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MovieController {
	
	@RequestMapping("movie/select")
	public String forwardMovieSelect() {
		
		
		return "movie/movieSelectPage";
		
	}
	
	

}
