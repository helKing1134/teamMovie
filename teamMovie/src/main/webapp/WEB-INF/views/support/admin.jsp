<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<div class="container-fluid mt-4">
    <div class="row">
        <!-- 사이드바 -->
        <div class="col-md-3">
            <div class="list-group">
                <a href="${contextRoot}/admin/movieRegisterForm" class="list-group-item list-group-item-action">🎬 영화 관리</a>
                <a href="${contextRoot}/inquiryList" class="list-group-item list-group-item-action">📩 1:1 문의 관리</a>
                <a href="${contextRoot}/adminMember" class="list-group-item list-group-item-action">👤 회원 관리</a>
                <!-- 환불항목 추가 by sh.k 06.16 -->
                <a href="${contextRoot}/admin/refund" class="list-group-item list-group-item-action">💸 환불 관리</a>
            </div>
        </div>

        <!-- 메인 콘텐츠 -->
        <div class="col-md-9">
            <h3 class="mb-4">영화관 관리자 대시보드</h3>

            <div class="row">
                
                <div class="col-md-4 mb-3">
				    <a href="${contextRoot}/inquiryList" style="text-decoration: none;">
				        <div class="card text-white" style="background-color: #b98e00;">
				            <div class="card-body">
				                <h5 class="card-title">처리 대기 문의</h5>
				                <p class="card-text"><strong>14</strong> 건</p>
				            </div>
				        </div>
				    </a>
				</div>
            </div>
        </div>
    </div>
</div>

