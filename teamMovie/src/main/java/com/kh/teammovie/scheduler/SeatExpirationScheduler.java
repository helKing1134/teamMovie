package com.kh.teammovie.scheduler;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class SeatExpirationScheduler {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Scheduled(fixedRate = 1000 * 60 * 1)
	public void runCheck() {
		
		int deleted = sqlSession.delete("reservedSeatMapper.deleteTempSeats");
        System.out.println("만료된 임시 좌석 삭제됨: " + deleted + "건");
	}

}
