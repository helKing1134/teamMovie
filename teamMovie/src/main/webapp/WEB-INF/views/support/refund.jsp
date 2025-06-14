<%@ page contentType="text/html; charset=UTF-8" language="java"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
	.confirm{
		color : green;
	}
	.reject{
		color : red;
	}
</style>
</head>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<div class="container mt-5 mb-5">
	<h2 class="mb-4">환불요청 관리</h2>

	<table id="inquiryList" class="table table-hover text-center">
		<thead class="thead-dark">
			<tr>
				<th>No</th>
				<th>결제 아이디</th>
				<th>요청자</th>
				<th>요청일</th>
				<th>상태</th>
				<th>승인</th>
				<th>승인날짜</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="refund" items="${rfList}" varStatus="loop">
		        <tr>
		          <td>${loop.index + 1}</td>
		          <td>${refund.paymentId}</td>
		          <td>${refund.memberName}</td>
		          <td>${refund.requestTime}</td>
		          <td class="status-cell">${refund.status}</td>
		          <td>
				  <c:choose>
				    <c:when test="${refund.status == 'REQUEST'}">
				      <button class="btn btn-success btn-sm approve-btn" data-id="${refund.refundId}">승인</button>
				      <button class="btn btn-danger btn-sm reject-btn" data-id="${refund.refundId}">반려</button>
				    </c:when>
				        <c:when test="${refund.status == 'CONFIRM'}">
					      <span class="confirm">승인됨</span>
					    </c:when>
					    <c:when test="${refund.status == 'REJECT'}">
					      <span class="reject">반려됨</span>
					    </c:when>
				    <c:otherwise>
				      <span class="error">처리불가</span>
				    </c:otherwise>
				  </c:choose>
		          </td>
		          <td>
	            <c:choose>
				    <c:when test="${refund.approveTime != null}">
				      ${refund.approveTime}
				    </c:when>
				    <c:otherwise>
				      -
				    </c:otherwise>
			  </c:choose>
		          </td>
		        </tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<script type="text/javascript">
$(document).ready(function() {
	/* 승인 클릭 이벤트 */
	$(".approve-btn").on("click", function() {
    const refundId = $(this).data("id");
    const $row = $(this).closest("tr");

    if (!confirm("정말 승인하시겠습니까?")) return;

    $.ajax({
      type: "POST",
      url: '<%= request.getContextPath() %>/admin/refund/approve', // 너가 매핑한 컨트롤러 주소로 수정
      data: { refundId: refundId },
      success: function(result) {
        if (result.success) {
          // 상태 변경
          $row.find(".status-cell").text("CONFIRM");
          // 승인 버튼 영역 텍스트로 대체
          $row.find("td:eq(5)").html("<span class='text-success'>완료</span>");
          // 승인날짜 삽입
          $row.find("td:eq(6)").text(result.approveTime);
        } else {
          alert("처리에 실패했습니다.");
        }
      },
      error: function() {
        alert("서버 오류 발생");
      }
    });
  });
	
	
	/* 반려 클릭 이벤트 */
	$(".reject-btn").on("click", function() {
	  const refundId = $(this).data("id");
	  const $row = $(this).closest("tr");

	  if (!confirm("정말 반려하시겠습니까?")) return;
	  
	  //반려 사유 입력 창 
	  const reason = prompt("반려 사유를 입력해주세요:");
	  if (!reason || reason.trim() === "") {
	    alert("반려 사유는 필수입니다.");
	    return;
	    
	  }
	  console.log(reason);

	  $.ajax({
	    type: "POST",
	    url: '<%= request.getContextPath() %>/admin/refund/reject', // 반려용 컨트롤러 매핑 주소
	    data: { 
	    	refundId: refundId,
    	 	rejectReason: reason
	    	},
	    success: function(result) {
	      if (result.success) {
	        // 상태 변경
	        $row.find(".status-cell").text("REJECT");
	        // 버튼 영역 텍스트로 대체
	        $row.find("td:eq(5)").html("<span class='text-danger'>반려됨</span>");
	        // 승인날짜 칸은 비워두거나 '-' 유지 (혹은 반려시간을 따로 찍을 수도 있음)
	        $row.find("td:eq(6)").text("-");
	      } else {
	        alert("처리에 실패했습니다.");
	      }
	    },
	    error: function() {
	      alert("서버 오류 발생");
	    }
	  });
	});
});
</script>

</html>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>