<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
    #footer {
        width: 100%;
        background: linear-gradient(90deg, #000000, #000000);
        color: white;
        border-radius: 8px 8px 0 0;
        box-shadow: 0 -4px 8px rgba(0, 0, 0, 0.5);
        font-family: 'Noto Sans KR', sans-serif;
        padding: 40px 20px 20px;
        box-sizing: border-box;
        text-align: center;
    }

    /* 기존 버튼형 스타일 (필요하면 유지) */
    .footer-link-button {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        text-decoration: none;
        background-color: transparent;
        border: 2px solid #fff;
        padding: 8px 14px;
        border-radius: 8px;
        color: white;
        transition: all 0.3s;
        font-weight: 600;
        margin-bottom: 20px;
    }

    .footer-link-button:hover {
        background-color: #ffcc00;
        color: #000;
        border-color: #ffcc00;
    }

    .footer-link-button img {
        width: 40px;
        height: 40px;
        object-fit: contain;
    }

    /* 새로 넣는 심플 링크 스타일 */
    .footer-link-simple {
        display: inline-flex;
        flex-direction: column;
        align-items: center;
        gap: 8px;
        text-decoration: none;
        color: white;
        font-weight: 600;
        cursor: pointer;
        margin-bottom: 20px; /* 아래 공간 약간 띄우기 */

        
    }

    .footer-link-simple img {
        width: 40px;
        height: 40px;
        object-fit: contain;
    }

    .footer-link-simple span {
         
        transition: border-color 0.3s;
    }

    .footer-link-simple:hover span {
        border-bottom-color: white;
    }

    /* 하단 링크들 */
    #footer-1 {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 30px;
        padding: 15px 0;
        border-top: 0 solid rgba(255, 255, 255, 0.1);
       
    }
    .footer-link-simple:hover {
    color: white; /* 추가! */
	}

    #footer-1 > a {
        text-decoration: none;
        font-weight: 600;
        color: white;
        transition: color 0.3s;
    }

    #footer-1 > a:hover {
        color: #ffcc00;
    }
</style>

<div id="footer">
    <!-- 기존 버튼 스타일 예시 (필요 없으면 삭제 가능) -->
    <!--
    <a href="#" class="footer-link-button">
        <img src="${pageContext.request.contextPath}/images/CustomerService.jpg" alt="고객센터">
        <span>고객센터</span>
    </a>
    -->

    <!-- 새 심플 스타일 링크 (헤드셋 아이콘 + 고객센터 텍스트) -->
    <a href="#" class="footer-link-simple">
        <img src="${pageContext.request.contextPath}/images/CustomerService.jpg" alt="고객센터">
        <span>고객센터</span>
    </a>

    <!-- 하단 링크들 -->
    <div id="footer-1">
        <a href="#">이용약관</a>
        <a href="https://www.megabox.co.kr/support/privacy">개인정보처리방침</a>
        <h6>당산점 : 서울특별시 영등포구 선유동2로 57 이레빌딩(구관) 19F, 20F</h6>
    </div>
</div>