package com.kh.teammovie.movie.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class StillCut {
	
//	STILLCUT_ID	NUMBER
	private int stillcutId;
//	MOVIE_ID	NUMBER
	private int movieId;
//	FILE_LEVEL	NUMBER
	private int fileLevel;
//	STILLCUT_FILE	VARCHAR2(100 BYTE)
	private String stilcutFile;
	
	public void setStillCutFile(String stillCutPath) {
		// TODO Auto-generated method stub
		
	}

}
