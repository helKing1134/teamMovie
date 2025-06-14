package com.kh.teammovie.movie.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Type {
	
//	TYPE_ID	NUMBER
	private int typeId;
//	MOVIE_TYPE	VARCHAR2(20 BYTE)
	private String movieType;

}
