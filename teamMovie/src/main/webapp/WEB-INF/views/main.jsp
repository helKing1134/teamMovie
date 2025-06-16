<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    // 캐시 방지 헤더 설정 (브라우저 뒤로가기 시 캐시된 페이지가 뜨는 걸 방지)
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies
%>
<!DOCTYPE html>
<html>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

<style>
    body {
        margin: 0;
        padding: 0;
        font-family: 'Noto Sans KR', sans-serif;
        background: linear-gradient(to right,
            #111 0%,
            #1c1c1c 20%,
            #2a2a2a 50%,
            #1c1c1c 80%,
            #111 100%);
        color: #ffffff;
    }

    .main-container {
        max-width: 1200px;
        margin: 40px 350px 0;
        padding: 0 20px 100px 20px;
        min-height: 800px;
        box-sizing: border-box;
        position: relative;
    }

    .movie-header {
        position: relative;
        margin-bottom: 30px;
        text-align: center;
    }

    .movie-header h2 {
        font-size: 32px;
        font-weight: bold;
        margin: 70px auto 0 auto;
        color: #ffffff;
    }

    .more-movies-btn {
        position: absolute;
        right: 0;
        top: 50%;
        transform: translateY(-50%);
        font-size: 16px;
        color: #bbbbbb;
        text-decoration: none;
        transition: color 0.3s;
        padding-right: 5px;
    }

    .more-movies-btn:hover {
        color: #00bcd4;
    }

    .movie-list {
        display: flex;
        justify-content: center;
        gap: 50px;
        flex-wrap: wrap;
        padding: 20px 0;
    }

    .movie-card {
        background-color: #2a2a2a;
        border-radius: 12px;
        overflow: hidden;
        width: 245px;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.6);
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    /* 포스터 및 GIF 이미지 감싸는 컨테이너 */
    .poster-wrapper {
        position: relative;
        width: 245px;   /* movie-card 너비와 동일 */
        height: 352px;  /* 고정 높이 */
        overflow: hidden;
    }

    /* 포스터, GIF 공통 스타일 */
    .movie-poster {
        position: absolute;
        width: 100%;
        height: 100%;
        object-fit: cover;
        top: 0;
        left: 0;
        transition: opacity 0.3s ease;
    }

    /* 기본 포스터는 보임 */
    .static {
        opacity: 1;
        z-index: 1;
    }

    /* GIF는 기본 숨김 */
    .hover-gif {
        opacity: 0;
        z-index: 2;
    }

    /* 호버 시 포스터 숨기고 GIF 보여주기 */
    .poster-wrapper:hover .static {
        opacity: 0;
    }

    .poster-wrapper:hover .hover-gif {
        opacity: 1;
    }

    .movie-info {
        padding: 15px;
        text-align: center;
    }

    .movie-title {
        font-size: 16px;
        margin-bottom: 8px;
        font-weight: bold;
        color: #ffffff;
    }

    .movie-subinfo {
        font-size: 13px;
        color: #bbbbbb;
    }

    .movie-actions-bottom {
        display: flex;
        justify-content: center; /* 좋아요 제거 후에도 가운데 정렬 유지 */
        padding: 15px 0 20px;
        background-color: #2a2a2a;
        border-top: 1px solid rgba(255, 255, 255, 0.1);
    }

    .reserve-button {
        background: #E0115F;
        border: 0;
        padding: 6px 50px;
        color: white;
        border-radius: 4px;
        cursor: pointer;
        font-size: 18px;
        font-weight: bold;
        transition: background 0.3s;
        text-decoration: none !important;  /* 밑줄 제거 */
        border-bottom: none !important;    /* 혹시 border-bottom 있으면 제거 */
        box-shadow: none !important;       /* 혹시 그림자에 의한 선이면 제거 */
    }

    .reserve-button:hover {
        background: linear-gradient(to right, #ff8a00, #e52e71);
        color: white; 
    }

    .white-section {
        background-color: #ffffff;
        color: #222222;
        padding: 60px 20px;
        text-align: center;
    }

    .white-section h3 {
        font-size: 28px;
        font-weight: bold;
        margin-bottom: 20px;
    }

    .white-section p {
        font-size: 16px;
        max-width: 800px;
        margin: 0 auto;
        line-height: 1.6;
    }

    .scroll-indicator {
        position: absolute;
        bottom: 80px;
        left: 50%;
        transform: translateX(-50%);
        width: 20px;
        height: 30px;
        border: 2px solid #ffffff;
        border-radius: 20px;
        display: flex;
        justify-content: center;
        align-items: flex-start;
        padding-top: 5px;
        box-sizing: border-box;
    }

    .scroll-indicator::before {
        content: "";
        width: 6px;
        height: 6px;
        background: #ffffff;
        border-radius: 50%;
        animation: scrollDown 1.5s infinite;
    }

    @keyframes scrollDown {
        0% {
            opacity: 1;
            transform: translateY(0);
        }
        50% {
            opacity: 0.3;
            transform: translateY(10px);
        }
        100% {
            opacity: 1;
            transform: translateY(0);
        }
    }
</style>
</head>
<body>
	
    <!-- 로그인 성공 메시지 알림 -->
    <c:if test="${not empty sessionScope.alertMsg}">
        <script>
            alert('${sessionScope.alertMsg}');
        </script>
        <c:remove var="alertMsg" scope="session" />
    </c:if>


<div class="main-container">
    <div class="movie-header">
        <h2>BOX OFFICE</h2>
       <a href="/teammovie/movies" class="more-movies-btn">더 많은 영화 보기 +</a>
    </div>
			<c:if test="${empty mlist}">
    			<p>영화 목록이 없습니다.</p>
			</c:if>
<div class="movie-list">
   
<c:forEach var="movie" items="${mlist}" varStatus="status">
    <div class="movie-card">
        <div class="poster-wrapper">
            <!-- 포스터 이미지 : 기본 상태 -->
            
            <!-- 포스터 임의로 하드코딩 -->
            <img src="https://www.themoviedb.org/t/p/w600_and_h900_bestv2/ylFyiOl7w6tMIWYV4ZAa2HpThhk.jpg"
                 alt="${movie.movieTitle} 포스터"
                 class="movie-poster static" />
                 
            <!-- GIF 이미지 : hover 시에만 보임 -->
            
            <!-- GIF 임의로 하드코딩 -->
            <img src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExMmJudjExanoydHJ6YWlmdmdtdGFuZnF0cm90Z3Yxbnl6d29wbHN5cCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/9Zma6yZTtPOYVUAAb3/giphy.gif"
                 alt="${movie.movieTitle} GIF"
                 class="movie-poster hover-gif" />
        </div>
       <!-- 예매 버튼 -->
        <div class="movie-info">
            <div class="movie-title">${movie.movieTitle}</div>
            <a href="/teammovie/movie/select?movieNo=${movie.movieId}" class="reserve-button">
                예매하기
            </a>
        </div>
    </div>
    
</c:forEach>

</div>
</div>
        <!-- 카드 반복 끝 -->

        <!-- 스크롤 인디케이터 -->
        <div class="scroll-indicator"></div>
 


<!-- 영화 예고편 슬라이드 -->
<div id="videoCarousel" class="carousel slide" data-ride="carousel" style="background:#ffffff; padding: 40px 0; position: relative;" data-interval="20000">
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
			<iframe width="600" height="300" src="https://www.youtube.com/embed/9ESZQPX3ewA?enablejsapi=1" frameborder="0" allowfullscreen></iframe>
			<h5 class="mt-3">[트론: 아레스]</h5>
        </div>
    </div>

    <!-- 인디케이터 및 진행바 -->
    <div style="text-align:center; margin-top: 10px;">
        <div style="width: 600px; height: 4px; background:#eee; margin: 5px auto 0 auto; border-radius:2px; overflow:hidden;">
            <div id="progressBar" style="height:100%; width:0%; background:rgba(0,0,0,0.5);"></div>
        </div>
    </div>

    <!-- 좌우 컨트롤 -->
    <a class="carousel-control-prev" href="#videoCarousel" role="button" data-slide="prev">
        <span class="carousel-control-prev-icon" style="filter: invert(1);" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
    </a>
    <a class="carousel-control-next" href="#videoCarousel" role="button" data-slide="next">
        <span class="carousel-control-next-icon" style="filter: invert(1);" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
    </a>
</div>

<!-- JavaScript 로직 -->
<script>
    let tag = document.createElement('script');
    tag.src = "https://www.youtube.com/iframe_api";
    let firstScriptTag = document.getElementsByTagName('script')[0];
    firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

    let players = [];
    let currentIndex = 0;
    let totalSlides = 0;
    let progressBar = null;
    let progressIntervalId = null;
    const intervalTime = 20000;
    let progressElapsed = 0;
    let isHovered = false;

    function startProgressBarAndAutoSlide() {
        if (!progressBar) return;

        if (progressIntervalId !== null) {
            clearInterval(progressIntervalId);
        }

        progressBar.style.transition = 'none';
        progressBar.style.width = '0%';
        progressElapsed = 0;

        const stepTime = 200;

        progressIntervalId = setInterval(() => {
            if (isHovered) return;

            progressElapsed += stepTime;
            let percent = (progressElapsed / intervalTime) * 100;
            progressBar.style.width = Math.min(percent, 100) + '%';

            if (progressElapsed >= intervalTime) {
                clearInterval(progressIntervalId);
                progressIntervalId = null;

                $('#videoCarousel').carousel('next');
            }
        }, stepTime);
    }

    function resetProgressBarOnly() {
        if (!progressBar) return;

        if (progressIntervalId !== null) {
            clearInterval(progressIntervalId);
        }

        progressElapsed = 0;
        progressBar.style.transition = 'none';
        progressBar.style.width = '0%';

        startProgressBarAndAutoSlide();
    }

    function isElementInViewport(el, ratio = 0.5) {
        const rect = el.getBoundingClientRect();
        const windowHeight = (window.innerHeight || document.documentElement.clientHeight);
        const visibleHeight = Math.max(0, Math.min(rect.bottom, windowHeight) - Math.max(rect.top, 0));
        const elHeight = rect.height || (rect.bottom - rect.top);
        return visibleHeight / elHeight > ratio;
    }

    function handleScrollVideoPlayback() {
        const carousel = document.getElementById('videoCarousel');
        if (!carousel || players.length === 0) return;

        if (isElementInViewport(carousel, 0.5)) {
            if (players[currentIndex] && players[currentIndex].playVideo) {
                players[currentIndex].playVideo();
            }

            resetProgressBarOnly(); // 바만 초기화

        } else {
            if (players[currentIndex] && players[currentIndex].pauseVideo) {
                players[currentIndex].pauseVideo();
            }

            if (progressIntervalId !== null) {
                clearInterval(progressIntervalId);
            }
        }
    }

    window.addEventListener('scroll', handleScrollVideoPlayback);

    function onYouTubeIframeAPIReady() {
        document.querySelectorAll('#videoCarousel iframe').forEach((iframe, index) => {
            players[index] = new YT.Player(iframe, {
                events: {
                    'onReady': function (event) {
                        if (index === currentIndex) {
                            event.target.playVideo();
                            startProgressBarAndAutoSlide();
                        }
                    },
                    'onStateChange': function (event) {
                        // 영상이 끝나도 자동 전환 X
                        // 자동 전환은 진행바에서만
                    }
                }
            });
        });
    }

    $('#videoCarousel').on('slide.bs.carousel', function (e) {
        let items = document.querySelectorAll('#videoCarousel .carousel-item');
        currentIndex = Array.prototype.indexOf.call(items, e.relatedTarget);

        players.forEach(player => {
            if (player.pauseVideo) player.pauseVideo();
        });

        // 영상 자동 재생 보장 (지연 실행)
        setTimeout(() => {
            if (players[currentIndex] && players[currentIndex].playVideo) {
                players[currentIndex].playVideo();
            }
        }, 200);

        startProgressBarAndAutoSlide();
    });

    document.addEventListener('DOMContentLoaded', function () {
        totalSlides = document.querySelectorAll('#videoCarousel .carousel-item').length;
        progressBar = document.getElementById('progressBar');

        const carousel = document.getElementById('videoCarousel');
        carousel.addEventListener('mouseenter', () => { isHovered = true; });
        carousel.addEventListener('mouseleave', () => { isHovered = false; });

        startProgressBarAndAutoSlide();
        
    });
</script>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	
	

</body>
</html>