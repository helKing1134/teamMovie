package com.kh.teammovie.movie.controller;

<<<<<<< HEAD
import java.util.ArrayList;
import java.util.HashMap;
=======
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.teammovie.movie.model.service.MovieService;
import com.kh.teammovie.movie.model.vo.Movie;
import com.kh.teammovie.request.RqPayment;
import com.kh.teammovie.schedule.model.dto.SchWithTime;
import com.kh.teammovie.schedule.model.dto.ScheduleWithTitle;
import com.kh.teammovie.schedule.model.vo.Schedule;
import com.kh.teammovie.screen.model.vo.Screen;
import com.kh.teammovie.seat.model.vo.Seat;

@Controller
public class MovieController {
	
//	필드 선언
	@Autowired
	private MovieService mvService;
	
	@RequestMapping("movie/select")
	public String forwardMovieSelect(Model model) {
		
		//현재 개봉중인 영화만 리스트로 가져옴
		String status = "P";
		ArrayList<Movie> mlist = mvService.movieSelect(status);
		
		
		
		// 모델과 session 어느 쪽이 유용할까 
		model.addAttribute("mlist",mlist);
		

		
		return "movie/movieSelectPage";
		
	}
	
	@GetMapping("movie/schedule")
	@ResponseBody
	public List<ScheduleWithTitle> getSchedules(int movieId){
		
		
		ArrayList<Schedule> schedules = mvService.schSelect(movieId);
		
		String movieTitle = mvService.getMovieById(movieId).getMovieTitle();
		

	    // 해당 movieId의 상영정보만 필터링하여 결과 생성
	    List<ScheduleWithTitle> result = new ArrayList<>();
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	    
	    for (Schedule s : schedules) {
	        if (s.getMovieId() == movieId) {
	            ScheduleWithTitle swt = new ScheduleWithTitle();
	            
	            swt.setScheduleId(s.getScheduleId());
	            swt.setStartTime(sdf.format(s.getStartTime()));
	            swt.setLanguage(s.getLanguage());
	            swt.setMovieTitle(movieTitle);
	            swt.setScreenId(s.getScreenId());
	            
	            result.add(swt);
	        }
	    }
		

		
		return result;
		
	}
	
	@PostMapping("movie/reserveSeat")
	public String forwardSeatSelect(int  movieId, int  scheduleId, int  screenId, Model model) {
		
		System.out.println("무비 아이디 : "+movieId);
		System.out.println("상영정보 아이디 : "+scheduleId);
		System.out.println("상영관 아이디 : "+screenId);
		
		// 데이터 받아온 것 확인 
		// 보내줄 데이터 : 영화제목, 상영정보, 상영관, 좌석리스트
		
		//영화 
		Movie m = mvService.getMovieById(movieId);
		//상영정보
		Schedule sch = mvService.getSchById(scheduleId);
		SchWithTime swt = new SchWithTime();
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
		
        swt.setScheduleId(sch.getScheduleId());
        swt.setMovieId(sch.getMovieId());
        swt.setScreeningDate(sch.getScreeningDate());
        swt.setStartTime(sdf.format(sch.getStartTime()));
        swt.setLanguage(sch.getLanguage());
        swt.setScreenId(sch.getScreenId());
		
		//상영관
		Screen s = mvService.getScreenById(screenId);
		//좌석
		ArrayList<Seat> stList = mvService.getStListBySchId(screenId);
		
		//모델에 데이터 삽입
		model.addAttribute("m",m);
		model.addAttribute("sch",swt);
		model.addAttribute("s",s);
		model.addAttribute("stList",stList);
		
		return "movie/seatSelectPage";
		
	}
	@PostMapping("movie/payment")
	public String forwardMoviePayment(RqPayment rqp, Model model) {
		
		int movieId = rqp.getMovieId();
		int screenId = rqp.getScreenId();
		int scheduleId = rqp.getScheduleId();
		List<Integer> seatIds = rqp.getSeatIds();
		
		for (int integer : seatIds) {
			
			System.out.println("좌석들 : "+integer);
			
		}
		
		//객체들 불러오기 
		//영화 
		Movie m = mvService.getMovieById(movieId);
		//상영정보
		Schedule sch = mvService.getSchById(scheduleId);
		//상영관
		Screen s = mvService.getScreenById(screenId);
		
		
		return "movie/paymentConfirm";
		
	}
	
	
>>>>>>> refs/remotes/origin/main

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.teammovie.movie.model.service.MovieService;
import com.kh.teammovie.movie.model.vo.Movie;
import com.kh.teammovie.movie.model.vo.Review;


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
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
