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
      <input type="text" class="form-control" id="movieTitle" name="movieTitle" required>
    </div>

    <div class="form-group">
      <label for="director">감독</label>
      <input type="text" class="form-control" id="director" name="director" required>
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
	  <br>
	  
	  	
	  	<div>
	  <!-- 배우 입력 필드 옆에 버튼 추가 -->
	  <small>*배우 추가가 필요하다면 등록해주세요</small>
		<button type="button" class="btn btn-sm btn-outline-primary ml-2" data-toggle="modal" data-target="#addActorModal">
	  	배우 등록하기
		</button>
	  	
	  	</div>
	  	
	</div>
	
	

	<script>
		$(function(){
			$("#submitActorBtn").click(function(){
				$.ajax({
					url : "registerActor.mv",
					data : {
						actorName : $("#actorName").val(),
						birthDate : $("#actorBirth").val(),
						imagePath : $("#actorImage").val()
					},
					success : function(result){
						if(result > 0){
							alert("배우가 성공적으로 등록되었습니다.\n배우 목록 새로고침 버튼을 클릭해주세요.");
							$("#addActorModal").modal("hide");
						}else{
							alert("배우 등록에 실패하였습니다");
						}
					},
					error : function(){
						alert("서버 통신 오류로 배우 등록에 실패하였습니다");
					}
				});
			});
		});
	</script>

	
	<script>
	  $(function () {
	    
	    // 새로고침 버튼
	    $('#refreshActorBtn').click(function () {
	    	
			$("#actorSearchInput").val("");
	      	getActorList("");
	    });

	    // 검색 버튼 클릭
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
	        	  let actorFlag = true;
	              let html = "";
	              
	              for(let i = 0; i < $("input[name=actorIds]").length; i++){
	            	  console.log($("input[name=actorIds]")[i].value);
	            		if(actor.actorId == $("input[name=actorIds]")[i].value){
	            			actorFlag = false;
	            			break;
	            		}
            	  }
	              console.log(actorFlag);
	              html += "<div class='form-check'>";
	           	  if(actorFlag){ //오른쪽 선택된 배우에 대해 중복 없음
			            html += "<input class='form-check-input actor-checkbox' type='checkbox' ";
			            html += "value='" + actor.actorId + "' data-name='" + actor.actorName + "' id='actor_" + actor.actorId + "'>";
	           	  }else{//중복 있음
		           		html += "<input checked class='form-check-input actor-checkbox' type='checkbox' ";
			            html += "value='" + actor.actorId + "' data-name='" + actor.actorName + "' id='actor_" + actor.actorId + "'>";
	           	  }
	              html += "<label class='form-check-label' for='actor_" + actor.actorId + "'>";
	              html += actor.actorName + "(" + actor.birthDate + ")";
	              html += "</label>"; 
	              html += "</div>";
	            	  
	              
	            $('#actorSearchResults').append(html);
	          });

	          // 선택 시 오른쪽으로 이동
	          $('.actor-checkbox').change(function () {
	            const actorId = $(this).val();
	            const actorName = $(this).data('name');
	            
	            console.log(actorId);
	            console.log(actorName);
	            
	            if (this.checked) {
	        	    
		                let html = "";
		                html += "<div class='form-check selected-actor' id='selected_" + actorId + "'>";
		                html += "<input type='hidden' name='actorIds' value='" + actorId + "'>";
		                html += "<label>" + actorName + "</label>&nbsp;&nbsp;";
		                html += "</div>";
		              $('#selectedActors').append(html);
	            	
	            }else{
	            	$("#selected_" + actorId).remove();
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
	      <input type="radio" name="typeId" id="${type.movieType}" value="${type.typeId}" required> <label for="${type.movieType}">${type.movieType}</label> 
      </c:forEach>
    </div>
    
    <script>
    	$(function(){
    		$("#registerBtn").on("click",function(){
	    		const genreIds = $("input[name=genreIds]");
	    		let flag = false;
	    		genreIds.each(function(){
	    			if($(this).prop("checked")){
	    				flag = true;
	    			}
	    		});
	    		if(!flag){
	   				alert("장르는 반드시 1개 이상 선택되어야 합니다");
	   				return false;
	    		}
	    		//$("input[name=actorIds]")는 jQuery 객체 자체를 반환하고, 이는 비어 있어도 항상 truthy다!!!!
	    		if($("input[name=actorIds]").length === 0){
	    			alert("배우는 반드시 1명 이상 선택되어야 합니다");
	    			return false;
	    		}
    		});
    		
    	});
    </script>
    
    <div class="form-group">
      <label for="rating">연령제한</label>
      <select name="rating" required>
		  <option value="" disabled selected>-- 등급 선택 --</option>
		  <option value="12세">12세</option>
		  <option value="15세">15세</option>
		  <option value="청불">청불</option>
	  </select>
    </div>

    <div class="form-group">
      <label for="releaseDateStr">상영 시작일</label>
      <input type="date" class="form-control"  id="releaseDateStr" name="releaseDateStr" required>
    </div>
    
     <div class="form-group">
      <label for="starteDateStr">종영일</label>
      <input type="date" class="form-control"  id="endDateStr" name="endDateStr" required>
    </div>
    
    <div class="form-group">
      <label for="duration">러닝타임 (분)</label>
      <input type="number" class="form-control"  id="duration" name="duration" min="1" required>
    </div>

    <div class="form-group">
      <label for="description">줄거리</label>
      <textarea id="description" name="description"  style="resize : none;" required></textarea>
    </div>

    <div class="form-group">
      <label for="poster">포스터 이미지</label>
      <input type="file" class="form-control-file"  accept="image/*" id="posterFile" name="posterFile" required>
    </div>
    
    <div class="form-group">
      <label for="stillCuts">스틸컷</label>
      <input type="file" class="form-control-file"  multiple accept="image/*" id="stillCutFiles" name="stillCutFiles" required>
      <small>*선택하신 파일 순서대로 스틸컷이 상세페이지에 등록됩니다.</small>
    </div>

    <button type="submit" class="btn btn-primary" id="registerBtn">영화 등록</button>
  </form>
</div>
	
	<!-- 배우 등록 모달 -->
	<div class="modal fade" id="addActorModal" tabindex="-1" role="dialog" aria-labelledby="addActorModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document">
	    <div class="modal-content">
	      
	      <div class="modal-header">
	        <h5 class="modal-title" id="addActorModalLabel">배우 등록</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="닫기">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	
	      <div class="modal-body">
	        <form id="addActorForm">
	          <div class="form-group">
	            <label for="actorName">이름</label>
	            <input type="text" class="form-control" id="actorName" name="actorName" required>
	          </div>
	          <div class="form-group">
	            <label for="actorBirth">생년월일</label>
	            <input type="date" class="form-control" id="actorBirth" name="actorBirth">
	          </div>
	          <div class="form-group">
	            <label for="actorImage">프로필 이미지 URL</label>
	            <input type="text" class="form-control" id="actorImage" name="actorImage">
	          </div>
	        </form>
	      </div>
	
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
	        <button type="button" class="btn btn-primary" id="submitActorBtn">등록</button>
	      </div>
	
	    </div>
	  </div>
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
