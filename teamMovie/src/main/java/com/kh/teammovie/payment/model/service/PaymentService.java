package com.kh.teammovie.payment.model.service;

import java.util.List;

import com.kh.teammovie.payment.model.vo.Payment;
import com.kh.teammovie.refund.model.vo.Refund;
import com.kh.teammovie.reservation.model.vo.Reservation;
import com.kh.teammovie.seat.model.vo.Seat;

public interface PaymentService {
	
	//결제 데이터 생성 메소드
	int insertPayment(Payment p);
	
	//예약 데이터 생성 메소드
	int insertReserv(int paymentId);
	
	//예약좌석 테이블의 결제 아이디를 컬럼을 채우는 메소드
	void updateRseatTable(List<Integer> seatIds, int paymentId);
	
	//결제 아이디로 결제 객체 가져오기
	Payment findById(int paymentId);
	
	//결제 아이디로 좌석 리스트 객체 가져오기
	List<Seat> getStListByPmId(int paymentId);
	
	//결제 아이디로 예매 객체 가져오기 
	Reservation getReservationByPmId(int paymentId);
	
	//환불 아이디로 환불 객체 가져오기
	Refund getRefundByRfId(int refundId);
	
	//멤버 넘버(식별자)로 환불 아이디 가져오기
	List<Refund> getRefundByMemberNo(String memberNo);

}
