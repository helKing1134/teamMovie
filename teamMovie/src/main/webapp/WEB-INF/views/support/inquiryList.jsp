<%@ page contentType="text/html; charset=UTF-8" language="java"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<div class="container mt-5 mb-5">
	<h2 class="mb-4">문의글 관리</h2>

	<table class="table table-hover text-center">
		<thead class="thead-dark">
			<tr>
				<th>No</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>상태</th>
				<th>관리</th>
			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${empty list}">
					<tr>
						<td colspan="6">조회된 게시글이 없습니다.</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="i" items="${list}">
						<tr>
							<td>${i.inquiryId}</td>
							<td>${i.title}</td>
							<td>${i.inquiryWriter}</td>
							<td>${i.createdAt}</td>
							<td><c:choose>
									<c:when test="${i.status == 'N'}">
										<span class="badge badge-warning">답변대기</span>
									</c:when>
									<c:when test="${i.status == 'Y'}">
										<span class="badge badge-success">답변완료</span>
									</c:when>
									<c:otherwise>
										<span class="badge badge-secondary">처리중</span>
									</c:otherwise>
								</c:choose></td>
							<td><a
								href="${contextRoot}/inquiryAnswer?no=${i.inquiryId}"
								class="btn btn-sm btn-outline-primary">답변</a> <a
								
								href="${contextRoot}/deleteInquiry.sp?no=${i.inquiryId}"
								class="btn btn-sm btn-outline-danger"
								onclick="return confirm('삭제하시겠습니까?');">삭제</a></td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>

	<c:if test="${empty list}">
		<p class="text-center text-muted mt-4">등록된 문의가 없습니다.</p>
	</c:if>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>