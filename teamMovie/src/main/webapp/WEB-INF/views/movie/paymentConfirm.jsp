<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<title>예매 결제 페이지</title>
<style>
    ul>li{
     list-style:none;
 	}
 	
/* ===== 공통 wrapper ===== */
.payment {
  font-family: 'Noto Sans KR', sans-serif;
  color: #ffffff;
  font-size: 14px;
}

/* ===== 최상위 박스 ===== */
.payment.summary {
  max-width: 360px;
  margin: 0 auto;
  padding: 24px;
  background-color: #2c2c2c;
  border-radius: 20px;
  box-shadow: 0 6px 18px rgba(0, 0, 0, 0.4);
  display: flex;
  flex-direction: column;
  gap: 20px;
}

/* ===== 제목 ===== */
.payment.title {
  font-size: 18px;
  font-weight: bold;
  margin-bottom: 8px;
}

/* ===== 티켓 정보 박스 ===== */
.payment.ticket {
  background-color: #3a3a3a;
  border-radius: 12px;
  padding: 16px;
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.payment.ticket-row,
.payment.total-row,
.payment.extra-row,
.payment.final-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.payment.discount-row{
  background-color: #3a3a3a;
  border-radius: 12px;
  padding: 16px;
  gap: 10px;
  display: flex;
  justify-content: space-between;
  align-items: center;
	

}

/* ===== 라벨 / 금액 ===== */
.payment.label {
  color: #b0b0b0;
}

.payment.price {
  font-weight: bold;
  color: #ffffff;
}
/* 최종금액  */
.payment.price.highlight {
  font-size: 18px;
  color: #00c3cc;
}

/* ===== 구분선 ===== */
.payment.separator {
  height: 1px;
  background-color: #444;
  margin: 8px 0;
}

/* ===== 결제수단 ===== */
.payment.method {
  display: flex;
  justify-content: space-between;
  font-size: 14px;
  color: #ffffff;
  margin-top: 8px;
}

.payment.method-type {
  font-weight: bold;
}

/* ===== 버튼 그룹 ===== */
.payment.button-group {
  display: flex;
  gap: 8px;
  margin-top: 12px;
}

.payment.btn {
  flex: 1;
  padding: 10px 0;
  border: none;
  border-radius: 8px;
  font-weight: bold;
  font-size: 15px;
  cursor: pointer;
}

.payment.btn.prev {
  background-color: #4a4a4a;
  color: #ffffff;
}

.payment.btn.pay {
  background-color: #00c3cc;
  color: #ffffff;
}

.payment.total-row .payment.label {
  font-weight: bold;
  color: #ffffff; /* 다른 label은 #b0b0b0인데, 여긴 흰색으로 더 강조 */
}

/* 원 */
.payment.unit {
  margin-left: 2px;  /* 딱 붙지 않게 미세한 여백 */
  font-size: 15px;
  font-weight: bold;
  color: #ffffff;
}
/* 원과 결제금액 변수를 묶는 span */
.payment.final-amount {
  display: inline-flex;
  align-items: baseline; /* 숫자와 원을 같은 선상에 맞춤 */
  gap: 2px; /* 간격 조정, 너무 벌어질 경우 1px로 줄여도 됨 */
}

/* 결제 수단 선택 구간  */
/* 전체 컨테이너 정리 */
.paySelect {
  display: flex;
  justify-content: space-between;
  border: 1px solid #ccc;
  border-radius: 8px;
  overflow: hidden;
  width: 100%;
  max-width: 500px;
  margin-top: 10px;
  background-color: #f7f7f7;
}

/* 각각의 결제 방식 (div 버튼처럼 보이게) */
.paySelect .pays {
  flex: 1;
  padding: 12px 0;
  text-align: center;
  cursor: pointer;
  font-weight: bold;
  font-size: 14px;
  color: #444;
  transition: background-color 0.3s, color 0.3s;
  border-right: 1px solid #ddd;
}

.paySelect .pays:last-child {
  border-right: none;
}

/* 비활성화 상태 */
.paySelect .pays:not(.act):hover {
  background-color: #eaeaea;
}

/* 활성화 상태 */
.paySelect .pays.act {
  background-color: #5d6dfc;
  color: #fff;
}

/* 모바일/간편결제 클릭 시 표시될 영역 감추기 기본 */
.ord {
  display: none;
  margin-top: 15px;
}

/* 활성화 시 보이게 */
.ord.active {
  display: block;
  border: 1px solid #ddd;
  padding: 15px;
  border-radius: 8px;
  background-color: #fff;
}

/* 카드 선택 및 옵션 라디오 정리 */
.ord .item {
  margin-bottom: 12px;
  font-size: 14px;
}

.ord .radioArea {
  display: flex;
  gap: 10px;
}

.ord .radionOption_1 {
  flex: 1;
  padding: 10px;
  border: 1px solid #aaa;
  border-radius: 6px;
  text-align: center;
  cursor: pointer;
  background-color: #f9f9f9;
}

.ord .radionOption_1 input[type="radio"] {
  margin-right: 6px;
}

/* 예매 정보 구역  */
/* 예매정보 전체 박스 */
.reserve-info {
  display: flex;
  align-items: flex-start;
  gap: 20px;
  padding: 20px;
  border: 2px solid #ccc;
  border-radius: 12px;
  background-color: #fdfdfd;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
  max-width: 600px;
  margin: 20px auto;
  font-family: 'Pretendard', sans-serif;
}

/* 텍스트 타이틀 */
.reserve-info .text {
  position: absolute;
  top: -10px;
  left: 20px;
  background-color: #fff;
  padding: 0 8px;
  font-weight: 600;
  font-size: 15px;
  color: #555;
}

/* 이미지 박스 */
.reserve-info .movimg img {
  width: 100px;
  height: 143px;
  border-radius: 6px;
  object-fit: cover;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

/* 리스트 */
.reserve-info .list {
  list-style: none;
  padding: 0;
  margin: 0;
  flex: 1;
  font-size: 14px;
  color: #333;
}

.reserve-info .list li {
  margin-bottom: 10px;
}

/* 세부 정보 span들 */
.reserve-info .list span,
.reserve-info .list em {
  margin-right: 6px;
  color: #666;
}

/* 영화 제목 강조 */
.reserve-info #movId {
  font-weight: bold;
  font-size: 16px;
  color: #111;
}



 	

</style>

</head>
<body>

	<%@ include file="/WEB-INF/views/common/header.jsp" %>
	
	<h2>결제하기</h2>
    <hr>

    <div class="reserve-info">
        <span class="text">예매정보</span>
        <div class="movimg">
            <img src="${pageContext.request.contextPath}/resources/image/mimpfinal.jpg" alt="미션 임파서블 : 파이널 레코닝" width="100" height="143">
        </div>
        <ul class="list">
            <li id="movId">${m.movieTitle }</li>
            <li>
                <span id="playDy">${sch.screeningDate }</span>
                <span id="playTime"> ${sch.startTime } ~ ${endStr }</span>
            </li>
            <li>
                <span id="scrnNm">${s.screenName }</span>
                <span id="lanType">${sch.language }</span>
            </li>
            <li>성인${count }</li>
        </ul>
    </div>

    <hr>

    <div class="payTitleArea">
        <div class="tit">결제수단</div>
    </div>

    <div class="paySelect" id="paySelect">

        <div class="pays act" data-type="credit">신용/체크카드</div>
        <div class="pays" data-type="easy">간편결제</div>
        <div class="pays" data-type="mobile">휴대폰결제</div>
        <div class="pays" data-type="bank">내통장결제</div>
    </div>
    <div class="ord" id="credit-display">
        <div class="item">카드사 선택</div>
        <div class="item">
            <select name="" id="card_select">
                <option value="01">kh카드</option>
                <option value="02">hk카드</option>
                <option value="03">kk카드</option>
                <option value="04">hh카드</option>
             </select>
        </div>
        <!-- 얘는 flex로 묶어야 함 -->
        <div class="item"> 
            <div class="radioArea">
                <div class="radionOption_1"><input type="radio" name="rdo_card_select" id="app_car">앱카드</div>
                <div class="radionOption_1"><input type="radio" name="rdo_card_select" id="general_card">일반결제</div>
                <div class="radionOption_1"><input type="radio" name="rdo_card_select" id="special_card">특수결제</div>
            </div>
        </div>
    </div>
    <br> <br> <br>
    
<!-- 결제 요약 정보 영역  -->
<div class="payment summary">
	  <h3 class="payment title">결제금액</h3>
	  <div class="payment ticket">
	    <div class="payment ticket-row">
	      <span class="payment label">성인 ${count}</span>
	      <span class="payment price">${totalPrice}원</span>
	    </div>
	    <div class="payment separator"></div>
	    <div class="payment total-row">
	      <span class="payment label">금액</span>
	      <span class="payment price">${totalPrice}원</span>
	    </div>
	  </div>
	
	  
	
	  <div class="payment discount">
	    <div class="payment discount-row">
	      <span class="payment label">할인적용</span>
	      <span class="payment price">0원</span>
	    </div>
	  </div>
		<br><br><br><br>
	  <div class="payment final">
	    <div class="payment extra-row">
	      <span class="payment label">추가 차액</span>
	      <span class="payment price">0</span>
	    </div>
	    <div class="payment final-row">
	      <span class="payment label">최종결제금액</span>
	      <span class="payment final-amount">
		    <span class="payment price highlight">${totalPrice}</span>
		    <span class="payment unit">원</span>
		 </span>
	    </div>
	  </div>
		<div class="payment separator"></div>
	  <div class="payment method">
	    <span class="payment label">결제수단</span>
	    <!-- 위 에 결제수단 div영역을 택하면 값이 변한다.  -->
	    <span class="payment method-type">신용/체크카드</span>
	  </div>
	
	  <div class="payment button-group">
	    <button class="payment btn prev">이전</button>
	    <button class="payment btn pay">결제</button>
	  </div>
</div>


<!-- form 영역 -->
<form action="${contextRoot }/movie/payment/process" method="post" id="forwardingForm">
    <input type="hidden" name="movieId" id="movieId">
    <input type="hidden" name="userId" id="userId" value="${mem.memberNo }">
    <input type="hidden" name="scheduleId" id="scheduleId">
    <input type="hidden" name="screenId" id="screenId">
    <input type="hidden" name="count" id="count">
    <input type="hidden" name="totalPrice" id="totalPrice">
    <input type="hidden" name="payMethod" id="payMethod" >
</form>
<form id="rollbackForm" action="${contextRoot }/movie/reserveSeat" method="post" style="display: none;">
  <input type="hidden" name="movieId" value="${m.movieId}">
  <input type="hidden" name="scheduleId" value="${sch.scheduleId}">
  <input type="hidden" name="screenId" value="${s.screenId}">
  <input type="hidden" name="memberId" value="${mem.memberNo }">
</form>

<form id="prevForm" action="${contextRoot }/reservation/cancel" method="post" style="display: none;">
  <input type="hidden" name="movieId" value="${m.movieId}">
  <input type="hidden" name="scheduleId" value="${sch.scheduleId}">
  <input type="hidden" name="screenId" value="${s.screenId}">
  <input type="hidden" name="memberId" value="${mem.memberNo }">
</form>

    
    <br><br><br><br>



	
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	
	
<script type="text/javascript">

	// paySelect 영역 안의 모든 결제수단 버튼들
	const payOptions = document.querySelectorAll('#paySelect .pays');
	
	// 실제 결제 요약 영역의 결제수단 표시 요소
	const methodType = document.querySelector('.payment .method-type');
	
	payOptions.forEach(option => {
	  option.addEventListener('click', () => {
	  
		    const stList = JSON.parse('${stList}');
		    console.log('stList:', stList);
	  
	  	// 먼저 모든 옵션에서 act 클래스 제거
	    payOptions.forEach(opt => opt.classList.remove('act'));
	
	    // 클릭된 옵션에만 act 클래스 추가
	    option.classList.add('act');
	
	    // 해당 텍스트로 결제수단 업데이트
	    methodType.textContent = option.textContent;
	    // jQuery로 hidden input 값 설정 (여기서 option이 this 아님에 주의)
	    console.log('수정검증');
	    $('#payMethod').val($(option).data('type'));  // ← 이게 맞음 : $(option)
	  });
	});
	
	/* 페이지 오픈시 작동하는 함수 - form의 가져온 데이터 value값에 넣어주기  */
	$(function () {
		const stList = JSON.parse('${stList}');
		console.log('stList:', stList);
		
	    document.getElementById('movieId').value = '${m.movieId}';
	    document.getElementById('scheduleId').value = '${sch.scheduleId}';
	    document.getElementById('screenId').value = '${s.screenId}';
	    document.getElementById('count').value = '${count}';
	    document.getElementById('totalPrice').value = '${totalPrice}';
	
	    const paySelectInput = document.getElementById("payMethod");

	    // 초기 설정: .pays.act의 data-type 값을 히든 input에 설정
	    const activePayDiv = document.querySelector('.pays.act');
	    if (activePayDiv) {
	    	console.log(document.getElementById("payMethod"));
	        paySelectInput.value = activePayDiv.getAttribute("data-type");
	    }
	
	    
	
	    // 폼 요소에 동적으로 좌석 hidden 추가
	    const form = document.getElementById('forwardingForm');
	    if (Array.isArray(stList)) {
	        stList.forEach(function (seat, index) {
	            const input = document.createElement('input');
	            input.type = 'hidden';
	            input.name = 'seatIds';
	            input.id = 'seatId_' + index;
	            input.value = seat.seatId;  // 좌석 ID 기준
	            form.appendChild(input);
	        });
	    }
	});
	
	/* 폼 전송 함수  */
	$('.button-group>.pay').click(function(){
		 // 1. 서버에 임시좌석 상태 확인 (결제 가능 여부 확인)
	    $.ajax({
	        url: '${contextRoot }/reservation/checkTempSeat',
	        method: 'POST',
	        data: {
	            scheduleId: ${sch.scheduleId},  // 또는 예약좌석 ID 등
	            memberNo : ${mem.memberNo}
	        },
	        success: function(response) {
	            if (response === 'valid') {
	                // 임시좌석 유효 → 결제 처리 진행
	                loadingProcess();
	               //3초 뒤에 값이 나감
	                setTimeout(function() {
	                	  postToProcess();
	                	}, 3000);
	            } else {
	                // 임시좌석 없음 또는 만료됨
	                alert("결제 시간이 만료되었습니다. 좌석을 다시 선택해 주세요.");
	                //location.href = '/teammovie/movie/reserve'; // 원하는 이전 페이지로 리다이렉트
	                document.getElementById("rollbackForm").submit();

	            }
	        },
	        error: function() {
	            alert("서버 오류가 발생했습니다. 다시 시도해 주세요.");
	        }
	    });
		
	});
	function postToProcess(){
		var postFomr = document.getElementById('forwardingForm');
		postFomr.submit();
	}
	
	/* 이전 버튼 클릭시 작동 이벤트 */
	$('.button-group>.prev').click(function(){
		
		document.getElementById("prevForm").submit();
	});
	
	
	/* 로딩창 controller */
	function loadingProcess(){
 	 openLoading();
  	// 타이머를 이용해 로딩창 종료
  	setTimeout(closeLoading, 3000);
	}

	// 로딩창 키는 함수
	function openLoading() {
	    //화면 높이와 너비를 구합니다.
	    let maskHeight = $(document).height();
	    let maskWidth = window.document.body.clientWidth;
	    //출력할 마스크를 설정해준다.
	    let mask = `
		  <div id="mask" 
		       style="position:fixed; z-index:9000; background-color:#000000; 
		              display:none; left:0; top:0; width:100%; height:100%; opacity:0.6;">
		
		              <div style="position:absolute; top:50%; left:50%;
		                  transform: translate(-50%, -50%);
		                  color: white;
		                  font-size: 26px;
		                  font-weight: 900;
		                  text-shadow: 2px 2px 4px rgba(0,0,0,0.8);
		                  text-align: center;">
		        결제가 진행중입니다.<br/>잠시만 기다려주세요.
		      </div
		
		  </div>
		`;

	    // 로딩 이미지 주소 및 옵션
	    let loadingImg ='';
	    loadingImg += "<div id='loadingImg' style='position:absolute; top: calc(50% - (200px / 2)); width:100%; z-index:99999999;'>";
	    loadingImg += " <img src='${pageContext.request.contextPath}/resources/image/loading.gif' style='position: relative; display: block; margin: 0px auto;'/>";
	    loadingImg += "</div>"; 
	    //레이어 추가
	    $('body')
	        .append(mask)
	        .append(loadingImg)
	    //마스크의 높이와 너비로 전체 화면을 채운다.
	    $('#mask').css({
	            'width' : maskWidth,
	            'height': maskHeight,
	            'opacity' :'0.3'
	    });
	    //마스크 표시
	    $('#mask').show();  
	    //로딩 이미지 표시
	    $('#loadingImg').show();
	}
	
	// 로딩창 끄는 함수
	function closeLoading() {
	    $('#mask, #loadingImg').hide();
	    $('#mask, #loadingImg').empty(); 
	}

	


</script>	
	
</body>
</html>