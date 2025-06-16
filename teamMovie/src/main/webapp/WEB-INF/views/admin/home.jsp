<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>관리자 메인 페이지</title>
</head>
<body>
    <h1>👑 관리자 홈입니다!</h1>
    <p>여기서 회원 관리, 영화 등록, 예매 확인 등을 할 수 있어요.</p>
    <button onclick="location.href='${pageContext.request.contextPath}/'">메인 홈</button>
</body>
</html>