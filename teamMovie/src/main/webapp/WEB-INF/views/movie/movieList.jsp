<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<style>
	  body {
	  background-color: #121212;
	  color: white;
	  font-family: 'Noto Sans KR', sans-serif;
	}

  
	.tab-btn {
	  font-weight: bold;
	  padding: 10px 20px;
	  border: 2px solid #ffffff;
	  color: #ffffff;
	  background-color: #333333; /* 어두운 회색 배경 */
	  transition: all 0.3s ease;
	  border-radius: 30px;
	}
	
	.tab-btn:hover,
	.tab-btn.active {
	  background-color: #d32f2f;
	  color: white;
	  border-color: #d32f2f;
	}

  .form-select,
  .form-control {
    border-radius: 10px;
    background-color: #1e1e1e;
    color: white;
    border: 1px solid #555;
  }

  .form-control::placeholder {
    color: #aaa;
  }

  .btn-danger {
    background-color: #d32f2f;
    border: none;
    font-weight: bold;
  }

  .btn-danger:hover {
    background-color: #b71c1c;
  }
  
  .movie-list {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
  gap: 20px;
  padding: 20px;
  }
	
	.movie-card {
	  background-color: #1e1e1e;
	  color: white;
	  border-radius: 15px;
	  overflow: hidden;
	  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
	  transition: transform 0.2s ease;
	  text-align: center;
	}
	
	.movie-card:hover {
	  transform: translateY(-5px);
	}
	
	.movie-card img {
	  width: 100%;
	  height: 320px;
	  object-fit: cover;
	  border-bottom: 1px solid #333;
	}
	
	.movie-card .card-body {
	  padding: 15px;
	}
	
	.movie-card .movie-title {
	  font-size: 1.1rem;
	  font-weight: bold;
	  margin-bottom: 8px;
	}
	
	.movie-card .movie-release {
	  font-size: 0.9rem;
	  color: #bbb;
	}

   
</style>
</head>
<body>

	<%@ include file="../common/header.jsp" %>
	
	
	<!-- 탭 버튼 영역 -->
	<div class="tab-buttons d-flex justify-content-center my-4 gap-2">
	  <button class="btn btn-outline-light tab-btn" data-status="all">전체</button>
	  <button class="btn btn-outline-light tab-btn" data-status="now">상영 중</button>
	  <button class="btn btn-outline-light tab-btn" data-status="coming">상영 예정</button>
	</div>
	
	<!-- 검색창 영역 -->
	<div class="search-bar bg-dark p-4 rounded shadow-lg text-white mx-auto" style="max-width: 900px;">
	  <form id="searchForm" class="row g-3 align-items-center">
	    <div class="col-md-3">
	      <select id="searchType" class="form-select" name="condition">
	        <option value="" disabled>검색조건</option>
	        <option value="title">제목</option>
	        <option value="director">감독</option>
	        <option value="actor">주연</option>
	        <option value="genre">장르</option>
	      </select>
	    </div>
	    <div class="col-md-6">
	      <input type="text" id="searchKeyword" class="form-control" placeholder="검색어를 입력하세요">
	    </div>
	    <div class="col-md-3 text-end">
	      <button type="button" class="btn btn-danger w-100">검색</button>
	    </div>
	  </form>
	</div>
	
		<!-- 영화 목록 표시 영역 -->
	<div id="movieList" class="movie-list container my-5">
	  <!-- JS로 영화 카드들이 여기에 동적으로 들어올 예정 -->
	</div>

	<script>
		let isLoading = false;
		const limit = 8; //영화 포스터 8개씩 화면에 출력
		let startRow = 1;
		let endRow = 8;
		let currentStatus = 'all';
		let condition = '';
		let keyword = '';
		
		function loadMovies(){
			if(isLoading || endRow > 30){
				return;			
			}
			
			isLoading = true;
			
			$.ajax({
				url : "movies/list.mv",
				data : {
					startRow : startRow, //이번엔 9
					endRow : endRow, //이번엔 16
					currentStatus : currentStatus,
					condition : condition,
					keyword : keyword
				},
				success : function(movieList){
					console.log(movieList); //테스트용
					
					if(movieList.length === 0){ //!movieList 해도 되나?
						isEnd = true;
						return;
					}
					movieList.forEach(function(movie){
						
						let html = '<div class="movie-card">'
								   + '<img src="https://www.themoviedb.org/t/p/w600_and_h900_bestv2/cd8ThAWer67IvETRmRm3NZFdhU2.jpg" alt="Movie Poster">' 
								   + '<div class="card-body">'
								   + '<div class="movie-title">' + movie.movieTitle + '</div>'
								   + '<div class="movie-release">개봉일: ' + movie.releaseDate + '</div>'
								   + '</div>'
								   + '</div>';
								   
						$("#movieList").append(html);
						
					});
					
					startRow += 8;
					endRow = startRow + limit - 1;
					
				},
				error : function(){
					alert("일시적인 오류로 영화를 불러오지 못했습니다");
				},
				complete : function(){
					isLoading = false;
				}
			});
			
		} // loadMovies()함수 정의 끝 부분
		
		
		$(window).on("scroll",function(){
			let nearBottom = $(window).scrollTop() + $(window).height() >= $(document).height() - 100;
			if(nearBottom){
				loadMovies();					
			}
		});
		
		$(function(){
			
			loadMovies();
			
			$(".tab-btn").on("click",function(e){
				$("#movieList").empty();
				startRow = 1;
				endRow = 8;
				let status = $(e.target).data("status");	
				currentStatus = status;
				loadMovies();
			});
			
			$("#searchForm button").on("click",function(){
				$("#movieList").empty();
				keyword = $("#searchKeyword").val().trim();
				if(!keyword){
					alert("검색어를 입력해주세요");
					return;
				}
				startRow = 1;
				endRow = 8;
				condition = $("#searchType").val();
				loadMovies();
			});
			
			
		});
	</script>
	
	
	
	
	
	
	
	
	
	
	

<jsp:include page="../common/footer.jsp"/>
</body>

</html>