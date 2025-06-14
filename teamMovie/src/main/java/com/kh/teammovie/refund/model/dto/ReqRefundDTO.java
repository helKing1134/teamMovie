package com.kh.teammovie.refund.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


//환불 요청 controller 메소드 parameter 용
@NoArgsConstructor
@AllArgsConstructor
@Data
public class ReqRefundDTO {
	
	private int refundId;
	
    private int paymentId;
    private int userId;
    private int reservationId;

}
