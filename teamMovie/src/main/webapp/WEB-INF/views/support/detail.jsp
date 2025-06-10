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
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
