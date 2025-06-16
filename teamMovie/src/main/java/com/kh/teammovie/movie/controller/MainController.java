package com.kh.teammovie.movie.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.teammovie.movie.model.service.MovieService;
import com.kh.teammovie.movie.model.vo.Movie;

@Controller
public class MainController {

    @Autowired
    private MovieService movieService;

    @GetMapping("/")//메인 페이지 가기전에 동작할 컨트롤
    public String main(Model model) {
        System.out.println("main으로 어서오세요");

        List<Movie> top4 = movieService.selectTop4Movies();
        model.addAttribute("mlist", top4);
        System.out.println("top4 영화 목록: " + top4);

        return "main"; // /WEB-INF/views/main.jsp
    }
}
