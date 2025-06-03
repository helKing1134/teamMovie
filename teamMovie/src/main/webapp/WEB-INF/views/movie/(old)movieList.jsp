<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>영화 목록</title>
  <!-- 필수: Bootstrap JS + Popper -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <style>
    body {
      background-color: #f5f5f5;
      font-family: 'Segoe UI', sans-serif;
    }

    h2 {
      font-weight: 700;
    }

    .nav-tabs .nav-link {
      font-size: 16px;
      font-weight: 500;
      color: #555;
      border: none;
    }

    .nav-tabs .nav-link.active {
      background-color: #0d6efd;
      color: white;
      font-weight: bold;
      border-radius: 5px 5px 0 0;
      box-shadow: inset 0 -3px 0 rgba(255, 255, 255, 0.6);
    }

    .movie-card {
      background-color: white;
      border-radius: 12px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
      padding: 15px;
      margin-bottom: 30px;
      transition: transform 0.2s;
      position: relative;
    }

    .movie-card:hover {
      transform: translateY(-5px);
    }

    .movie-img {
      width: 100%;
      height: 330px;
      object-fit: cover;
      border-radius: 10px;
    }

    .movie-title {
      font-size: 18px;
      font-weight: bold;
      margin-top: 12px;
      color: #333;
    }

    .movie-desc {
      font-size: 14px;
      color: #666;
      margin-top: 5px;
    }

    @media (max-width: 768px) {
      .movie-img {
        height: 250px;
      }
    }
    
    #loading {
      text-align: center;
      padding: 20px;
      display: none;
    }
    
    .movie-card button.btn-primary:hover {
	  background-color: #0b5ed7;
	  box-shadow: 0 6px 16px rgba(13, 110, 253, 0.6);
	  transform: translateY(-2px);
	}
    /* 선택박스(select)를 좀 더 둥글고 깔끔하게 */
  #searchCategory {
    border-radius: 8px;
    padding: 6px 12px;
    border: 1px solid #ced4da;
    background-color: #fff;
    font-size: 1rem;
    height: 40px;
  }

  /* 인풋창 스타일도 조금 더 부드럽게 */
  #searchKeyword {
    border-radius: 8px;
    height: 40px;
    font-size: 1rem;
  }

  /* 버튼 스타일도 약간만 수정 */
  #searchBtn {
    height: 40px;
    border-radius: 8px;
    font-weight: 500;
    transition: background-color 0.2s ease;
  }

  #searchBtn:hover {
    background-color: #0b5ed7;
  }

  /* 반응형을 위한 여유 */
  @media (max-width: 576px) {
    #searchKeyword {
      width: 100% !important;
    }
    #searchCategory {
      width: 100% !important;
    }
    #searchBtn {
      width: 100%;
    }
  }
  </style>
  
  
</head>
<body>

<%@ include file="../common/header.jsp" %>

<div class="container my-5">
  <h2 class="text-center mb-4">영화 목록</h2>

  <!-- 탭 메뉴 -->
  <ul class="nav nav-tabs justify-content-center" id="movieTab" role="tablist">
    <li class="nav-item" role="presentation">
      <button class="nav-link active" id="all-tab" data-bs-toggle="tab" data-bs-target="#all" type="button" role="tab">전체</button>
    </li>
    <li class="nav-item" role="presentation">
      <button class="nav-link" id="now-tab" data-bs-toggle="tab" data-bs-target="#now" type="button" role="tab">현재상영작</button>
    </li>
    <li class="nav-item" role="presentation">
      <button class="nav-link" id="soon-tab" data-bs-toggle="tab" data-bs-target="#soon" type="button" role="tab">상영예정작</button>
    </li>
  </ul>
  
	<!-- 검색 영역 -->
	<div class="container my-4">
	  <div class="d-flex justify-content-center align-items-center gap-2 flex-wrap">
	    
	    <!-- 검색 조건 선택 -->
	    <select class="form-select w-auto" id="searchCategory" style="min-width: 150px;">
	      <option value="title">영화명</option>
	      <option value="actor">주연</option>
	      <option value="genre">장르</option>
	      <option value="director">감독</option>
	    </select>
	    
	    <!-- 검색 키워드 입력 -->
	    <input type="text" class="form-control" id="searchKeyword" placeholder="검색어를 입력하세요" style="width: 250px;">
	    
	    <!-- 검색 버튼 -->
	    <button type="button" id="searchBtn" class="btn btn-primary px-4">검색</button>
	  </div>
	</div>
	
	
		
	
  
  <!-- 탭 콘텐츠 -->
  <div class="tab-content mt-4" id="movieTabContent">
    <div class="tab-pane fade show active" id="all" role="tabpanel">
      <div class="row" id="allMovieContainer">
        <!-- JS로 영화 카드 삽입 -->
      </div>
      
      <div id="loading-all">로딩 중...</div>
    </div>

    <div class="tab-pane fade" id="now" role="tabpanel">
      <div class="row" id="nowMovieContainer">
        <!-- JS로 영화 카드 삽입 -->
      </div>
      
      <div id="loading-now">로딩 중...</div>
    </div>

    <div class="tab-pane fade" id="soon" role="tabpanel">
      <div class="row" id="soonMovieContainer">
        <!-- JS로 영화 카드 삽입 -->
      </div>
      
      <div id="loading-soon">로딩 중...</div>
    </div>
  </div>

</div>



<!-- 영화 목록 관련 JS -->
<script>
  // written by 이수한
  // 무한스크롤 방식으로 스크롤 내릴때마다 영화 목록이 나오도록 구현해봤습니다.
  
  // 무한스크롤 비동기통신 구현 
  	
  	let allState = {page : 1, isLoading : false, isEnd : false}; //전체 영화 목록 조회시 필요한 상태값 객체
  	let nowState = {page : 1, isLoading : false, isEnd : false}; //상영중인 영화 목록 조회시 필요한 상태값 객체
  	let soonState = {page : 1, isLoading : false, isEnd : false}; //상영예정 영화 목록 조회시 필요한 상태값 객체
  	
  	let allSearchState = {page : 1, isLoading : false, isEnd : false}; 
  	let nowSearchState = {page : 1, isLoading : false, isEnd : false}; 
  	let soonSearchState = {page : 1, isLoading : false, isEnd : false}; 
   	
  	
  	$(function(){
  		//영화목록 페이지 도달시
  		//'전체' 탭 활성화되니 'movies/all'로 비동기 통신 바로 요청
  		//받아온 영화 목록 개수만큼 사용자 화면에 출력됨
	  	loadMovies(allState,'movies/all','#allMovieContainer','#loading-all'); 
  		
  		//무한스크롤 이벤트 핸들러 설정
	  	setScrollEvent(allState,'movies/all','#allMovieContainer');
  		
  		searchBtnClick("#all");
  		
	  	
	  	//(in 부트스트랩) shown.bs.tab = 탭활성화 이후 자동 실행되는 이벤트
	  	//탭버튼 '활성화'(사용자 입장에서는 '클릭') 시 실행될 이벤트 핸들러 정의
  		$('#movieTab button').on('shown.bs.tab', function (event) {
  			
  		  $("#searchBtn").off('click');		
 		  $(window).off('scroll'); //기존 스크롤 이벤트 핸들러 제거
 		  
 		  //클릭된 탭(HTML 요소: button)의 data-bs-target 속성
 		  //이 target 속성값은 이 button과 연결된 div의 id값이니
 		  //button의 id값이라고 생각하셔도 좋습니다.
 		  
 		  const targetId = $(event.target).attr('data-bs-target'); 

  		  if (targetId === '#all') { //'전체' 탭 누름
  			
  			searchBtnClick("#all");
  			loadMovies(allState,'movies/all','#allMovieContainer','#loading-all');
  		  	setScrollEvent(allState,'movies/all','#allMovieContainer');
  		  	
  		  } else if (targetId === '#now') { //'현재상영작' 탭 누름
  			  
			searchBtnClick("#now"); 			  
  			loadMovies(nowState,'movies/now','#nowMovieContainer','#loading-now');
  		  	setScrollEvent(nowState,'movies/now','#nowMovieContainer');
  		  	
  		  } else if (targetId === '#soon') { //'상영예정작' 탭 누름
			
  			searchBtnClick("#soon");  
   			loadMovies(soonState,'movies/soon','#soonMovieContainer','#loading-soon');
  		  	setScrollEvent(soonState,'movies/soon','#soonMovieContainer');
  		  }
  		});
  		
  		//스크롤 이벤트 핸들러 정의
  		function setScrollEvent(state,url,container){
  			$(window).on('scroll',function(){
  				//바닥에 닿기 직전에만!!(전체높이 - 300px)
	  			if($(window).scrollTop() + $(window).height() >= $(document).height() - 300){
		   			loadMovies(state,url,container,'#loading-' + url.split('/')[1]);
				}
  			});
  		}
  		
  		//db에서 지정한 개수만큼 가져온 영화 목록을
  		//사용자에게 보여주는 함수 (컨테이너 역할 div에 html태그요소를 생성/추가)
  		function loadMovies(state,url,container,loadingId){
  			//isLoading : 서버와 비동기통신중인가 
  			//isEnd : 서버로부터 가져올 데이터가 없는가
  			
  			//서버와 이미 비동기통신중이어서 page값 증가 안됐거나 서버로부터 가져올 데이터가없다면
  			//함수 실행되면 안되니 return
  			if(state.isLoading || state.isEnd){
  				return;
  			}
			
  			state.isLoading = true; //비동기 통신 시작을 의미 & 스크롤 내려도 해당 함수 실행 안되도록 설정
  			$(loadingId).show(); //서버로부터 데이터 받아오는 동안 보여줄 문구 = 로딩 중...
  			
  			$.ajax({
  				url : url,
  				data : {page : state.page},
  				success : function(movieList){
  					if(movieList.length === 0){ //서버로부터 불러올 영화 목록 x
  						state.isEnd = true; //더이상 불러올 데이터가 없다면 true처리하여 함수 실행안되도록 처리
  						$(window).off('scroll'); //윈도우 스크롤 이벤트 핸들러도 더이상 필요없으니 제거
  						$(loadingId).hide();
  						return;
  					}
  					
  					//서버로부터 불러올 영화 목록 o
  					movieList.forEach(function(movie){ 
  						//해당 html속성값은 부트스트랩을 이용했습니다(영화 포스터 느낌↑)
  						const html = '<div class="col-md-4">' + 
				  					  '<div class="movie-card position-relative">' +
				  					  '  <button type="button" class="btn btn-lg btn-primary position-absolute"' +
				  					  '  style="bottom:15px; right:15px; padding: 5px 10px; font-weight: 600;' + 
				  					  '  border-radius: 25px; box-shadow: 0 4px 12px rgba(13, 110, 253, 0.4); ' + 
				  					  '  transition: all 0.3s ease;" id="' + movie.movieId + '">예매</button>' +
				  					  '  <img src="https://media.themoviedb.org/t/p/original/fLDe4xRrp0BNmvYGzDu4CFIXUP3.jpg" class="movie-img" alt="엑박">' +
				  					  '  <strong class="movie-title">' + movie.movieTitle + '</strong>' +
				  					  '  <div class="movie-desc">' + movie.releaseDate + '</div>' +
				  					  '</div>' +
				  					  '</div>';   		   
						$(container).append(html);  	
						
						
  					});
  					
  					//영화 목록 불러왔으니
  					state.page++; //page + 1 처리
  					state.isLoading = false; //스크롤 내릴때마다 해당 함수 호출할 수 있도록 처리 
  				},
  				error : function (){ //서버와 비동기통신 실패시
  					alert("일시적인 오류로 영화를 불러오지 못했습니다.");
  					state.isLoading = false; //스크롤 내릴때마다 해당 함수 호출할 수 있도록 처리
  				}
  			});
  		}
  		
  		function searchLoadMovies(state,url,container,loadingId,condition,keyword){
  			//isLoading : 서버와 비동기통신중인가 
  			//isEnd : 서버로부터 가져올 데이터가 없는가
  			
  			//서버와 이미 비동기통신중이어서 page값 증가 안됐거나 서버로부터 가져올 데이터가없다면
  			//함수 실행되면 안되니 return
  			if(state.isLoading || state.isEnd){
  				return;
  			}
			
  			state.isLoading = true; //비동기 통신 시작을 의미 & 스크롤 내려도 해당 함수 실행 안되도록 설정
  			$(loadingId).show(); //서버로부터 데이터 받아오는 동안 보여줄 문구 = 로딩 중...
  			
  			$.ajax({
  				url : url,
  				data : {page : state.page,
  						condition : condition,
  						keyword : keyword},
  				success : function(movieList){
  					
  					console.log(movieList);
  					
  					if(movieList.length === 0){ //서버로부터 불러올 영화 목록 x
  						state.isEnd = true; //더이상 불러올 데이터가 없다면 true처리하여 함수 실행안되도록 처리
  						$(window).off('scroll'); //윈도우 스크롤 이벤트 핸들러도 더이상 필요없으니 제거
  						$(loadingId).hide();
  						return;
  					}
  					
  					//서버로부터 불러올 영화 목록 o
  					movieList.forEach(function(movie){ 
  						//해당 html속성값은 부트스트랩을 이용했습니다(영화 포스터 느낌↑)
  						const html = '<div class="col-md-4">' + 
				  					  '<div class="movie-card position-relative">' +
				  					  '  <button type="button" class="btn btn-lg btn-primary position-absolute"' +
				  					  '  style="bottom:15px; right:15px; padding: 5px 10px; font-weight: 600;' + 
				  					  '  border-radius: 25px; box-shadow: 0 4px 12px rgba(13, 110, 253, 0.4); ' + 
				  					  '  transition: all 0.3s ease;" id="' + movie.movieId + '">예매</button>' +
				  					  '  <img src="https://media.themoviedb.org/t/p/original/fLDe4xRrp0BNmvYGzDu4CFIXUP3.jpg" class="movie-img" alt="엑박">' +
				  					  '  <strong class="movie-title">' + movie.movieTitle + '</strong>' +
				  					  '  <div class="movie-desc">' + movie.releaseDate + '</div>' +
				  					  '</div>' +
				  					  '</div>';   		   
						$(container).append(html);  	
						
						
  					});
  					
  					//영화 목록 불러왔으니
  					state.page++; //page + 1 처리
  					state.isLoading = false; //스크롤 내릴때마다 해당 함수 호출할 수 있도록 처리 
  				},
  				error : function (){ //서버와 비동기통신 실패시
  					alert("일시적인 오류로 영화를 불러오지 못했습니다.");
  					state.isLoading = false; //스크롤 내릴때마다 해당 함수 호출할 수 있도록 처리
  				}
  			});
  		}
  		
  		function searchBtnClick(targetId){
			$("#searchBtn").click(function(){
				let condition = $(this).siblings("select").val();
				let keyword = $(this).siblings("input").val();
				if(!keyword || keyword.trim() === ""){
					alert("검색어를 입력해주세요");
					return;
				}
				if(targetId === "#all"){
					searchLoadMovies(allSearchState,'movies/allSearch','#allMovieContainer','#loading-all',condition,keyword);
				}else if(targetId === "#now") {
					searchLoadMovies(nowSearchState,'movies/nowSearch','#nowMovieContainer','#loading-now',condition,keyword);
				}else {
					searchLoadMovies(soonSearchState,'movies/soonSearch','#soonMovieContainer','#loading-soon',condition,keyword);
				}
			});
		}	
  		
  		// 석현님 예매 기능 매핑용 버튼입니다.
  		// 임의로 teammovie/book.mv 로 매핑되도록 해놨습니다.
  		$("#movieTabContent").on("click","button",function(event){
  			let movieId = $(event.target).attr("id");
  			location.href = "book.mv?memberNo=${loginMember.memberNo}&movieId=" + movieId;
  		});
  		
  	});
</script>

<jsp:include page="../common/footer.jsp"/>
</body>
</html>
