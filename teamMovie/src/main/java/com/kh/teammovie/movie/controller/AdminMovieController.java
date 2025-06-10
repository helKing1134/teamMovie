package com.kh.teammovie.movie.controller;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.kh.teammovie.movie.model.service.MovieService;
import com.kh.teammovie.movie.model.vo.Movie;

@Controller
@RequestMapping("/admin")
public class AdminMovieController {
	
	@Autowired
	private MovieService service;
	
	
	@GetMapping("movieRegisterForm")
	public String movieRegisterForm() {
		
		return "movie/movieRegisterForm";
	}
	
	
	@PostMapping("registerMovie")
	public String registerMovie(Movie movie
							   ,String releaseDateStr
							   ,String endDateStr
							   ,String[] actorName
							   ,String[] genreName
							   ,MultipartFile posterFile
							   ,ArrayList<MultipartFile> stillCutFiles) {
		
		// 개봉날짜 < 시간 < 종영날짜 : 상영중인 영화 ("S")
		// 종영날짜 < 시간 : 상영종료 영화 ("E")
		// 시간 < 개봉날짜 : 개봉예정 영화 ("P")
		
		//input[type=date] --------> sql.Date 타입 releaseDate로 바인딩 X
		
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd"); // input[type=date] 형식
	    LocalDate releaseDate = LocalDate.parse(releaseDateStr, formatter);
	    LocalDate endDate = LocalDate.parse(endDateStr, formatter);
	    LocalDate now = LocalDate.now();
	    
	    // 상태 계산
	    String status;
	    if (now.isBefore(releaseDate)) {
	        status = "P"; // 개봉예정
	    } else if (now.isAfter(endDate)) {
	        status = "E"; // 상영종료
	    } else {
	        status = "S"; // 상영중
	    }

	    // 상태 및 날짜를 Movie 객체에 세팅
	    movie.setReleaseDate(Date.valueOf(releaseDate));
	    movie.setEndDate(Date.valueOf(endDate));
	    movie.setStatus(status);

	    System.out.println("movie : " + movie);
	    System.out.println("posterFile : " + posterFile);
	    System.out.println("stillCutFiles : " + stillCutFiles);
	    System.out.println("status : " + status);
	    
	    return "redirect:/movies";
	}
	
	//파일 서버 업로드 처리 메서드
	/*
	public String saveFile(HttpSession session,MultipartFile file) {
		
		String currentTime = DateTimeFormatter.ofPattern("yyyyMMdd").format(LocalDate.now());
		
		int ranNum = (int)(Math.random() * 90000) + 10000;
		
	}
	*/
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
