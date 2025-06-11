package com.kh.teammovie.seat.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class ReservedSeat {
	
//	RESERVED_SEAT_ID	NUMBER
	private int reservedSeatId;
//	SEAT_ID	NUMBER
	private int seatId;
//	STATUS	VARCHAR2(20 BYTE)
	private String status;
//	CREATED_AT	DATE
	private Date createdAt;
//	SCHEDULE_ID	NUMBER
	private int scheduleId;

}
