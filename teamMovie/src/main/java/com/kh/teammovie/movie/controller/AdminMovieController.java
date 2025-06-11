package com.kh.teammovie.movie.controller;

import java.io.File;

import java.io.IOException;
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
	
	
	//관리자 영화 등록용 메서드
	@PostMapping("registerMovie")
	public String registerMovie(Movie movie
							   ,String releaseDateStr
							   ,String endDateStr
							   ,String[] actorName
							   ,String[] genreName
							   ,MultipartFile posterFile
							   ,ArrayList<MultipartFile> stillCutFiles) {
		
		Movie insertMovie = setMovieStatus(movie, releaseDateStr, endDateStr);

	    return "redirect:/movies";
	}

	// 영화 STATUS 설정을 위한 메서드
	private Movie setMovieStatus(Movie movie, String releaseDateStr, String endDateStr) {
 
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
		return movie;
	}
	
	
	//아래 2개는 파일 서버 업로드 처리 메서드
	//1.파일 서버 업로드 시 저장될 이름 얻는 메서드
	public String getSavedPosterName(HttpSession session,Movie movie,MultipartFile file) {
		
		String movieTitle = movie.getMovieTitle();
		String originName = file.getOriginalFilename();
		String ext = originName.substring(originName.lastIndexOf('.'));
		
		//서버 내부 저장용 패스(사용자 접근 위험 높긴 하지만 임의로 설정해놨습니다) by 이수한
		String path = session.getServletContext().getRealPath("/resources/poster/");
		String saveName = movieTitle + "_포스터" + ext;
		String savePath = path + saveName;
		
		return savePath;
	}
	//2.파일 서버 업로드 처리 메서드
	public void savePoster(String savePath, MultipartFile file) {
		
		try {
			file.transferTo(new File(savePath));
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
