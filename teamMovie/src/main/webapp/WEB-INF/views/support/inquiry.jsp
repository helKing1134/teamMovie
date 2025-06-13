<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container mt-5">
    <h3>1:1 문의 작성</h3>
    <hr>

    <c:choose>
        <c:when test="${not empty loginUser}">
            <form method="post" action="${pageContext.request.contextPath}/support/inquiry" enctype="multipart/form-data">
                <table class="table table-bordered">
                    <tbody>
                        <tr>
                            <th style="width: 15%;">문의유형</th>
                            <td colspan="3">
                                <select class="form-control" name="category" required>
                                    <option value="">문의유형 선택</option>
                                    <option value="예매">예매</option>
                                    <option value="환불">환불</option>
                                    <option value="관람">관람</option>
                                    <option value="이벤트">이벤트</option>
                                    <option value="기타">기타</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th>문의자</th>
                            <td colspan="3">${loginUser.memberId} 님</td>
                        </tr>
                        <tr>
                            <th>제목</th>
                            <td colspan="3">
                                <input type="text" class="form-control" name="title" required />
                            </td>
                        </tr>
                        <tr>
                            <th>내용</th>
                            <td colspan="3">
                                <textarea class="form-control" name="content" rows="6" maxlength="2000" required></textarea>
                                <div class="text-muted small mt-2">
                                    - 개인정보(이름, 연락처, 카드번호 등)를 포함하지 않도록 주의해 주세요.<br>
                                    - 재고 소진 이벤트, 오리지널 티켓 등은 실시간 응대가 어려울 수 있습니다.
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>첨부파일</th>
                            <td colspan="3">
                                <input type="file" class="form-control-file" name="file" multiple />
                                <small class="form-text text-muted">JPEG, PNG 이미지 (5MB 이하, 최대 5개)</small>
                            </td>
                        </tr>
                    </tbody>
                </table>

                <div class="text-right mt-3">
                    <button type="submit" class="btn btn-primary">등록하기</button>
                </div>
            </form>
        </c:when>

        <c:otherwise>
            <div class="alert alert-warning mt-4">로그인 후 이용 가능한 서비스입니다.</div>
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
