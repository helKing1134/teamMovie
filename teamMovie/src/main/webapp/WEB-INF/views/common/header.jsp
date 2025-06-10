<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

<!-- 구글 폰트 -->
<link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">

<style>
    * {
        box-sizing: border-box;
    }

    #header {
        width: 100%;
        font-family: 'Noto Sans KR', sans-serif;
        background-color: #1f1f1f;
        color: white;
        border-bottom: 1px solid rgba(255, 255, 255, 0.06);
    }

    .header-top {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 15px 30px;
    }

    .header-top-left a {
        font-family: 'Pacifico', cursive;
        font-size: 46px;
        color: white;
        text-decoration: none;
        line-height: 1;
        user-select: none;
        padding-left: 10px;
    }

    .header-top-left a:hover {
        color: #ffcc00;
    }

    .header-top-right a,
    .header-top-right span {
        margin-left: 18px;
        color: #e0e0e0;
        text-decoration: none;
        font-size: 15px;
        transition: all 0.3s ease;
    }

    .header-top-right a:hover {
        color: #FFFFFF;
        text-decoration: underline;
    }

    .nav-bar {
        background-color: #1e1e1e;
        border-top: 1px solid rgba(255, 255, 255, 0.03);
    }

    .nav-bar ul {
        display: flex;
        justify-content: center;
        padding: 0;
        margin: 0;
        list-style: none;
    }

    .nav-bar ul li {
        flex: 1;
        text-align: center;
    }

    .nav-bar ul li a {
        display: block;
        padding: 14px 0;
        color: #f5f5f5;
        font-size: 18px;
        font-weight: bold;
        text-decoration: none;
        transition: background 0.3s, color 0.3s;
    }

    .nav-bar ul li a:hover {
        background-color: rgba(255, 255, 255, 0.05);
    }

    /* 로그인 모달 스타일 */
    .modal-dialog.modal-sm {
        max-width: 320px;
    }

    .modal-content {
        background-color: #fff;
        color: #000;
        border-radius: 8px;
        border: none;
        padding: 1rem;
    }

    .modal-header {
        border-bottom: none;
        justify-content: space-between;
        align-items: center;
        padding-bottom: 0.5rem;
    }

    .modal-title {
        font-weight: 700;
        color: #000;
    }

    .modal-header .close {
        color: #000;
        font-size: 1.5rem;
        opacity: 1;
    }

    .modal-body label {
        font-weight: 600;
        color: #000;
        margin-top: 0.5rem;
    }

    .modal-body input.form-control {
        background: #fff;
        border: 1px solid #ccc;
        color: #000;
        margin-bottom: 0.5rem;
        padding: 0.375rem 0.75rem;
    }

    .form-check-label {
        font-size: 14px;
        color: #333;
        cursor: default;
    }

    .modal-footer {
        padding-top: 0.5rem;
        border-top: none;
        display: flex;
        justify-content: space-between;
    }

    .modal-footer .btn {
        
        font-weight: 600;
    }

    .btn-primary {
        background-color: #ffcc00;
        border: none;
        color: #000;
    }

    .btn-primary:hover {
        background-color: #e6b800;
    }

    .btn-secondary {
        background-color: #555;
        border: none;
        color: white;
    }

    .btn-secondary:hover {
        background-color: #444;
    }
</style>

<!-- 헤더 시작 -->
<div id="header">
    <div class="header-top">
        <div class="header-top-left">
            <a href="${contextRoot}/">Cinema</a>
        </div>
        <div class="header-top-right">
            <c:choose>
                <c:when test="${empty loginUser}">
                    <a href="${contextRoot}/register">회원가입</a>
                    <a href="#" data-toggle="modal" data-target="#loginModal">로그인</a>
                </c:when>
                <c:otherwise>
                    <span>${loginUser.userName}님 환영합니다</span>
                    <a href="${contextRoot}/mypage">마이페이지</a>
                    <a href="${contextRoot}/logout">로그아웃</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    <div class="nav-bar">
        <ul>
            <li><a href="${contextRoot}/movies">영화</a></li>
            <li><a href="${contextRoot}/booking">예매</a></li>
            <li><a href="${contextRoot}/theaters">극장</a></li>
            <li><a href="${contextRoot}/mypage">스토어</a></li>
        </ul>
    </div>
</div>
<!-- 헤더 끝 -->

<!-- 로그인 모달 -->
<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="loginModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="loginModalLabel">로그인</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="닫기">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form action="${contextRoot}/login" method="post">
                <div class="modal-body">
                    <label for="userId">아이디</label>
                    <input type="text" class="form-control" id="userId" name="userId" placeholder="아이디" autocomplete="username" />

                    <label for="userPwd">비밀번호</label>
                    <input type="password" class="form-control" id="userPwd" name="userPwd" placeholder="비밀번호" autocomplete="current-password" />

                    <!-- 아이디 저장 토글 버튼 -->
                    <div class="form-check mt-2 mb-3 d-flex align-items-center">
                        <button type="button" class="btn btn-outline-secondary p-1 me-2" id="rememberBtn">&#x2610;</button>
                        <span>아이디 저장</span>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">로그인</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- 아이디 저장 토글 스크립트 -->
<script>
    const btn = document.getElementById('rememberBtn');
    let isChecked = false;

    btn.addEventListener('click', () => {
        isChecked = !isChecked;
        btn.innerHTML = isChecked ? '&#x2611;' : '&#x2610;';
    });
</script> 
