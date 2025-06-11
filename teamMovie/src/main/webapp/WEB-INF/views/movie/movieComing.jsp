<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>전체영화 목록</title>

  <%@ include file="../common/header.jsp" %>
  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
  <!-- Font Awesome 아이콘 추가 -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  
 <style>
  /* 전체 폰트 및 배경 스타일 */
  body {
    font-family: 'Noto Sans KR', sans-serif;
    background-color: #121212;
    color: #fff;
  }

  .movie-tab-menu {
    margin-top: 30px;
  }

  .nav-tabs .nav-link {
    color: #ccc;
    font-size: 1.1rem;
    transition: all 0.3s;
  }

  .nav-tabs .nav-link.active {
    background-color: #dc3545;
    color: white;
    border-radius: 5px;
  }

  .nav-tabs .nav-link:hover {
    color: white;
  }

  .search-bar {
    margin: 30px auto;
    padding: 20px;
    border-radius: 10px;
    background-color: #1e1e1e;
  }

  .form-control,
  .btn {
    border-radius: 8px;
  }

  .alert-box {
    text-align: center;
    padding: 30px;
    font-size: 1.2rem;
    color: #ccc;
  }

  /* 영화 카드 스타일 */
  .card {
    background-color: #1f1f1f;
    border: none;
    transition: transform 0.3s ease;
    opacity: 0;
    transform: translateY(50px);
    animation: fadeInUp 0.6s forwards;
  }

  /* 카드 등장 애니메이션 */
  @keyframes fadeInUp {
    to {
      opacity: 1;
      transform: translateY(0);
    }
  }

  .card:hover {
    transform: scale(1.03);
    box-shadow: 0 8px 16px rgba(255, 255, 255, 0.1);
  }

  .card-title {
    color: #fff;
    font-size: 1.1rem;
  }

  .card-img-top {
    height: 400px;
    object-fit: cover;
    border-top-left-radius: 0.5rem;
    border-top-right-radius: 0.5rem;
  }

  /* 부드러운 카드 애니메이션 지연 효과 (왼쪽부터 순차적으로) */
  #movieListAll > div {
    animation: fadeInUp 0.6s forwards;
  }

  #movieListAll > div:nth-child(4n+1) {
    animation-delay: 0s;
  }

  #movieListAll > div:nth-child(4n+2) {
    animation-delay: 0.1s;
  }

  #movieListAll > div:nth-child(4n+3) {
    animation-delay: 0.2s;
  }

  #movieListAll > div:nth-child(4n+4) {
    animation-delay: 0.3s;
  }

  #loadingSpinner {
    margin: 30px auto;
    font-size: 1.2rem;
  }
  
    .movie-card {
    background-color: #1f1f1f;
    border: none;
    position: relative;
    transition: transform 0.3s ease;
    opacity: 0;
    transform: translateY(50px);
    animation: fadeInUp 0.6s forwards;
  }

  .movie-card:hover {
    transform: scale(1.03);
    box-shadow: 0 8px 16px rgba(255, 255, 255, 0.1);
  }

  .poster-wrapper {
    position: relative;
    cursor: pointer;
  }

  .poster-img {
    height: 400px;
    object-fit: cover;
    width: 100%;
    border-top-left-radius: 0.5rem;
    border-top-right-radius: 0.5rem;
    display: block;
  }

  .overlay {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.75);
    opacity: 0;
    color: white;
    transition: opacity 0.3s ease;
    border-radius: 0.5rem;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 15px;
    text-align: center;
  }

  .poster-wrapper:hover .overlay {
    opacity: 1;
  }

  .summary-text {
    font-size: 0.9rem;
    line-height: 1.4;
  }

  @keyframes fadeInUp {
    to {
      opacity: 1;
      transform: translateY(0);
    }
  }
  
  .reserve-btn {
  display: inline-block;
  padding: 8px 20px;
  background-color: #ff4d4f;
  color: #fff;
  font-size: 14px;
  font-weight: bold;
  border: none;
  border-radius: 4px;
  text-decoration: none;
  text-align: center;
  cursor: pointer;
  transition: background 0.4s ease-in-out, transform 0.2s ease;

  /* 링크 스타일 제거 */
  outline: none;
}

.reserve-btn:hover {
  background: linear-gradient(45deg, #ff4d4f, #ff6a00); /* 그라데이션 효과 */
  transform: translateY(-1px);  /* 살짝 떠오르는 느낌 */
  text-decoration: none;        /* 밑줄 제거 */
  color: #fff;                  /* 글자색 유지 */
}
  .rating-tag {
    display: inline-block;
    font-weight: 600;
    font-size: 0.85rem;
    color: #fff;
    padding: 0.25em 0.7em;
    border-radius: 4px;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    user-select: none;
    box-shadow: 0 2px 6px rgba(0,0,0,0.15);
    margin-right: 0.5em;
    letter-spacing: 0.03em;
    text-align: center;
    min-width: 32px;
  }

  .all {
    background: linear-gradient(135deg, #2ecc71, #27ae60);
    box-shadow: 0 3px 8px rgba(39, 174, 96, 0.6);
  }
  .twelve {
    background: linear-gradient(135deg, #3498db, #2980b9);
    box-shadow: 0 3px 8px rgba(41, 128, 185, 0.6);
  }
  .fifteen {
    background: linear-gradient(135deg, #e67e22, #d35400);
    box-shadow: 0 3px 8px rgba(211, 84, 0, 0.6);
  }
  .nineteen {
    background: linear-gradient(135deg, #e74c3c, #c0392b);
    box-shadow: 0 3px 8px rgba(192, 57, 43, 0.6);
  }

  
</style>
</head>
<body>


  

  
	<!-- 영화 탭 메뉴 -->
	<ul class="nav nav-tabs justify-content-center movie-tab-menu">
	  <li class="nav-item">
	    <a class="nav-link" href="${contextRoot}/movies">전체 영화</a>
	  </li>
	  <li class="nav-item">
	    <a class="nav-link" href="${contextRoot}/movies/screening">상영 중</a>
	  </li>
	  <li class="nav-item">
	    <a class="nav-link active" href="${contextRoot}/movies/coming">상영 예정</a>
	  </li>
	</ul>

  

  <div class="container">

    <!-- 검색 바 -->
    <div class="search-bar">
      <form class="form-inline row" id="searchFormAll">
        <div class="form-group col-md-3">
          <select class="form-control w-100" id="condition">
            <option value="title">제목</option>
            <option value="director">감독</option>
            <option value="actor">배우</option>
            <option value="genre">장르</option>
          </select>
        </div>
        <div class="form-group col-md-6">
          <input type="text" class="form-control w-100" id="keyword" placeholder="검색어 입력">
        </div>
        <div class="form-group col-md-3">
          <button type="submit" class="btn btn-danger w-100">검색</button>
        </div>
      </form>
    </div>

    

    	
    		
    	
    	
    

    <!-- 영화 리스트 -->
   <div class="container" id="movieBox">
  		<div class="row" id="movieListAll">
  			
  		</div>
  		<div id="loadingSpinner" style="display: none; text-align: center; color: #999;">
			  <i class="fas fa-spinner fa-spin"></i> 불러오는 중...
		</div>
   </div>
    
  </div>
  
  <script>
  	let isLoading = false;
  	let isEnd = false;
  	let page = 1;
  	let keyword = '';
  	let condition = '';
  	
  	let count = 0; //검색용(검색시에 영화 누적개수 0이면 출력할 내용 따로 정의하기 위함)
  
  	function loadMoviesAll(){
  		if(isLoading || isEnd){ //로드중이거나 데이터 없을 시
  			return;
  		}
  		
  		isLoading = true;
  		$("#loadingSpinner").show();
  		$.ajax({
  			url : "${contextRoot}/movies/coming.mv",
  			data : {
  				page : page	
  			},
  			success : function(movieList){
  				
  				if(movieList.length === 0){
  					$("#movieBox").append('<div class="alert-box">'
											+ '<i class="fas fa-film"></i> 더 이상 불러올 영화가 없습니다.'
											+ '</div>');
  					isEnd = true;
  					return;
  				}
  				movieList.forEach(function(movie){
  					console.log(movie);
  					console.log(movie.movieTitle);
	  					$("#movieListAll").append(
					  							'<div class="col-md-3 mb-4">' +
											    '<div class="card movie-card h-100">' +
											      '<div class="poster-wrapper" data-id="' + movie.movieId + '">' +
												    '<a href="${contextRoot}/movies/detail.mv?mvId=' + movie.movieId + '">' +
											        '<img src="https://www.themoviedb.org/t/p/w600_and_h900_bestv2/fDu0T5WE0QAoX2yAqZ1RtlWBn6I.jpg" class="card-img-top poster-img" alt="' + movie.movieTitle + '">' +
											        '<div class="overlay">' +
											          '<div class="summary-text">' + movie.description + '</div>' +
											        '</div>' +
											        '</a>' +
											      '</div>' +
											      '<div class="card-body text-center">' +
											        '<h5 class="card-title" id="' + movie.movieId + '">' + movie.movieTitle + '</h5>' +
											        '<p class="card-text text-muted">' + movie.releaseDate + '</p>' +
											        '<a href="${contextRoot}/reserve.mv?mvId=' + movie.movieId + '" class="reserve-btn">예매하기</a>' +
											      '</div>' +
											    '</div>' +
											  '</div>'
						  						 );
	  					
	  					if(movie.rating === '전체'){
							$("#" + movie.movieId).prepend('<span class="rating-tag all">전체</span>');
						}else if(movie.rating === '12세'){
							$("#" + movie.movieId).prepend('<span class="rating-tag twelve">12세</span>');
						}else if(movie.rating === '15세'){
							$("#" + movie.movieId).prepend('<span class="rating-tag fifteen">15세</span>');
						}else{
							$("#" + movie.movieId).prepend('<span class="rating-tag nineteen">19세</span>');
						} 


  				});
  				
  				page++;
  				
  			},
  			error : function(){
  				alert("일시적인 오류로 영화를 불러오지 못했습니다");
  			},
  			complete : function(){
  				isLoading = false;
  				$("#loadingSpinner").hide();
  			}
  		});//비동기통신 끝		
  	}//loadMoviesAll() 끝
  	
  	function loadSearchOfAllMovies(){
  		
  		
  		if(isLoading || isEnd){
  			return;
  		}
  		
		condition = $("#condition").val();
		
		isLoading = true;
		
		$.ajax({
			url : "${contextRoot}/movies/searchOfComing.mv",
			data : {
				page : page,
				condition : condition,
				keyword : keyword
			},
			success : function(movieList){
				
				count += movieList.length;
				
				if(movieList.length === 0 && count === 0){
					$("#movieBox").append('<div class="alert-box">'
							                + '<i class="fas fa-exclamation-circle"></i> 해당 조건에 맞는 영화가 존재하지 않습니다.'
							  				+ '</div>');
  					isEnd = true;
  					return;
				}else if(movieList.length === 0){
					$("#movieBox").append('<div class="alert-box">'
											+ '<i class="fas fa-film"></i> 더 이상 불러올 영화가 없습니다.'
											+ '</div>');
  					isEnd = true;
  					return;
				}
				
				movieList.forEach(function(movie){
					$("#movieListAll").append(
											'<div class="col-md-3 mb-4">' +
										    '<div class="card movie-card h-100">' +
										      '<div class="poster-wrapper" data-id="' + movie.movieId + '">' +
										      	'<a href="${contextRoot}/movies/detail.mv?mvId=' + movie.movieId + '">' +
										        '<img src="https://www.themoviedb.org/t/p/w600_and_h900_bestv2/fDu0T5WE0QAoX2yAqZ1RtlWBn6I.jpg" class="card-img-top poster-img" alt="' + movie.movieTitle + '">' +
										        '<div class="overlay">' +
										          '<div class="summary-text">' + movie.description + '</div>' +
										        '</div>' +
										        '</a>' +
										      '</div>' +
										      '<div class="card-body text-center">' +
										        '<h5 class="card-title" id="' + movie.movieId + '">' + movie.movieTitle + '</h5>' +
										        '<p class="card-text text-muted">' + movie.releaseDate + '</p>' +
										        '<a href="${contextRoot}/reserve.mv?mvId=' + movie.movieId + '" class="reserve-btn">예매하기</a>' +
										      '</div>' +
										    '</div>' +
										  '</div>'
					  						 );
					if(movie.rating === '전체'){
						$("#" + movie.movieId).prepend('<span class="rating-tag all">전체</span>');
					}else if(movie.rating === '12세'){
						$("#" + movie.movieId).prepend('<span class="rating-tag twelve">12세</span>');
					}else if(movie.rating === '15세'){
						$("#" + movie.movieId).prepend('<span class="rating-tag fifteen">15세</span>');
					}else{
						$("#" + movie.movieId).prepend('<span class="rating-tag nineteen">19세</span>');
					} 
						
			});
			
			
			page++;
			},
			error : function(){
				alert("일시적인 오류로 영화를 불러오지 못했습니다");
			},
			complete : function(){
				isLoading = false;
			}
			
		});
  	}
  	
  	$(window).on("scroll",function(){
  		let nearBottom = $(window).scrollTop() + $(window).height() > $(document).height() - 300;
  		if(nearBottom) {
  			loadMoviesAll();
  		}
  	});
  	
  	$(function(){
  		
  		loadMoviesAll();
  		
  		$("#searchFormAll").submit(function(e){
  			
  			e.preventDefault();
  			
  			keyword = $("#keyword").val().trim();
  			
  			if(keyword === ''){
  				alertMsg("검색어를 입력해주세요");
  				return;
  			}
  			
  			count = 0;
  			$("#movieListAll").empty();
  			$("#loadingSpinner").next().remove();
  			//이제 검색흐름만 진행
  			//어차피 탭 눌러야 다시 검색 초기화됨
  			$(window).off("scroll");
  			$(window).on("scroll",function(){
  		  		let nearBottom = $(window).scrollTop() + $(window).height() > $(document).height() - 300;
  		  		if(nearBottom) {
  		  			loadSearchOfAllMovies();
  		  		}
  		  	});
  			page = 1;
  			isLoading = false;
  			isEnd = false;
  			loadSearchOfAllMovies();
  			
  	  	  });
  	});
  	
  
  	
  	
  	
  	
  </script>

  <%@ include file="../common/footer.jsp" %>
  
  
  
  
  
  
  
  
  

</body>
</html>
