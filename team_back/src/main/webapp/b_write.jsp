<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="UTF-8">
		<c:if test="${session_id==null}">
			<script>
				alert("로그인을 해야만 접속이 가능합니다.");
				location.href="a_login.do";
			</script>
		</c:if>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>요청게시글 글쓰기-m_write.jsp</title>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<link rel="stylesheet" href="css/css.css">
		<link href="https://fonts.cdnfonts.com/css/nasa" rel="stylesheet">
	</head>
	<style>
		footer {margin-top: 20px; padding: 65px 0; border-top: 1px solid #ddd; text-align: center;
				display: flex; height: 100%; font-size: 1.4rem; background-color: #003F88; color: #FFD500;}
		header {text-align: center; background-color: #003F88; height: 200px;}
		header .logo {padding: 20px 0; color: #FFD500; font-size: 100px; font-family: 'Nasa', sans-serif; position: relative; top: 30px;}
		header .logo img {height: 40px;}
		nav {padding: 25px; position: absolute; top: 0; right: 0;}
		nav li {display: inline-block; margin: 0 20px;}
		nav a {font-size: 1.4rem; color: #FFD500; font-size: 20px;}
		#logo_name{font-size: 1.4rem; color: #FFD500; font-size: 20px;}
		nav a:hover {text-decoration: underline;}
		.border {color: #FFD500; font-weight: 700; font-size: 20px; margin-top: 120px;}
		#team {position: relative; left: 500px;}
		#info_m {width: 350px;}
	</style>
	<script>
		$(function(){
			$(".on").click(function(){
				//alert("파일을 첨부합니다.");
				if($("#btitle").val().length<1){
					alert("※게시글 제목을 입력하세요.");
					$("#btitle").focus();
					return false;
				}//if(게시글 제목)
				w_frm.submit();
			})//.on
		})//제이쿼리 최신
	</script>
<body>
	<header>
		<h1 class="logo"><a href="">JJAGEUL</a></h1>
		<nav>
			<ul>
				<li id="logo_name">${session_name}님</li>
				<li class="border">|</li>
				<li><a href="a_myPage.do">회원정보</a></li>
				<li class="border">|</li>
				<li><a href="a_logout.do">로그아웃</a></li>
				<li class="border">|</li>
				<li><a href="a_main.do">메인페이지</a></li>
			</ul>
		</nav>
	</header>
	
	<div class="board_wrap">
		<div class="board_title">
			<strong>요청게시글 작성</strong>
			<p>다시보고 싶은 영상의 교육내용 또는 교육일자를 내용안에 입력해주세요.</p>
		</div>
		<form name="w_frm" method="post" action="doB_write.do" enctype="multipart/form-data">
		<div class="board_write_wrap">
			<div class="board_write">
				<div class="title">
					<dl>
						<dt>제목</dt>
						<dd>
							<input type="text" name="btitle" id="btitle" placeholder="제목 입력">
						</dd>
					</dl>
				</div>
				<div class="info">
					<dl>
						<dt>글쓴이</dt>
						<dd><input type="text" id="info_m" name="id" value="${session_id}" readonly></dd>
					</dl>
					<dl>
						<dt>첨부파일</dt>
						<dd>
							<input type="file" name="bfile" id="bfile">
						</dd>
					</dl>
				</div>
				<div class="cont">
					<textarea name="bcontent" placeholder="내용 입력"></textarea>
				</div>
			</div>
			<div class="bt_wrap">
				<a class="on">작성글 저장</a>
				<a href="b_list.do">취소</a>
			</div>
		</div>
		</form>
	</div>
	<footer>
		<div id="team">
			<h3>한국 직업전문학교 copyright © ★항공 JAVA 풀스택 개발자 양성과정 5기★ - 2팀( 최창윤 | 조민진 | 정보람 | 김승우 )</h3>
		</div>
	</footer>
</body>
</html>