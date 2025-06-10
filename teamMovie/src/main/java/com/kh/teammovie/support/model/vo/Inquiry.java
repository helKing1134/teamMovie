package com.kh.teammovie.support.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Inquiry {
	
	private int inquiryId; 
	private int inquiryWriter;
	private String title;
	private String content;
	private Date createdAt;
	private String status;
	private String category;
	


}
