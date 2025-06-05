package com.kh.teammovie.screen.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Screen {
	
//	SCREEN_ID	NUMBER
	private int screenId;
//	THEATER_ID	NUMBER
	private int theaterId;
//	SCREEN_NAME	VARCHAR2(100 BYTE)
	private String screenName;
//	SCREEN_ROWS	NUMBER
	private int screenRows;
//	SEATS_PER_ROW	NUMBER
	private int seatsPerRow;

}
