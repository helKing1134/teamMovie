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
	
	body {
	  margin: 0;
	  font-family: 'Noto Sans KR', sans-serif;
	  background-color: #f8f9fa;
	}
	
	.container {
	  display: grid;
	  grid-template-columns: 2fr 1fr; /* 좌: 좌석, 우: 영화 정보 */
	  gap: 40px; /* 좌우 간격 조절 */
	  align-items: start;
	  max-width: 1200px;
   	  margin-top: 120px;
	}

	
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
	  height: 486px;
	  position: relative;
	  margin: 0 auto;
	}
	.text{
		color : white;
		align-items: center;
		flex-direction: column;
	}
	
	.reserve-div{
	  display: flex;
	  flex-direction: column;
	  align-items: center;
	  gap: 20px;
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
	
	/* 예약좌석은 사용자의 선택을 막음  */
	.seat-temp {
	  background: none !important;
	  background-color: yellow !important;
	  cursor: not-allowed;
	  z-index: 9999;
	}
	
	.seat-confirm {
	  background: none !important;
	  background-color: red !important;
	  cursor: not-allowed;
	  z-index: 9999;
	}
	
	/* === 예약 summarry 부분 === */
	.reserve-decision {
	  background-color: #1c1c1c;
	  color: white;
	  border-radius: 12px;
	  right: 200px;
	  padding: 20px;
	  box-shadow: 0 4px 10px rgba(0,0,0,0.3);
	  width: 100%;
	  max-width: 300px;
	}
	
	.left {
	  display: flex;
	  flex-direction: column;
	  align-items: center;
	  gap: 20px;
	}
	.reserve-decision span,
	.reserve-decision em {
	  display: block;
	  margin-bottom: 5px;
	  font-size: 14px;
	  color: #ccc;
	}
	
	.reserve-decision strong {
	  font-size: 16px;
	  color: #fff;
	}
	
	.decision-seat {
	  min-height: 20px;
	  margin-top: 5px;
	  color: #00d1b2;
	}
	
	.total-payment {
	  background-color: #2c2c2c;
	  padding: 20px;
	  border-radius: 10px;
	  margin-top: 20px;
	}
	
	.total-payment .text {
	  display: block;
	  font-size: 16px;
	  font-weight: bold;
	  margin-bottom: 10px;
	}
	
	.total-payment .cost {
	  font-size: 24px;
	  font-weight: bold;
	  color: #00e0cc;
	}
	
	.confirm {
	  display: flex;
	  justify-content: space-between;
	  margin-top: 20px;
	}
	
	.confirm button {
	  width: 48%;
	  padding: 12px 0;
	  border: none;
	  border-radius: 10px;
	  font-size: 16px;
	  font-weight: bold;
	  cursor: pointer;
	}
	
	.confirm #nextBtn {
	  background-color: #00c3b5;
	  color: white;
	}
	
	.confirm #nextBtn:disabled {
	  background-color: #444;
	  cursor: not-allowed;
	}
	
	.confirm #reset {
	  background-color: #444;
	  color: white;
	}
/* === 예약 summarry 부분 === */
	
/* 푸터는 항상 아래에 고정됨 */
.footer {
  width: 100%;
  padding: 20px 0;
  text-align: center;
  flex-shrink: 0;
}

/*===관람인원 선택 div 스타일 조정  */
.audience-selector {
  width: 100%;
  max-width: 500px;
  margin: 0 auto 40px;
  text-align: center;
  top: 300px;
}

.audience-selector h4 {
  font-size: 18px;
  font-weight: 600;
  margin-bottom: 20px;
  color: #333;
}

.audience-selection {
  display: flex;
  justify-content: center;
  gap: 12px;
  flex-wrap: wrap;
}

.audience-selection .audience {
  width: 35px;
  height: 25px;
  font-size: 16px;
  font-weight: 500;
  color: #333;
  background-color: #f1f1f1;
  border: 1px solid #ccc;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.2s ease-in-out;
}

.audience-selection .audience:hover {
  background-color: #007bff;
  color: #fff;
  border-color: #007bff;
}

.audience-selection .audience.selected {
  background-color: #007bff;
  color: #fff;
  border-color: #007bff;
}
/*===관람인원 선택 div 스타일 조정  */


</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container">
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
      <%-- 줄바꿈 시작 --%><%-- 현재 좌석이 줄의 첫번째 좌석일 때 줄 바꿈 시작 --%>
      <c:if test="${status.index % s.seatsPerRow == 0}">
        <div class="seat-row">
      </c:if>
      <%-- 좌석 ID 설정 --%>
      <c:set var="seatId" value="${seat.seatCols}${seat.seatRows}" />

      <%-- 예약좌석 상태 파악 --%>
      <c:set var="seatStatus" value="" />
      <c:forEach var="rs" items="${rsList}">
        <c:if test="${rs.seatId == seat.seatId}">
          <c:set var="seatStatus" value="${rs.status}" />
        </c:if>
      </c:forEach>

      <%-- 상태에 따른 버튼 생성 --%>
      <c:choose>
        <c:when test="${seatStatus == 'TEMP'}">
          <button class="seat seat-temp" id="${seatId}" disabled data-seat-id="${seat.seatId}">
            ${seatId}
          </button>
        </c:when>
        <c:when test="${seatStatus == 'CONFIRM'}">
          <button class="seat seat-confirm" id="${seatId}" disabled data-seat-id="${seat.seatId}">
            ${seatId}
          </button>
        </c:when>
        <c:otherwise>
          <button class="seat" id="${seatId}" data-seat-id="${seat.seatId}">
            ${seatId}
          </button>
        </c:otherwise>
      </c:choose>

      <%-- 줄바꿈 끝 --%><%-- 현재 좌석이 줄의 마지막 좌석일 경우, 줄 바꿈 영역을 마감한다. --%>
      <c:if test="${status.index % s.seatsPerRow == s.seatsPerRow - 1}">
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
		${timeMap.startStr } ~ ${timeMap.endStr } <br>
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
	

    <form action="${contextRoot }/movie/payment" id="submitForm" method="post">
 	    <input type="hidden" name="movieId" id="movieId" value="${m.movieId}" />
 	 	<input type="hidden" name="scheduleId" id="scheduleId" value="${sch.scheduleId }" />
 	 	<input type="hidden" name="screenId" id="screenId" value="${s.screenId }" />
 	 	<input type="hidden" name="memberId"  value="${mem.memberNo }" />
 	 <c:forEach var="rsSeat" items="${rsList }">
 	 	<input type="hidden" name="rSeats" value="${rsSeat.reservedSeatId }">
 	 </c:forEach>
    
    </form>

<br>


	
	
<script type="text/javascript">
$(function() {
	
	openMask();
});

/* 페이지 로딩시 호출될 마스킹 함수 */
function openMask() {
    const $target = $('#mask-target');

    const $mask = $('<div id="mask"><span class="text">^ 관람인원을 선택해 주세요 ^</span></div>').css({
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
	   	 const seatId = $(this).data("seat-id");
	    
	    if ($(this).hasClass('selected')) {
	        $(this).removeClass('selected');
	        $('#nextBtn').prop('disabled', true).addClass('disabled'); //이미 활성화 되었음에도 좌석을 취소하면 다시 비활성화 하도록
	        selectedSeats = selectedSeats.filter(id => id !== this.id);
	        bookingSummary();
	        $(`#submitForm input[type='hidden'][data-seat-id='\${seatId}']`).remove();
	        
	        return;
	    }
	 // 선택되지 않은 좌석이면: 선택 및 hidden input 생성
	    const input = $("<input>")
	      .attr("type", "hidden")
	      .attr("name", "seatIds")
	      .attr("data-seat-id", seatId)
	      .val(seatId);
	    $("#submitForm").append(input);

	    // 선택 제한 확인
	    if (selectedSeats.length >= maxSelectableSeats) {
	    	
    		// cursor: not-allowed;
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
	    let total = selectedSeats.length * 15000;
	
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
	    
	    //8. 좌석 히든 요소 제거
	    $("input[type='hidden'][name='seatIds']").remove();
	}
	


	
	/* 특정 조건을 만족할시 마스킹을 해제할 함수  */
	function closeMask() {
	    $('#mask').remove();
	}

</script>	
	
</body>
</html>