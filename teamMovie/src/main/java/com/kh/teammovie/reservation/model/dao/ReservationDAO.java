package com.kh.teammovie.reservation.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.teammovie.movie.model.vo.Movie;
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

	public ArrayList<Movie> movieAll(SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		
		return  (ArrayList) sqlSession.selectList("movieMapper.movieAll");
	}

	

}
