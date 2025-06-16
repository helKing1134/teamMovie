<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container mt-5">
    <h3 class="mb-4">👥 회원 관리</h3>

    <table class="table table-bordered text-center">
        <thead class="thead-light">
            <tr>
          	    <th>화원 NO</th>
                <th>회원 ID</th>
                <th>이름</th>
                <th>이메일</th>
                <th>전화번호</th>
                <th>권한</th>
                <th>가입일</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="m" items="${members}">
                <tr>
                    <td>${m.memberNo}</td>
                    <td>${m.memberId}</td>
                    <td>${m.memberName}</td>
                    <td>${m.email}</td>
                    <td>${m.phone}</td>
                    <td>${m.role}</td>
                    <td>${m.createdDate}</td>
                </tr>
            </c:forEach>

            <c:if test="${empty members}">
                <tr>
                    <td colspan="7">등록된 회원이 없습니다.</td>
                </tr>
            </c:if>
        </tbody>
    </table>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
