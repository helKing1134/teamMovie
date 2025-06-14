package com.kh.teammovie.movie.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Genre {
	
//	GENRE_ID	NUMBER
	private int genreId;
//	GENRE	VARCHAR2(30 BYTE)
	private String genre;

}
