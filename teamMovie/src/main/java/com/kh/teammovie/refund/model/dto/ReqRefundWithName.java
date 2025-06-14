package com.kh.teammovie.refund.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author user1
 * 관리자 환불요청 목록 jsp 에 데이터를 전송할 DTO
 */
@NoArgsConstructor
@AllArgsConstructor
@Data
public class ReqRefundWithName {
	
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
//	REJECT_REASON	VARCHAR2(400 BYTE) added by 06.13
	private String rejectReason;
//	MEMBER_NAME
	private String memberName;

}
