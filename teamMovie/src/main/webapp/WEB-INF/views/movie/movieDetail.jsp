<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>영화 상세보기</title>
  <%@ include file="../common/header.jsp" %>
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <style>
    body {
      background-color: #121212;
      color: #f1f1f1;
    }
    .age-badge {
      display: inline-block;
      padding: 5px 10px;
      border-radius: 4px;
      font-weight: bold;
      color: white;
      font-size: 0.9rem;
    }
    .age-all { background-color: #4CAF50; }
    .age-12 { background-color: #2196F3; }
    .age-15 { background-color: #FFC107; }
    .age-19 { background-color: #F44336; }

    .movie-poster {
      width: 100%;
      border-radius: 10px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.5);
    }
    .section-title {
      border-left: 4px solid #888;
      padding-left: 10px;
      font-weight: bold;
      margin-top: 40px;
      margin-bottom: 20px;
      font-size: 1.4rem;
    }

    .tab-menu {
      background-color: #1e1e1e;
      border-radius: 8px;
    }
    .tab-menu .nav-link {
      color: #ccc;
      font-weight: bold;
    }
    .tab-menu .nav-link.active {
      background-color: #343a40;
      color: #fff;
    }

    .review-box {
      background-color: #1e1e1e;
      border-radius: 10px;
      padding: 20px;
      margin-bottom: 20px;
    }

    .review-input {
      background-color: #2a2a2a;
      color: white;
      border: 1px solid #444;
    }

    textarea::placeholder {
      color: #aaa;
    }
  </style>
</head>
<body>

<div class="container mt-5">
  <div class="row">
    <!-- 포스터 -->
    <div class="col-md-4">
      <img src="https://www.themoviedb.org/t/p/w600_and_h900_bestv2/fDu0T5WE0QAoX2yAqZ1RtlWBn6I.jpg" alt="영화 포스터" class="movie-poster">
    </div>

    <!-- 영화 정보 -->
    <div class="col-md-8">
      <h2 class="font-weight-bold text-white">${movie.movieTitle}</h2>
      <span class="age-badge age-15">${movie.rating}</span>
      <p class="mt-3"><strong>개봉일:</strong> ${movie.releaseDate}</p>
      <p>
      	<strong>장르:</strong>
      	<c:forEach var="genre" items="${movie.genres}" varStatus="vs">
      		<c:choose>
      			<c:when test="${!vs.last}">
      				${genre.genreName},
      			</c:when>
      			<c:otherwise>
      				${genre.genreName}
      			</c:otherwise>
      		</c:choose>
      	</c:forEach>
      </p>
      <p><strong>감독:</strong> ${movie.director}</p>
      <p>
      	<strong>출연:</strong>
      	<c:forEach var="actor" items="${movie.actors}" varStatus="vs">
      		<c:choose>
      			<c:when test="${!vs.last}">
      				${actor.actorName},
      			</c:when>
      			<c:otherwise>
      				${actor.actorName}
      			</c:otherwise>
      		</c:choose>
      	</c:forEach>
      </p>
      <button class="btn btn-outline-info mt-3">예매하기</button>
    </div>
  </div>
  <br>
  
  <!-- 탭 메뉴 -->
  <ul class="nav nav-tabs tab-menu" id="movieTab" role="tablist">
    <li class="nav-item">
      <a class="nav-link active" id="mainInfo-tab" data-toggle="tab" href="#mainInfo" role="tab">주요정보</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" id="review-tab" data-toggle="tab" href="#review" role="tab">실관람평</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" id="stillcut-tab" data-toggle="tab" href="#stillcut" role="tab">스틸컷</a>
    </li>
  </ul>

  <div class="tab-content mt-4">
    <!-- 주요정보 -->
    <div class="tab-pane fade show active" id="mainInfo" role="tabpanel">
      <p>${movie.description}</p>
    </div>

    <!-- 실관람평 -->
    <div class="tab-pane fade" id="review" role="tabpanel">
      <div class="review-box">
        <!-- 비동기 리뷰 목록 삽입 위치 -->
        <div id="reviewList">
          <p>리뷰 데이터를 불러오는 중...</p>
        </div>

        <!-- 리뷰 작성 -->
        <div class="mt-4">
          <textarea class="form-control review-input mb-2" rows="3" placeholder="리뷰를 입력하세요."></textarea>
          <button class="btn btn-info btn-sm">리뷰 등록</button>
        </div>
      </div>
    </div>

    <!-- 스틸컷 -->
    <div class="tab-pane fade" id="stillcut" role="tabpanel">
      <div id="stillcutList">
        <p>스틸컷 데이터를 불러오는 중...</p>
      </div>
    </div>
  </div>
</div>

<jsp:include page="../common/footer.jsp"/>


<script>
	function getReviews(){
		let reviewList = null; 
		$.ajax({
			url : "${contextRoot}/movies/reviews.mv",
			data : {
				mvId : ${movie.movieId}
			},
			success : function(reviews){
				reviewList = reviews;
				
			},
			error : function(){
				
			}
		});
		return reviewList;
	}
	
	
	$(function(){
		
		$("#mainInfo-tab").on('shown.bs.tab', function(){
			console.log(getReviews());
		});
		
	    // 예: 탭 클릭 시 데이터 로딩
		$('#review-tab').on('shown.bs.tab', function () {
		});
		
	    $('#stillcut-tab').on('shown.bs.tab', function () {
		
	});
  });
</script>
</body>
</html>
