<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	
	<!-- CDN으로 Summernote 불러오기 -->
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
</head>
<body>
	<!-- 에디터가 들어갈 textarea -->
	<textarea id="summernote"></textarea>
	
	<script>
	  $(document).ready(function() {
	    $('#summernote').summernote({
	      height: 300,                 // 에디터 높이
	      placeholder: '줄거리를 입력하세요',
	      toolbar: [
	        ['style', ['bold', 'italic', 'underline']],
	        ['font', ['fontsize', 'color']],
	        ['para', ['ul', 'ol', 'paragraph']],
	        ['insert', ['link', 'picture']],
	        ['view', ['codeview']]
	      ]
	    });
	  });
	</script>
</body>
</html>