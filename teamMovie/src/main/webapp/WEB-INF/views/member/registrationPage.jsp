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
			display: inline-block;
    		margin: 0 auto;           
        }
        

        .submit-btn:hover {
            background-color: #0056b3;
        }
        
        /*버튼 비활성화 시 시각적으로 보이게 커서 회색 처리, 커서 올릴 수 없도록 처리*/
        .submit-btn:disabled {
    	background-color: #ccc;
    	color: #666;
    	cursor: not-allowed;
    	opacity: 0.6;
		}
		
		  .reset-btn{
            width: 20%;
            padding: 12px;
            background-color: Lightsteelblue;
            border: none;
            color: white;
            font-weight: bold;
            border-radius: 5px;
            cursor: pointer;
			display: inline-block;
    		margin: 0 auto;           
        }
        

        .reset-btn:hover {
            background-color: Lightslategray;
        }
        
        
        .buttons {  
        text-align: center; /*두 버튼 가운데 정렬*/
        margin-top: 20px;
        }	
        
		.idNum {
		  display: flex;
		  align-items: center;
		  gap: 8px;
		  margin-bottom: 16px;
		}

		.idNum input {
		  width: 120px;
		  padding: 8px;
		  font-size: 1rem;
		  border: 1px solid #ccc;
		  border-radius: 5px;
		}

		.separator {
		  font-weight: bold;
		  font-size: 1.2rem;
		  user-select: none;
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
			<div id="dupCheckDiv" style="font-size:0.8em"> </div> <!-- 아이디 중복 여부 메세지창 Div -->

            <label for="memberName">이름</label>
            <input type="text" name="memberName" id="memberName" placeholder="필수 기입 정보입니다." required>

            <label for="password1">비밀번호</label>
            <input type="password" name="password1" id="password1forRegister" placeholder="필수 기입 정보입니다."  required>
			
			<label for="password2">비밀번호 확인</label>
            <input type="password" name="password2" id="password2" placeholder="비밀번호를 다시한번 입력하세요."  required>
			<div id="pwdCheckDiv" style="font-size:0.8em"> </div> <!-- 비밀번호 일치 여부 메세지창 Div -->
			
			<label for="idNumFront">주민번호</label>
			<div class="idNum">
  			<input id="idNumFrontInput" type="text" maxlength="6" placeholder="앞 6자리" />
  			<span class="separator">-</span>
  			<input id="genderCodeInput" type="text" maxlength="1" placeholder="뒤 1자리" />
			<input type="hidden" name="idNum" id="idNumHidden" />
			</div>
			
            <label for="age">나이&nbsp;</label>
            <input type="number" name="age" id="age" readonly style="background-color: #dcdcdc ; width:80px; margin-bottom: 4px;">
			<div id="ageDiv" style="font-size:0.8em; color: gray;">주민등록번호 입력 시 자동 계산됩니다.</div>
			<br>
			
            <label for="email">이메일</label>
            <input type="email" name="email" id="email" >

            <label for="phone">전화번호</label>
            <input type="text" name="phone" id="phone">
			
			<div class="buttons">
            <button type="submit" class="submit-btn">가입하기🎬</button>
        	<button type="reset" class="reset-btn">다시 작성하기</button>
        	</div>
        </form>
    </div>

	<script>

		//$("button[type=submit]").attr("disabled", true);
		//일단 버튼 disabled 걸어놓고, 필요한 부분 다 채워지고, 중복확인, 비밀번호 확인 등 조건 채워지면 마지막에 버튼 활성화 하기 

		let idDupCheckResult = false; // 나중에 validateForm 함수에서 에서 사용할 전역변수 생성, 사용 가능/불가 -> True/False    

		$(function() {
			var idInput = $("#memberIdCheck"); //idInput: 
			idInput.keyup(function() {
				if (idInput.val().length > 3) {
					$.ajax({
						url : "dupCheck.me",
						data : {
							memberId : idInput.val()
						},
						success : function(result) {

							if (result === "NNNNN") { // 중복인 경우	
								$("#dupCheckDiv").show();
								$("#dupCheckDiv").css("color", "red").text(
										"중복된 아이디 입니다.");
								idDupCheckResult = false; //boolean 값 true/false 로 작성하기
								//$("button[type=submit]").attr("disabled",true);
							} else { //NNNNY 사용가능인 경우 
								idDupCheckResult = true; //boolean 값 true/false 로 작성하기
								$("#dupCheckDiv").show();
								$("#dupCheckDiv").css("color", "green").text(
										"사용가능한 아이디 입니다.");
								//$("button[type=submit]").attr("disabled",false);
							}
							validateForm();
						},

						error : function() {
							console.log("ajax error 메세지 출력 구문: 통신 실패");
						}
					});
				} else {
					//길이가 3자 이하면 가리기
					$("#dupCheckDiv").show();
					$("#dupCheckDiv").css("color", "red").text(
							"아이디를 4자 이상으로 입력하세요");
					validateForm();

				}
			});
		});

		let pwdCheckResult = false; // 나중에 validateForm 함수에서 에서 사용할 전역변수 생성, 비밀번호 확인 True/False    

		$(function() {
			var password1 = $("#password1forRegister"); // 첫번째 입력 비밀번호 
			var password2 = $("#password2"); // 두번째 입력 비밀번호 (확인용 - VO 에 없음) 

			$("#password1forRegister,#password2").keyup(function() {
				if (password1.val().length > 3 && password2.val().length > 3) {
					console.log(password1.val(), password2.val());
					
					$.ajax({
						url : "passwordCheck.me",
						type : "POST",
						data : {
							password1 : password1.val(),
							password2 : password2.val()
						},
						success : function(result) {
							if (result === "NNNNY") { //비밀번호와 비밀번호 확인이 일치 일 경우 => 가입가능
								pwdCheckResult = true; //boolean 값 true/false 로 작성하기
								$("#pwdCheckDiv").show();
								$("#pwdCheckDiv").css("color", "green").text(
										"비밀번호가 일치합니다.");
								//$("button[type=submit]").attr("disabled",false);
							} else { //비밀번호와 비밀번호 확인이 불일치 일 경우 => 가입 불가능, 메시지 및 제출 버튼 비활성화
								pwdCheckResult = false; //boolean 값 true/false 로 작성하기
								$("#pwdCheckDiv").show();
								$("#pwdCheckDiv").css("color", "red").text(
										"비밀번호가 일치하지 않습니다. 다시 입력해 주세요.");
								//$("button[type=submit]").attr("disabled",true);
							}
							validateForm();
						},
						error : function() {
							console.log("ajax error 메세지 출력 구문: 통신 실패");
						}
					});
				} else {
					$("#pwdCheckDiv").show();
					$("#pwdCheckDiv").css("color", "blue").text(
							"비밀번호와 비밀번호 확인을 4자리 이상 동일하게 입력하세요");
					validateForm();
				}

			});
		});

		//Null 이면 안되는 입력 조건들    
		/*    MEMBER_ID	VARCHAR2(50 BYTE)	No
		      MEMBER_NAME	VARCHAR2(100 BYTE)	No
		  PASSWORD	VARCHAR2(255 BYTE)	No
		  AGE NUMBER No */
		//idDupCheckResult: True 이고 pwdCheckResult 가 True 이고 나머지 칸 (Name, Age)가 빈칸이 아닐 때 버튼 활성화 조건 만들기
		function validateForm() {
			var memberId = $("#memberIdCheck").val();
			var memberName = $("#memberName").val();
			var idNumFront = $("#idNumFrontInput").val();
			var genderCode = $("#genderCodeInput").val();
			const allFieldsFilled = idNumFront.length === 6 && genderCode.length === 1 && memberName.length > 1
					&& memberId.length > 3;

			if (idDupCheckResult && pwdCheckResult && allFieldsFilled) { // 아이디 중복확인, 비밀번호 확인, 이름 나이 입력 되었을 때 
				$("button[type=submit]").attr("disabled", false);
			} else {
				$("button[type=submit]").attr("disabled", true);
			}
		}

		$(function() {
			// 이름, 나이, 아이디, 비밀번호 입력 시 validateForm 자동 실행
			$("#memberIdCheck, #memberName, #idNumFrontInput,#genderCodeInput, #password1forRegister, #password2").on("input", function() {
						validateForm();
					});
		});
		
		
		  // 앞 6자리 입력 후 자동으로 다음 칸 포커스 이동 (제이쿼리로 작성하기!)
		$(function(){
			  $("#idNumFrontInput").on("input",function(){
				  if($(this).val().length===6){
					  $("#genderCodeInput").focus();
				  }
			  });
		  });  
	
		//주민등록번호 -> 이메일로 옮겨 갈 때 나이 란에는 계산된 나이 값 age 나타나도록 하기
	 $(function(){
		 $("#genderCodeInput").on("blur",function(){
			const idNumFront = $("#idNumFrontInput").val();
			const genderCode = $("#genderCodeInput").val();	
		 	if(idNumFront.length === 6 && genderCode.length ===1){
		 		const fullSevenNums = idNumFront+genderCode; //문자열이 합쳐짐
		 		$("#idNumHidden").val(fullSevenNums);
		 	
		 //나이 계산 함수 사용하여 나이 readonly input 칸에 나이 나타나게 하기
		  	const age = calculateAge(idNumFront,genderCode);
		 if(age!==null){
			 $("#age").val(age).css("background-color","#ddd");
		 }
		 $("#email").focus();	
		 	}
		 });
	 });
		  
		  
	function calculateAge(idNumFront,genderCode){
		
		const yy = parseInt(idNumFront.substring(0,2),10);
		const mm = parseInt(idNumFront.substring(2,4),10);
		const dd = parseInt(idNumFront.substring(4,6),10);
		
		let fullYear;
		if(genderCode ==='1'||genderCode==='2'){
			fullYear = 1900+yy;
		}else if (genderCode==='3'||genderCode==='4'){
			fullYear = 2000+yy;
		}else {
			alert("주민번호 입력값이 잘못되었습니다");
		}
		
		const birthDate = new Date (fullYear, mm-1, dd);
		//new Date 객체는 월은 0부터 세기 때문에 
		const today = new Date();
		
		let age = today.getFullYear()-birthDate.getFullYear();
		
		//생일이 지났는지 안지났는지 구분하기
		const pastBdayThisYear =
			today.getMonth()> birthDate.getMonth()|| // 생일 월이 이미 지났으면 생일 지남
			(today.getMonth()=== birthDate.getMonth() && today.getDate()>=birthDate.getDate());
			
			if(!pastBdayThisYear){
				age--;
			}
		
		    if (age < 0 || age > 100) {
		        alert("주민번호 정보가 잘못되었습니다.");
		        return null;}
		    
		return age;
	 	}
	

	</script>
	

</body>
</html>
