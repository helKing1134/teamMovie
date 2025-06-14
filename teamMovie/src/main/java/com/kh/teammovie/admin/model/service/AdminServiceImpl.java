package com.kh.teammovie.admin.model.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.teammovie.admin.model.dao.AdminDAO;
import com.kh.teammovie.refund.model.dto.ReqRefundWithName;
import com.kh.teammovie.refund.model.vo.Refund;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private AdminDAO amDAO;

	@Override
	//환불 데이터를 모두 조회하는 메소드
	public List<Refund> getAllRefund() {
		// TODO Auto-generated method stub
		return amDAO.getAllRefund(sqlSession);
	}

	@Override
	// 환불 데이터 + 유저명을 모두 조회하는 메소드
	public List<ReqRefundWithName> getAllRefundWithUser() {
		// TODO Auto-generated method stub
		return amDAO.getAllRefundWithUser(sqlSession);
	}

	@Override
	//환불 승인
	public void approveRefund(int refundId) {
		// TODO Auto-generated method stub
		amDAO.approveRefund(sqlSession, refundId);
		
	}

	@Override
	//환불 아이디로 결제 아이디 가져오기 
	public int getPayIdByRfId(int refundId) {
		// TODO Auto-generated method stub
		
		return amDAO.getPayIdByRfId(sqlSession, refundId);
	}

	@Override
//	예약 취소
	public void cancelReservation(int paymentId) {
		// TODO Auto-generated method stub
		amDAO.cancelReservation(sqlSession, paymentId);
	}

	@Override
	//환불 데이터 업데이트(반려)
	public int rejectRefund(int refundId, String reason) {
		// TODO Auto-generated method stub
		return amDAO.rejectRefund(sqlSession, refundId, reason);
	}

	@Override
	//예고작 -> 개봉작 상태 변경 
	public int updateMvStatus(int movieId) {
		// TODO Auto-generated method stub
		return amDAO.updateMvStatus(sqlSession, movieId);
	}
	

}
