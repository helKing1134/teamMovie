<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container mt-5">
    <h3>문의 상세 및 답변 작성</h3>
    <hr>
	
    <!-- 문의 상세 정보 -->
    <table class="table">
        <tr>
            <th>문의 유형</th>
            <td colspan="3">${i.category}</td>
        </tr>
        <tr>
            <th style="width: 15%;">제목</th>
            <td colspan="3">${i.title}</td>
        </tr>
        <tr>
            <th>내용</th>
            <td colspan="3" style="height: 200px;">${i.content}</td>
        </tr>
        <tr>
            <th style="width: 15%; font-size: 0.9em;">작성자</th>
            <td style="width: 20%; font-size: 0.9em;">${i.inquiryWriter}</td>
            <th style="width: 15%; font-size: 0.9em;">작성일</th>
            <td style="width: 20%; font-size: 0.9em;">${i.createdAt}</td>
        </tr>
    </table>

    <!-- 답변 작성 폼 -->
  <c:choose>
    <c:when test="${i.status == 'N'}">
        <c:choose>
            <c:when test="${sessionScope.loginUser.role == 'ADMIN'}">
                <!-- 관리자만 답변 작성 가능 -->
                <form action="${contextRoot}/detail" method="post">
                    <input type="hidden" name="inquiryId" value="${i.inquiryId}">

                    <div class="form-group">
                        <label for="answerContent">답변 내용</label>
                        <textarea class="form-control" id="answerContent" name="answerContent" rows="6" placeholder="답변을 입력하세요" required></textarea>
                    </div>

                    <div class="text-right mt-3">
                        <button type="submit" class="btn btn-primary">답변 등록</button>
                        <a href="${contextRoot}/inquiryList" class="btn btn-secondary">목록으로</a>
                    </div>
                </form>
            </c:when>
            <c:otherwise>
                <!-- 고객에게 보여주는 메시지 -->
                <div class="alert alert-info mt-4" role="alert">
                    답변을 준비 중입니다. 빠른 시일 내에 답변드리겠습니다.
                </div>
            </c:otherwise>
        </c:choose>
    </c:when>

    <c:otherwise>
        <!-- 답변 완료된 경우 누구에게나 보이는 답변 내용 -->
        <hr class="my-4" />
        <table class="table" style="background-color: transparent; border: none;">
            <tr>
                <th style="width: 20%;">답변 내용</th>
                <td colspan="3" style="min-height: 200px; vertical-align: top; padding: 0.75rem 1.25rem;">${a.answerContent}</td>
            </tr>
            <tr>
                <th style="width: 20%; font-size: 0.9em;">답변일</th>
                <td colspan="3" style="font-size: 0.9em;">${a.answeredAt}</td>
            </tr>
        </table>
    </c:otherwise>
</c:choose>

    
    
    
    
    
    
    
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %> 
