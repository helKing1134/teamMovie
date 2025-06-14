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
	//PAYMENT_ID
	private int paymentId;
//	STATUS	VARCHAR2(20 BYTE)
	private String status;
//	CREATED_AT	DATE
	private Date createdAt;
//	SCHEDULE_ID	NUMBER
	private int scheduleId;
//	SEAT_SELECTOR	NUMBER
	private int seatSelector;
	
	
	public ReservedSeat(int reservedSeatId, int seatId, String status, Date createdAt, int scheduleId) {
		super();
		this.reservedSeatId = reservedSeatId;
		this.seatId = seatId;
		this.status = status;
		this.createdAt = createdAt;
		this.scheduleId = scheduleId;
	}
	
	

}
