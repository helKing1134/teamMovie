package com.kh.teammovie.payment.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Payment {
	
//	PAYMENT_ID	NUMBER
	private int paymentId;
//	MEMBER_NO	NUMBER
	private int memerNo;
//	SCHEDULE_ID	NUMBER
	private int scheduleId;
//	AMOUNT	NUMBER
	private int amount;
//	METHOD	VARCHAR2(50 BYTE)
	private String method;
//	PAYMENT_TIME	DATE
	private Date paymentTime;
	
	public Payment(int memerNo, int scheduleId, int amount, String method) {
		super();
		this.memerNo = memerNo;
		this.scheduleId = scheduleId;
		this.amount = amount;
		this.method = method;
	}
	
	
	

}


