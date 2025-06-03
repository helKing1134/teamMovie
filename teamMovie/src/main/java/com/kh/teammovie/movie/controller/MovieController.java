package com.kh.teammovie.movie.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.teammovie.movie.model.service.MovieService;
import com.kh.teammovie.movie.model.vo.Movie;


@Controller
@RequestMapping("/movies")
public class MovieController {
	
	
	@Autowired
	private MovieService service;
	
	@GetMapping("")//(동기)영화목록 페이지 위임 요청
	public String movieListView() {
		return "movie/movieList";
	}
	
	@ResponseBody
	@GetMapping(value = "list.mv", produces = "application/json; charset=utf-8")
	public ArrayList<Movie> movieList(int startRow
									 ,int endRow
									 ,String currentStatus
									 ,String condition
									 ,String keyword
									 ){
		
		System.out.println("condtion : " + condition + " keyword : " + keyword);
		System.out.println("currentStatus : " + currentStatus);
		System.out.println("startRow : " + startRow);
		System.out.println("endRow : " + endRow);
		HashMap<String,Object> map = new HashMap<>();
		map.put("startRow",startRow);
		map.put("endRow",endRow);
		map.put("currentStatus", currentStatus);
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		ArrayList<Movie> movieList = service.movieList(map);
		
		return movieList;
	}
	
	
	/*
	@ResponseBody
	@GetMapping(value =  "/all", produces = "application/json;charset=utf-8") //(비동기)전체영화목록 조회 맵핑 주소
	public ArrayList<Movie> movieAllList(int page) { //위임 시 영화 목록 담을 Model 객체
		
		
		ArrayList<Movie> movieAllList = service.movieAllList(page);
		
		return movieAllList;
	}
	
	@ResponseBody
	@GetMapping(value = "/now", produces = "application/json;charset=utf-8") //(비동기)상영중인 영화목록 조회 맵핑 주소
	public ArrayList<Movie> movieNowList(int page){
		
		ArrayList<Movie> movieNowList = service.movieNowList(page);
		
		return movieNowList;
	}
	
	@ResponseBody
	@GetMapping(value = "/soon", produces = "application/json;charset=utf-8") //(비동기)상영예정인 영화목록 조회 맵핑 주소
	public ArrayList<Movie> movieSoonList(int page){
		
		ArrayList<Movie> movieSoonList = service.movieSoonList(page);
		
		return movieSoonList;
	}
	
	@ResponseBody
	@GetMapping(value = "/allSearch", produces = "application/json;charset=utf-8") //(비동기)상영예정인 영화목록 조회 맵핑 주소
	public ArrayList<Movie> movieAllSearchList(int page,String condition,String keyword){
		
		HashMap<String,String> map = new HashMap<>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		ArrayList<Movie> movieAllSearchList = service.movieAllSearchList(page,map);
		System.out.println(page + condition + keyword);
		
		return movieAllSearchList;
	}
	
	@ResponseBody
	@GetMapping(value = "/nowSearch", produces = "application/json;charset=utf-8") //(비동기)상영예정인 영화목록 조회 맵핑 주소
	public ArrayList<Movie> movieNowSearchList(int page,String condition,String keyword){
		
		HashMap<String,String> map = new HashMap<>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		ArrayList<Movie> movieNowSearchList = service.movieNowSearchList(page,map);
		
		return movieNowSearchList;
	}
	
	@ResponseBody
	@GetMapping(value = "/soonSearch", produces = "application/json;charset=utf-8") //(비동기)상영예정인 영화목록 조회 맵핑 주소
	public ArrayList<Movie> movieSoonSearchList(int page,String condition,String keyword){
		
		HashMap<String,String> map = new HashMap<>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		ArrayList<Movie> movieSoonSearchList = service.movieSoonSearchList(page,map);
		
		return movieSoonSearchList;
	}
	*/
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
