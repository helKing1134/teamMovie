package com.kh.teammovie.movie.model.vo;

import java.util.ArrayList;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Type {
	private int typeId;//	TYPE_ID	NUMBER
	private String movieType;//	MOVIE_TYPE	VARCHAR2(20 BYTE)
	
	private ArrayList<Criterion> criteria; //영화타입 1개당 가지는 평가 기준들 
}
