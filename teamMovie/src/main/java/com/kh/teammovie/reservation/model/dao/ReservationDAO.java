package com.kh.teammovie.reservation.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.teammovie.movie.model.vo.Movie;
import com.kh.teammovie.refund.model.dto.ReqRefundDTO;
import com.kh.teammovie.schedule.model.vo.Schedule;
import com.kh.teammovie.screen.model.vo.Screen;
import com.kh.teammovie.seat.model.vo.ReservedSeat;
import com.kh.teammovie.seat.model.vo.Seat;

@Repository
public class ReservationDAO {
	
	public ArrayList<Movie> movieSelect(SqlSessionTemplate sqlSession, String status) {
		// TODO Auto-generated method stub
		
		ArrayList<Movie> mList = new ArrayList<>();
		
		mList = (ArrayList) sqlSession.selectList("movieMapper.movieSelect", status);
		
		return mList;
	}

	public ArrayList<Schedule> schSelect(SqlSessionTemplate sqlSession, int movieId) {

		return (ArrayList) sqlSession.selectList("movieMapper.schSelect", movieId);
	}

	public Movie getMovieById(SqlSessionTemplate sqlSession, int movieId) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("movieMapper.getMovieById", movieId);
	}

	public Schedule getSchById(SqlSessionTemplate sqlSession, int scheduleId) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("movieMapper.getSchById", scheduleId);
	}

	public Screen getScreenById(SqlSessionTemplate sqlSession, int screenId) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("screenMapper.getScreenById", screenId);
	}

	public ArrayList<Seat> getStListBySchId(SqlSessionTemplate sqlSession, int screenId) {
		// TODO Auto-generated method stub
		return (ArrayList) sqlSession.selectList("seatMapper.getStListBySchId", screenId);
	}

	public List<Seat> getStListByStId(SqlSessionTemplate sqlSession, List<Integer> seatIds) {
		// TODO Auto-generated method stub
		return (List) sqlSession.selectList("seatMapper.getStListByStId", seatIds);
	}

	public int insertRsInit(SqlSessionTemplate sqlSession, List<Integer> seatIds, int scheduleId, int memberId) {
		// TODO Auto-generated method stub
		
		System.out.println(seatIds);
		
		for(int seatId : seatIds) {
		    Map<String, Object> param = new HashMap<>();
		    param.put("seatId", seatId);
		    param.put("scheduleId", scheduleId);
		    param.put("memberId", memberId);
		    sqlSession.insert("seatMapper.insertSingleSeat", param);
		}

		
		return 1;
	}

	public int existsTempSeat(SqlSessionTemplate sqlSession, int scheduleId) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("seatMapper.existsTempSeat", scheduleId);
	}

	public int insertRefund(SqlSessionTemplate sqlSession, ReqRefundDTO dto) {
		// TODO Auto-generated method stub
		return sqlSession.insert("refundMapper.insertRefund", dto);
	}
	
	//예약좌석 즉시 삭제 메소드
	public int cancelReservSeat(SqlSessionTemplate sqlSession, int scheduleId, int memberId) {
		// TODO Auto-generated method stub
		Map<String,Object> param = new HashMap<>();
		
		param.put("scheduleId", scheduleId);
		param.put("memberId", memberId);
		
		return sqlSession.delete("reservedSeatMapper.deleteTempSeatsImmediately", param);		
	}

	public List<ReservedSeat> rsSelect(SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("reservedSeatMapper.rsSelect");
	}

	public List<ReservedSeat> getRSeatsBySchedule(SqlSessionTemplate sqlSession, int scheduleId) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("reservedSeatMapper.getRSeatsBySchedule", scheduleId);
	}

}
