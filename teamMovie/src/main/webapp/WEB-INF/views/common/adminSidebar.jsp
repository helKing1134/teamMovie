<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="list-group">
    <a href="${contextRoot}/admin/movies" class="list-group-item list-group-item-action">🎬 영화 관리</a>
    <a href="${contextRoot}/admin/theaters" class="list-group-item list-group-item-action">🏢 상영관 관리</a>
    <a href="${contextRoot}/admin/schedule" class="list-group-item list-group-item-action">🕒 상영 일정 관리</a>
    <a href="${contextRoot}/admin/bookings" class="list-group-item list-group-item-action">🎟️ 예매 현황</a>
    <a href="${contextRoot}/inquiryList" class="list-group-item list-group-item-action">📩 1:1 문의 관리</a>
    <a href="${contextRoot}/admin/members" class="list-group-item list-group-item-action">👤 회원 관리</a>
</div>
</body>
</html>