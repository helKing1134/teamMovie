<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container mt-5">
    <h3>나의 문의 내역</h3>
    <hr>

    <c:choose>
        <c:when test="${empty list}">
            <div class="alert alert-info text-center">
                등록한 문의가 없습니다.
            </div>
        </c:when>
        <c:otherwise>
            <table class="table table-hover text-center">
                <thead class="thead-light">
                    <tr>
                        <th>문의 번호</th>
                        <th>제목</th>
                        <th>유형</th>
                        <th>작성일</th>
                        <th>상태</th>
                        <th>관리</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="i" items="${list}">
                        <tr>
                            <td>${i.inquiryId}</td>
                            <td class="text-left">${i.title}</td>
                            <td>${i.category}</td>
                            <td>${i.createdAt}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${i.status eq 'Y'}">
                                        <span class="text-success">답변 완료</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-secondary">미답변</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a href="${contextRoot}/detail?bno=${i.inquiryId}" class="btn btn-sm btn-outline-primary">상세</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>


<script>
    window.addEventListener("DOMContentLoaded", function () {
        const loginRequired = "${loginRequired}";
        if (loginRequired === 'true') {
            alert("로그인 후 이용 가능한 서비스입니다.");
            $('#loginModal').modal('show');
        }
    });
</script>


<%@ include file="/WEB-INF/views/common/footer.jsp" %>
