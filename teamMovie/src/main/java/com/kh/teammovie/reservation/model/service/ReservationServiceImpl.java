package com.kh.teammovie.reservation.model.service;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.teammovie.movie.model.vo.Movie;
import com.kh.teammovie.refund.model.dto.ReqRefundDTO;
import com.kh.teammovie.reservation.model.dao.ReservationDAO;
import com.kh.teammovie.schedule.model.vo.Schedule;
import com.kh.teammovie.screen.model.vo.Screen;
import com.kh.teammovie.seat.model.vo.ReservedSeat;
import com.kh.teammovie.seat.model.vo.Seat;

@Service
public class ReservationServiceImpl implements ReservationService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private ReservationDAO rvDAO;

	@Override
	//현재 상영중인 영화목록 가져오기
	public ArrayList<Movie> movieSelect(String status) {

		return rvDAO.movieSelect(sqlSession, status);
	}

	@Override
	// 스케줄 목록 가져오기
	public ArrayList<Schedule> schSelect(int movieId) {
		// TODO Auto-generated method stub
		return rvDAO.schSelect(sqlSession, movieId);
	}

	@Override
	public List<Schedule> getSchByMvId(int movieId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
//	선택한 영화 데이터 가져오기 
	public Movie getMovieById(int movieId) {
		// TODO Auto-generated method stub
		return rvDAO.getMovieById(sqlSession, movieId);
	}

	@Override
	// 아이디로 상영정보 객체 가져오기 
	public Schedule getSchById(int scheduleId) {
		// TODO Auto-generated method stub
		return rvDAO.getSchById(sqlSession, scheduleId);
	}

	@Override
	//아이디로 상영관 객체 가져오기
	public Screen getScreenById(int screenId) {
		// TODO Auto-generated method stub
		return rvDAO.getScreenById(sqlSession, screenId);
	}

	@Override
	// 상영관 아이디를 가지고 좌석 목록 가져오기
	public ArrayList<Seat> getStListBySchId(int screenId) {
		// TODO Auto-generated method stub
		return rvDAO.getStListBySchId(sqlSession, screenId);
	}

	@Override
	// 좌석 아이디 목록을 가지고 좌석 목록 가져오기
	public List<Seat> getStListByStId(List<Integer> seatIds) {
		// TODO Auto-generated method stub
		return rvDAO.getStListByStId(sqlSession, seatIds);
	}

	@Override
	// 예약좌석 데이터 insert
	public int insertRsInit(List<Integer> seatIds, int scheduleId, int memberId) {
		// TODO Auto-generated method stub
		return rvDAO.insertRsInit(sqlSession, seatIds, scheduleId, memberId);
	}

	@Override
	//결제 검증 메소드 
	public boolean tempSeatExists(int scheduleId, int memberNo) {
		// TODO Auto-generated method stub
		int count = rvDAO.existsTempSeat(sqlSession, scheduleId, memberNo);
		return count > 0;
	}

	@Override
	//예약취소(환불 요청) 메소드 
	public boolean insertRefund(ReqRefundDTO dto) {
		// TODO Auto-generated method stub
		int count = rvDAO.insertRefund(sqlSession, dto);
		
		return count > 0;
	}

	@Override
	//예약좌석 즉시 삭제 메소드 
	public int cancelReservSeat(int scheduleId, int memberId) {
		// TODO Auto-generated method stub
		return rvDAO.cancelReservSeat(sqlSession, scheduleId, memberId );
	}

	@Override
	//예약좌석 리스트 가져오는 메소드 
	public List<ReservedSeat> rsSelect() {
		// TODO Auto-generated method stub
		return rvDAO.rsSelect(sqlSession);
	}

	@Override
	//같은 스케줄을 가진 예약좌석만을 가져오는 메소드 
	public List<ReservedSeat> getRSeatsBySchedule(int scheduleId) {
		// TODO Auto-generated method stub
		return rvDAO.getRSeatsBySchedule(sqlSession, scheduleId);
	}
	
	@Override
	public ArrayList<Movie> movieAll() {
		// TODO Auto-generated method stub
		return rvDAO.movieAll(sqlSession);
	}

	
	
}
