<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>좌석 선택 페이지</title>
<style type="text/css">
	.screen-wraper {
	
	  position: relative;
	  margin-bottom: 20px;
	
	}
	
	.screen-label{
	  font-weight: bold;
	  text-align: center; 
	  position: absolute;
	  top: 45px;
	  font-size: 24px;
	  z-index: 2;
	  position: relative;
	
	}
	
	.screen-curve {
	  position: absolute;
	  top: 30px; /* SCREEN 텍스트 위로 */
	  left: 50%;
	  transform: translateX(-50%);
	  width: 500px;
	  height: 100px;
	  border-top: 4px solid rgba(128, 128, 128, 0.5); /* 반투명 회색 */
	  border-radius: 50%/100%;
	  z-index: 3;
	}
	

	
		.seat-area {
		  display: flex;
		  flex-direction: column;
		  align-items: center; /* 모든 seat-row를 중앙 정렬 */
		  gap: 10px;
		}
		
		.seat-row {
		  display: flex;
		  justify-content: center;
		  gap: 10px;
		  margin-bottom: 10px; /* 줄 간격 조절 */
		}
		
		.seat-container {
		  display: flex;
		  flex-direction: column;
		  align-items: center; /* 중앙 정렬 */
		  margin-top: 80px;
		}


		
	.seat {
	  width: 40px;
	  height: 40px;
	  background: linear-gradient(to bottom, #999 0%, #666 100%);
	  border: 2px solid #444;
	  border-radius: 8px 8px 4px 4px; /* 위는 둥글고 아래는 살짝 평평하게 */
	  box-shadow: inset 0 -2px 4px rgba(0,0,0,0.4), 0 2px 5px rgba(0,0,0,0.2);
	  cursor: pointer;
	  font-weight: bold;
	  color: white;
	  text-shadow: 0 1px 1px rgba(0,0,0,0.5);
	  display: flex;
	  align-items: center;
	  justify-content: center;
	  transition: 0.2s;
	}
	
	.seat:hover {
	  background: linear-gradient(to bottom, #aaa, #555);
	}
	
	/* 선택된 좌석 */
	.seat.selected {
	  background: linear-gradient(to bottom, #4CAF50, #388E3C);
	  border-color: #2E7D32;
	}
	
	/* 이미 예약된 좌석 */
	.seat.occupied {
	  background: linear-gradient(to bottom, #aaa, #777);
	  border-color: #555;
	  cursor: not-allowed;
	  color: #eee;
	}
		
	#mask-target {
	  width: 500px;
	  height: 686px;
	  position: relative;
	  margin: 0 auto;
	}
	
	.reserve-div{
		display: flex;
	}
 	.audience.selected{
       background-color: black;
       color: white;
	}
	.reserve-decision{
		position: absolute;
		right : 150px;
		color : green;
	}
	
	.confirm {
	  display: flex;
	  width: 100%;
	  max-width: 400px;
	  margin: 0 auto;
	}
	
	.confirm .next {
	  flex: 1;
	  padding: 16px 0;
	  font-size: 18px;
	  border: none;
	  cursor: pointer;
	  color: white;
	}
	
	#nextBtn {
	  border-top-left-radius: 8px;
	  border-bottom-left-radius: 8px;
	}
	
	#reset {
	  border-top-right-radius: 8px;
	  border-bottom-right-radius: 8px;
	  color : black;
	  border-left: 1px solid #333; /* 가짜 경계선 느낌 */
	}
	
	#nextBtn{
		background-color: #00c3cc;
		color : white;
	}
	
	#nextBtn:disabled{
		background-color : gray;
		color : white;
		cursor: not-allowed;
	}
	





</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="reserve-div">
    <div class="audience-selector">
		<h4>관람인원을 선택해주세요</h4>
        <div class="audience-selection">
	       	<button class="audience" id="adult1">1</button>
		    <button class="audience" id="adult2">2</button>
		    <button class="audience" id="adult3">3</button>
		    <button class="audience" id="adult4">4</button>

        </div>
	</div>
	 <div id="mask-target">
	  <div class="screen-wraper">
	    <div class="screen-curve"></div>
	    <div class="screen-label"><h4>SCREEN</h4></div>
	  </div>
	
<c:set var="currentRow" value="0" />

<div class="seat-container">
	<c:forEach var="seat" items="${stList}" varStatus="status">
	  <c:if test="${status.index % s.seatsPerRow == 0}">
	    <div class="seat-row">
	  </c:if>
	
	  <c:set var="seatId" value="${seat.seatCols}${seat.seatRows}" />
	  <button class="seat" id="${seatId}" data-seat-id="${seat.seatId}">
	    ${seatId}
	  </button>
	
	  <c:if test="${status.index % s.seatsPerRow == s.seatsPerRow -1}">
	    </div>
	  </c:if>
	</c:forEach>
</div>

</div>


	</div>
	<div class="reserve-decision">
		<span><strong>${m.movieTitle }</strong></span> 
		<br>
		<em>${sch.language }</em> <br>
		<em>${s.screenName }</em> <br>
		<em>${sch.screeningDate }</em> <br>
		${sch.startTime } ~ 13:50 <br>
		<em>선택좌석</em>
		<div class="decision-seat"></div> <br> <br>
		
		<div class="total-payment">
			<span class="text">결제금액</span>
			<span class="cost"></span>원
		</div>
		<div class="confirm">
			<button class="next" id="nextBtn" disabled>결제</button>
			<button class="next" id="reset">초기화</button>
		</div>
		
		
	</div>
	
</div>


    <form action="${contextRoot }/movie/payment" id="submitForm" method="post">
        <input type="hidden" name="seats" value="seat">
    </form>


	
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	
<script type="text/javascript">
$(function() {
	
	openMask();
});

/* 페이지 로딩시 호출될 마스킹 함수 */
function openMask() {
    const $target = $('#mask-target');

    const $mask = $('<div id="mask"></div>').css({
        position: 'absolute',
        top: 0,
        left: 0,
        width: '100%',
        height: '100%',
        backgroundColor: 'rgba(0, 0, 0, 0.5)',
        zIndex: 9999
    });

    $target.css('position', 'relative').append($mask);
}

	let maxSelectableSeats = 0; // 선택 가능한 좌석 수
	let selectedSeats = [];     // 현재 선택된 좌석 배열
	/* 버튼 클릭시 동작하는 이벤트 함수 */
	
	// 관람인원 클릭 이벤트
	$('.audience-selection .audience').click(function () {
	    closeMask(); // 마스크 제거
	
	    // 관람인원 수 추출
	    maxSelectableSeats = parseInt($(this).text());
	    selectedSeats = []; // 초기화
	    // 결정 div 구간 초기화
	    $('.cost').text('');
	    $('.decision-seat').text('');
	
	    // 좌석 선택 초기화
	    $('.seat').removeClass('selected');
	});
	
	
	/* 좌석 선택 제한 이벤트 함수  */
	$('.seat').click(function () {
	    // 이미 선택된 좌석일 경우 취소
	    if ($(this).hasClass('selected')) {
	        $(this).removeClass('selected');
	        $('#nextBtn').prop('disabled', true).addClass('disabled'); //이미 활성화 되었음에도 좌석을 취소하면 다시 비활성화 하도록
	        selectedSeats = selectedSeats.filter(id => id !== this.id);
	        bookingSummary();
	        
	        return;
	    }

	    // 선택 제한 확인
	    if (selectedSeats.length >= maxSelectableSeats) {
	    	
	    	if (maxSelectableSeats < 1) {
	    		
	    		alert('관람하실 인원을 먼저 선택해주세요');
	    		return;
				
			}else{
		        alert(`최대 \${maxSelectableSeats}명까지 선택할 수 있습니다.`);
		        return;
			}
	    }

	    // 좌석 선택
	    $(this).addClass('selected');
	    selectedSeats.push(this.id);
	    bookingSummary();
	    paymentButtonActivate();
	});
	
	
	/* 인원 선택 이벤트 함수 */
	$('.audience').click(function () {
	    if ($(this).hasClass('selected')) {
	        // 다시 클릭하면 선택 해제
            maxSelectableSeats = 0;
        	selectedSeats = [];
	        $(this).removeClass('selected');
	        $('#nextBtn').prop('disabled', true).addClass('disabled');
	    } else {
	        // 다른 선택 모두 해제하고, 이 버튼만 선택
	        $('.audience').removeClass('selected');
	        $('#nextBtn').prop('disabled', true).addClass('disabled');
	        $(this).addClass('selected');
	    }
	});

		
	


	/* 선택좌석과 결제금액을 나타내주는 함수 */
	function bookingSummary() {
	    // 선택된 좌석 리스트 갱신
	    let displaySeats = selectedSeats.join(', ');
	    $('.decision-seat').text(displaySeats);
	
	    // 결제 금액 계산
	    let total = selectedSeats.length * 12000;
	
	    // 쉼표 포맷
	    let formatted = total.toLocaleString('ko-KR');
	    $('.total-payment .cost').text(formatted);
	}
	
	/* 결제 버튼 활성화 함수  */
	function paymentButtonActivate() {
	    if (selectedSeats.length === maxSelectableSeats) {
	        $('#nextBtn').prop('disabled', false);
	    } else {
	        $('#nextBtn').prop('disabled', true);
	    }
	}
	
	/* 결제버튼 클릭시 다음 페이지로 */
	$('.confirm>#nextBtn').click(function(){
		console.log('눌렀나');
		postToPayment();
		
	});
	function postToPayment() {
		
        var submitForm = document.getElementById('submitForm');
        submitForm.submit();

    }
	
	/* 초기화 버튼 클릭시 상태 초기화 */
	$('#reset').click(function () {
	    resetSelection();
	});
	function resetSelection(){
		 // 1. 좌석 선택 초기화
	    $('.seat').removeClass('selected');

	    // 2. 선택 좌석 정보 초기화
	    selectedSeats = [];

	    // 3. 결제 금액 초기화
	    $('.cost').text('');

	    // 4. 선택 좌석 출력 영역 초기화
	    $('.decision-seat').text('');

	    // 5. 인원 선택 초기화
	    $('.audience').removeClass('selected');

	    // 6. 최대 선택 가능 인원 초기화
	    maxSelectableSeats = 0;

	    // 7. 결제 버튼 비활성화
	    $('#nextBtn').prop('disabled', true).addClass('disabled');
	}

	
	/* 특정 조건을 만족할시 마스킹을 해제할 함수  */
	function closeMask() {
	    $('#mask').remove();
	}

</script>	
	
</body>
</html>