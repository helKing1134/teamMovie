<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    // 캐시 방지 헤더 설정 (브라우저 뒤로가기 시 캐시된 페이지가 뜨는 걸 방지)
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies
%>
<!DOCTYPE html>
<html>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>
	
	<c:choose>
	  <c:when test="${sessionScope.loginUser.role == 'ADMIN'}">
	    <%@ include file="/WEB-INF/views/support/admin.jsp" %>
	  </c:when>
	  <c:otherwise>
	    <%@ include file="/WEB-INF/views/common/main.jsp" %>
	  </c:otherwise>
	</c:choose>
	
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html> 