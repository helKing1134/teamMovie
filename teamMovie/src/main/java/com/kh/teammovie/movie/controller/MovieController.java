package com.kh.teammovie.movie.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.teammovie.movie.model.vo.Movie;
import com.kh.teammovie.schedule.model.vo.Schedule;
import com.kh.teammovie.screen.model.dto.ScheduleWithTitle;

@Controller
public class MovieController {
	
	@RequestMapping("movie/select")
	public String forwardMovieSelect(Model model) {
		
		Movie m1 = new Movie(1, "영화1", "영화1에대한 설명", "P");
		Movie m2 = new Movie(2, "영화2", "영화2에대한 설명", "P");
		Movie m3 = new Movie(3, "영화3", "영화3에대한 설명", "P");
		Movie m4 = new Movie(4, "영화4", "영화4에대한 설명", "P");
		
		
		ArrayList<Movie> mlist = new ArrayList<>();
		
		mlist.add(m1);
		mlist.add(m2);
		mlist.add(m3);
		mlist.add(m4);
		
		model.addAttribute("mlist",mlist);
		
		Schedule s1 = new Schedule(1, 1, "11:00", "자막");
		Schedule s2 = new Schedule(2, 2, "12:00", "자막");
		Schedule s3 = new Schedule(3, 1, "1:00", "더빙");
		Schedule s4 = new Schedule(4, 2, "2:00", "더빙");
		
		ArrayList<Schedule> slist = new ArrayList<>();

		slist.add(s1);
		slist.add(s2);
		slist.add(s3);
		slist.add(s4);
		
		model.addAttribute("slist",slist);
		return "movie/movieSelectPage";
		
	}
	
	@GetMapping("movie/schedule")
	@ResponseBody
	public List<ScheduleWithTitle> getSchedules(int movieId){
		
		System.out.println("들어왔나?"); 
//		원래 이렇게 해야 함 지금은 db 접근 안할거라 
//		List<Schedule> schedules = scheduleService.getByMovieId(movieId);
		
		List<Schedule> schedules = new ArrayList<>();
		
		Schedule s1 = new Schedule(1, 1, "11:00", "자막");
		Schedule s2 = new Schedule(2, 2, "12:00", "자막");
		Schedule s3 = new Schedule(3, 1, "1:00", "더빙");
		Schedule s4 = new Schedule(4, 2, "2:00", "더빙");
		
		schedules.add(s1);
		schedules.add(s2);
		schedules.add(s3);
		schedules.add(s4);
		
		Movie m1 = new Movie(1, "영화1", "영화1에대한 설명", "P");
		Movie m2 = new Movie(2, "영화2", "영화2에대한 설명", "P");
		Movie m3 = new Movie(3, "영화3", "영화3에대한 설명", "P");
		Movie m4 = new Movie(4, "영화4", "영화4에대한 설명", "P");
		
		
		ArrayList<Movie> mlist = new ArrayList<>();
		
		mlist.add(m1);
		mlist.add(m2);
		mlist.add(m3);
		mlist.add(m4);
		
	    // movieId에 해당하는 영화 제목 찾기
	    String movieTitle = "";
	    for (Movie m : mlist) {
	        if (m.getMovieId() == movieId) {
	            movieTitle = m.getMovieTitle();
	            break;
	        }
	    }

	    // 해당 movieId의 상영정보만 필터링하여 결과 생성
	    List<ScheduleWithTitle> result = new ArrayList<>();
	    for (Schedule s : schedules) {
	        if (s.getMovieId() == movieId) {
	            ScheduleWithTitle swt = new ScheduleWithTitle();
	            swt.setScheduleId(s.getScheduleId());
	            swt.setStartTime(s.getStartTime());
	            swt.setLanguage(s.getLanguage());
	            swt.setMovieTitle(movieTitle);
	            result.add(swt);
	        }
	    }
		
//		원래 이렇게 해야함2
//		String movieTitle = movieService.getMovieById(movieId).getMovieTitle();
		
		return result;
		
	}
	
	@PostMapping("movie/reserveSeat")
	public String forwardSeatSelect() {
		
		
		return "movie/seatSelectPage";
		
	}
	
	

}
