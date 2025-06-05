package com.kh.teammovie.movie.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.teammovie.movie.model.vo.Movie;
import com.kh.teammovie.schedule.model.vo.Schedule;
import com.kh.teammovie.screen.model.vo.Screen;
import com.kh.teammovie.seat.model.vo.Seat;

@Repository
public class MovieDAO {

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
	
	

}
