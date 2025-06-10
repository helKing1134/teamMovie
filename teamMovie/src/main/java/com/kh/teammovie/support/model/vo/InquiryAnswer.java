package com.kh.teammovie.support.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class InquiryAnswer {
	
	private int answerId;
	private int inquiryId;
	private String answerContent;
	private Date answeredAt;

}

