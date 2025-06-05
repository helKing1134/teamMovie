package com.kh.teammovie.movie.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Criteria {
	private int criteriaId;//	CRITERIA_ID	NUMBER
	private String criteria;//	CRITERIA	VARCHAR2(30 BYTE)
}
