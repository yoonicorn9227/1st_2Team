<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
	<head>
		<meta charset="UTF-8">
		<title>답글달기</title>
	</head>
	<body>
		<script>
			alert("답글달기를 완료하셨습니다.")
			location.href = "b_list.do?page=${page}";
		</script>
	</body>
</html>