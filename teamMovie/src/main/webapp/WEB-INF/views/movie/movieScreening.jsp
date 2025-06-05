<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>전체영화 목록</title>


  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

  <style>
    body {
      background-color: #121212;
      color: white;
      font-family: 'Noto Sans KR', sans-serif;
    }

    .search-bar {
      background-color: #1e1e1e;
      padding: 20px;
      border-radius: 10px;
      margin: 20px 0;
    }

    .form-select,
    .form-control {
      background-color: #2a2a2a;
      border: 1px solid #555;
      color: white;
    }

    .form-control::placeholder {
      color: #aaa;
    }

    .btn-danger {
      background-color: #d32f2f;
      border: none;
    }

    .btn-danger:hover {
      background-color: #b71c1c;
    }

    .movie-list {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
      gap: 20px;
      padding: 20px 0;
    }

    .movie-card {
      background-color: #1e1e1e;
      border-radius: 15px;
      overflow: hidden;
      text-align: center;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.5);
      transition: transform 0.2s ease;
    }

    .movie-card:hover {
      transform: translateY(-5px);
    }

    .movie-card img {
      width: 100%;
      height: 300px;
      object-fit: cover;
    }

    .movie-title {
      font-weight: bold;
      margin-top: 10px;
    }

    .movie-release {
      font-size: 0.9rem;
      color: #ccc;
    }
    
     .movie-tab-menu {
    font-size: 1.2rem; /* 글자 크기 크게 */
    margin-top: 20px;
    margin-bottom: 30px;
  }

  .movie-tab-menu .nav-link {
    padding: 12px 25px; /* 버튼 크기 크게 */
    border-radius: 8px;
    color: #333;
    font-weight: 500;
    transition: background-color 0.3s, color 0.3s;
  }

  .movie-tab-menu .nav-link.active {
    background-color: #dc3545; /* 붉은 배경 강조 */
    color: #fff;
    font-weight: 700;
  }

  .movie-tab-menu .nav-link:hover {
    background-color: #f8d7da;
    color: #dc3545;
  }
  </style>
</head>
<body>

  <%@ include file="../common/header.jsp" %>
  
	<!-- 영화 탭 메뉴 -->
	<ul class="nav nav-tabs justify-content-center movie-tab-menu">
	  <li class="nav-item">
	    <a class="nav-link" href="${contextRoot}/movies">전체 영화</a>
	  </li>
	  <li class="nav-item">
	    <a class="nav-link active" href="${contextRoot}/movies/screening">상영 중</a>
	  </li>
	  <li class="nav-item">
	    <a class="nav-link" href="${contextRoot}/movies/coming">상영 예정</a>
	  </li>
	</ul>

  

  <div class="container">

    <!-- 검색 바 -->
    <div class="search-bar">
      <form class="form-inline row" id="searchFormAll">
        <div class="form-group col-md-3">
          <select class="form-control w-100" name="condition">
            <option value="title">제목</option>
            <option value="director">감독</option>
            <option value="actor">배우</option>
            <option value="genre">장르</option>
          </select>
        </div>
        <div class="form-group col-md-6">
          <input type="text" class="form-control w-100" name="keyword" placeholder="검색어 입력">
        </div>
        <div class="form-group col-md-3">
          <button type="button" class="btn btn-danger w-100">검색</button>
        </div>
      </form>
    </div>

    <!-- 영화 리스트 -->
   <div class="container">
  <div class="row" id="movieListAll"></div>
	</div>
    
  </div>
  
  <script>
  	let isLoading = false;
  	let isEnd = false;
  	let page = 1;
  
  	function loadMoviesAll(){
  		if(isLoading || isEnd){ //로드중이거나 데이터 없을 시
  			return;
  		}
  		
  		isLoading = true;
  		$.ajax({
  			url : "${contextRoot}/movies/all.mv",
  			data : {
  				page : page	
  			},
  			success : function(movieList){
  				console.log(movieList);
  				if(movieList.length === 0){
  					$("#movieListAll").append("<div>더 이상 불러올 영화가 없습니다</div>");
  					isEnd = true;
  					return;
  				}
  				movieList.forEach(function(movie){
	  					$("#movieListAll").append(
						  						  '<div class="col-lg-3 col-md-4 col-sm-6 mb-4">' +
						  						    '<div class="card shadow-sm">' +
						  						      '<div style="height: 400px; overflow: hidden;">' + // 이미지 컨테이너
						  						        '<img src="https://www.themoviedb.org/t/p/w600_and_h900_bestv2/abeH7n5pcuQcwYcTxG6DTZvXLP1.jpg" ' +
						  						             'class="card-img-top" alt="" style="width: 100%; height: 100%; object-fit: cover;">' +
						  						      '</div>' +
						  						      '<div class="card-body d-flex flex-column">' +
						  						        '<h5 class="card-title text-truncate">' + movie.movieTitle + '</h5>' +
						  						        '<p class="card-text">' +
						  						          '<small class="text-muted">개봉일: ' + movie.releaseDate + '</small>' +
						  						        '</p>' +
						  						        '<div class="mt-auto">' +
						  						          '<a href="movieDetail.mv?movieId=' + movie.movieId + '" class="btn btn-primary btn-sm btn-block">예매하기</a>' +
						  						        '</div>' +
						  						      '</div>' +
						  						    '</div>' +
						  						  '</div>'
						  						 );


  				});
  				
  				page++;
  				
  			},
  			error : function(){
  				alert("일시적인 오류로 영화를 불러오지 못했습니다");
  			},
  			complete : function(){
  				isLoading = false;
  			}
  		});//비동기통신 끝		
  	}//loadMoviesAll() 끝
  	
  	$(window).on("scroll",function(){
  		let nearBottom = $(window).scrollTop() + $(window).height() > $(document).height() - 300;
  		if(nearBottom) {
  			loadMoviesAll();
  		}
  	});
  	
  	$(function(){
  		
  		loadMoviesAll();
  		
  		$()
  	});
  </script>

  <%@ include file="../common/footer.jsp" %>
  
  
  
  
  
  
  
  
  

</body>
</html>
