package com.kh.teammovie.schedule.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class ScheduleWithTitle {
	
    private int scheduleId;
    private int movieId;
    private String movieTitle; // 추가
    private int screenId;
    private Date screeningDate;
    private String startTime;
    private String language;

}
