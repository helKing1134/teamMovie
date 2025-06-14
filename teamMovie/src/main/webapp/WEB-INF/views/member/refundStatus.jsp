<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>환불 현황 페이지</title>

<style type="text/css">

	/* refund-status.css */

.refund-status-container {
  max-width: 800px;
  margin: 50px auto;
  padding: 20px;
  background: #fff;
  border-radius: 16px;
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
  font-family: 'Noto Sans KR', sans-serif;
}

.refund-status-container h2 {
  text-align: center;
  font-size: 28px;
  margin-bottom: 30px;
  color: #333;
}

.refund-status-flow {
  display: flex;
  flex-direction: column;
  gap: 20px;
  padding: 0;
  list-style: none;
  position: relative;
}

.status-node {
  display: flex;
  align-items: flex-start;
  gap: 20px;
  position: relative;
}

.status-circle {
  min-width: 100px;
  text-align: center;
  padding: 12px 0;
  border-radius: 50px;
  font-weight: bold;
  color: white;
  background-color: #ccc;
  transition: all 0.3s ease;
}

.status-desc {
  flex: 1;
  font-size: 15px;
  color: #555;
  padding-top: 5px;
}

/* 상태별 색상 */
.completed .status-circle {
  background-color: #2d89ef;
}

.pending .status-circle {
  background-color: #f0ad4e;
}

.generated .status-circle {
  background-color: #5bc0de;
}

.approved .status-circle {
  background-color: #5cb85c;
}

.done .status-circle {
  background-color: #4caf50;
}

.rejected .status-circle {
  background-color: #d9534f;
}

.rejected .status-desc {
  color: #a94442;
  background: #f2dede;
  border-left: 4px solid #d9534f;
  padding: 10px 15px;
  border-radius: 8px;
}

.rejected button {
  margin-top: 10px;
  margin-right: 10px;
  padding: 6px 14px;
  background-color: #fff;
  border: 1px solid #d9534f;
  border-radius: 6px;
  color: #d9534f;
  font-weight: 500;
  cursor: pointer;
  transition: 0.2s ease;
}

.rejected button:hover {
  background-color: #d9534f;
  color: white;
}

/* 선 연결 효과를 위한 선 */
.refund-status-flow::before {
  content: '';
  position: absolute;
  left: 45px;
  top: 40px;
  bottom: 0;
  width: 4px;
  background-color: #eee;
  z-index: 0;
}

.status-node::before {
  content: '';
  position: absolute;
  left: 50px;
  top: 0;
  bottom: 0;
  width: 2px;
  background-color: transparent;
  z-index: 1;
}

/* 노드 원 강조 애니메이션 (선택적으로 사용 가능) */
.status-circle {
  animation: fadeInUp 0.5s ease both;
}

@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}
	

</style>

</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>
	
	<div class="refund-status-container">

  <h2>환불 현황</h2>
  <hr>

  <ul class="refund-status-flow">

    <!-- 결제 완료 -->
    <li class="status-node completed">
      <div class="status-circle">결제완료</div>
      <div class="status-desc">
      ${m.movieTitle } | ${sch.screeningDate } 
      ${timeMap.startStr } ~ ${timeMap.endStr} |
      ${s.screenName} |
      <c:forEach var="seat" items="${stList }" varStatus="status">
      	<span class="seats-info">
      		${seat.seatCols }열 ${seat.seatRows }번
      		<c:if test="${!status.last}"> / </c:if>
      	</span>
      </c:forEach>
      </div>
      
    </li>

    <!-- 요청 중 -->
    <li class="status-node pending">
      <div class="status-circle">환불요청중</div>
      <div class="status-desc">요청일: ${rf.requestTime }</div>
    </li>


    <!-- 환불 완료 -->
    <c:if test="${rf.status == 'CONFIRM'}">
    <li class="status-node done" >
      <div class="status-circle"  >환불완료</div>
      <div class="status-desc">환불일: ${rf.approveTime }</div>
    </li>
    </c:if>

    <!-- 관리자 반려 (선택적 노드) -->
    <c:if test="${rf.status == 'REJECT'}">
    <li class="status-node rejected">
      <div class="status-circle rejected">반려됨</div>
      <div class="status-desc">
        반려사유: <span class="rejection-reason">${rf.rejectReason }</span><br/>
        <!--  <button onclick="location.href='resubmitRefund.jsp'">다시 요청하기</button>
        <button onclick="location.href='contactSupport.jsp'">고객센터 문의</button>-->
      </div>
    </li>
    </c:if>

  </ul>

</div>
	
	
	
	
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	
	
</body>


<script type="text/javascript">
const refundStatus = "ai";

</script>
</html>