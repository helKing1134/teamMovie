package com.kh.teammovie.reservation.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.teammovie.movie.model.vo.Movie;
import com.kh.teammovie.refund.model.dto.ReqRefundDTO;
import com.kh.teammovie.request.RqPayment;
import com.kh.teammovie.reservation.model.service.ReservationService;
import com.kh.teammovie.schedule.model.dto.SchWithTime;
import com.kh.teammovie.schedule.model.dto.ScheduleWithTitle;
import com.kh.teammovie.schedule.model.vo.Schedule;
import com.kh.teammovie.screen.model.vo.Screen;
import com.kh.teammovie.seat.model.vo.ReservedSeat;
import com.kh.teammovie.seat.model.vo.Seat;

@Controller
public class ReservationController {
	
//	필드 선언
	@Autowired
	private ReservationService rvService;
	
	/*
	 * 
	 * 석현님 기존 forwardMovieSelect 메서드입니다
	 * 수정할 부분이 있어서 매개변수를 추가했는데
	 * 기존 메서드 필요하시면 다시 쓰시면 됩니다
	 * 
	@RequestMapping("movie/select")
	public String forwardMovieSelect(Model model) {
		
		//현재 개봉중인 영화만 리스트로 가져옴
		String status = "P";
		ArrayList<Movie> mlist = rvService.movieSelect(status);
		List<ReservedSeat> rsList = rvService.rsSelect();
		
		
		
		// 모델과 session 어느 쪽이 유용할까 
		model.addAttribute("mlist",mlist);
		model.addAttribute("rsList",rsList);
		

		
		return "movie/movieSelectPage";
		
	}
	*/
	
	@RequestMapping("movie/select")
	public String forwardMovieSelect(Model model,
									@RequestParam(defaultValue = "0") int movieNo) {
		
		//현재 개봉중인 영화만 리스트로 가져옴
		String status = "P";
//		ArrayList<Movie> mlist = rvService.movieListAll(status);
		ArrayList<Movie> mlist = rvService.movieAll();
		
//		for (Movie m : mlist) {
//		    System.out.println("영화: " + m.getMovieTitle());
//		}
		
		
		model.addAttribute("mlist",mlist);
		model.addAttribute("selectedMovieId",movieNo);
		//model.addAttribute("targetMvId", movieId);
		

		
		return "movie/movieSelectPage";
		
	}
	
	@GetMapping("movie/schedule")
	@ResponseBody
	public List<ScheduleWithTitle> getSchedules(int movieId){
		
		
		ArrayList<Schedule> schedules = rvService.schSelect(movieId);
		
		String movieTitle = rvService.getMovieById(movieId).getMovieTitle();
		

	    // 해당 movieId의 상영정보만 필터링하여 결과 생성
	    List<ScheduleWithTitle> result = new ArrayList<>();
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	    
	    for (Schedule s : schedules) {
	        if (s.getMovieId() == movieId) {
	            ScheduleWithTitle swt = new ScheduleWithTitle();
	            
	            swt.setScheduleId(s.getScheduleId());
	            swt.setStartTime(sdf.format(s.getStartTime()));
	            swt.setLanguage(s.getLanguage());
	            swt.setMovieTitle(movieTitle);
	            swt.setScreenId(s.getScreenId());
	            
	            result.add(swt);
	        }
	    }
		

		
		return result;
		
	}
	
	@PostMapping("movie/reserveSeat")
	public String forwardSeatSelect(int  movieId, 
									int  scheduleId, 
									int  screenId, 
									int memberId,
									Model model) {
		
		System.out.println("무비 아이디 : "+movieId);
		System.out.println("상영정보 아이디 : "+scheduleId);
		System.out.println("상영관 아이디 : "+screenId);
		System.out.println("멤버 아이디 : "+memberId);
		
		// 데이터 받아온 것 확인 
		// 보내줄 데이터 : 영화제목, 상영정보, 상영관, 좌석리스트
		
		//영화 
		Movie m = rvService.getMovieById(movieId);
		//상영정보
		Schedule sch = rvService.getSchById(scheduleId);
		SchWithTime swt = new SchWithTime();
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
		
        swt.setScheduleId(sch.getScheduleId());
        swt.setMovieId(sch.getMovieId());
        swt.setScreeningDate(sch.getScreeningDate());
        swt.setStartTime(sdf.format(sch.getStartTime()));
        swt.setLanguage(sch.getLanguage());
        swt.setScreenId(sch.getScreenId());
		
		//상영관
		Screen s = rvService.getScreenById(screenId);
		//좌석
		ArrayList<Seat> stList = rvService.getStListBySchId(screenId);
		
		//예약좌석
		List<ReservedSeat> rsList = rvService.getRSeatsBySchedule(scheduleId);
		
		//시작시간, 종료 시간
		Map<String,String> timeMap = timeCalculator(sch, m);
 		//모델에 데이터 삽입
		model.addAttribute("m",m);
		model.addAttribute("sch",swt);
		model.addAttribute("s",s);
		model.addAttribute("stList",stList);
		model.addAttribute("rsList",rsList);
		model.addAttribute("timeMap",timeMap);
		
		return "movie/seatSelectPage";
		
	}
	@PostMapping("movie/payment")
	public String forwardMoviePayment(RqPayment rqp, Model model) {
		
		int movieId = rqp.getMovieId();
		int screenId = rqp.getScreenId();
		int scheduleId = rqp.getScheduleId();
		List<Integer> seatIds = rqp.getSeatIds();
		int memberId = rqp.getMemberId();
		

		
		//객체들 불러오기 
		//영화 
		Movie m = rvService.getMovieById(movieId);
		//상영정보
		Schedule sch = rvService.getSchById(scheduleId);
		//상영관
		Screen s = rvService.getScreenById(screenId);
		
		//좌석 객체 리스트
		List<Seat> stList = rvService.getStListByStId(seatIds);
		
		System.out.println(stList);
		
		System.out.println("stList size: " + stList.size());
		for (Seat seat : stList) {
		    System.out.println(seat);
		}

		
		//좌석 객체 리스트의 좌석을 예약좌석에 등록
		int rsResult = 0;
		try {
		     rsResult = rvService.insertRsInit(seatIds, scheduleId, memberId);
		} catch (Exception e) {
		    System.out.println("이미 예약된 좌석이 있어 insert 생략");
		}
		
		
		if (rsResult > 0) {
			
			System.out.println("정상적으로 insert 완료");
			
		}
		
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
        
        //예약좌석별 티켓값 계산
        int count = stList.size();
        System.out.println(count);
        int pricePerPerson = 15000;
        int totalPrice = count * pricePerPerson;

        // stList json 객체 변환
        ObjectMapper mapper = new ObjectMapper();
        String seatJson = null;
		try {
			seatJson = mapper.writeValueAsString(stList);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.println(seatJson);
        


	
		//모델에 정보 전달 
		model.addAttribute("m",m);
		model.addAttribute("sch",swt);
		model.addAttribute("s",s);
		model.addAttribute("stList", seatJson);
		
		model.addAttribute("endStr", endStr);
		
		model.addAttribute("count", count); // 1, 2, ...
        model.addAttribute("unitPrice", pricePerPerson); // 15000
        model.addAttribute("totalPrice", totalPrice); // 15000 * count

		
		
		
		return "movie/paymentConfirm";
		
	}
	
	//예약취소(환불 요청) 메소드 
	@PostMapping("reservation/delete")
	@ResponseBody
	public Map<String, Object> requestRefund(@RequestBody ReqRefundDTO dto) {
	    Map<String, Object> resultMap = new HashMap<>();

	    boolean success = rvService.insertRefund(dto);

	    resultMap.put("result", success);
	    if (success) {
	        resultMap.put("refundId", dto.getRefundId()); 
	    }

	    return resultMap;
	}
	
	//결제 검증 로직 
	@PostMapping("reservation/checkTempSeat")
	@ResponseBody
	public String checkTempSeat( int scheduleId) {
		
		
	    boolean exists = rvService.tempSeatExists(scheduleId);
	    
	    return exists ? "valid" : "expired";
	}
	
	//이전 클릭시 발동되는 controller
	@PostMapping("reservation/cancel")
	public String cancelReservSeat(int  movieId, 
								int  scheduleId, 
								int  screenId, 
								int  memberId,
								Model model) {
		
		//예약좌석 삭제 로직
		int result = rvService.cancelReservSeat(scheduleId, memberId);
		
		//모델에 데이터 전달
		model.addAttribute("movieId", movieId);
		model.addAttribute("scheduleId", scheduleId);
		model.addAttribute("screenId", screenId);
		model.addAttribute("memberId", memberId);
		
		if (result > 0) {
			
			System.out.println("좌석 삭제됨 : "+result+"건");
		}
		
		
		return "forward:/movie/reserveSeat";
	}
	
	//종료시간 계산 메소드
	public Map<String, String> timeCalculator(Schedule sch, Movie m){
		
		Map<String, String> param = new HashMap<>();
		
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
		
		param.put("startStr", startStr);
		param.put("endStr", endStr);
		
		return param;
	}
}
