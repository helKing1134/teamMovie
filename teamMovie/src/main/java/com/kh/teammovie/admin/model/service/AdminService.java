package com.kh.teammovie.admin.model.service;

import java.util.List;

import com.kh.teammovie.refund.model.dto.ReqRefundWithName;
import com.kh.teammovie.refund.model.vo.Refund;

public interface AdminService {
	
	// 환불 데이터를 모두 조회하는 메소드
	List<Refund> getAllRefund();
	
	// 환불 데이터 + 유저명을 모두 조회하는 메소드
	List<ReqRefundWithName> getAllRefundWithUser();
	
	// 환불 데이트 업데이트(승인)
	void approveRefund(int refundId);
	
	//환불 아이디로 결제 아이디 가져오기
	int getPayIdByRfId(int refundId);
	
	//예약 취소
	void cancelReservation(int paymentId);
	
	//환불 데이터 업데이트(반려)
	int rejectRefund(int refundId, String reason);
	
	//영화 상태 변경 (예고작 -> 개봉작)
	int updateMvStatus(int movieId);
	

}
