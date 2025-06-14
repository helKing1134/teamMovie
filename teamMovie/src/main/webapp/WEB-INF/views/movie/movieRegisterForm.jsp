<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>영화 등록</title>
  <%@ include file="../common/header.jsp" %>
  
  <!-- 
  	 SummerNote 라이브러리 추가
	 html태그 그대로 db에 저장을 위해 필요한 css 및 js 추가했습니다 (written by 이수한)
   -->
  <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/lang/summernote-ko-KR.min.js"></script>
  
  <style>
  	.autocomplete-box {
  border: 1px solid #ccc;
  max-height: 180px;
  overflow-y: auto;
  background-color: white;
  position: absolute;
  z-index: 999;
  width: 100%;
}

.suggestion-item {
  display: flex;
  align-items: center;
  padding: 5px;
  cursor: pointer;
}

.suggestion-item:hover {
  background-color: #f0f0f0;
}

.actor-thumb {
  width: 40px;
  height: 40px;
  object-fit: cover;
  border-radius: 50%;
  margin-right: 10px;
}

.actor-card {
  cursor: pointer;
  border: 1px solid #ccc;
  transition: background-color 0.2s;
}
.actor-card:hover {
  background-color: #f0f0f0;
}
  	
  </style>
  
</head>
<body>
<div class="container mt-5">
  <h2 class="mb-4">🎬 영화 등록</h2>
  <form action="registerMovie" method="post" enctype="multipart/form-data">
    <div class="form-group">
      <label for="movieTitle">제목</label>
      <input type="text" class="form-control" id="movieTitle" name="movieTitle" >
    </div>

    <div class="form-group">
      <label for="director">감독</label>
      <input type="text" class="form-control" id="director" name="director">
    </div>
	
	
	<div class="form-group">
	  <label>출연 배우</label>
	  <div class="row">
	    <!-- 왼쪽 영역 -->
	    <div class="col-md-6">
	      <div class="d-flex justify-content-between align-items-center mb-2">
	        <small>배우 목록</small>
	        <button type="button" class="btn btn-sm btn-outline-secondary" id="refreshActorBtn">🔄</button>
	      </div>
	      <div class="input-group mb-2">
	        <input type="text" class="form-control" id="actorSearchInput" placeholder="배우 이름 검색">
	        <div class="input-group-append">
	          <button type="button" class="btn btn-outline-secondary" id="searchActorBtn">검색</button>
	        </div>
	      </div>
	      <div id="actorSearchResults" class="border p-2" style="height: 250px; overflow-y: auto;">
	        <!-- AJAX로 배우 목록 여기에 채워짐 -->
	      </div>
	    </div>
	
	    <!-- 오른쪽 영역 -->
	    <div class="col-md-6">
	      <small>선택된 배우</small>
	      <div id="selectedActors" class="border p-2" style="height: 250px; overflow-y: auto;">
	        <!-- 체크된 배우가 이쪽으로 이동됨 -->
	      </div>
	    </div>
	  </div>
	</div>

	<script>
	  $(function () {
	    // 🔄 새로고침 버튼
	    $('#refreshActorBtn').click(function () {
	    	
			$("#actorSearchInput").val("");
	      	getActorList("");
	    });

	    // 🔍 검색 버튼 클릭
	    $('#searchActorBtn').click(function () {
	      const keyword = $('#actorSearchInput').val().trim();
	      getActorList(keyword);
	    });

	    // 배우 목록 가져오기 함수
	    function getActorList(keyword) {
	      $.ajax({
	        url: 'findActors.mv',
	        data: { keyword: keyword },
	        success: function (actorList) {
	          $('#actorSearchResults').empty();
	          if (actorList.length === 0) {
	            $('#actorSearchResults').html('<p class="text-muted">검색 결과가 없습니다.</p>');
	            return;
	          }

	          actorList.forEach(function (actor) {
	              
	              let html = "";
	              html += "<div class='form-check'>";
	              html += "<input class='form-check-input actor-checkbox' type='checkbox' ";
	              html += "value='" + actor.actorId + "' data-name='" + actor.actorName + "' id='actor_" + actor.actorId + "'>";
	              html += "<label class='form-check-label' for='actor_" + actor.actorId + "'>";
	              html += actor.actorName + "(" + actor.birthDate + ")";
	              html += "</label>"; 
	            	  
	              
	            $('#actorSearchResults').append(html);
	          });

	          // 선택 시 오른쪽으로 이동
	          $('.actor-checkbox').change(function () {
	            const actorId = $(this).val();
	            const actorName = $(this).data('name');
	            
	            console.log(actorId);
	            console.log(actorName);
	            
	            if (this.checked) {
		            // 오른쪽에 추가
	                let html = "";
	                html += "<div class='form-check selected-actor' id='selected_" + actorId + "'>";
	                html += "<input type='hidden' name='actorIds' value='" + actorId + "'>";
	                html += "<label>" + actorName + "</label>";
	                html += "</div>";
	              $('#selectedActors').append(html);
	            } else {
	              // 오른쪽에서 제거
	              $('#selected_' + actorId).remove();
	            }
	          });
	        },
	        error: function () {
	          alert('배우 목록을 불러오는 데 실패했습니다.');
	        }
	      });
	    }

	    // 페이지 로드시 전체 배우 목록 미리 불러오기
	    getActorList("");
	  });
	</script>






	
    <div class="form-group">
      <label for="genre">장르</label>
      <br>
      <c:forEach var="genre" items="${currentGenres}" varStatus="vs">
	      <input type="checkbox" name="genreIds" id="${genre.genreName}" value="${genre.genreId}"> 
          <label for="${genre.genreName}">${genre.genreName}</label> &nbsp;
	      <c:if test="${vs.count % 5 == 0}">
	      	<br>
	      </c:if>
      </c:forEach>
    </div>
    
    <div class="form-group">
      <label for="movieType">타입</label>
      <br>
      <c:forEach var="type" items="${currentTypes}">
	      <input type="radio" name="typeId" id="${type.movieType}" value="${type.typeId}"> <label for="${type.movieType}">${type.movieType}</label> 
	      
      </c:forEach>
    </div>
    
    <div class="form-group">
      <label for="rating">연령제한</label>
      <select name="rating">
      	<option value="전체">전체
      	<option value="12세">12세
      	<option value="15세">15세
      	<option value="청불">청불
      </select>
    </div>

    <div class="form-group">
      <label for="releaseDateStr">상영 시작일</label>
      <input type="date" class="form-control"  id="releaseDateStr" name="releaseDateStr">
    </div>
    
     <div class="form-group">
      <label for="starteDateStr">종영일</label>
      <input type="date" class="form-control"  id="endDateStr" name="endDateStr">
    </div>
    
    <div class="form-group">
      <label for="duration">러닝타임 (분)</label>
      <input type="number" class="form-control"  id="duration" name="duration" min="1">
    </div>

    <div class="form-group">
      <label for="description">줄거리</label>
      <textarea id="description" name="description"  style="resize : none;"></textarea>
    </div>

    <div class="form-group">
      <label for="poster">포스터 이미지</label>
      <input type="file" class="form-control-file"  accept="image/*" id="posterFile" name="posterFile">
    </div>
    
    <div class="form-group">
      <label for="stillCuts">스틸컷</label>
      <input type="file" class="form-control-file"  multiple accept="image/*" id="stillCutFiles" name="stillCutFiles">
      <small>*선택하신 파일 순서대로 스틸컷이 상세페이지에 등록됩니다.</small>
    </div>

    <button type="submit" class="btn btn-primary" id="registerBtn">영화 등록</button>
  </form>
</div>
	
	<jsp:include page="../common/footer.jsp" />

	<script>
		  $(function(){
		    $('#description').summernote({
		      height: 300,
		      lang: 'ko-KR',
		      placeholder: '줄거리를 입력하세요...'
		    });
		    
		  });
	</script>

</body>
</html>
