<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>





    <style>
        body {
            margin: 0;
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f8f8f6;
            color: #2c2c2c;
        }

        .container {
            display: flex;
            min-height: 100vh;
        }

        /* 사이드바 */
        .sidebar {
            width: 220px;
            background-color: #f0ede9;
            padding: 2rem 1rem;
            border-right: 1px solid #ddd3ca;
        }

        .sidebar h2 {
            font-size: 1.2rem;
            margin-bottom: 1.5rem;
            color: #5e4732;
        }

        .sidebar ul {
            list-style: none;
            padding: 0;
        }

        .sidebar ul li {
            margin-bottom: 1rem;
        }

        .sidebar ul li a {
            text-decoration: none;
            color: #3b3b3b;
            font-size: 0.95rem;
            display: block;
            padding: 0.4rem 0.8rem;
            border-radius: 4px;
        }

        .sidebar ul li a:hover,
        .sidebar ul li a.active {
            background-color: #dfd7cc;
            color: #2c2c2c;
        }

        /* 메인 콘텐츠 */
        .main {
            flex: 1;
            padding: 2.5rem;
        }

        .main h1 {
            font-size: 1.8rem;
            margin-bottom: 1.5rem;
            color: #4d392b;
        }

        .main .section {
            margin-bottom: 2rem;
        }

        .main .section h3 {
            font-size: 1.2rem;
            margin-bottom: 0.5rem;
            color: #3b3b3b;
        }

        .main .section p {
            font-size: 0.95rem;
            color: #555;
        }

        .quick-box {
            display: flex;
            gap: 2rem;
            flex-wrap: wrap;
            margin-top: 2rem;
        }

        .quick-item {
            flex: 1 1 220px;
            padding: 1rem;
            background-color: #ffffff;
            border: 1px solid #e2dcd3;
            border-radius: 6px;
        }

        .quick-item h4 {
            font-size: 1rem;
            margin-bottom: 0.5rem;
            color: #5a3c28;
        }

        .quick-item p {
            font-size: 0.85rem;
            color: #666;
        }
    </style>
    
    
</head>
<body>

	<%@ include file="/WEB-INF/views/common/header.jsp" %>
	

	
	<div class="container">
    <!-- 사이드바 -->
    <aside class="sidebar">
        <h2>고객센터</h2>
        <ul>
            <li><a href="${contextRoot}/support" class="active">고객센터 홈</a></li>
            <li><a href="${contextRoot}/support/faq">자주 묻는 질문</a></li>
            <li><a href="#">공지사항</a></li>
            <li><a href="${contextRoot}/support/inquiry" id = "inquiry">1:1 문의</a></li>
            <li><a href="${contextRoot}/inquiryList">1:1 관리자 문의목록</a></li>
            <li><a href="${contextRoot}/admin">관리자 페이지</a></li>
            <li><a href="${contextRoot}/myInquiryList">나의 문의 내역</a></li>
            <li><a href="#">분실물 문의</a></li>
            <li><a href="#">이용약관</a></li>
            <li><a href="#">개인정보처리방침</a></li>
            
            
            
        </ul>
    </aside>

    <!-- 메인 콘텐츠 -->
    <main class="main">
        <h1>고객센터 홈</h1>
        <p>무엇을 도와드릴까요?</p>

        <div class="quick-box">
            <div class="quick-item">
                <h4>자주 묻는 질문</h4>
                <p>자주 묻는 질문을 모았습니다. 빠르게 확인해보세요.</p>
            </div>
            <div class="quick-item">
                <h4>1:1 문의</h4>
                <p>개인적인 문제나 요청은 1:1 문의를 이용해주세요.</p>
            </div>
            <div class="quick-item">
                <h4>분실물 접수</h4>
                <p>분실한 물건이 있다면 이곳에서 접수해 주세요.</p>
            </div>
        </div>
    </main>
</div>
	
	
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>

</body>


</html>