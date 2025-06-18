<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String contextRoot = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>고객센터 홈</title>
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

        .sidebar {
            width: 220px;
            background-color: #f0ede9;
            padding: 2rem 1rem;
            border-right: 1px solid #ddd3ca;
            margin-top: 120px;
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

        .main {
            flex: 1;
            padding: 2.5rem;
        }

        .main h1 {
            font-size: 1.8rem;
            margin-bottom: 1.5rem;
            color: #4d392b;
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
            <li><a href="${pageContext.request.contextPath}/support" class="active">고객센터 홈</a></li>
            <li><a href="${pageContext.request.contextPath}/support/faq">자주 묻는 질문</a></li>
            <li><a href="${contextRoot}/support/inquiry" id = "inquiry">1:1 문의</a></li>
        </ul>
    </aside>

    <!-- 메인 콘텐츠 -->
    <main class="main">
        <h1>고객센터 홈</h1>
        <p>무엇을 도와드릴까요?</p>

        <div class="quick-box">
    <a href="${contextRoot}/support/faq" class="quick-item" style="text-decoration: none;">
        <h4>자주 묻는 질문</h4>
        <p>자주 묻는 질문을 모았습니다. 빠르게 확인해보세요.</p>
    </a>

    <a href="${contextRoot}/support/inquiry" class="quick-item" style="text-decoration: none;" id="inquiryBox">
        <h4>1:1 문의</h4>
        <p>개인적인 문제나 요청은 1:1 문의를 이용해주세요.</p>
    </a>

</div>

    </main>
</div>

<!-- 로그인 상태 확인 변수 -->
<c:set var="isLogin" value="${empty sessionScope.loginUser ? 'false' : 'true'}" />

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const isLogin = "${isLogin}" === 'true';

        const inquiryLink = document.getElementById("inquiry");
        const myInquiryLink = document.getElementById("myInquiryList");

        function handleAuthClick(e, targetUrl) {
            if (!isLogin) {
                e.preventDefault();

                // 세션에 리다이렉트 URL 저장
                fetch("${pageContext.request.contextPath}/saveRedirectUrl", { method: "POST",
                    headers: {
                        "Content-Type": "application/json"
                    },
                    body: JSON.stringify({ redirect: targetUrl })
                })
                .then(() => {
                    $('#loginModal').modal('show');
                })
                .catch(error => {
                    console.error("Redirect URL 저장 실패:", error);
                });
            }
        }

        if (inquiryLink) {
            inquiryLink.addEventListener("click", function(e) {
                handleAuthClick(e, "/support/inquiry");
            });
        }

        if (myInquiryLink) {
            myInquiryLink.addEventListener("click", function(e) {
                handleAuthClick(e, "/myInquiryList");
            });
        }
    });
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

</body>
</html>
</body>
</html>
