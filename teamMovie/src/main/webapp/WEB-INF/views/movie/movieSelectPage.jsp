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
  justify-content: center;
  gap: 40px;
  margin-top: 30px;
  flex-wrap: wrap;
}

.choice-container ul {
  list-style: none;
  padding: 0;
  margin: 0;
}

.choice-container li {
  margin: 8px 0;
}

.choice-container .btn-outline-secondary {
  border: 2px solid #ced4da;
  background-color: #fff;
  color: #333;
  border-radius: 10px;
  padding: 10px 18px;
  font-size: 16px;
  min-width: 180px;
  text-align: left;
  box-shadow: 0 2px 4px rgba(0,0,0,0.08);
  transition: all 0.2s ease;
}

.choice-container .btn-outline-secondary:hover {
  background-color: #f0f0f0;
  border-color: #999;
}

.choice-container .btn-outline-secondary.selected {
  background-color: #007bff;
  color: white;
  border-color: #007bff;
}

.movie-choice, .theater-choice, .time-choice {
  width: 250px;
}

.time-choice .btn-outline-secondary {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  white-space: nowrap;
}

.time-choice .btn-outline-secondary .time {
  font-size: 18px;
  font-weight: bold;
  color: green;
}

.time-choice .btn-outline-secondary .title {
  margin-top: 4px;
  font-size: 14px;
  color: #333;
}

.time-choice .btn-outline-secondary .screen {
  margin-top: 2px;
  font-size: 13px;
  color: #666;
}


form .btn.next {
  padding: 12px 30px;
  font-size: 18px;
  border-radius: 12px;
  margin-top: 40px;
  transition: background-color 0.2s ease, box-shadow 0.2s ease;
}

form .btn.next:disabled {
  background-color: #ccc;
  border-color: #ccc;
  cursor: not-allowed;
}

form .btn.next:not(:disabled):hover {
  background-color: #0056b3;
  box-shadow: 0 4px 10px rgba(0,0,0,0.15);
}


.schedule-option {
  border-radius: 10px;
  background-color: white;
  border: 2px solid #ccc;
  padding: 12px;
  width: 100%;
  text-align: left;
  transition: all 0.2s ease;
}

.schedule-option:hover {
  background-color: #f8f9fa;
  border-color: #888;
}

.schedule-option.selected {
  background-color: #007bff;
  color: white;
  border-color: #007bff;
}

body {
  font-family: 'Segoe UI', 'Pretendard', sans-serif;
  background-color: #fafafa;
  color: #222;
}

	ul>li{
	list-style:none;
	}
	
	/* 상단제목 */
	.head-title {
	  width: 100%;
	  padding: 30px 0 20px;
	  text-align: center;
	  border-bottom: 2px solid #e0e0e0;
	  margin-bottom: 40px;
	}

	.head-title h3 {
	  font-size: 28px;
	  font-weight: 700;
	  color: #222;
	  margin: 0;
	}
	
	</style>
<meta charset="UTF-8">
<title>무비 select page</title>
</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<div class="head-title"><h3>예매</h3></div>

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
 	 <input type="hidden" name="movieId" id="movieId" />
 	 <input type="hidden" name="scheduleId" id="scheduleId" />
 	 <input type="hidden" name="screenId" id="screenId" />
 	 <input type="hidden" name="memberId" value=1  />
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
	    
	  }
	});
	
	/*01.영화 선택시 ajax 호출  */
	$('.movie-choice .btn-outline-secondary').click(function(e){
		const $btn = $(e.currentTarget);
		/* movie-no에 저장된 값을 가져와 movieId에 넣어줌  */
	    const movieId = $btn.attr('movie-no');
        //무비선택을 변경하면 상영정보와 상영관 초기화 
		$('#scheduleId').val('');
        $('#screenId').val('');
		
        // hidden input에 값 저장
        $('#movieId').val(movieId);
		
		/* 버튼 선택 해제시 time-choice 클래스를 비워줌 */
	    if ($btn.hasClass('selected')) {
	        $('.time-choice ul').empty(); 
	        
	        $('#movieId').val(''); // 폼 안의 영화 아이디 값도 비워줌
            $('#scheduleId').val('');
            $('#screenId').val('');
            
	        checkFormReady() // 버튼 비활성화 
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
	                	
                        const item = `
                            <li>
                                <button 
                                    class="btn btn-outline-secondary schedule-option" 
                                    data-schedule-id="\${schedule.scheduleId}" 
                                    data-screen-id="\${schedule.screenId}">
                                    <span class="time">
                                        <strong>\${schedule.startTime}</strong>
                                    </span>
                                    <span class="title">
                                        <strong title="\${schedule.movieTitle}">\${schedule.movieTitle}</strong>
                                        <em>\${schedule.language}</em>
                                    </span>
                                    <span class="screen">
                                    	<strong>제 \${schedule.screenId}관</strong>
                                    </span
                                </button>
                            </li>`;
	                		
						$list.append(item);
	                	
	                });
	                
	                //동적 이벤트 바인딩
	                bindScheduleSelectEvent();
	    			
	    		},
	    		error : function(){
	    			console.log('상영 정보를 불러오지 못했습니다.');
	    		}
	    		
	    	});
	    }
		
	    checkFormReady(); // 상태 확인
		
	});
	
	
	/* 02. 각 클래스의 버튼이 활성화 되었으면 다음버튼 활성화 */
    function checkFormReady() {
        const movieId = $('#movieId').val();
        const scheduleId = $('#scheduleId').val();
        const screenId = $('#screenId').val();

        const $btn = $('.btn.next');
        
        
        if (movieId && scheduleId && screenId) {
            $btn.prop('disabled', false);
        } else {
            $btn.prop('disabled', true);
        }
    }
	
	/* 03. 상영 시간 선택 이벤트 바인딩 함수  */
	function bindScheduleSelectEvent() {
        $('.schedule-option').click(function () {
        	const $btn = $('.schedule-option');
        	
        	console.log($btn);
        	
        	if ($btn.hasClass('selected')) {
        		
                $('#scheduleId').val('');
                $('#screenId').val('');
                checkFormReady();
				
			}else{
	            const scheduleId = $(this).data('schedule-id');
	            const screenId = $(this).data('screen-id');
	
	            $('#scheduleId').val(scheduleId);
	            $('#screenId').val(screenId);
	
	            checkFormReady();
			}
        });
    }

	
	

</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>


</body>
</html>