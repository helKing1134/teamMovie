package com.kh.teammovie.seat.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Seat {
//	SEAT_ID	NUMBER
	private int seatId;
//	SCREEN_ID	NUMBER
	private int screenId;
//	SEAT_ROWS	NUMBER
	private int seatRows;
//	SEAT_COLS	VARCHAR2(9 BYTE)
	private String seatCols;
	

}
