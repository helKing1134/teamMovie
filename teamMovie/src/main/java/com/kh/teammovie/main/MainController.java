package com.kh.teammovie.main;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.teammovie.movie.model.vo.Movie;

@Controller
public class MainController {
	
	@RequestMapping("/")
	public String showMainPage() {
		
		System.out.println("메인접근 완료");
		
	    return "main";
	}

}
