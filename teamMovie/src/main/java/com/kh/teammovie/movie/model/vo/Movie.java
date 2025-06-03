package com.kh.teammovie.movie.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Movie {
	
//	MOVIE_ID
	private int movieId;
//	TYPE_ID
	private int typeId;
//	MOVIE_TITLE
	private String movieTitle;
//	DESCRIPTION
	private String description;
//	DIRECTOR
	private String director;
//	DURATION
	private String duration;
//	RATING
	private String rating;
//	RELEASE_DATE
	private Date releaseDate;
//	STATUS
	private String status;
//	POSTER_PATH
	private String posterPath;

	
public Movie(int movieId, String movieTitle, String description, String status) {
	super();
	this.movieId = movieId;
	this.movieTitle = movieTitle;
	this.description = description;
	this.status = status;
}
	
	
	
}
