package com.kh.teammovie.movie.model.vo;

import java.sql.Date;

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
	private Date birthDate;
//	IMAGE_PATH	VARCHAR2(100 BYTE)
	private String imagePath;

}
