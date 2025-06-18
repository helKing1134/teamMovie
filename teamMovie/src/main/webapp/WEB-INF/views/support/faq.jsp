<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>자주 묻는 질문 - 고객센터</title>
    <style>
        body {
            margin: 0;
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #121212;
            color: #e0e0e0;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
            padding: 3rem 1.5rem;
        }

        h1 {
            font-size: 2rem;
            margin-bottom: 2rem;
            color: #ffffff;
            border-bottom: 1px solid #333;
            padding-bottom: 0.5rem;
        }

        .faq-item {
            margin-bottom: 2rem;
            border-bottom: 1px solid #2a2a2a;
            padding-bottom: 1.5rem;
        }

        .faq-question {
            font-weight: 600;
            font-size: 1.1rem;
            color: #bb86fc;
            margin-bottom: 0.6rem;
        }

        .faq-answer {
            font-size: 0.95rem;
            color: #cccccc;
            line-height: 1.6;
        }

        .faq-answer::before {
            content: "A. ";
            font-weight: bold;
            color: #03dac6;
        }

        a {
            color: #03a9f4;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

	<%@ include file="/WEB-INF/views/common/header.jsp" %>
	
<div class="container">
    <h1>자주 묻는 질문</h1>

    <div class="faq-item">
        <div class="faq-question">Q. 예매는 어떻게 하나요?</div>
        <div class="faq-answer">로그인 후 원하는 영화와 시간대를 선택하여 좌석을 지정한 뒤 결제하시면 예매가 완료됩니다.</div>
    </div>

    <div class="faq-item">
        <div class="faq-question">Q. 예매 취소는 언제까지 가능한가요?</div>
        <div class="faq-answer">상영 시작 20분 전까지 마이페이지에서 예매 취소가 가능합니다.</div>
    </div>

    <div class="faq-item">
        <div class="faq-question">Q. 모바일 티켓은 어디서 확인하나요?</div>
        <div class="faq-answer">모바일 티켓은 마이페이지 > 예매내역에서 확인하실 수 있습니다.</div>
    </div>

    <div class="faq-item">
        <div class="faq-question">Q. 할인카드는 어떻게 등록하나요?</div>
        <div class="faq-answer">예매 시 결제 단계에서 할인카드를 선택해 등록하시면 자동으로 적용됩니다.</div>
    </div>

    <div class="faq-item">
        <div class="faq-question">Q. 회원 등급은 어떻게 결정되나요?</div>
        <div class="faq-answer">최근 6개월 간의 누적 관람 횟수와 결제 금액을 기준으로 매월 1일 갱신됩니다.</div>
    </div>
</div>


	<%@ include file="/WEB-INF/views/common/footer.jsp" %>


</body>
</html>