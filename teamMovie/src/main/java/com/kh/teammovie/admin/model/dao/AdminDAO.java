package com.kh.teammovie.admin.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.teammovie.refund.model.dto.ReqRefundWithName;
import com.kh.teammovie.refund.model.vo.Refund;

@Repository
public class AdminDAO {

	public List<Refund> getAllRefund(SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("refundMapper.getAllRefund");
	}

	public List<ReqRefundWithName> getAllRefundWithUser(SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("refundMapper.getAllRefundWithUser");
	}

	public void approveRefund(SqlSessionTemplate sqlSession, int refundId) {
		// TODO Auto-generated method stub
		
		sqlSession.update("refundMapper.approveRefund", refundId);
		
	}

	public int getPayIdByRfId(SqlSessionTemplate sqlSession, int refundId) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("refundMapper.getPayIdByRfId", refundId);
	}

	public void cancelReservation(SqlSessionTemplate sqlSession, int paymentId) {
		// TODO Auto-generated method stub
		sqlSession.update("refundMapper.cancelReservation", paymentId);
	}

	public int rejectRefund(SqlSessionTemplate sqlSession, int refundId, String reason) {
		// TODO Auto-generated method stub
		
		Map<String,Object> updateMap = new HashMap<>();
		
		updateMap.put("refundId", refundId);
		updateMap.put("reason", reason);
		
		return sqlSession.update("refundMapper.rejectRefund", updateMap);
	}

	public int updateMvStatus(SqlSessionTemplate sqlSession, int movieId) {
		// TODO Auto-generated method stub
		return sqlSession.update("movieMapper.updateMvStatus", movieId);
	}

}
