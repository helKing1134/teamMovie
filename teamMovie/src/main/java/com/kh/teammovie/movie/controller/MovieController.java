package com.kh.teammovie.movie.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.teammovie.movie.model.service.MovieService;
import com.kh.teammovie.movie.model.vo.Movie;
import com.kh.teammovie.movie.model.vo.Review;
import com.kh.teammovie.movie.model.vo.StillCut;


@Controller
@RequestMapping("/movies")
public class MovieController { //written by 이수한
	
	
	@Autowired
	private MovieService service;

	
	
	/*====================영화 목록 조회 메서드=====================*/

	
	
	
	@GetMapping("")//(동기)전체 영화 목록 페이지 위임 요청
	public String allMovieListView() {
		return "movie/movieAll";
	}
	
	@ResponseBody //(비동기)전체 영화 목록 가져오기
	@GetMapping(value =  "/all.mv", produces = "application/json;charset=utf-8") 
	public ArrayList<Movie> movieListAll(int page) {
		
		ArrayList<Movie> movieListAll = service.movieListAll(page);
		
		return movieListAll;
	}
	
	@ResponseBody //(비동기)전체 영화에서 검색필터링된 목록 가져오기
	@GetMapping(value = "searchOfAll.mv", produces = "application/json;charset = utf-8")
	public ArrayList<Movie> searchOfAllMovie(int page
								  ,String condition
								  ,String keyword
								  ) {
		HashMap<String,String> searchMap = new HashMap<>();
		
		searchMap.put("condition", condition);
		searchMap.put("keyword", keyword);
		
		return service.searchOfAllMovie(page,searchMap); 
	}
	
	@GetMapping("screening") //(동기)상영중인 영화 목록 페이지 위임 요청
	public String screeningMovieListView() {
		return "movie/movieScreening";
	}
	
	@ResponseBody //(비동기)상영중인 영화 목록 가져오기
	@GetMapping(value =  "/screening.mv", produces = "application/json;charset=utf-8")
	public ArrayList<Movie> screeningMovieList(int page) { 
		
		ArrayList<Movie> screeningMovieList = service.screeningMovieList(page);
		
		return screeningMovieList;
	}
	
	@ResponseBody //(비동기)상영중인 영화에서 검색필터링된 목록 가져오기
	@GetMapping(value = "searchOfScreening.mv", produces = "application/json;charset = utf-8")
	public ArrayList<Movie> searchOfScreeningMovie(int page
								  ,String condition
								  ,String keyword
								  ) {
		HashMap<String,String> searchMap = new HashMap<>();
		
		searchMap.put("condition", condition);
		searchMap.put("keyword", keyword);
		
		return service.searchOfScreeningMovie(page,searchMap); 
	}
	
	@GetMapping("coming") //(동기)상영 예정 영화 목록 페이지 위임 요청
	public String comingMovieListView() {
		return "movie/movieComing";
	}
	
	@ResponseBody //(비동기)상영 예정 영화 목록 가져오기
	@GetMapping(value =  "/coming.mv", produces = "application/json;charset=utf-8")
	public ArrayList<Movie> comingMovieList(int page) { 
		
		//예고작 가져오기
		ArrayList<Movie> comingMovieList = service.comingMovieList(page);
		
		return comingMovieList;
	}
	
	@ResponseBody //(비동기)상영 예정 영화에서 검색필터링된 목록 가져오기
	@GetMapping(value = "searchOfComing.mv", produces = "application/json;charset = utf-8")
	public ArrayList<Movie> searchOfComingMovie(int page
											   ,String condition
											   ,String keyword
											   ) {
		HashMap<String,String> searchMap = new HashMap<>();
		
		searchMap.put("condition", condition);
		searchMap.put("keyword", keyword);
		
		return service.searchOfComingMovie(page,searchMap); 
	}
	
	
	
	
	/*====================영화 상세 조회 메서드=====================*/
	
	
	
	
	@GetMapping("detail.mv")
	public String movieDetail(int mvId
							 ,Model model) { //매개변수 mvId = movieId(영화 아이디)
		
		Movie movie = service.movieDetail(mvId);
		model.addAttribute("movie",movie);
		
		return "movie/movieDetail";
	}
	
	@ResponseBody
	@GetMapping(value = "reviews.mv", produces = "application/json;charset=utf-8")
	public ArrayList<Review> getReviews(int mvId){
		
		ArrayList<Review> reviews = service.getReviews(mvId);
		
		return reviews;
	}
	
	@ResponseBody
	@GetMapping(value = "stillCuts.mv", produces = "application/json;charset=utf-8")
	public ArrayList<StillCut> getStillCuts(int mvId){
		
		ArrayList<StillCut> stillCuts = service.getStillCuts(mvId);
		
		return stillCuts;
	}
	/*====================영화 리뷰 등록 메서드=====================*/
	
	@ResponseBody
	@PostMapping("registerReview.mv")
	public int registerReview(Review review
							 ,int[] selectedCriterionId) {
		
		
		System.out.println("review : " + review); //rating 확인
		
		int reviewId = service.getReviewId();
		if(reviewId > 0) { //reviewId값 db에서 제대로 가져옴
			review.setReviewId(reviewId);
			try {
				
				int result = service.registerReview(review,selectedCriterionId);
				//모두 잘 등록됐으면 아래 문장 실행됨
				return result;
				
			}catch(RuntimeException e){
				
				System.out.println(e.getMessage());
				return 0;
			}
		}else {//reviewId값 db에서 가져오기 실패
			return reviewId; 
		}
	}
	
//	김석현 수정 영화 관리 페이지
	@GetMapping("adjustment")//(동기)전체 영화 목록 페이지 위임 요청
	public String adjustMovieView() {
		
		
		return "movie/movieModulation";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
