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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.teammovie.movie.model.service.MovieService;
import com.kh.teammovie.movie.model.vo.Actor;
import com.kh.teammovie.movie.model.vo.Genre;
import com.kh.teammovie.movie.model.vo.Movie;
import com.kh.teammovie.movie.model.vo.StillCut;
import com.kh.teammovie.movie.model.vo.Type;

@Controller
@RequestMapping("/admin")
public class AdminMovieController {
	
	@Autowired
	private MovieService service;
	
	
	@GetMapping("movieRegisterForm")
	public String movieRegisterForm(Model model) {
		
		ArrayList<Actor> currentActors = service.getActorList();
		ArrayList<Type> currentTypes = service.getTypeList();
		ArrayList<Genre> currentGenres = service.getGenreList();
		
		model.addAttribute("currentActors", currentActors);
		model.addAttribute("currentTypes", currentTypes);
		model.addAttribute("currentGenres", currentGenres);
		
		System.out.println("배우 리스트 : " + currentActors);
		System.out.println("타입 리스트 : " + currentTypes);
		System.out.println("장르 리스트 : " + currentGenres);
		
		return "movie/movieRegisterForm";
	}
	
	//관리자가 배우 이름 입력했을 때 "비동기"로 배우 리스트 가져오기
	@ResponseBody
	@GetMapping(value = "findActors.mv", produces = "application/json;charset=utf-8")
	public ArrayList<Actor> findActors(String keyword){
		
		System.out.println(keyword);
		return service.findActors(keyword);
	}
	
	
	
	//관리자 영화 등록용 메서드
	@PostMapping("registerMovie")
	public String registerMovie(Movie movie
							   ,String releaseDateStr
							   ,String endDateStr
							   ,String[] actorNames
							   ,String[] genreNames
							   ,MultipartFile posterFile
							   ,ArrayList<MultipartFile> stillCutFiles
							   ,HttpSession session) {
		
		setMovieStatus(movie, releaseDateStr, endDateStr); //개봉일,종영일,상태값 설정
		setPosterPathForSave(session, movie, posterFile); //포스터경로 설정
		
		ArrayList<StillCut> stillCuts = new ArrayList<StillCut>();
		int i = 1; //스틸컷 FILE_LEVEL을 위한 변수
		ArrayList<String> stillCutPaths = new ArrayList<String>(); //스틸컷 저장 경로 담을 변수
		
		for(MultipartFile file : stillCutFiles) {
			
			String stillCutPath = getStillCutPathForSave(session, movie, file);
			StillCut stillCut = new StillCut();
			stillCut.setFileLevel(i++);
			stillCut.setStillCutFile(stillCutPath);
			stillCuts.add(stillCut);
			stillCutPaths.add(stillCutPath);
		}
		
		int result = service.registerMovie(movie,actorNames,genreNames,stillCuts);
		
		if(result> 0) { //MOVIE,ACTOR,GENRE,MOVIE_ACTOR,MOVIE_GENRE 테이블 및 STILLCUT 테이블 DB 저장 성공시
			saveFile(movie.getPosterPath(), posterFile); //포스터 서버에 저장
			
			for(int j = 0; j < stillCutFiles.size(); j++) {
				saveFile(stillCutPaths.get(j), stillCutFiles.get(j)); //스틸컷 서버에 저장
			}
			session.setAttribute("alertMsg", movie.getMovieTitle() + " 영화가 정상적으로 등록되었습니다.");
			
		}else {
			session.setAttribute("alertMsg", "영화 등록에 실패하였습니다. 다시 시도해주세요");
			
		}

	    return "redirect:/movies";
	}

	// 영화 STATUS 설정을 위한 메서드
	private void setMovieStatus(Movie movie, String releaseDateStr, String endDateStr) {
 
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
	}
	
	
	//아래는 파일 서버 업로드 처리 메서드
	//1.파일 서버 업로드 시 저장될 이름 얻는 메서드 (포스터,스틸컷)
	public void setPosterPathForSave(HttpSession session,Movie movie,MultipartFile file) {
		
		String currentTime = new SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		int ranNum = (int)(Math.random() * 90000) + 10000;
		String movieTitle = movie.getMovieTitle();
		String originName = file.getOriginalFilename();
		String ext = originName.substring(originName.lastIndexOf('.'));
		
		//서버 내부 저장용 패스(사용자 접근 위험 높긴 하지만 임의로 설정해놨습니다) by 이수한
		String path = session.getServletContext().getRealPath("/resources/poster/");
		String saveName = movieTitle + "_포스터_" + currentTime + ranNum + ext;
		String savePath = path + saveName;
		
		
		movie.setPosterPath(savePath);
	}
	
	public String getStillCutPathForSave(HttpSession session,Movie movie,MultipartFile file) {
		
		String currentTime = new SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		int ranNum = (int)(Math.random() * 90000) + 10000;
		String movieTitle = movie.getMovieTitle();
		String originName = file.getOriginalFilename();
		String ext = originName.substring(originName.lastIndexOf('.'));
		
		//서버 내부 저장용 패스(사용자 접근 위험 높긴 하지만 임의로 설정해놨습니다) by 이수한
		String path = session.getServletContext().getRealPath("/resources/stillCuts/");
		String saveName = movieTitle + "_스틸컷_" + currentTime + ranNum + ext;
		String savePath = path + saveName;
		
		return savePath;
	}
	
	//2.파일 서버 업로드 처리 메서드 (포스터,스틸컷)
	public void saveFile(String savePath, MultipartFile file) {
		
		try {
			file.transferTo(new File(savePath));
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
