<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>좌석 선택 페이지</title>
<style type="text/css">
	.screen-wraper {
	
	  position: relative;
	  margin-bottom: 20px;
	
	}
	
	.screen-label{
	
	  font-weight: bold;
	  position: absolute;
	  top: 45px;
	  font-size: 24px;
	  z-index: 2;
	  position: relative;
	
	}
	
	.screen-curve {
	  position: absolute;
	  top: 30px; /* SCREEN 텍스트 위로 */
	  left: 50%;
	  transform: translateX(-50%);
	  width: 900px;
	  height: 100px;
	  border-top: 4px solid rgba(128, 128, 128, 0.5); /* 반투명 회색 */
	  border-radius: 50%/100%;
	  z-index: 10;
	}
	

	
		.seat-area {
		  display: flex;
		  flex-direction: column;
		  align-items: center; /* 모든 seat-row를 중앙 정렬 */
		  gap: 10px;
		}
		
		.seat-row {
		  display: flex;
		  justify-content: center;
		  gap: 10px;
		  position: absolute;
		  top: 200px; /* screen 밑으로 충분히 내림 */
		  left: 50%;
		  transform: translateX(-50%);
		  z-index: 11;
		}

		
		.seat {
		  width: 40px;
		  height: 40px;
		  background-color: #ccc;
		  border-radius: 6px;
		  text-align: center;
		  line-height: 40px;
		  font-weight: bold;
		  cursor: pointer;
		  border: none;
		}
		
		.seat.selected {
		  background-color: #4CAF50;
		  color: white;
		}
		
		.seat.occupied {
		  background-color: #999;
		  cursor: not-allowed;
		}



</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>
	
	<div class="screen-wraper">
		<div class="screen-curve"></div>
		
		
		<div align="center" class="screen-label">
			<h4>SCREEN </h4>
		</div>
	</div>
	
	
<div class="seat-row">
  <button class="seat" id="A1">A1</button>
  <button class="seat" id="A2">A2</button>
  <button class="seat" id="A3">A3</button>
  <button class="seat" id="A4">A4</button>
</div>
	
	<br><br><br><br><br><br><br><br><br><br><br><br><br>
	
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	
	
	
</body>
</html>