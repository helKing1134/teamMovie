package com.kh.teammovie.movie.model.vo;

import java.util.ArrayList;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Review {
	private int reviewId;//	REVIEW_ID	NUMBER
	private int memberNo;//	MEMBER_NO	NUMBER
	private int movieId;//	MOVIE_ID	NUMBER
	private String reviewContent;//	REVIEW_CONTENT	VARCHAR2(300 BYTE)
	private int reviewRating;//	REVIEW_RATING	NUMBER
	
	private ArrayList<Criteria> criterias; //평가 기준들
	
}
