<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
   <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
  margin: 100px;
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
  border-color: #ffffff;
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
  border-color: #ffffff;
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
			    	<c:choose>
			    		<c:when test="${selectedMovieId != 0}">
					       	<button 
							    class="btn btn-outline-secondary ${selectedMovieId eq movie.movieId ? 'selected' : ''}"
							    data-movieId="${movie.movieId}" >
							    <span class="txt">${movie.movieTitle}</span>
							</button>
			    		</c:when>
			    		<c:otherwise>
			    			<button class="btn btn-outline-secondary" data-movieId="${movie.movieId}">
							    <span class="txt">${movie.movieTitle}</span>
							    <div></div>
							</button>
			    		</c:otherwise>
			    	</c:choose>
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
        <ul></ul>
    </div>
</div>

<form id="movieSelectForm" method="post" action="${contextRoot}/movie/reserveSeat">
    <input type="hidden" name="movieId" id="movieId" value="${selectedMovieId}" />
    <input type="hidden" name="scheduleId" id="scheduleId" />
    <input type="hidden" name="screenId" id="screenId" />
    <input type="hidden" name="memberId" value="1" />
    <div align="center">
        <button type="submit" class="btn btn-primary next" disabled>다음으로</button>
    </div>
</form>

	<script>
		$("button").click(function(){
			console.log($(this).data("movieId"));
		});
	</script>

<script>
$(document).ready(function () {
    const selectedBtn = $('.movie-choice .btn-outline-secondary.selected');
    console.log(selectedBtn);
    if (selectedBtn.length > 0) {
        $('#movieId').val(selectedBtn.attr('data-movieId'));
        fetchSchedules(selectedBtn.attr('data-movieId'));
    }

    $('.choice-container').on('click', '.btn-outline-secondary', function (e) {
        const $btn = $(e.currentTarget);
        const $group = $btn.closest('.movie-choice, .time-choice, .theater-choice');
        $group.find('.btn-outline-secondary').removeClass('selected');
        $btn.addClass('selected');
    });

    $('.movie-choice .btn-outline-secondary').click(function (e) {
        const $btn = $(e.currentTarget);
        const movieId = $btn.attr('data-movieId');
        console.log(movieId);

        $('#movieId').val(movieId);
        $('#scheduleId').val('');
        $('#screenId').val('');
        $('.time-choice ul').empty();
        checkFormReady();

        fetchSchedules(movieId);
    });

    function fetchSchedules(movieId) {
        $.ajax({
            url: '<%= request.getContextPath() %>/movie/schedule',
            method: 'GET',
            data: { movieId: movieId },
            success: function (schedules) {
                const $list = $('.time-choice ul');
                $list.empty();
                schedules.forEach(function (schedule) {
                    const item = `
                        <li>
                            <button 
                                class="btn btn-outline-secondary schedule-option" 
                                data-schedule-id="\${schedule.scheduleId}" 
                                data-screen-id="\${schedule.screenId}">
                                <span class="time"><strong>\${schedule.startTime}</strong></span>
                                <span class="title"><strong title="\${schedule.movieTitle}">${schedule.movieTitle}</strong><em>${schedule.language}</em></span>
                                <span class="screen"><strong>제 \${schedule.screenId}관</strong></span>
                            </button>
                        </li>`;
                    $list.append(item);
                });
                bindScheduleSelectEvent();
            },
            error: function () {
                console.log('상영 정보를 불러오지 못했습니다.');
            }
        });
    }
    
    

    function bindScheduleSelectEvent() {
        $('.schedule-option').click(function () {
            $('.schedule-option').removeClass('selected');
            $(this).addClass('selected');
            $('#scheduleId').val($(this).data('schedule-id'));
            $('#screenId').val($(this).data('screen-id'));
            checkFormReady();
        });
    }

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
    
    
    //function chk	
});

 // 처음 자동 호출
function loadScheduleForSelectedMovie() {
    // selected 클래스가 붙은 버튼을 찾음
    const $selectedBtn = $('.btn-outline-secondary.selected');
    const movieId = $selectedBtn.attr('data-movieId');
    
    if (movieId) {
    	fetchSchedules(movieId)
    }
    
 }
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>