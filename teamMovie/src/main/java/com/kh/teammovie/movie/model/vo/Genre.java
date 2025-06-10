package com.kh.teammovie.movie.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Genre {
	private int genreId;//	GENRE_ID	NUMBER
	private String genreName;//	GNERE	VARCHAR2(30 BYTE)
}
