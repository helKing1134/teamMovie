<%@ page contentType="text/html; charset=UTF-8" language="java"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

    <style>
        .content {
            background-color:rgb(247, 245, 245);
            width:80%;
            margin:auto;
        }
        .innerOuter {
            border:1px solid lightgray;
            width:80%;
            margin:auto;
            padding:5% 10%;
            background-color:white;
        }

        #boardList {text-align:center;}
        #boardList>tbody>tr:hover {cursor:pointer;}

        #pagingArea {width:fit-content; margin:auto;}
        
        #searchForm {
            width:80%;
            margin:auto;
        }
        #searchForm>* {
            float:left;
            margin:5px;
        }
        .select {width:20%;}
        .text {width:53%;}
        .searchBtn {width:20%;}
    </style>

<div class="container mt-5 mb-5">
	<h2 class="mb-4">문의글 관리</h2>
	

	
	
	<table id="inquiryList" class="table table-hover text-center">
		<thead class="thead-dark">
			<tr>
				<th>No</th>
				<th>문의유형</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>상태</th>
				<th>관리</th>
			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${empty list}">
					<tr>
						<td colspan="7">조회된 게시글이 없습니다.</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="i" items="${list}">
						<tr>
							<td>${i.inquiryId}</td>
							<td>${i.category}</td>
							<td>${i.title}</td>
							<td>${i.inquiryWriter}</td>
							<td>${i.createdAt}</td>
							<td><c:choose>
									<c:when test="${i.status == 'N'}">
										<span class="badge badge-warning">답변대기</span>
									</c:when>
									<c:when test="${i.status == 'Y'}">
										<span class="badge badge-success">답변완료</span>
									</c:when>
									<c:otherwise>
										<span class="badge badge-secondary">처리중</span>
									</c:otherwise>
								</c:choose></td>
							<td><a
								href="${contextRoot}/detail?bno=${i.inquiryId}"
								class="btn btn-sm btn-outline-primary">답변</a> <a
								
								href="${contextRoot}/deleteAnswer?bno=${i.inquiryId}"
								class="btn btn-sm btn-outline-danger"
								onclick="return confirm('삭제하시겠습니까?');">삭제</a></td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>
	
				<script>
				//게시글을 클릭했을때 상세보기 할 수 있도록 처리하는 함수 준비 
				//상세보기 요청 매핑주소 : detail.bo
				//메소드명 boardDetail() - SELECT
				//조회수 증가 메소드명 increaseCount() - DML  
				//조회수 증가가 성공이라면 게시글 조회해서 상세페이지로 전달 및 이동 
				//실패시 오류발생 메시지를 담고 에러페이지로 위임처리하기
				$(function(){
					
					$("#inquiryList>tbody>tr").click(function(){
						//글번호 추출
						var bno = $(this).children().first().text();
						//console.log(bno);
						location.href="${contextRoot}/detail?bno="+bno;
					});
					
					//검색 condition 유지
					$("option[value=${map.condition}]").attr("selected",true);
				});
			</script>
			
			<script>
$(function(){
    $(".status-filter").on("change", function(){
        const selectedStatuses = $(".status-filter:checked").map(function(){
            return $(this).val();
        }).get();

        $.ajax({
            url: "${contextRoot}/filterInquiries",
            type: "GET",
            data: { statuses: selectedStatuses },
            traditional: true, // 배열을 쿼리스트링으로 보낼 때 필요
            success: function(data){
                // 테이블 바디 업데이트
                let tbody = $("#inquiryList tbody");
                tbody.empty();

                if(data.length === 0){
                    tbody.append('<tr><td colspan="7">조회된 게시글이 없습니다.</td></tr>');
                } else {
                    data.forEach(function(i){
                        let statusBadge = "";
                        if(i.status === 'N'){
                            statusBadge = '<span class="badge badge-warning">답변대기</span>';
                        } else if(i.status === 'Y'){
                            statusBadge = '<span class="badge badge-success">답변완료</span>';
                        } else {
                            statusBadge = '<span class="badge badge-secondary">처리중</span>';
                        }

                        tbody.append(`
                            <tr>
                                <td>${i.inquiryId}</td>
                                <td>${i.category}</td>
                                <td>${i.title}</td>
                                <td>${i.inquiryWriter}</td>
                                <td>${i.createdAt}</td>
                                <td>${statusBadge}</td>
                                <td>
                                    <a href="${contextRoot}/detail?bno=${i.inquiryId}" class="btn btn-sm btn-outline-primary">답변</a>
                                    <a href="${contextRoot}/deleteAnswer?bno=${i.inquiryId}" class="btn btn-sm btn-outline-danger" onclick="return confirm('삭제하시겠습니까?');">삭제</a>
                                </td>
                            </tr>
                        `);
                    });
                }
            },
            error: function(){
                alert("데이터 로딩 실패");
            }
        });
    });
});
</script>
			

	<c:if test="${empty list}">
		<p class="text-center text-muted mt-4">등록된 문의가 없습니다.</p>
	</c:if>
	
	
	
	
			<!-- 
				검색시 검색어와 선택상자가 작성한것으로 남아있도록 처리 하기 
				페이징바 클릭했을때 페이징처리된 결과가 보여지도록 요청처리 
			 -->
			<!-- list.bo 또는 search.bo  -->
			<c:url var="url" value="${empty map?'list.bo':'search.bo'}">
				<c:if test="${not empty map }"> <!-- 검색 -->
					<c:param name="condition">${map.condition }</c:param>
					<c:param name="keyword" value="${map.keyword }" />
				</c:if>
				<c:param name="currentPage"></c:param>
			</c:url>
			
			
			<form id="pageForm" method="post" action="${contextRoot}/inquiryList">
			    <input type="hidden" name="currentPage" id="currentPageInput" />
			</form>
			
			<div id="pagingArea">
			    <ul class="pagination">
			        <c:forEach var="i" begin="${pi.startPage}" end="${pi.endPage}">
			            <li class="page-item">
			                <a class="page-link" href="#" onclick="goToPage(${i})">${i}</a>
			            </li>
			        </c:forEach>
			    </ul>
			</div>
			
			<script>
			    function goToPage(pageNumber) {
			        document.getElementById("currentPageInput").value = pageNumber;
			        document.getElementById("pageForm").submit();
			    }
			</script>


            <br clear="both"><br>

            <br><br>
        </div>
        <br><br>

	
	
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>