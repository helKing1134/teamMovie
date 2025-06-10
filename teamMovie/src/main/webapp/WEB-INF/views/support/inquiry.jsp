<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">
    <title>1:1 문의</title>
    <style>
    .inquiry-container {
        max-width: 800px;
        margin: 2rem auto;
        padding: 2rem;
        background-color: #1b1b1b;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
        color: #f0f0f0;
        font-family: 'Noto Sans KR', sans-serif;
    }

    .inquiry-container h2 {
        font-size: 1.8rem;
        margin-bottom: 1.5rem;
        color: #fff;
    }

    .inquiry-form label {
        display: block;
        margin: 1rem 0 0.5rem;
        font-weight: 500;
    }

    .inquiry-form input[type="text"],
    .inquiry-form input[type="email"],
    .inquiry-form textarea {
        width: 100%;
        padding: 0.8rem;
        border: none;
        border-radius: 5px;
        background-color: #2c2c2c;
        color: #fff;
        font-size: 1rem;
    }

    .inquiry-form textarea {
        resize: vertical;
    }

    .inquiry-form .notice {
        font-size: 0.85rem;
        color: #aaa;
        background-color: #1e1e1e;
        padding: 0.75rem;
        border-radius: 4px;
        margin-top: 0.5rem;
        line-height: 1.5;
    }

    .inquiry-form button {
        margin-top: 2rem;
        padding: 0.75rem 1.5rem;
        background-color: #9b4722;
        color: #fff;
        border: none;
        border-radius: 5px;
        font-size: 1rem;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    .inquiry-form button:hover {
        background-color: #7f3618;
    }
</style>


</head>
<body>


<%@ include file="/WEB-INF/views/common/header.jsp" %>



<div class="inquiry-container">
    <h1>1:1 문의</h1>

    <form method="post" action="${contextRoot}/support/inquiry" > <!-- enctype="multipart/form-data" -->
        <div class="row">
            <div class="input-group">
                <label for="category">문의유형</label>
                <select id="category" name="category" required>
                    <option value="">문의유형 선택</option>
                    <option value="예매">예매</option>
                    <option value="환불">환불</option>
                    <option value="관람">관람</option>
                    <option value="이벤트">이벤트</option>
                    <option value="기타">기타</option>
                </select>
            </div>
            
        </div>

        <div class="row">
            <span> 문의자 : ${loginUser.memberId} 님</span>
        </div>

        <div class="input-group">
            <label for="title">제목</label>
            <input type="text" id="title" name="title" required />
        </div>

        <div class="input-group">
            <label for="content">내용</label>
            <textarea id="content" name="content" maxlength="2000" required></textarea>
            <div class="notice">
                - 개인정보(이름, 연락처, 카드번호 등)를 포함하지 않도록 주의해 주세요.<br>
                - 재고 소진 이벤트, 오리지널 티켓 등은 실시간 응대가 어려울 수 있습니다.
            </div>
        </div>

        <div class="input-group">
            <label for="file">첨부파일</label>
            <input type="file" id="file" name="file" multiple />
            <div class="file-info">* JPEG, PNG 이미지 (5MB 이하, 최대 5개)만 첨부 가능합니다.</div>
        </div>

        <input type="submit" value="등록하기" />
    </form>
</div>


<script>
   
   
</script>


<%@ include file="/WEB-INF/views/common/footer.jsp" %>


</body>
</html>