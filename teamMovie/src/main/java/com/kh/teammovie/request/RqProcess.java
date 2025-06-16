package com.kh.teammovie.request;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class RqProcess {
//    <input type="hidden" name="movieId" id="movieId">
	private int movieId;
//    <input type="hidden" name="userId" id="userId" value="1">
	private int userId;
//    <input type="hidden" name="scheduleId" id="scheduleId">
	private int scheduleId;
//    <input type="hidden" name="screenId" id="screenId">
	private int screenId;
//    <input type="hidden" name="count" id="count">
	private int count;
//    <input type="hidden" name="totalPrice" id="totalPrice">
	private int totalPrice;
//    <input type="hidden" name="paySelect" id="paySelect">
	private String payMethod;

	private List<Integer> seatIds;
}
