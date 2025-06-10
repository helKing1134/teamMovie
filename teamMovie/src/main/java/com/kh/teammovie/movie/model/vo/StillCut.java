package com.kh.teammovie.movie.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class StillCut {
	private int stillCutId;//	STILLCUT_ID	NUMBER
	//private int movieId;//	MOVIE_ID	NUMBER
	private int fileLevel;//	FILE_LEVEL	NUMBER
	private String stillCutFile;//	STILLCUT_FILE	VARCHAR2(100 BYTE)
}
