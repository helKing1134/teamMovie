<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<title>결제 완료 페이지</title>
<style>
    ul>li{
     list-style:none;
 	}
 	
	.ticket {
	  background-color: #f9fbfd;
	  border-radius: 12px;
	  padding: 20px;
	  max-width: 400px;
	  margin: 40px auto;
	  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
	  font-family: 'Pretendard', sans-serif;
	}
	
	.ticket-title {
	  color: #5a4ed4;
	  font-size: 18px;
	  margin-bottom: 4px;
	}
	
	.ticket-number {
	  color: #888;
	  font-size: 14px;
	  margin-bottom: 16px;
	}
	
	.movie-title {
	  font-size: 20px;
	  font-weight: bold;
	}
	
	.movie-sub {
	  font-size: 14px;
	  color: #666;
	  margin-bottom: 20px;
	}
	
	.ticket-section {
	  display: flex;
	  justify-content: space-between;
	  margin-bottom: 20px;
	}
	
	.section .label {
	  font-size: 13px;
	  color: #888;
	}
	
	.section .info {
	  font-size: 15px;
	  line-height: 1.4;
	}
	
	.seat-info {
	  margin-bottom: 20px;
	}
	
	.seat-info .label {
	  font-size: 13px;
	  color: #888;
	}
	
	.seat-info .info {
	  font-size: 15px;
	  font-weight: bold;
	}
	
	.entry-button {
	  display: block;
	  width: 100%;
	  background-color: #5a4ed4;
	  color: white;
	  border: none;
	  border-radius: 8px;
	  padding: 12px;
	  font-size: 16px;
	  margin: 20px 0;
	  cursor: pointer;
	}
	
	.footer {
	  max-width: 400px;
	  margin: 0 auto; /* 가운데 정렬 */
	  display: flex;
	  justify-content: space-between;
	  gap: 10px;
	  padding: 0 20px 40px; /* 좌우 패딩 ticket과 동일하게 */
	}
	
	.footer-btn {
	  flex: 1;
	  padding: 12px;
	  font-size: 15px;
	  border: none;
	  border-radius: 8px;
	  cursor: pointer;
	  background-color: #e0e0e0;
	  color: #333;
	  font-weight: bold;
	}
	
	.footer-btn.cancel {
	  background-color: #ff6666;
	  color: white;
	}
	
	
	/* 모달 */
	.modal-overlay {
	  position: fixed;
	  top: 0;
	  left: 0;
	  width: 100%;
	  height: 100%;
	  background: rgba(0, 0, 0, 0.4);
	  display: flex;
	  justify-content: center;
	  align-items: center;
	  z-index: 9999;
	}
	
	.custom-modal {
	  background: #fff;
	  border-radius: 16px;
	  padding: 30px 20px;
	  width: 320px;
	  text-align: center;
	  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
	  font-family: 'Pretendard', sans-serif;
	  z-index: 1;		
	}
	
	.modal-header {
	  font-size: 24px;
	  font-weight: bold;
	  color: #e74c3c;
	  margin-bottom: 10px;
	}
	
	.modal-icon {
	  font-size: 40px;
	  margin-bottom: 12px;
	}
	
	.modal-text {
	  font-size: 14px;
	  color: #555;
	  margin-bottom: 24px;
	}
	
	.modal-buttons {
	  display: flex;
	  justify-content: space-around;
	  gap: 10px;
	}
	
	.modal-btn {
	  flex: 1;
	  padding: 10px;
	  border: none;
	  border-radius: 8px;
	  font-weight: bold;
	  cursor: pointer;
	  font-size: 14px;
	}
	
	.modal-btn.confirm {
	  background-color: #e74c3c;
	  color: white;
	}
	
	.modal-btn.cancel {
	  background-color: #ccc;
	  color: black;
	}
	
 	
</style>

</head>
<body>

	<%@ include file="/WEB-INF/views/common/header.jsp" %>
	
	<div class="reserve-confirm">
	
	</div>
	<hr>
	
<div class="ticket">
  <h3 class="ticket-title">예매 상세정보</h3>
  <div class="ticket-number">티켓번호 T80217-071-4886</div>
  
  <div class="movie-title">${m.movieTitle }</div>
  <div class="movie-sub">${sch.language } | ${m.rating }</div>
  
  <div class="ticket-section">
    <div class="section">
      <span class="label">상영일시</span>
      <div class="info">${sch.screeningDate }<br><strong>${sch.startTime } ~ ${ endStr} </strong></div>
    </div>
    <div class="section">
      <span class="label">상영관</span>
      <div class="info"><br><strong>${s.screenName }</strong></div>
    </div>
  </div>

  <div class="seat-info">
    <span class="label">좌석정보</span>
    <div class="info">성인 ${count } 명  <br>
    <c:forEach var="seat" items="${stList}" varStatus="status">
    <span class="seats-info">
    	${seat.seatCols }열 ${seat.seatRows }번 
    	<c:if test="${!status.last}"> / </c:if>
    </span>
    </c:forEach>
    
    </div>
  </div>
 </div>
<div class="footer">
  <button class="footer-btn home">홈으로 이동</button>
  <button class="footer-btn confirm" data-id="(예약아이디)">예약 취소</button>
</div>


<!-- 모달 배경 -->
<div class="modal-overlay" id="modal" style="display: none;">
  <div class="custom-modal">
    <h2 class="modal-header">경고!</h2>
    <div class="modal-icon">⚠️</div>
    <p class="modal-text">한 번 진행하면 되돌릴 수 없습니다</p>
    <div class="modal-buttons">
      <button class="modal-btn confirm">예</button>
      <button class="modal-btn cancel" onclick="closeModal()">아니요</button>
    </div>
  </div>
</div>
  
	
	
	


<!-- form 영역 -->
<form id="refundForm" action="/refund.me" method="post" style="display: none;">
  <input type="hidden" name="refundId" value="123"> <!-- 실제 예약 ID -->
</form>


    
    
    <br><br><br><br>



	
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	
	
<script type="text/javascript">
	// 모달창 이벤트
	document.querySelector('.footer-btn.confirm').addEventListener('click', function () {
	    document.getElementById('modal').style.display = 'flex';
	  });
	  
	// "아니요" 버튼 클릭 시 모달 닫기
	function closeModal() {
	  document.getElementById('modal').style.display = 'none';
	}
	
	/* 예약 취소 메소드  */
    $('.modal-btn.confirm').on('click', function() {
    	const reservationId = $(this).data('id'); // 버튼에 있는 예약 ID
    	
    	$.ajax({
    		url : '<%= request.getContextPath() %>/reservation/delete',
    		method : 'POST',
    		contentType: 'application/json',
    		data : JSON.stringify({
    	        paymentId: '${p.paymentId}',
    	        userId : '${mem.memberNo}',
    	        reservationId : '${r.reservationId}'

    		}),
    		success : function(response){
    			if(response.result){
    	            const refundId = response.refundId;
    	            alert('환불 요청 성공');
    	            // 환불현황 페이지로 이동
    	            location.href = '<%= request.getContextPath() %>/refund.me?refundId=' + refundId;
    	        } else {
    	            alert('환불 요청 실패');
    	        }
    		},
    		error : function(){
    			console.log('예약 취소중 오류가 발생했습니다.')
    		}
    	});
      
    });
	
	/* 홈으로 이동  */
	$('.footer-btn.home').on('click', function(){
		 location.href = '/teammovie/';
	})
	
	$(function(){
		console.log(${stList});
	});
	
</script>	
	
</body>
</html>