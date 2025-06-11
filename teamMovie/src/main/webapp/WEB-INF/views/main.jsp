<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

<style>
    /* 전체 페이지 배경 및 기본 글꼴 설정 */
    body {
        margin: 0; /* 기본 여백 제거 */
        padding: 0; /* 기본 패딩 제거 */
        font-family: 'Noto Sans KR', sans-serif; /* 한국어 웹 폰트 지정 */
        background: linear-gradient(to right,
            #111 0%,         /* 왼쪽 진한 회색 */
            #1c1c1c 20%,     /* 중간보다 약간 어두운 회색 */
            #2a2a2a 50%,     /* 중앙 회색 */
            #1c1c1c 80%,     /* 대칭되는 어두운 회색 */
            #111 100%);      /* 오른쪽 진한 회색 */
        color: #ffffff; /* 기본 글자색 흰색 */
    }

    /* 메인 콘텐츠 박스 설정 */
    .main-container {
        max-width: 1200px; /* 최대 가로 너비 */
        margin: 40px 350px 0; /* 상단/좌우 여백 */
        padding: 0 20px 100px 20px; /* 내부 여백 (좌우, 하단) */
        min-height: 800px; /* 최소 높이 설정 */
        box-sizing: border-box; /* 패딩 포함한 크기 계산 */
        position: relative; /* 자식 요소 위치 기준 */
    }

    /* 영화 리스트 상단 헤더 영역 */
    .movie-header {
        position: relative; /* 내부 버튼 정렬을 위한 기준 */
        margin-bottom: 30px; /* 아래쪽 여백 */
        text-align: center; /* 제목 가운데 정렬 */
    }

    /* 영화 리스트 타이틀 */
    .movie-header h2 {
        font-size: 32px; /* 폰트 크기 */
        font-weight: bold; /* 굵은 글씨 */
        margin: 0 auto; /* 중앙 정렬 */
        color: #ffffff; /* 글자색 흰색 */
    }

    /* '더보기' 버튼 스타일 */
    .more-movies-btn {
        position: absolute; /* movie-header 기준 절대 위치 */
        right: 0; /* 오른쪽 정렬 */
        top: 50%; /* 상단 기준 50% 위치 */
        transform: translateY(-50%); /* 수직 가운데 정렬 */
        font-size: 16px; /* 글자 크기 */
        color: #bbbbbb; /* 연한 회색 텍스트 */
        text-decoration: none; /* 밑줄 제거 */
        transition: color 0.3s; /* 색상 전환 애니메이션 */
        padding-right: 5px; /* 오른쪽 여백 */
    }

    /* '더보기' 버튼 호버 시 색상 변경 */
    .more-movies-btn:hover {
        color: #00bcd4; /* 시안 색상으로 변경 */
    }

    /* 영화 카드 리스트 전체 정렬 */
    .movie-list {
        display: flex; /* 가로 정렬 */
        justify-content: center; /* 가운데 정렬 */
        gap: 50px; /* 카드 사이 간격 */
        flex-wrap: wrap; /* 줄바꿈 허용 */
        padding: 20px 0; /* 위아래 패딩 */
    }

    /* 영화 카드 기본 박스 스타일 */
    .movie-card {
        background-color: #2a2a2a; /* 어두운 회색 배경 */
        border-radius: 12px; /* 모서리 둥글게 */
        overflow: hidden; /* 넘치는 부분 숨김 */
        width: 245px; /* 고정 너비 */
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.6); /* 그림자 효과 */
        display: flex; /* 세로 정렬을 위한 플렉스 */
        flex-direction: column; /* 상하 배치 */
        justify-content: space-between; /* 내부 요소 간격 */
        transition: transform 0.3s ease, box-shadow 0.3s ease; /* 부드러운 애니메이션 */
    }

    /* 포스터 이미지 영역 */
    .poster-wrapper {
        position: relative; /* 자식 이미지 위치 기준 */
        width: 100%; /* 부모 너비 전부 차지 */
        height: 352px; /* 고정 높이 */
        overflow: hidden; /* 넘치는 이미지 숨김 */
    }

    /* 기본 정적 포스터 */
    .movie-poster {
        position: absolute; /* 부모 기준 절대 위치 */
        width: 100%; /* 전체 너비 */
        height: 100%; /* 전체 높이 */
        object-fit: cover; /* 비율 유지하며 채우기 */
        transition: opacity 0.3s ease; /* 투명도 전환 효과 */
    }

    /* hover 시 보여질 GIF 이미지 초기 상태 */
    .hover-gif {
        opacity: 0; /* 숨김 */
    }

    /* 마우스 오버 시 정적 이미지 숨김 */
    .poster-wrapper:hover .static {
        opacity: 0; /* 정적 이미지 투명하게 */
    }

    /* 마우스 오버 시 GIF 이미지 표시 */
    .poster-wrapper:hover .hover-gif {
        opacity: 1; /* GIF 보이게 함 */
    }

    /* 영화 정보 텍스트 박스 */
    .movie-info {
        padding: 15px; /* 내부 여백 */
        text-align: center; /* 중앙 정렬 */
    }

    /* 영화 제목 스타일 */
    .movie-title {
        font-size: 16px; /* 글자 크기 */
        margin-bottom: 8px; /* 아래 여백 */
        font-weight: bold; /* 굵은 글씨 */
        color: #ffffff; /* 흰색 */
    }

    /* 영화 부가 정보 (감독 등) */
    .movie-subinfo {
        font-size: 13px; /* 작은 글자 크기 */
        color: #bbbbbb; /* 연한 회색 */
    }

    /* 예매/좋아요 버튼 하단 영역 */
    .movie-actions-bottom {
        display: flex; /* 가로 정렬 */
        justify-content: center; /* 가운데 정렬 */
        gap: 20px; /* 버튼 사이 간격 */
        padding: 15px 0 20px; /* 상단, 하단 패딩 */
        background-color: #2a2a2a; /* 배경색 동일 */
        border-top: 1px solid rgba(255, 255, 255, 0.1); /* 윗 경계선 */
    }

    /* 예매 버튼 스타일 */
    .reserve-button {
        background: #E0115F; /* 진한 핑크 */
        border: 0; /* 테두리 없음 */
        padding: 6px 50px; /* 내부 여백 */
        color: white; /* 글자색 흰색 */
        border-radius: 4px; /* 둥근 모서리 */
        cursor: pointer; /* 클릭 커서 */
        font-size: 18px; /* 글자 크기 */
        font-weight: bold; /* 굵은 글씨 */
        transition: background 0.3s; /* 배경 변화 애니메이션 */
    }

    /* 예매 버튼 호버 시 색상 변경 */
    .reserve-button:hover {
        background: linear-gradient(to right, #ff8a00, #e52e71); /* 오렌지-핑크 그라데이션 */
    }

    /* 좋아요 버튼 스타일 */
    .like-button {
        background: none; /* 배경 없음 */
        border: none; /* 테두리 없음 */
        color: #999999; /* 회색 */
        font-size: 18px; /* 크기 */
        cursor: pointer; /* 클릭 커서 */
        transition: transform 0.2s, color 0.2s; /* 확대 및 색상 변화 */
    }

    /* 좋아요 버튼이 클릭된 상태 */
    .like-button.active {
        color: #ff4d4d; /* 붉은 색 하트 */
    }

    /* 호버 시 버튼 확대 */
    .like-button:hover {
        transform: scale(1.2); /* 1.2배 확대 */
    }

    /* 흰색 배경 영역(소개용 등) */
    .white-section {
        background-color: #ffffff; /* 흰색 배경 */
        color: #222222; /* 진한 회색 글자 */
        padding: 60px 20px; /* 상하/좌우 여백 */
        text-align: center; /* 가운데 정렬 */
    }

    /* 흰색 섹션 제목 */
    .white-section h3 {
        font-size: 28px; /* 제목 크기 */
        font-weight: bold; /* 굵은 글씨 */
        margin-bottom: 20px; /* 아래 여백 */
    }

    /* 흰색 섹션 설명 문단 */
    .white-section p {
        font-size: 16px; /* 본문 글자 크기 */
        max-width: 800px; /* 최대 너비 제한 */
        margin: 0 auto; /* 가운데 정렬 */
        line-height: 1.6; /* 줄 간격 */
    }

    /* 스크롤 인디케이터 외곽 (마우스 형태) */
    .scroll-indicator {
        position: absolute; /* 부모 기준 위치 지정 */
        bottom: 80px; /* 아래 여백 */
        left: 50%; /* 가로 중앙 */
        transform: translateX(-50%); /* 중앙 정렬 보정 */
        width: 20px; /* 너비 */
        height: 30px; /* 높이 */
        border: 2px solid #ffffff; /* 테두리 */
        border-radius: 20px; /* 타원형 */
        display: flex; /* 내부 점 중앙 정렬 */
        justify-content: center; /* 가로 정렬 */
        align-items: flex-start; /* 위쪽 정렬 */
        padding-top: 5px; /* 점의 위치 여백 */
        box-sizing: border-box; /* 테두리 포함 */
    }

    /* 인디케이터 내부 점 (움직이는 점) */
    .scroll-indicator::before {
        content: ""; /* 가상 요소 사용 */
        width: 6px; /* 원 너비 */
        height: 6px; /* 원 높이 */
        background: #ffffff; /* 흰색 점 */
        border-radius: 50%; /* 동그라미 */
        animation: scrollDown 1.5s infinite; /* 아래로 반복 애니메이션 */
    }

    /* 스크롤 애니메이션 정의 */
    @keyframes scrollDown {
        0% {
            opacity: 1; /* 시작 시 보임 */
            transform: translateY(0); /* 위치 초기화 */
        }
        50% {
            opacity: 0.3; /* 중간에 흐려짐 */
            transform: translateY(10px); /* 아래로 이동 */
        }
        100% {
            opacity: 1; /* 다시 보임 */
            transform: translateY(0); /* 원위치 */
        }
    }
</style>
</head>
<body>
<script>
    // 좋아요 버튼 토글 기능
    function toggleLike(button) {
        button.classList.toggle('active');
    }
</script>

<div class="main-container">
    <div class="movie-header">
        <h2>BOX OFFICE</h2>
        <a href="/movies/all" class="more-movies-btn">더 많은 영화 보기 +</a>
    </div>

    <div class="movie-list">
        <!-- 카드 반복 시작 -->
        <div class="movie-card">
            <div class="poster-wrapper">
                <img src="${pageContext.request.contextPath}/images/movie-poster1.jpg" class="movie-poster static" alt="극한직업 포스터" />
                <img src="${pageContext.request.contextPath}/images/movie-poster1.gif" class="movie-poster hover-gif" alt="극한직업 GIF" />
            </div>
            <div class="movie-info">
                <div class="movie-title">극한직업</div>
                <div class="movie-subinfo">개그 / 예매율 500% / 2025-06-01</div>
            </div>
            <div class="movie-actions-bottom">
                <button class="reserve-button">예매</button>
                <button class="like-button" onclick="toggleLike(this)"><i class="fas fa-heart"></i></button>
            </div>
        </div>

        <div class="movie-card">
            <div class="poster-wrapper">
                <img src="${pageContext.request.contextPath}/images/movie-poster2.jpg" class="movie-poster static" alt="타이타닉 포스터" />
                <img src="${pageContext.request.contextPath}/images/movie-poster2.gif" class="movie-poster hover-gif" alt="타이타닉 GIF" />
            </div>
            <div class="movie-info">
                <div class="movie-title">타이타닉리메이크</div>
                <div class="movie-subinfo">액션 / 예매율 600% / 2025-06-02</div>
            </div>
            <div class="movie-actions-bottom">
                <button class="reserve-button">예매</button>
                <button class="like-button" onclick="toggleLike(this)"><i class="fas fa-heart"></i></button>
            </div>
        </div>

        <div class="movie-card">
            <div class="poster-wrapper">
                <img src="${pageContext.request.contextPath}/images/movie-poster3.jpg" class="movie-poster static" alt="아이언맨 포스터" />
                <img src="${pageContext.request.contextPath}/images/movie-poster3.gif" class="movie-poster hover-gif" alt="아이언맨 GIF" />
            </div>
            <div class="movie-info">
                <div class="movie-title">아이언맨</div>
                <div class="movie-subinfo">액션/SF / 예매율 800% / 2025-06-03</div>
            </div>
            <div class="movie-actions-bottom">
                <button class="reserve-button">예매</button>
                <button class="like-button" onclick="toggleLike(this)"><i class="fas fa-heart"></i></button>
            </div>
        </div>

        <div class="movie-card">
            <div class="poster-wrapper">
                <img src="${pageContext.request.contextPath}/images/movie-poster4.jpg" class="movie-poster static" alt="겨울왕국 포스터" />
                <img src="${pageContext.request.contextPath}/images/movie-poster4.gif" class="movie-poster hover-gif" alt="겨울왕국 GIF" />
            </div>
            <div class="movie-info">
                <div class="movie-title">겨울왕국</div>
                <div class="movie-subinfo">UFC / 예매율 700% / 2025-06-04</div>
            </div>
            <div class="movie-actions-bottom">
                <button class="reserve-button">예매</button>
                <button class="like-button" onclick="toggleLike(this)"><i class="fas fa-heart"></i></button>
            </div>
        </div>
        <!-- 카드 반복 끝 -->

        <!-- 스크롤 인디케이터 -->
        <div class="scroll-indicator"></div>
    </div>
</div>

<!-- 유튜브 영상 슬라이드 섹션 -->
<div id="videoCarousel" class="carousel slide" data-ride="carousel" style="background:#ffffff; padding: 40px 0;">
    <div class="carousel-inner text-center">
        <div class="carousel-item active">
            <iframe width="600" height="300" src="https://www.youtube.com/embed/LEjhY15eCx0?enablejsapi=1" frameborder="0" allowfullscreen></iframe>
            <h5 class="mt-3">Inside Out 2</h5>
        </div>
        <div class="carousel-item">
            <iframe width="600" height="300" src="https://www.youtube.com/embed/uJMCNJP2ipI?enablejsapi=1" frameborder="0" allowfullscreen></iframe>
            <h5 class="mt-3">Deadpool & Wolverine</h5>
        </div>
        <div class="carousel-item">
            <iframe width="600" height="300" src="https://www.youtube.com/embed/yqnfZcJWmEg?enablejsapi=1" frameborder="0" allowfullscreen></iframe>
            <h5 class="mt-3">Despicable Me 4</h5>
        </div>
    </div>

    <!-- 좌우 컨트롤 버튼 -->
    <a class="carousel-control-prev" href="#videoCarousel" role="button" data-slide="prev">
        <span class="carousel-control-prev-icon" style="filter: invert(1);" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
    </a>
    <a class="carousel-control-next" href="#videoCarousel" role="button" data-slide="next">
        <span class="carousel-control-next-icon" style="filter: invert(1);" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
    </a>
</div>
	<div id="videoCarousel" class="carousel slide" data-ride="carousel" data-interval="20000"></div>
<!-- YouTube iframe API 비동기 로드 및 자동 슬라이드 로직 -->
<script>
    // YouTube iframe API 로드
    let tag = document.createElement('script');
    tag.src = "https://www.youtube.com/iframe_api";
    let firstScriptTag = document.getElementsByTagName('script')[0];
    firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

    let players = [];
    let currentIndex = 0;

    // YouTube API 로드 후 플레이어 초기화
    function onYouTubeIframeAPIReady() {
        document.querySelectorAll('#videoCarousel iframe').forEach((iframe, index) => {
            players[index] = new YT.Player(iframe, {
                events: {
                    'onStateChange': function (event) {
                        if (event.data === YT.PlayerState.ENDED) {
                            nextSlide();
                        }
                    }
                }
            });
        });
        autoSlide(); // 자동 슬라이드 시작
    }

    // 다음 슬라이드로 이동
    function nextSlide() {
        $('#videoCarousel').carousel('next');
    }
	
<<<<<<< HEAD
    // 자동 슬라이드 (5초마다 상태 체크 후 재생 안 되면 다음 슬라이드)
    function autoSlide() {
        setInterval(() => {
            if (players[currentIndex] && players[currentIndex].getPlayerState() !== YT.PlayerState.PLAYING) {
                nextSlide();
            }
        }, 20000);
    }

    // 슬라이드 변경 시 현재 인덱스 업데이트 및 재생 제어
    $('#videoCarousel').on('slide.bs.carousel', function (e) {
        currentIndex = $(e.relatedTarget).index();
        players.forEach(player => {
            if (player.pauseVideo) player.pauseVideo();
        });
        if (players[currentIndex] && players[currentIndex].playVideo) {
            players[currentIndex].playVideo();
        }
    });
</script>

<!-- <%@ include file="/WEB-INF/views/common/footer.jsp" %> -->

	<button onclick="location.href='movie/select';">영화선택페이지</button>
	
	
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	
	

</body>
</html>