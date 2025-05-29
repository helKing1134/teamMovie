<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<style type="text/css">
		
	.choice-container {
	  display: flex;
	  flex-direction: row; /* 기본값이지만 명시적으로 적어줌 */
	  gap: 20px; /* div들 사이 간격 */
	}
	
	</style>
<meta charset="UTF-8">
<title>무비 select page</title>
</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<h1>예매</h1>
<div class="choice-container">
<div class="movie-choice">
	<ul>
		<li>
			1번
		</li>
		<li>
			1_2번
		</li>
	</ul>
</div>

<div class="theater-choice">

	<ul>
		<li>
			2번
		</li>
	</ul>

</div>

<div class="time-choice">

	<ul>
		<li>
			3번
		</li>
	</ul>

</div>
</div>


<%@ include file="/WEB-INF/views/common/footer.jsp" %>

<br><br><br><br><br><br><br><br>
</body>
</html>