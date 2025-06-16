package com.kh.teammovie.movie.model.dao;

import java.util.ArrayList;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.teammovie.movie.model.vo.Movie;
import com.kh.teammovie.schedule.model.vo.Schedule;
import com.kh.teammovie.screen.model.vo.Screen;
import com.kh.teammovie.seat.model.vo.Seat;
import com.kh.teammovie.movie.model.vo.Review;
import com.kh.teammovie.movie.model.vo.StillCut;
import org.apache.ibatis.session.RowBounds;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;

@Repository
public class MovieDAO {
	
	
	public ArrayList<Movie> movieListAll(SqlSessionTemplate sqlSession,int page) {
		
		int limit = 4;
		int offset = (page - 1) * limit;
		
		
		return (ArrayList)sqlSession.selectList("movieMapper.movieListAll",null,new RowBounds(offset, limit));
	}
	
	public ArrayList<Movie> searchOfAllMovie(SqlSessionTemplate sqlSession, int page, HashMap<String, String> searchMap) {
		
		int limit = 4;
		int offset = (page - 1) * limit;
		return (ArrayList)sqlSession.selectList("movieMapper.searchOfAllMovie",searchMap,new RowBounds(offset,limit));
	}

	public ArrayList<Movie> screeningMovieList(SqlSessionTemplate sqlSession, int page) {
		
		int limit = 4;
		int offset = (page - 1) * limit;
		return (ArrayList)sqlSession.selectList("movieMapper.screeningMovieList",null,new RowBounds(offset, limit));
	}

	public ArrayList<Movie> searchOfScreeningMovie(SqlSessionTemplate sqlSession,int page,HashMap<String, String> searchMap) {
		
		int limit = 4;
		int offset = (page - 1) * limit;
		return (ArrayList)sqlSession.selectList("movieMapper.searchOfScreeningMoive",searchMap,new RowBounds(offset,limit));
	}

	public ArrayList<Movie> comingMovieList(SqlSessionTemplate sqlSession, int page) {
		
		int limit = 4;
		int offset = (page -1) * limit;
		return (ArrayList)sqlSession.selectList("movieMapper.comingMovieList",null,new RowBounds(offset, limit));
	}

	public ArrayList<Movie> searchOfComingMovie(SqlSessionTemplate sqlSession,int page,HashMap<String, String> searchMap) {
		
		int limit = 4;
		int offset = (page -1) * limit;
		return (ArrayList)sqlSession.selectList("movieMapper.searchOfComingMovie", searchMap, new RowBounds(offset, limit));
	}

	public Movie movieDetail(SqlSessionTemplate sqlSession, int mvId) {
		
		return sqlSession.selectOne("movieMapper.movieDetail", mvId);
	}

	public ArrayList<Review> getReviews(SqlSessionTemplate sqlSession, int mvId) {
		return (ArrayList)sqlSession.selectList("movieMapper.getReviews", mvId);
	}

	public ArrayList<StillCut> getStillCuts(SqlSessionTemplate sqlSession, int mvId) {
		return (ArrayList)sqlSession.selectList("movieMapper.getStillCuts", mvId);
	}
		
		

		
		
		

	


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

	   public List<Movie> selectTop4Movies(SqlSessionTemplate sqlSession) {
	        return sqlSession.selectList("movieMapper.selectTop4Movies");
	    }
	
	

}
