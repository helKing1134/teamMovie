<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>영화 예매 플랫폼</title>
    <!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Bootstrap JS -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
        div { box-sizing: border-box; }
		#header {
		    width: 80%;
		    height: 100px;
		    padding-top: 20px;
		    margin: auto;
		    font-family: 'Noto Sans KR', sans-serif;
		    background: linear-gradient(90deg, #000000, #222222); /* 좌우 그라데이션 블랙 */
		    color: white; /* 기본 글자 흰색 */
		    border-radius: 8px;
		    box-shadow: 0 4px 8px rgba(0,0,0,0.5);
		}
		
		#header_1_right a {
		    margin-left: 15px;
		    color: white; /* 메뉴 링크 흰색 */
		    text-decoration: none;
		    transition: color 0.3s;
		}
		#header_1_right a:hover {
		    color: #ffcc00; /* 호버시 골드톤 */
		    text-decoration: underline;
		}
		
		#header_2 {
		    border-top: 1px solid rgba(255,255,255,0.3);
		    height: 60%;
		    background: linear-gradient(90deg, #111111, #333333); /* 조금 밝은 그라데이션 블랙 */
		    box-shadow: inset 0 -2px 5px rgba(255,255,255,0.1);
		}
		
		#header_2 > ul {
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    height: 100%;
		    margin: 0;
		    padding: 0;
		    list-style: none;
		}
		
		#header_2 > ul > li {
		    flex: 1;
		    text-align: center;
		    line-height: 55px;
		}
		
		#header_2 > ul > li a {
		    text-decoration: none;
		    color: white; /* 메뉴 흰색 */
		    font-size: 18px;
		    font-weight: 700;
		    display: block;
		    transition: color 0.3s;
		}
		
		#header_2 > ul > li a:hover {
		    color: #ffcc00; /* 호버시 골드톤 */
		}
        /* 공통 컨텐츠 스타일 */
        .content {
            background-color: rgb(247, 245, 245);
            width: 80%;
            margin: auto;
        }
        .innerOuter {
            border: 1px solid lightgray;
            width: 80%;
            margin: auto;
            padding: 5% 10%;
            background-color: white;
        }
    </style>
</head>
<body>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

<script type="text/javascript">
    var msg = "${alertMsg}";
    if(msg != "") {
        alert(msg);
    }
</script>
<c:remove var="alertMsg" />

<div id="header">
    <div id="header_1">
        <div id="header_1_left">
            <!-- 예매 플랫폼용 로고로 교체 -->
            <img src="https://yourdomain.com/resources/images/logo_movie.png" alt="영화 예매 플랫폼 로고" />
        </div>
        <div id="header_1_center"></div>
        <div id="header_1_right">
            <c:choose>
                <c:when test="${empty loginUser}">
                    <a href="${contextRoot}/register">회원가입</a>
                    <a data-toggle="modal" data-target="#loginModal">로그인</a>
                </c:when>
                <c:otherwise>
                    <span>${loginUser.userName}님 환영합니다</span>
                    <a href="${contextRoot}/mypage">마이페이지</a>
                    <a href="${contextRoot}/logout">로그아웃</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    <div id="header_2">
        <ul>
            <li><a href="${contextRoot}/movies">영화</a></li>
            <li><a href="${contextRoot}/booking">예매</a></li>
            <li><a href="${contextRoot}/theaters">극장</a></li>
            <li><a href="${contextRoot}/mypage">마이페이지</a></li>
        </ul>
    </div>
</div>

<!-- 로그인 모달 -->
<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="loginModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <!-- Modal Header -->
            <div class="modal-header">
                <h5 class="modal-title" id="loginModalLabel">로그인</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="닫기">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>

            <form action="${contextRoot}/login" method="post">
                <div class="modal-body">
                    <label for="userId" class="mr-sm-2">ID :</label>
                    <input type="text" class="form-control mb-2" id="userId" name="userId" placeholder="아이디 입력">
                    <label for="userPwd" class="mr-sm-2">비밀번호 :</label>
                    <input type="password" class="form-control mb-2" id="userPwd" name="userPwd" placeholder="비밀번호 입력">
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">로그인</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                </div>
            </form>
        </div>
    </div>
</div>

<br clear="both" />
</body>
</html>
