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
  		<label>배우(주연)</label>
  			<div id="actors-container">
    			<div class="actor-group mb-2">  
    				<!-- 관리자가 배우를 클릭해야만 입력될 수 있도록 해야함...! -->
			    	<input type="text" class="form-control actor-name" placeholder="예: 박보검">
			    	<div class="autocomplete-box"></div> <!-- 자동완성 결과 보여줄 공간 -->
			      	<!-- <input type="hidden" name="actorIds">  --> <!-- 선택된 actorId 저장용 -->
    			</div>
			</div>
  	  	<button type="button" class="btn btn-sm btn-secondary" id="add-actor">+ 배우 추가</button>
	</div>
	
	<script>
		$(function(){
		    $("#add-actor").on("click",function(){
		    	let actorGroupDiv = $("<div class='actor-group mb-2'>");
				let inputEl = $("<input type='text' class='form-control actor-name' placeholder='예: 박보검'>");
				let autocompleteDiv = $("<div class='autocomplete-box'>");
				$("#actors-container").append(actorGroupDiv);
				actorGroupDiv.append(inputEl);
				actorGroupDiv.append(autocompleteDiv);
			});
		    
		    $("#actors-container").on("keyup",".actor-name",function(){
		    	let entered = $(this).val(); //관리자가 입력한 내용
		    	let autoCompleteBox = $(this).next(); //자동완성박스(div.autocomplete-box)
		    	
		    	if(entered.length >= 1){
		    		let html = "";
		    		
		    		$.ajax({
		    			url : "findActors.mv",
		    			data : {
		    				keyword : $(this).val()
		    			},
		    			success : function(actors){
		    				console.log(actors);
		    				
		    				actors.forEach(function(actor){
		    					html += "<div class='suggestion-item'>";
		    					html += "<img src='https://img.vogue.co.kr/vogue/2022/08/style_630d81ae75ddf-1400x933.png' class='actor-thumb'>";
		    					html += "<span>" + actor.actorName + "</span>";
		    					html += "<div style='display:none;'>" + actor.actorId + "</div>";  
		    					html += "</div>";
		    				});
		    				autoCompleteBox.html(html).show();
		    			},
		    			error : function(){
		    				
		    				html += "<div class='suggestion-item'>";
		    				html += "<span>조회에 실패하였습니다</span>"; 
		    				html += "</div>";
		    				
		    				autoCompletebox.html(html).show();
		    			}
		    		});
		    	}else{
		    		autoCompleteBox.hide();
		    	}
		    });
		   	
		    //자동완성된 항목 선택시 input태그 value값 채우기
		    $("#actors-container").on("click",".suggestion-item",function(){
		    	let selectedActorName = $(this).children("span").text();
		    	$(this).parent().prev().val(selectedActorName); //input태그에 value값 채우기
		    	//내가 지금 하고자 하는 것은?
				//관리자가 배우 클릭했을때는 최종적으로 배우가 선택된것임
				//그러니까 그 배우에 대한 actorId값을 서버로 전달해야함
				let actorId = $(this).children("div").val();
				$(this).parents(".actor-group").append("<input type='hidden' value='" + actorId + "'>");
				
		    	let autoCompleteBox = $(this).parent(); //자동완성박스(div.autocomplete-box)
		    	autoCompleteBox.empty(); // 배우이름 선택했으면 자동완성박스 내용 지우기
		    });
		    
		    //배우 이름 입력창에 변화 발생시 hidden요소 지워버리기(잘못된 actorId 전달 방지 위함)
		    $("actors-container").on("input",".actor-name",function(){
		    	$(this).siblings(":hidden").remove();
		    });
		    
		    
		});
		
		
	</script>

	
    <div class="form-group">
      <label for="genre">장르</label>
      <br>
      <input type="checkbox" name="genreNames" id="action" value="action"> <label for="action">액션</label>
      <input type="checkbox" name="genreNames" id="drama" value="drama"> <label for="drama">드라마</label>
      <input type="checkbox" name="genreNames" id="comedy" value="comedy"> <label for="comedy">코미디</label>
      <input type="checkbox" name="genreNames" id="romance" value="romance"> <label for="romance">로맨스</label>
      <input type="checkbox" name="genreNames" id="sf" value="sf"> <label for="sf">SF</label>
      <input type="checkbox" name="genreNames" id="horror" value="horror"> <label for="horror">공포</label>
    </div>
    
    <div class="form-group">
      <label for="movieType">타입</label>
      <br>
      <input type="radio" name="movieType" id="live" value="live"> <label for="live">인물 영화</label>
      <input type="radio" name="movieType" id="animated" value="animated"> <label for="animated">애니메이션 영화</label>
      <input type="radio" name="movieType" id="hybrid" value="hybrid"> <label for="hybrid">하이브리드 영화</label>
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
		    
		  });
	</script>

</body>
</html>
