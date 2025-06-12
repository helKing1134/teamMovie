package com.kh.teammovie.movie.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Actor {
	private String actorId;//	ACTOR_ID	NUMBER
	private String actorName;//	ACTOR_NAME	VARCHAR2(15 BYTE)
	private Date birthDate;//	BIRTH_DATE	DATE
	private String imagePath;//	IMAGE_PATH	VARCHAR2(100 BYTE)
}
