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
    
    /* 스틸컷 그리드 레이아웃 */
	.stillCut-grid {
	  display: grid;
	  grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
	  gap: 15px;
	}
	.stillCut-grid img {
	  width: 100%;
	  border-radius: 10px;
	  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.5);
	}
	
	 .star-rating {
    direction: rtl;
    font-size: 2rem;
    unicode-bidi: bidi-override;
    display: inline-flex;
  }

  .star-rating input {
    display: none;
  }

  .star-rating label {
    color: #ccc;
    cursor: pointer;
  }

  .star-rating input:checked ~ label,
  .star-rating label:hover,
  .star-rating label:hover ~ label {
    color: gold;
  }
  
  .form-checker-label{
  	color: white;
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
      <a class="nav-link" id="stillCut-tab" data-toggle="tab" href="#stillCut" role="tab">스틸컷</a>
    </li>
  </ul>

  <div class="tab-content mt-4">
    <!-- 주요정보 -->
    <div class="tab-pane fade show active" id="mainInfo" role="tabpanel">
    </div>

    <!-- 실관람평 -->
    <div class="tab-pane fade" id="review" role="tabpanel">
      <div class="review-box">
       

	    <!-- 리뷰 작성 -->
		<div class="mt-4">
		
		<c:choose>
		  	<c:when test="${not empty loginUser}">
			    <textarea class="form-control review-input mb-2" style="resize:none;" rows="3" placeholder="리뷰를 입력하세요."></textarea>
		  	</c:when>
		  	<c:otherwise>
		  		<textarea class="form-control review-input mb-2 disabled" style="resize:none;" rows="3" placeholder="로그인 후 이용 가능한 서비스입니다." disabled></textarea>
		  	</c:otherwise>
		  </c:choose>
		  <!-- 평가 기준 -->
		  <div id="reviewCriteriaBox" class="mb-2">
		  <c:forEach var="c" items="${movie.criteria}">
		  		  <div class="form-check form-check-inline">
		  		  	<c:choose>
		  		  		<c:when test="${not empty loginUser }">
			  		  		 <input class="form-check-input" type="checkbox" name="reviewCriteria" value="${c.criteriaId}" id="criteria_${c.criteriaId}">
		  		  		</c:when>
		  		  		<c:otherwise>
		  		  			 <input disabled class="form-check-input" type="checkbox" name="reviewCriteria" value="${c.criteriaId}" id="criteria_${c.criteriaId}">
		  		  		</c:otherwise>
		  		  	</c:choose>
			           		 <label class="form-checker-label" for="criteria_${c.criteriaId}">${c.criteria}</label>
		           
		          </div>
		  </c:forEach>
			  </div>
		  
	      <!-- 평점 선택 -->
		  <div class="form-group mb-2">
		  <label>평점</label>
		  <div class="star-rating">
		  	<c:choose>
		  		<c:when test="${not empty loginUser}">
				    <input type="radio" name="rating" id="star10" value="10"><label for="star10">★</label>
				    <input type="radio" name="rating" id="star9" value="9"><label for="star9">★</label>
				    <input type="radio" name="rating" id="star8" value="8"><label for="star8">★</label>
				    <input type="radio" name="rating" id="star7" value="7"><label for="star7">★</label>
				    <input type="radio" name="rating" id="star6" value="6"><label for="star6">★</label>
				    <input type="radio" name="rating" id="star5" value="5"><label for="star5">★</label>
				    <input type="radio" name="rating" id="star4" value="4"><label for="star4">★</label>
				    <input type="radio" name="rating" id="star3" value="3"><label for="star3">★</label>
				    <input type="radio" name="rating" id="star2" value="2"><label for="star2">★</label>
				    <input type="radio" name="rating" id="star1" value="1"><label for="star1">★</label>
		  		</c:when>
		  		<c:otherwise>
		  			<input disabled type="radio" name="rating" id="star10" value="10"><label for="star10">★</label>
				    <input disabled type="radio" name="rating" id="star9" value="9"><label for="star9">★</label>
				    <input disabled type="radio" name="rating" id="star8" value="8"><label for="star8">★</label>
				    <input disabled type="radio" name="rating" id="star7" value="7"><label for="star7">★</label>
				    <input disabled type="radio" name="rating" id="star6" value="6"><label for="star6">★</label>
				    <input disabled type="radio" name="rating" id="star5" value="5"><label for="star5">★</label>
				    <input disabled type="radio" name="rating" id="star4" value="4"><label for="star4">★</label>
				    <input disabled type="radio" name="rating" id="star3" value="3"><label for="star3">★</label>
				    <input disabled type="radio" name="rating" id="star2" value="2"><label for="star2">★</label>
				    <input disabled type="radio" name="rating" id="star1" value="1"><label for="star1">★</label>
		  		</c:otherwise>
		  	</c:choose>
	       </div>
		   </div>
		   
		  	<c:if test="${not empty loginUser}">
		      	<button class="btn btn-info btn-sm">리뷰 등록</button>
		  	</c:if>
	    </div>
	    <br>
		 <!-- 비동기 리뷰 목록 삽입 위치 -->
        <div id="reviewList">
        
        </div>
	      </div>
    </div>

    <!-- 스틸컷 -->
    <div class="tab-pane fade" id="stillCut" role="tabpanel">
      <div id="stillCutList" class="stillCut-grid">
      </div>
    </div>
  </div>
</div>

<jsp:include page="../common/footer.jsp"/>


<script>

	$(function(){
		
		
		getReviews();
		
		
		$("#mainInfo-tab").on('shown.bs.tab', function(){
			getReviews();
		});
		
		$('#review-tab').on('shown.bs.tab', function () {
			getReviews();
		});
		
	    $('#stillCut-tab').on('shown.bs.tab', function () {
			getStillCuts();
		});
	    
	    //리뷰 등록 이벤트 핸들러
	    $('#review button').on('click', function(){
	    	const reviewContent = $("#review textarea").val(); //리뷰 내용
	    	const reviewRating = $("input[name=rating]:checked").val(); //리뷰 평점
	    	const memberNo = "${loginUser.memberNo}"; //리뷰 작성자 no
	    	const movieId = ${movie.movieId}; //참조 movieId
	    	let checkedCriteria = [];
	    	$("input[name=reviewCriteria]:checked").each(function () {
	    	  checkedCriteria.push($(this).val());
	    	});
	    	
	    	$.ajax({
	    		url : "${contextRoot}/movies/registerReview.mv",
	    		data : {
	    			movieId : movieId,
	    			reviewContent : reviewContent,
	    			reviewRating : reviewRating,
	    			memberNo : memberNo,
	    			selectedCriterionId : checkedCriteria
	    		},
	    		traditional: true, // 이걸 써줘야 배열이 올바르게 전송(직렬화 구버전)
	    		type: 'POST',    
	    		success : function(result){
	    			if(result > 0){ //리뷰 등록 성공시
	    				$("input[name=rating]").prop("checked",false);
	    				$("input[name=reviewCriteria]").each(function (index,criteria) {
	    			    	  $(criteria).prop("checked",false);
	    			    	});
	    				$("#review textarea").val("");
	    				getReviews();
	    			}else{
	    				alert("서버 오류로 인해 리뷰 등록에 실패하였습니다");
	    				console.log("db접근 실패(result == 0)");
	    			}
	    		},
	    		error : function(){
	    			alert("서버 오류로 인해 리뷰 등록에 실패하였습니다");
	    			console.log("error함수 실행됨(서버 비동기 통신 자체 실패)");
	    		}
	    	});
	    })
	});
	
	function getReviews(){
		
		
		$.ajax({
			url : "${contextRoot}/movies/reviews.mv",
			data : {
				mvId : ${movie.movieId}
			},
			success : function(reviews){
				let html = "";		
				
				reviews.forEach(function(review){
					let criteriaHtml = "";
					review.criteria.forEach(function(criterion){
							criteriaHtml += "<span class='badge badge-secondary mr-1'>" + criterion.criteria + "</span>";
					});
					
			        html += "<div class='review-item bg-dark text-light p-3 mb-3 rounded'>";
			        html += "  <div class='d-flex justify-content-between align-items-center mb-2'>";
			        html += "    <strong>" + review.reviewWriter + "</strong>";
			        html += "    <span class='badge badge-info'>평점: " + review.reviewRating + "</span>";
			        html += "  </div>";
			        html += "  <div class='mb-2'>" + criteriaHtml + "</div>";
			        html += "  <p class='mb-0'>" + review.reviewContent + "</p>";
			        html += "</div>";
					
					
				});				
				$("#reviewList").html(html);
				//summernote는 큰따옴표로 속성값이 묶이는 관계로 작은 따옴표 사용해서 문자열 결합
				$("#mainInfo").html('${movie.description}<br><br><br>' + html); 
				
			},
			error : function(){
				$("#reviewList").html("<p class='text-danger'>리뷰를 불러오는 데 실패했어요 😢</p>");
			}
		});
		
	}
	
	function getStillCuts(){
		$.ajax({
			url : "${contextRoot}/movies/stillCuts.mv",
			data : {
				mvId : ${movie.movieId}
			},
			success : function(stillCuts){
				console.log(stillCuts);
				let html = "";
				stillCuts.forEach(function(stillCut){
					html += "<img src='https://media.themoviedb.org/t/p/w500_and_h282_face/bZiuynt0RzxldXScTJCPfDEvRhI.jpg' alt='엑박'>";
				});
				$("#stillCutList").html(html);
			},
			error : function(){
				$("#stillCutList").html("<p class='text-danger'>화면을 불러오는 데 실패했어요 😢</p>");
			}
		});
	}
	
	
	

</script>
</body>
</html>
