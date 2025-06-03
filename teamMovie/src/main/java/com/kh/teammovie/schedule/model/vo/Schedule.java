package com.kh.teammovie.schedule.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Schedule {
	
//	SCHEDULE_ID	NUMBER
	private int scheduleId;
//	MOVIE_ID	NUMBER
	private int movieId;
//	SCREEN_ID	NUMBER
	private int screenId;
//	SCREENING_DATE	DATE
	private Date screeningDate;
//	START_TIME	DATE db내에서는 Date로 저장되지만 표시될땐 string으로 가져옴
	private String startTime;
//	LANGUAGE	VARCHAR2(9 BYTE)
	private String language;
	
	//더미 콜렉션 데이터 용 생성자 
	public Schedule(int scheduleId, int movieId, String startTime, String language) {
		super();
		this.scheduleId = scheduleId;
		this.movieId = movieId;
		this.startTime = startTime;
		this.language = language;
	}
	
	

}
