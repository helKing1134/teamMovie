package com.kh.teammovie.payment.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.teammovie.member.model.vo.Member;
import com.kh.teammovie.payment.model.vo.Payment;
import com.kh.teammovie.refund.model.vo.Refund;
import com.kh.teammovie.seat.model.vo.Seat;

@Repository
public class PaymentDao {
	
	//결제 데이터 생성 메소드 
	public int insertPayment(SqlSessionTemplate sqlSession, Payment p) {
		// TODO Auto-generated method stub
		return sqlSession.insert("paymentMapper.insertPayment", p);
	}
	//예약 데이터 생성 메소드
	public int insertReserv(SqlSessionTemplate sqlSession, int paymentId) {
		// TODO Auto-generated method stub
		return sqlSession.insert("reservMapper.insertReserv", paymentId);
	}
	
	//예약좌석 테이블의 결제 아이디를 컬럼을 채우는 메소드
	public void updateRseatTable(SqlSessionTemplate sqlSession, List<Integer> seatIds, int paymentId) {
		// TODO Auto-generated method stub
		Map<String, Object> param = new HashMap<>();
		
		param.put("seatIds", seatIds);
		param.put("paymentId", paymentId);
		
		sqlSession.update("seatMapper.updateRseatTable", param);
		
		
		
		
	}
	//결제 아이디로 결제 객체 가져오기
	public Payment findById(SqlSessionTemplate sqlSession, int paymentId) {
		// TODO Auto-generated method stub
		
		System.out.println(paymentId);
		return sqlSession.selectOne("paymentMapper.findById", paymentId);
	}
	public List<Seat> getStListByPmId(SqlSessionTemplate sqlSession, int paymentId) {
		// TODO Auto-generated method stub
		
		List<Seat> stList = sqlSession.selectList("seatMapper.getStListByPmId", paymentId);
		return stList;
	}
	public Refund getRefundByRfId(SqlSessionTemplate sqlSession, int refundId) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("paymentMapper.getRefundByRfId", refundId);
	}
	
	public List<Refund> getRefundByMemberNo(SqlSessionTemplate sqlSession, String memberNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("paymentMapper.getRefundByMemberNo", memberNo);
	}
	public Member getMemByPmId(SqlSessionTemplate sqlSession, int paymentId) {
		// TODO Auto-generated method stub
		
		String payId = String.valueOf(paymentId);
		return sqlSession.selectOne("paymentMapper.getMemByPmId", payId);
	}

}
