package com.kh.teammovie.movie.model.vo;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Actor {
	
//	ACTOR_ID	NUMBER
	private int actorId;
//	ACTOR_NAME	VARCHAR2(15 BYTE)
	private String actorName;
//	BIRTH_DATE	DATE
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	private Date birthDate;
//	IMAGE_PATH	VARCHAR2(100 BYTE)
	private String imagePath;

}
