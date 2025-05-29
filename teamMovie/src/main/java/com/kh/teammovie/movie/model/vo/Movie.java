package com.kh.teammovie.movie.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Movie {
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
}
