<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>작성글 수정</title>
	</head>
	<body>
		<script>
			alert("게시글이 수정되었습니다.");
			location.href = "b_list.do?page=${page}";
		</script>
	</body>
</html>