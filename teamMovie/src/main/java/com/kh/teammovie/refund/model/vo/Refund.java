package com.kh.teammovie.refund.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Refund {
	
//	REFUND_ID	NUMBER	No
	private int refundId;
//	PAYMENT_ID	NUMBER	No
	private int paymentId;
//	REQUEST_USER_ID	VARCHAR2(100 BYTE)	No
	private int requestUserId;
//	REQUEST_TIME	DATE	Yes
	private Date requestTime;
//	APPROVE_TIME	DATE	Yes
	private Date approveTime;
//	STATUS	VARCHAR2(20 BYTE)	Yes
	private String status;
//	REJECT_REASON	VARCHAR2(400 BYTE)
	private String rejectReason;

}
