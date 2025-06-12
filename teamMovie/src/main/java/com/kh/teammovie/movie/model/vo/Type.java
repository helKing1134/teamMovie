package com.kh.teammovie.movie.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Type {
	private int typeId;//	TYPE_ID	NUMBER
	private String movieType;//	MOVIE_TYPE	VARCHAR2(20 BYTE)
}
