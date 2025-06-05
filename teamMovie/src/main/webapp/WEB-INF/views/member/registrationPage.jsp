<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입페이지(Registration Page)</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 400px;
            margin: 80px auto;
            padding: 30px;
            background-color: #ffffff;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 10px;
        }
        h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #333333;
        }
        input[type="text"], input[type="password"], input[type="number"], input[type="email"] {
            width: 100%;
            padding: 10px;
            margin: 6px 0 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .submit-btn {
            width: 20%;
            padding: 12px;
            background-color: #007bff;
            border: none;
            color: white;
            font-weight: bold;
            border-radius: 5px;
            cursor: pointer;
			display: block;
    		margin: 0 auto;           
        }
        

        .submit-btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

	<%@ include file="/WEB-INF/views/common/header.jsp" %>
    <div class="container">
        <h2>회원가입</h2>
        <form action="register.me" method="post">
           
            <label for="memberId">아이디</label>
            <input type="text" name="memberId" id="memberIdCheck" placeholder="영문,숫자로만 입력해 주세요." required>
			<div id="dupCheckDiv" style="font-size:0.8em"> </div>

            <label for="memberName">이름</label>
            <input type="text" name="memberName" id="memberName" placeholder="필수 기입 정보입니다." required>

            <label for="password">비밀번호</label>
            <input type="password" name="password1" id="password1" placeholder="필수 기입 정보입니다."  required>
			
			<label for="password">비밀번호 확인</label>
            <input type="password" name="password2" id="password2" placeholder="비밀번호를 다시한번 입력하세요."  required>
			
            <label for="age">나이</label>
            <input type="number" name="age" id="age" placeholder="필수 기입 정보입니다.">

            <label for="email">이메일</label>
            <input type="email" name="email" id="email" >

            <label for="phone">전화번호</label>
            <input type="text" name="phone" id="phone">

            <button type="submit" class="submit-btn">가입하기🎬</button>
        	<!-- 초기화 버튼 추가하기 by 만손 -->
        </form>
    </div>
    
       <script>
    	$(function(){
    		var idInput = $("#memberIdCheck"); //idInput: 
    		idInput.keyup(function(){
    			if(idInput.val().length>3){
    				$.ajax({
    					url:"dupCheck.me",
    					data: {memberId: idInput.val()},
    					success: function(result){
    					
    					if(result==="NNNNN"){ // 중복인 경우	
    					$("#dupCheckDiv").show();
    					$("#dupCheckDiv").css("color","red").text("중복된 아이디 입니다.");
    					//사용불가능이면 제출 버튼 비활성화 하기 
    					$("button[type=submit]").attr("disabled",true);
    					} else{ //NNNNY 사용가능인 경우 
    					$("#dupCheckDiv").show();
    					$("#dupCheckDiv").css("color","green").text("사용가능한 아이디 입니다.");
    					$("button[type=submit]").attr("disabled",false);
    					}
    					},
    					error: function(){
    						console.log("ajax error 메세지 출력 구문: 통신 실패")
    					}				
    				});
    		} else {
    			//길이가 3자 이하면 가리기
    			$("#dupCheckDiv").hide();
    			$("button[type=submit]").attr("disabled",true);	
    		}
    	});
    });
    
    </script>
    
</body>
</html>
