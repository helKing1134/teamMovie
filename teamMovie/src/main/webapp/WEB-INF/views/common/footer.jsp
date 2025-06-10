<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <style>
        /* div{border:1px solid red;} */
		#footer {
		    width: 80%;
		    height: 200px;
		    margin: auto;
		    margin-top: 50px;
		    background: linear-gradient(90deg, #111111, #333333); /* 헤더와 어울리는 다크 그라데이션 */
		    color: white;
		    border-radius: 8px;
		    box-shadow: 0 -4px 8px rgba(0, 0, 0, 0.5);
		    font-family: 'Noto Sans KR', sans-serif;
		}
		
		#footer-1 {
		    width: 100%;
		    height: 20%;
		    border-top: 1px solid rgba(255, 255, 255, 0.3);
		    border-bottom: 1px solid rgba(255, 255, 255, 0.3);
		    padding-left: 50px;
		    display: flex;
		    align-items: center;
		}
		
		#footer-1 > a {
		    text-decoration: none;
		    font-weight: 600;
		    margin-right: 15px;
		    color: white;
		    transition: color 0.3s;
		}
		
		#footer-1 > a:hover {
		    color: #ffcc00; /* 헤더 호버 컬러와 동일하게 */
		}
		
		#footer-1 > a:not(:last-child)::after {
		    content: "|";
		    margin-left: 15px;
		    color: rgba(255, 255, 255, 0.5);
		}
		
		#footer-2 {
		    width: 100%;
		    height: 80%;
		    padding-left: 50px;
		}
		
		#footer-2 > p {
		    margin: 0;
		    padding: 10px 0;
		    font-size: 13px;
		    color: rgba(255, 255, 255, 0.7);
		}
		
		#p2 {
		    text-align: center;
		}
    </style>
</head>
<body>
    <div id="footer">
        <div id="footer-1">
            <a href="#">이용약관</a> | 
            <a href="#">개인정보취급방침</a> | 
            <a href="${contextRoot}/support">고객센터</a>
        </div>
        
    </div>
</body>
</html>