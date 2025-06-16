<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container-fluid mt-4">
    <div class="row">
        <!-- 사이드바 -->
        <div class="col-md-3">
            <div class="list-group">
                <a href="${contextRoot}/admin/movies" class="list-group-item list-group-item-action">🎬 영화 관리</a>
                <a href="${contextRoot}/admin/theaters" class="list-group-item list-group-item-action">🏢 상영관 관리</a>
                <a href="${contextRoot}/admin/schedule" class="list-group-item list-group-item-action">🕒 상영 일정 관리</a>
                <a href="${contextRoot}/admin/bookings" class="list-group-item list-group-item-action">🎟️ 예매 현황</a>
                <a href="${contextRoot}/inquiryList" class="list-group-item list-group-item-action">📩 1:1 문의 관리</a>
                <a href="${contextRoot}/admin/members" class="list-group-item list-group-item-action">👤 회원 관리</a>
            </div>
        </div>

        <!-- 메인 콘텐츠 -->
        <div class="col-md-9">
            <h3 class="mb-4">영화관 관리자 대시보드</h3>

            <div class="row">
                <div class="col-md-4 mb-3">
                    <div class="card text-white bg-primary">
                        <div class="card-body">
                            <h5 class="card-title">등록된 영화</h5>
                            <p class="card-text">총 <strong>${movieCount}</strong> 편</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="card text-white bg-success">
                        <div class="card-body">
                            <h5 class="card-title">오늘 예매 수</h5>
                            <p class="card-text"><strong>${todayBookingCount}</strong> 건</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="card text-white bg-warning">
                        <div class="card-body">
                            <h5 class="card-title">처리 대기 문의</h5>
                            <p class="card-text"><strong>${pendingInquiries}</strong> 건</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card mt-4">
                <div class="card-header">
                    📌 최근 등록된 영화
                </div>
                <ul class="list-group list-group-flush">
                    <c:forEach var="movie" items="${recentMovies}">
                        <li class="list-group-item">
                            ${movie.title} - ${movie.releaseDate}
                        </li>
                    </c:forEach>
                    <c:if test="${empty recentMovies}">
                        <li class="list-group-item">최근 등록된 영화가 없습니다.</li>
                    </c:if>
                </ul>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
