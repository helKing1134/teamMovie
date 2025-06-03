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
	private String status;//	STATUS	VARCHAR2(9 BYTE)
	private String posterPath;//	POSTER_PATH	VARCHAR2(100 BYTE)
	
	//영화 관련 다른 테이블
	private ArrayList<Genre> genreArr; //영화 1개당 갖고 있는 장르들
	private ArrayList<Actor> actorArr; //영화 1개당 갖고 있는 배우들
	//private ArrayList<StillCut> stillCut; //영화 1개당 갖고 있는 스틸컷들
	
	
	
	
}
