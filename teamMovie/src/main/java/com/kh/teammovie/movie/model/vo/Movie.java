package com.kh.teammovie.movie.model.vo;


import java.sql.Date;
import java.util.ArrayList;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;



@NoArgsConstructor
@AllArgsConstructor
@Data
public class Movie {
	//영화 테이블
	private int movieId;//	MOVIE_ID	NUMBER
	private int typeId;//	TYPE_ID	NUMBER
	private String movieTitle;//	MOVIE_TITLE	VARCHAR2(100 BYTE)
	private String description;//	DESCRIPTION	VARCHAR2(500 BYTE)
	private String director;//	DIRECTOR	VARCHAR2(15 BYTE)
	private String duration;//	DURATION	VARCHAR2(100 BYTE)
	private String rating;//	RATING	VARCHAR2(20 BYTE)
	private Date releaseDate;//	RELEASE_DATE	DATE
	
	private Date endDate; // (6.10) endDate 필드 추가 (by 이수한)
	
	private String status;//	STATUS	VARCHAR2(9 BYTE)
	private String posterPath;//	POSTER_PATH	VARCHAR2(100 BYTE)
	private String gifPath; //GIF_PATH	VARCHAR2(100 BYTE)
	//영화 관련 다른 테이블
	private ArrayList<Genre> genres; //영화 1개당 갖고 있는 장르들
	private ArrayList<Actor> actors; //영화 1개당 갖고 있는 배우들
	private ArrayList<StillCut> stillCuts; //영화 1개당 갖고 있는 스틸컷들
	private ArrayList<Review> reviews; //영화 1개당 갖고 있는 리뷰들
	

		
	public Movie(int movieId, String movieTitle, String description, String status) {
		super();
		this.movieId = movieId;
		this.movieTitle = movieTitle;
		this.description = description;
		this.status = status;
	}
	
	
	public Movie(int movieId, int typeId, String movieTitle, String description, String director, String duration,
			String rating, Date releaseDate, String status) {
		super();
		this.movieId = movieId;
		this.typeId = typeId;
		this.movieTitle = movieTitle;
		this.description = description;
		this.director = director;
		this.duration = duration;
		this.rating = rating;
		this.releaseDate = releaseDate;
		this.status = status;
	}


	
	
	
}
