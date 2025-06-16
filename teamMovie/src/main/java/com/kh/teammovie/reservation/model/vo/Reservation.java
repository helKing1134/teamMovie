package com.kh.teammovie.reservation.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Reservation {
	
//	RESERVATION_ID	NUMBER
	private int reservationId;
//	PAYMENT_ID	NUMBER
	private int paymentId;
//	STATUS	VARCHAR2(20 BYTE)
	private String status;

}
