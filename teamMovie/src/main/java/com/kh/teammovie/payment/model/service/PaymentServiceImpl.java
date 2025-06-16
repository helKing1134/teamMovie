package com.kh.teammovie.payment.model.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.teammovie.payment.model.dao.PaymentDao;
import com.kh.teammovie.payment.model.vo.Payment;
import com.kh.teammovie.refund.model.vo.Refund;
import com.kh.teammovie.reservation.model.vo.Reservation;
import com.kh.teammovie.seat.model.vo.Seat;

@Service
public class PaymentServiceImpl implements PaymentService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private PaymentDao pmDao;

	@Override
	public int insertPayment(Payment p) {
		// TODO Auto-generated method stub
		return pmDao.insertPayment(sqlSession, p);
	}

	@Override
	public int insertReserv(int paymentId) {
		// TODO Auto-generated method stub
		return pmDao.insertReserv(sqlSession, paymentId);
	}

	@Override
	//예약좌석 테이블의 결제 아이디를 컬럼을 채우는 메소드
	public void updateRseatTable(List<Integer> seatIds, int paymentId) {
		// TODO Auto-generated method stub
		pmDao.updateRseatTable(sqlSession, seatIds, paymentId);
		
	}

	@Override
	//결제 아이디로 결제 객체 가져오기
	public Payment findById(int paymentId) {
		// TODO Auto-generated method stub
		return pmDao.findById(sqlSession,paymentId);
	}

	@Override
	//결제 아이디로 좌석 객체 리스트 가져오기
	public List<Seat> getStListByPmId(int paymentId) {
		// TODO Auto-generated method stub
		return pmDao.getStListByPmId(sqlSession, paymentId);
	}

	@Override
	public Reservation getReservationByPmId(int paymentId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	//환불 아이디로 환불 객체 가져오기
	public Refund getRefundByRfId(int refundId) {
		// TODO Auto-generated method stub
		return pmDao.getRefundByRfId(sqlSession, refundId);
	}

	@Override
	//멤버 식별자로 환불 객체 가져오기 
	public List<Refund> getRefundByMemberNo(int memberNo) {
		// TODO Auto-generated method stub
		return pmDao.getRefundByMemberNo(sqlSession, memberNo);
	}

}
