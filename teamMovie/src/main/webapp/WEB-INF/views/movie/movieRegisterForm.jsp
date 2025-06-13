<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>영화 등록</title>
  <%@ include file="../common/header.jsp" %>
  <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/lang/summernote-ko-KR.min.js"></script>
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

    <div class="form-group">
	  <label>배우(주연)</label>
	  
	  <div id="actors-container">
	    <input type="text" class="form-control mb-2" name="actorName" placeholder="예: 박보검">
	  </div>
	  <button type="button" class="btn btn-sm btn-secondary" id="add-actor">+ 배우 추가</button>
	</div>
	
    <div class="form-group">
      <label for="genre">장르</label>
      <br>
      <input type="checkbox" name="genreName" id="action" value="action"> <label for="action">액션</label>
      <input type="checkbox" name="genreName" id="drama" value="drama"> <label for="drama">드라마</label>
      <input type="checkbox" name="genreName" id="comedy" value="comedy"> <label for="comedy">코미디</label>
      <input type="checkbox" name="genreName" id="romance" value="romance"> <label for="romance">로맨스</label>
      <input type="checkbox" name="genreName" id="sf" value="sf"> <label for="sf">SF</label>
      <input type="checkbox" name="genreName" id="horror" value="horror"> <label for="horror">공포</label>
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

	<jsp:include page="../common/footer.jsp" />

	<script>
		  $(function(){
		    $('#description').summernote({
		      height: 300,
		      lang: 'ko-KR',
		      placeholder: '줄거리를 입력하세요...'
		    });
		    
		    $("#add-actor").on("click",function(){
				let inputEl = $("<input type='text' class='form-control mb-2' name='actorName' placeholder='예: 박보검'>");
				$("#actors-container").append(inputEl);
			});
		  });
	</script>

</body>
</html>
