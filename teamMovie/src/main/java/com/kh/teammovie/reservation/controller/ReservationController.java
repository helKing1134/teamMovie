package com.kh.teammovie.reservation.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.teammovie.movie.model.vo.Movie;
import com.kh.teammovie.reservation.model.service.ReservationService;
import com.kh.teammovie.schedule.model.dto.SchWithTime;
import com.kh.teammovie.schedule.model.dto.ScheduleWithTitle;
import com.kh.teammovie.schedule.model.vo.Schedule;
import com.kh.teammovie.screen.model.vo.Screen;
import com.kh.teammovie.seat.model.vo.ReservedSeat;
import com.kh.teammovie.seat.model.vo.Seat;

@Controller
public class ReservationController {
	
//	필드 선언
	@Autowired
	private ReservationService rvService;
	
	@RequestMapping("movie/select")
	public String forwardMovieSelect(Model model,
									@RequestParam(defaultValue = "0") int movieNo) {
		
		//현재 개봉중인 영화만 리스트로 가져옴
		String status = "P";
//		ArrayList<Movie> mlist = rvService.movieListAll(status);
		ArrayList<Movie> mlist = rvService.movieAll();
		
//		for (Movie m : mlist) {
//		    System.out.println("영화: " + m.getMovieTitle());
//		}
		
		
		model.addAttribute("mlist",mlist);
		model.addAttribute("selectedMovieId",movieNo);
		//model.addAttribute("targetMvId", movieId);
		

		
		return "movie/movieSelectPage";
		
	}
	
	//상영정보를 가져오는 ajax 호출 메소드
	@GetMapping("movie/schedule")
	@ResponseBody
	public List<ScheduleWithTitle> getSchedules(int movieId){
		
		
		ArrayList<Schedule> schedules = rvService.schSelect(movieId);
		
		String movieTitle = rvService.getMovieById(movieId).getMovieTitle();
		

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
	@RequestMapping("/reservation/start")
	public String startReservation(@RequestParam("movieId") int movieId, Model model) {

	    // 1. 영화 정보 조회
	    Movie selectedMovie = rvService.getMovieById(movieId);

	    // 예외 처리: 영화가 없을 경우
	    if (selectedMovie == null) {
	        model.addAttribute("errorMsg", "영화 정보를 불러올 수 없습니다.");
	        return "common/errorPage";  // 에러 페이지 또는 기본 페이지로
	    }
	    String status = "P";
	    ArrayList<Movie> mlist = rvService.movieSelect(status);

	    // 2. 지역/영화관 정보는 나중에 추가 가능
	    // 지금은 영화 제목만 넘겨주기
	    model.addAttribute("selectedMovie", selectedMovie);
	    model.addAttribute("mlist", mlist); 

	    // 3. selectLocation.jsp로 이동
	    return "reservation/selectLocation";
	}
	
	
}
