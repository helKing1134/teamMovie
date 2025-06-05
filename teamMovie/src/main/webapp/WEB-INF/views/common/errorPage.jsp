<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>errorPage for 로그인 실패 </title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background: linear-gradient(to right, #0f2027, #203a43, #2c5364);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: white;
            text-align: center;
        }

        .container {
            margin-top: 100px;
        }

        .error-img {
            width: 300px;
            margin-bottom: 20px;
        }

        h1 {
            font-size: 2.5em;
            margin-bottom: 10px;
        }

        p {
            font-size: 1.2em;
            margin-bottom: 30px;
        }

        .btn-home {
            display: inline-block;
            padding: 12px 24px;
            background-color: #e50914;
            color: white;
            font-weight: bold;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            font-size: 1em;
            transition: background 0.3s;
        }

        .btn-home:hover {
            background-color: #b00610;
        }

        .bottom {
            position: fixed;
            bottom: 40px;
            width: 100%;
            text-align: center;
        }
    </style>
</head>
<body>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
    <div class="container">
        <img class="error-img" src="" alt="영화 로그인 실패 1조 영화관 로고 넣기?">
        <h1>에러가 발생하였습니다.  😢🎬</h1>
        <p>${errorMsg}</p>
    </div>

    <div class="bottom">
        <a href="${contextRoot}" class="btn-home">메인으로 돌아가기 🎬</a>
    </div>

</body>
</html>