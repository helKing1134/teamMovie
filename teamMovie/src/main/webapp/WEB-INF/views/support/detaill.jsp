<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>1:1 문의 답변</title>
    <style>
        .inquiry-container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 2rem;
            background-color: #1b1b1b;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            color: #f0f0f0;
            font-family: 'Noto Sans KR', sans-serif;
        }

        h2 {
            color: #fff;
            font-size: 1.8rem;
            margin-bottom: 1.5rem;
        }

        .readonly-box {
            background-color: #2c2c2c;
            padding: 1rem;
            border-radius: 5px;
            margin-bottom: 1rem;
        }

        .inquiry-form label {
            display: block;
            margin: 1rem 0 0.5rem;
            font-weight: 500;
        }

        .inquiry-form textarea {
            width: 100%;
            padding: 0.8rem;
            border: none;
            border-radius: 5px;
            background-color: #2c2c2c;
            color: #fff;
            font-size: 1rem;
            resize: vertical;
        }

        .inquiry-form button {
            margin-top: 2rem;
            padding: 0.75rem 1.5rem;
            background-color: #9b4722;
            color: #fff;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .inquiry-form button:hover {
            background-color: #7f3618;
        }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="inquiry-container">
    <h2>1:1 문의 상세 및 답변</h2>

    <div class="readonly-box">
        <strong>문의자:</strong> ${i.inquiryWriter}<br/>
        <strong>문의유형:</strong> ${i.category}<br/>
        <strong>제목:</strong> ${i.title}<br/>
        <strong>내용:</strong><br/>
        <p>${i.content}</p>
        <strong>작성일:</strong> ${i.createdAt}
    </div>

    <form class="inquiry-form" method="post" action="${contextRoot}/support/inquiry/answer">
        <input type="hidden" name="inquiryId" value="${inquiry.inquiryId}" />

        <label for="answerContent">답변 내용</label>
        <textarea id="answerContent" name="answerContent" rows="7" required></textarea>

        <button type="submit">답변 등록</button>
    </form>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

</body>
</html>
