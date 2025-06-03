<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<!-- 영화 예매 페이지 created by SH.k  -->
<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	<style type="text/css">
		
	.choice-container {
	  display: flex;
	  flex-direction: row; /* 기본값이지만 명시적으로 적어줌 */
	  gap: 20px; /* div들 사이 간격 */
	}
	
	.btn-outline-secondary.selected {
	  background-color: #6c757d;
	  color: white;
	  border-color: #6c757d;
	}
	ul>li{
	list-style:none;
	}
	
	</style>
<meta charset="UTF-8">
<title>무비 select page</title>
</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<h1>예매</h1>

<div class="choice-container" align="center">
	<div class="movie-choice">
		<ul>
		<c:forEach var="movie" items="${mlist}">
		    <li>
		      <button class="btn btn-outline-secondary" movie-no="${movie.movieId}"><span class="txt">${movie.movieTitle}</span></button>
		    </li>
		</c:forEach>
		</ul>
	</div>

	<div class="theater-choice">
	
		<ul>
			<li>
			<button class="btn btn-outline-secondary">서울 영등포구 극장</button>
			</li>
		</ul>
	
	</div>

	<div class="time-choice">
	
		<ul>
			<li>
			</li>
		</ul>
	
	</div>
</div>



<br><br><br><br><br><br><br><br>
 <form id="movieSelectForm" method="post" action="${contextRoot }/movie/reserveSeat">
 	 <input type="hidden" id="movieId" value="1"/>
 	 <input type="hidden" id="scheduleId" value="2"/>
 	 <input type="hidden" id="screenId" value="1"/>
 	 
    <div align="center">
            <button type="submit" class="btn btn-primary next" disabled>다음으로</button>
     </div>
 </form>

<br><br><br><br><br><br><br><br>

<script>	
	/* 00.버튼 클릭 함수  */
	$('.choice-container').on('click', '.btn-outline-secondary', function (e) {
	  const $btn = $(e.currentTarget);
	  const $group = $btn.closest('.movie-choice, .time-choice, .theater-choice');

	  if ($btn.hasClass('selected')) {
	    $btn.removeClass('selected');
	    
	  } else {
	    $group.find('.btn-outline-secondary').removeClass('selected');
	    $btn.addClass('selected');
	    
	    checkSelections(); // 모든 카테코리에서 버튼이 선택되었을 경우  다음버튼을 활성화 하는 함수
	  }
	});
	
	/*01.영화 선택시 ajax 호출  */
	$('.movie-choice .btn-outline-secondary').click(function(e){
		const $btn = $(e.currentTarget);
		/* movie-no에 저장된 값을 가져와 movieId에 넣어줌  */
	    const movieId = $btn.attr('movie-no');
		
		/* 버튼 선택 해제시 time-choice 클래스를 비워줌 */
	    if ($btn.hasClass('selected')) {
	        $('.time-choice ul').empty(); 
	    }else{
	    	
	    	/* ajax로 상영정보 요청  */
	    	$.ajax({
	    		url : '<%= request.getContextPath() %>/movie/schedule',
	    		method : 'GET',
	    		data : { movieId: movieId },
	    		success : function(schedules){
	    			
	    			const $list = $('.time-choice ul');
	                $list.empty(); // 함수 실행시 초기화 
	                
	                schedules.forEach(function (schedule){
	                	
	                	console.log(schedule);
	                	
	                	const item = `<li><button class="btn btn-outline-secondary">
	                		<span class="time">
		                		<strong>
		                			\${schedule.startTime}
		                		</strong>
	                		</span>
	                		<span class="title">
	                			<strong title="\${schedule.movieTitle}">
	                			\${schedule.movieTitle}
	                			</strong>
	                			<em>
	                				\${schedule.language}
	                			</em
	                		</span>
	                		</button></li>`;
	                		
						$list.append(item);
	                	
	                });
	    			
	    		},
	    		error : function(){
	    			console.log('상영 정보를 불러오지 못했습니다.');
	    		}
	    		
	    	});
	    } 
		
	});
	
	
	/* 02. 각 클래스의 버튼이 활성화 되었으면 다음버튼 활성화 */
	function checkSelections() {
	    const isMovieSelected = $('.movie-choice .btn.selected').length > 0;
	    const isTheaterSelected = $('.theater-choice .btn.selected').length > 0;
	    const isTimeSelected = $('.time-choice .btn.selected').length > 0;
	
	    if (isMovieSelected && isTheaterSelected && isTimeSelected) {
	        $('.btn.next').prop('disabled', false);
	    } else {
	        $('.btn.next').prop('disabled', true);
	    }
	}

	
	

</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>


</body>
</html>