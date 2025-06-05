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
            <li id="movId">미션 임파서블 : 파이널 레코닝</li>
            <li>
                <span id="playDy">2025.06.04</span>
                <em>(수)</em>
                <span id="playTime"> "11:40~13:50"</span>
            </li>
            <li>
                <span id="scrnNm">제 1상영관</span>
                <span id="lanType">자막</span>
            </li>
            <li>성인1</li>
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
	      <span class="payment label">성인 1</span>
	      <span class="payment price">15,000</span>
	    </div>
	    <div class="payment separator"></div>
	    <div class="payment total-row">
	      <span class="payment label">금액</span>
	      <span class="payment price">15,000원</span>
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
		    <span class="payment price highlight">15,000</span>
		    <span class="payment unit">원</span>
		 </span>
	    </div>
	  </div>
		<div class="payment separator"></div>
	  <div class="payment method">
	    <span class="payment label">결제수단</span>
	    <!-- 위 에 결제수단 div영역을 택하면 값이 변한다.  -->
	    <span class="payment method-type"></span>
	  </div>
	
	  <div class="payment button-group">
	    <button class="payment btn prev">이전</button>
	    <button class="payment btn pay">결제</button>
	  </div>
</div>
    
    
    <br><br><br><br>



	
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	
<script type="text/javascript">

	// paySelect 영역 안의 모든 결제수단 버튼들
	const payOptions = document.querySelectorAll('#paySelect .pays');
	
	// 실제 결제 요약 영역의 결제수단 표시 요소
	const methodType = document.querySelector('.payment .method-type');
	
	payOptions.forEach(option => {
	  option.addEventListener('click', () => {
	    // 먼저 모든 옵션에서 act 클래스 제거
	    payOptions.forEach(opt => opt.classList.remove('act'));
	
	    // 클릭된 옵션에만 act 클래스 추가
	    option.classList.add('act');
	
	    // 해당 텍스트로 결제수단 업데이트
	    methodType.textContent = option.textContent;
	  });
	});


</script>	
	
</body>
</html>