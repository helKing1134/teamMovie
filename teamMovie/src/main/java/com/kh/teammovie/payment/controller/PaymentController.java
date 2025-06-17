package com.kh.teammovie.payment.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.kh.teammovie.movie.model.vo.Movie;
import com.kh.teammovie.payment.model.service.PaymentService;
import com.kh.teammovie.payment.model.vo.Payment;
import com.kh.teammovie.request.RqProcess;
import com.kh.teammovie.reservation.model.service.ReservationService;
import com.kh.teammovie.reservation.model.vo.Reservation;
import com.kh.teammovie.schedule.model.dto.SchWithTime;
import com.kh.teammovie.schedule.model.vo.Schedule;
import com.kh.teammovie.screen.model.vo.Screen;
import com.kh.teammovie.seat.model.vo.Seat;

@Controller
public class PaymentController {
	
	@Autowired
	private PaymentService pmService;
	
	@Autowired
	private ReservationService rvService;
	
	@PostMapping("movie/payment/process")
	public String payMentProcess(RqProcess rqps) {
		
		List<Integer> seatIds =rqps.getSeatIds();
		
//		결제 테이블 데이터 생성 
		Payment p = new Payment(rqps.getUserId()
							   ,rqps.getScheduleId()
							   ,rqps.getCount()
							   ,rqps.getPayMethod()
								);
		
		
		
		int insertResultP = pmService.insertPayment(p);
		
		int paymentId = p.getPaymentId();
		System.out.println(paymentId);
		
		if (insertResultP > 0) {
			
			//예약 테이블 데이터 생성
			int insertResultR = pmService.insertReserv(paymentId);
			
			System.out.println(insertResultR);
			
			//예약좌석 테이블 업데이트
			pmService.updateRseatTable(seatIds, paymentId);
			
			
			//get Controller 에 데이터 전달
			return "redirect:/movie/payment/success?paymentId="+paymentId;
			
		}
		
		return "payment/fail";
	}
	
	@GetMapping("/movie/payment/success")
	public String paymentSuccess(int paymentId, Model model) {
	    
		System.out.println("get으로 넘어가는지 확인");
		//결제 객체 
		Payment p = pmService.findById(paymentId);
		
		//상영정보 객체
		Schedule sch = rvService.getSchById(p.getScheduleId());
		
		
		
		//영화
		Movie m = rvService.getMovieById(sch.getMovieId());
	    
		//상영관 객체
		Screen s = rvService.getScreenById(sch.getScreenId());
		
		//예약
		Reservation r = pmService.getReservationByPmId(paymentId);
		
		//좌석 리스트
		List<Seat> stList = pmService.getStListByPmId(paymentId);
		
		//종료시간 계산 & DTO에 값 input
		Date startTime = sch.getStartTime(); // 12:40
		int duration = Integer.parseInt(m.getDuration()); // 129분

		Calendar cal = Calendar.getInstance();
		cal.setTime(startTime);
		cal.add(Calendar.MINUTE, duration);
		Date endTime = cal.getTime();

		// 시간 포맷
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
		String startStr = sdf.format(startTime);
		String endStr = sdf.format(endTime);
		
		SchWithTime swt = new SchWithTime();
		
        swt.setScheduleId(sch.getScheduleId());
        swt.setMovieId(sch.getMovieId());
        swt.setScreeningDate(sch.getScreeningDate());
        swt.setStartTime(startStr);
        swt.setLanguage(sch.getLanguage());
        swt.setScreenId(sch.getScreenId());
		
		//결제금액 계산
		int count = p.getAmount();
	    int totalPrice = count * 15000;
	    
	    // 모든 연결 데이터를 paymentId 하나로 열람
	    model.addAttribute("p", p);
	    model.addAttribute("sch", swt);
	    model.addAttribute("m", m);
	    model.addAttribute("r", r);
	    model.addAttribute("s", s);
	    model.addAttribute("stList", stList);
	    model.addAttribute("totalPrice", totalPrice);
	    model.addAttribute("count", count);
	    model.addAttribute("endStr", endStr);
	    
	    
	    return "payment/success";
	}
	
}
