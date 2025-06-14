package com.kh.teammovie.movie.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;

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
		
		System.out.println("keyword : " + keyword);
		System.out.println(service.getActorList());
		
		if("".equals(keyword)) {
			return service.getActorList();
		}else {
			return service.findActors(keyword);
		}

		
	}
	
	//MOVIE,MOVIE_ACTOR,MOVIE_GENRE,STILLCUT에 등록
	@PostMapping("registerMovie")
	public String registerMovie(int[] actorIds
							 ,int[] genreIds
							 ,Movie movie
							 ,String releaseDateStr
							 ,String endDateStr
							 ,MultipartFile posterFile
							 ,ArrayList<MultipartFile> stillCutFiles
							 ,HttpSession session) {
		
		//0. 등록될 영화 movieId값 db에서 꺼내오기
		int movieId = service.getNextMovieId();
		//0-1. movieId값이 정상적으로 꺼내졌다면
		if(movieId > 0) {
			//0-2. movieId값을 세팅
			movie.setMovieId(movieId);
			
			//1. 영화 개봉일 세팅
			Date releaseDate = Date.valueOf(releaseDateStr);
			movie.setReleaseDate(releaseDate);
			
			//2. 영화 종영일 세팅
			Date endDate = Date.valueOf(endDateStr);
			movie.setEndDate(endDate);
			
			//3. 영화 Status값 세팅
			setMovieStatus(movie, releaseDateStr, endDateStr);
			
			//4. 영화 포스터 경로 세팅 *이후 db 저장 성공시 서버에 저장될 포스터 경로 posterPath변수에 담아놓기
			String posterPath = setAndGetPosterPathForSave(session, movie, posterFile);
			
			//5. 스틸컷 저장 경로 모~~~~~두 얻기
			ArrayList<StillCut> stillCuts = new ArrayList<>();
			int fileLevel = 1; //fileLevel 1부터 시작
			
			//*이후 db 저장 성공시 서버에 저장될 스틸컷 경로 담을 컬렉션
			ArrayList<String> stillCutPathList = new ArrayList<>();
			
			
			for(MultipartFile file : stillCutFiles) {
				
				String stillCutPath = getStillCutPathForSave(session, movie, file);
				StillCut stillCut = new StillCut();
				stillCut.setStillCutFile(stillCutPath);
				stillCut.setFileLevel(fileLevel++);
				stillCut.setMovieId(movieId);
				stillCuts.add(stillCut);
				stillCutPathList.add(stillCutPath);
			}
			
			try {
				//6. 영화,배우,장르,스틸컷 관련 데이터들 db로 넘기기
				service.registerMovie(movie, actorIds, genreIds, stillCuts);
				//밑에 코드 시행된다면 모두 정상적으로 등록 성공한것임
				
				//7 .이제 서버에 저장하기
				
				saveFile(posterPath, posterFile);
				
				for(int i = 0; i < stillCutFiles.size(); i++) {
					saveFile(stillCutPathList.get(i), stillCutFiles.get(i));
				}
				
				
				session.setAttribute("alertMsg", "영화 등록에 성공했습니다");
				return "redirect:/movies";
				
			}catch(RuntimeException e){
				session.setAttribute("alertMsg", "영화 등록에 실패했습니다(DB 접근 오류)");
				System.out.println(e.getMessage());
				return "redirect:/admin/movieRegisterForm";
			}
			
			
		}//movieId값 정상적으로 db에서 꺼내진 경우
		else {//movieId값 자체를 db에서 꺼내는데 실패한 경우
			session.setAttribute("alertMsg", "서버 오류로 영화 등록에 실패하였습니다(movieId값 조회 오류)");
			return "redirect:/admin/movieRegisterForm";
		}
	}
	
	@ResponseBody
	@GetMapping("registerActor.mv")
	public int registerActor(Actor actor) {
		
		return service.registerActor(actor);
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
	public String setAndGetPosterPathForSave(HttpSession session,Movie movie,MultipartFile file) {
		
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
		return savePath;
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
