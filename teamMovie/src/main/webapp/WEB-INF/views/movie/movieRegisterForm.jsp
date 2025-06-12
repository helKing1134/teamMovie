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
  <!--
  	 jQuery UI CSS & JS 추가 
  	 배우 입력시 필요한 css와 js 추가했습니다 (written by 이수한)
  -->
  <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>
  
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
  <form action="${contextRoot}/admin/registerMovie" method="post" enctype="multipart/form-data">
    <div class="form-group">
      <label for="movieTitle">제목</label>
      <input type="text" class="form-control" id="movieTitle" name="movieTitle" >
    </div>

    <div class="form-group">
      <label for="director">감독</label>
      <input type="text" class="form-control" id="director" name="director">
    </div>
	
	<!-- 
		동명이인 처리와 actorId값을 자동으로 서버로 전달하기 위한 로직 필요
		jQuery + jQuery UI 자동완성 로직 필요
		UI관련 css 및 js <head>태그에 추가 
	 -->
    <div class="form-group">
	  <label for="actor">출연 배우</label>
	  <div class="input-group">
	    <input type="text" class="form-control" id="actorName" name="actorName" placeholder="배우를 선택하세요" readonly>
	    <!-- 배우 ID들을 여기에 hidden으로 넣음 -->
  		<div id="selectedActorsContainer"></div>
	    <div class="input-group-append">
	      <button type="button" class="btn btn-outline-secondary" data-toggle="modal" data-target="#actorModal">
	        배우 선택
	      </button>
	    </div>
	  </div>
	  
	</div>
	




	
    <div class="form-group">
      <label for="genre">장르</label>
      <br>
      <c:forEach var="genre" items="${currentGenreList}" varStatus="vs">
	      <input type="checkbox" name="genreNames" id="${genre.genreName}" value="${genre.genreName}"> 
          <label for="${genre.genreName}">${genre.genreName}</label> &nbsp;
	      <c:if test="${vs.count % 5 == 0}">
	      	<br>
	      </c:if>
      </c:forEach>
    </div>
    
    <div class="form-group">
      <label for="movieType">타입</label>
      <br>
      <c:forEach var="type" items="${currentTypeList}">
	      <input type="radio" name="movieType" id="${type.movieType}" value="${type.movieType}"> <label for="${type.movieType}">${type.movieType}</label> 
	      
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
    </div>

    <button type="submit" class="btn btn-primary" id="registerBtn">영화 등록</button>
  </form>
</div>
	<jsp:include page="actorEnroll.jsp"/>
	
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
