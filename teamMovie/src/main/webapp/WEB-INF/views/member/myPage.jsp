<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

    <title>마이페이지 MyPage</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap JS (with Popper) -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>  
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	
  
    <style>
        body {
            background-color: #f8f9fa;
        }
        .profile-card {
            max-width: 600px;
            margin: 40px auto;
            padding: 30px;
            background-color: white;
            border-radius: 12px;     
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .profile-card h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #343a40;
        }
        .form-label {
            font-weight: bold;
        }
        
        .btn-primary, .btn-primary0,.btn-primary1,  .btn-primary2  {
            text-align: center;
            font-weight: bold;
            width: 30%;
        }

    
        
		        #passwordModal {
		    display: none; /* 처음에는 숨김 */
		    position: fixed;
		    z-index: 1000;
		    left: 0;
		    top: 0;
		    width: 100%;
		    height: 100%;
		    overflow: auto;
		    background-color: rgba(0, 0, 0, 0.4); /* 반투명 배경 */
		}
		
		/* 모달 내용 */
			#passwordModal {
		    background-color: #fff;
		    margin: auto;
		    padding: 20px;
		    width: 400px;
		    border-radius: 8px;
		
		    /* 화면 중앙 정렬 핵심 */
		    position: absolute;
		    top: 50%;
		    left: 50%;
		    transform: translate(-50%, -50%);
		}
        
    </style>
</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp" %>


    <div class="container">
        <div class="profile-card">
            <h2>마이페이지</h2>
            <form action="${contextRoot}/update.me" method="post">
                <input type="hidden" name="memberNo" value="${loginUser.memberNo}" />

                <div class="mb-3">
                    <label class="form-label readonly">아이디</label>
                    <input type="text" class="form-control" name="memberId" id="memberId" value="${loginUser.memberId}" readonly />
                	
                </div>

                <div class="mb-3">
                    <label class="form-label">이름</label>
                    <input type="text" class="form-control" name="memberName" value="${loginUser.memberName}" />
                </div>
			
              	<div class="mb-3">
                    <label class="form-label">생년월일</label>
                    <input type="number" class="form-control" name="birthDate" value="${fn:substring(loginUser.idNum, 0, 6)}" readonly/>
                </div>

				<c:set var="genderCode" value="${fn:substring(loginUser.idNum, 6, 7)}" />

				<c:set var="genderText">
    			<c:choose>
        		<c:when test="${genderCode == '1' || genderCode == '3'}">남자</c:when>
        		<c:when test="${genderCode == '2' || genderCode == '4'}">여자</c:when>
        		<c:otherwise>알 수 없음</c:otherwise>
    			</c:choose>
				</c:set>
				

				<!-- 기존 생년월일 다음에 추가 -->
				<div class="mb-3">
					<label class="form-label readonly">성별</label> <input type="text"
						class="form-control" name="gender" value="${genderText}" readonly />
				</div>

				<div class="mb-3">
					<label class="form-label">이메일</label> <input type="email"
						class="form-control" name="email" value="${loginUser.email}" />
				</div>

				<div class="mb-3">
                    <label class="form-label">전화번호</label>
                    <input type="text" class="form-control" name="phone" value="${loginUser.phone}" />
                </div>
        
               <br>
                <div style="text-align: center;">
   				<!-- 환불 현황 페이지 전환  -->
				<div style="text-align: center;" >
				  <button type="button" id="recentRefundBtn" class="btn btn-primary2" 
				          onclick="location.href='<%= request.getContextPath() %>/refund.me?refundId=${rfList[0].refundId}'" 
				          style="background-color:blue; color:white; font-weight:bold;">
				    최근 환불 이력
				  </button>
				  <br><br>
				</div>
               	<div>
               	<a href="${contextRoot}/myInquiryList" type="button" class="btn btn-primary0 " id="myInquiryListButton" style="background-color:#00FF7F; color:white; font-weight:bold; text-align: center;"> 문의내역 보기</a>
                </div>
                <br>
               	<div>
               	<button type="button" class="btn btn-primary" id="changePwdButton" data-bs-toggle="modal" data-bs-target="#changePwd" style="background-color:gray; color:white; font-weight:bold;text-align: center;"> 비밀번호 수정하기</button>
                </div>
                <br>
                <div> <!-- 누락된 div 여는 태그 추가  -->
                <button type="submit" class="btn btn-primary1" id="modifyButton" style="background-color:slateblue; color:white; font-weight:bold;text-align: center;">회원정보 수정하기</button>
                </div>
                <br>
                <div style="text-align: center;" id="deleteButton"  >
                <button type="button" class="btn btn-primary2" data-toggle="modal" data-target="#deleteForm" style="background-color:red; color:white; font-weight:bold;" >회원 탈퇴하기</button>
                </div>     
            </form>   
        </div>
    </div>
    
    <!-- 회원탈퇴 버튼 클릭 시 보여질 Modal -->
    <div class="modal fade" id="deleteForm">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">

                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">회원탈퇴</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <form action="${contextRoot}/delete.me" method="post">
                	<!--요청시 아이디 전달 -->
                	<input type="hidden" name="memberId" value="${loginUser.memberId}">
                    <!-- Modal body -->
                    <div class="modal-body">
                        <div align="center">
                            탈퇴 후 복구가 불가능합니다. <br>
                            정말로 탈퇴 하시겠습니까? <br>
                        </div>
                        <br>
                            <label for="password" class="mr-sm-2">Password : </label>
                            <input type="password" id="passwordForDelete" name="passwordForDelete" class="form-control mb-2 mr-sm-2"  placeholder="Enter Password" > <br>
                    </div>
                    <!-- Modal footer -->
                    <div class="modal-footer" align="center">
                        <button type="submit" class="btn btn-danger">탈퇴하기</button>
                    </div>
                </form>
            </div>
        </div>
    </div> 
    
<!-- 비밀번호 변경 시 보여질 Modal 창 -->
<div class="modal fade" id="changePwd" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- 모달 헤더 -->
      <div class="modal-header">
        <h5 class="modal-title">비밀번호 변경</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>

      <!-- 모달 바디: 단계별 입력 -->
      <div class="modal-body">
        <div id="step1">
          <label>현재 비밀번호</label>
          <input type="password" class="form-control mb-3" id="currentPassword">
          <button class="btn btn-primary w-100" onclick="checkCurrentPassword()">다음</button>
        </div>


		<!-- 새 비밀번호 입력 후 다음으로 넘어가기 -->
        <div id="step2" style="display:none;">
          <label>새 비밀번호</label>  
          <input type="password" class="form-control mb-3" id="newPassword">
          <!-- 서버 전송용 hidden input tag-->
          <input type="hidden" id="newPasswordHidden" name="newPassword"/>
          <button class="btn btn-secondary w-100 mb-2" onclick="nextStep(1)">이전</button>
          <button class="btn btn-primary w-100" onclick="newPasswordInput()">다음</button>
        </div>

        <div id="step3" style="display:none;">
          <label>새 비밀번호 확인</label>
          <input type="password" class="form-control mb-3" id="confirmPassword">
          <!-- 서버 전송용 hidden input tag -->
          <input type="hidden" id="confirmPasswordHidden" name="confirmPassword"/>
          <button class="btn btn-secondary w-100 mb-2" onclick="nextStep(2)">이전</button>
          <button class="btn btn-success w-100" onclick="confirmNewPassword()">변경</button>
        </div>
      </div>
    </div>
  </div>
</div>
   
   
   
 <script>
//Controller 에서 매개변수로 받기 위해 Hidden Input Tag 의 name 속성값에 value 값 넣어주기 - 변수 지정 필요 없음
 	 
 	
 	document.getElementById("newPasswordHidden").value=document.getElementById("newPassword").value;
 	document.getElementById("confirmPasswordHidden").value=document.getElementById("confirmPassword").value;
 
 	/* 페이지 이동시 작동 함수 */
 	  window.onload = function () {
 	    // JSTL 표현식을 안전하게 문자열로 감싸서 처리
 	    var rfListSize = ${empty rfList ? 0 : fn:length(rfList)};
 	    
 	    var btn = document.getElementById("recentRefundBtn");
 	    if (btn && rfListSize === 0) {
 	      btn.disabled = true;
 	      btn.style.backgroundColor = 'gray';
 	    }
 	  };
 	
 	
 	function checkCurrentPassword(){ 
 		//현재 입력한 비밀번호가 기존 비밀번호와 일치한지 확인 
 		const currentPassword = document.getElementById("currentPassword").value;
 		
 		$.ajax({
 			type:"POST",
 			url:"checkcurrentpwd.me",
 			data: { currentPassword: currentPassword
 			},
 			success: function(result){
 				if(result==="true"){
 					alert("현재 비밀번호와 일치합니다.");
 					document.getElementById("step1").style.display="none";
 					document.getElementById("step2").style.display="block";
 				} else {     
 					alert("비밀번호가 일치하지 않습니다.");
 				}
 			},
 			error: function(){
 				alert("서버에 오류가 발생하였습니다. 잠시 후 다시 시도하여 주십시오");
 			}
 		});
 		
 	}
 	
 	let newPassword="";
 	
 	function newPasswordInput(){
 		newPassword = document.getElementById("newPassword").value;
 		alert("새로운 패스워드가 입력됨");
 		document.getElementById("step2").style.display="none";
		document.getElementById("step3").style.display="block";
 	}
 	
 	function confirmNewPassword(){
 		const confirmPassword = document.getElementById("confirmPassword").value;
 		
 		$.ajax({
 			type:"POST",
 			url:"confirmpassword.me",
 			data: {confirmPassword: confirmPassword,
 				   newPassword: newPassword
 			},
 			success: function(result){
 				if(result==="true"){
 					alert("비밀번호가 성공적으로 변경되었습니다. \n 현재 창을 닫습니다.")
 					$("#changePwd").modal('hide'); //성공시 모달 창 자동으로 닫게 하기 
 				} else {     
 					alert("비밀번호가 일치하지 않습니다.");
 					
 				}
 			},
 			error: function(){
 				alert("서버에 오류가 발생하였습니다. 잠시 후 다시 시도하여 주십시오");
 			}
 		});
 		
 		
 	
 		}
 	
	function nextStep(step){
		//먼저 모든 step 숨기기
		document.getElementById("step1").style.display="none";
		document.getElementById("step2").style.display="none";
		document.getElementById("step3").style.display="none";
		
		//선택한 Step 만 보이게 하기 
		document.getElementById("step"+step).style.display="block";
	} 		
	
</script>
</body>

</html>