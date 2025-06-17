package com.kh.teammovie.admin.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.teammovie.admin.model.service.AdminService;
import com.kh.teammovie.refund.model.dto.ReqRefundWithName;

@Controller
public class AdminController {
	
	@Autowired
	private AdminService amService;
	
	@RequestMapping("admin/refund")
	//환불데이터를 가져와 관리자 환불 게시판에 전송하는 메소드
	public String forwardRefundPage(Model model) {
		
		//환불데이터 리스트에 저장
		List<ReqRefundWithName> rfList = amService.getAllRefundWithUser();
		
		model.addAttribute("rfList", rfList);
		
		
		
		
		return "support/refund";
	}
	
	@RequestMapping("admin/refund/approve")
	@ResponseBody // 
	public Map<String,Object> approveRefund(@RequestParam("refundId") int refundId){
	    Map<String, Object> result = new HashMap<>();
	    	
	    try {
	    	// 환불 승인
	    	amService.approveRefund(refundId);
	    	
	    	//환불 아이디로 결제 아이디 가져오기
	    	int paymentId = amService.getPayIdByRfId(refundId);
	    	
	        //예약 취소
	    	amService.cancelReservation(paymentId);
	    	
	    	result.put("success", true);
	    	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	        result.put("approveTime", LocalDateTime.now().format(formatter).toString());
			
		} catch (Exception e) {
			// TODO: handle exception
			
			e.printStackTrace();
			result.put("success", false);

		}
	    
	    return result;
	}
	
	
	@RequestMapping("admin/refund/reject")
	@ResponseBody
	public Map<String, Object> rejectRefund(@RequestParam("refundId") int refundId, @RequestParam("rejectReason")String rejectReason){
		
		 Map<String, Object> result = new HashMap<>();
		 
		 System.out.println("환불사유 : "+rejectReason);
		 
		 int updateResult = amService.rejectRefund(refundId, rejectReason); // 상태를 'REJECT'로 업데이트

		    if (updateResult > 0) {
		        result.put("success", true);
		    } else {
		        result.put("success", false);
		    }
		 
		 
		 return result;
	}
	
	@PostMapping("admin/convert")
	@ResponseBody
	public String convertStatus( @RequestBody List<Integer> movieIds) {
		
		System.out.println("받은 영화 ID 리스트: " + movieIds);
		
		for (int movieId : movieIds) {
			
			int result = amService.updateMvStatus(movieId);
			
		}
		
		return  "";
	}

	
	

}
