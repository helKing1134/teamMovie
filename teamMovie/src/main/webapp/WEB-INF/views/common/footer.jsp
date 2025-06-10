<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
    #footer {
        width: 100%;
        height: 200px;
        background: linear-gradient(90deg, #111111, #333333);
        color: white;
        border-radius: 8px 8px 0 0;
        box-shadow: 0 -4px 8px rgba(0, 0, 0, 0.5);
        font-family: 'Noto Sans KR', sans-serif;
        padding-top: 40px;
        box-sizing: border-box;
    }

    #footer-1 {
        width: 100%;
        height: 20%;
        border-top: 1px solid rgba(255, 255, 255, 0.3);
        border-bottom: 1px solid rgba(255, 255, 255, 0.3);
        padding-left: 50px;
        display: flex;
        align-items: center;
        gap: 15px;
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
    <div id="footer-1">
        <a href="#">이용약관</a>
        <a href="#">개인정보취급방침</a>
        <a href="#">고객센터</a>
    </div>
</div>
