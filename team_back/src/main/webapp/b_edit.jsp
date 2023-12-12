<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    <c:if test="${session_id!=sbdto.id}">
		<script>
			alert("글 작성자만 수정이 가능합니다.");
			location.href="b_view.do?page=${page}&bsno=${sbdto.bsno}";
		</script>
	</c:if>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <title>요청게시글 수정 - b-edit.jsp</title>
    <link rel="stylesheet" href="css/css.css">
     <style>
		footer {margin-top: 20px;padding: 65px 0;border-top: 1px solid #ddd;
		text-align: center; display: flex;  height: 100%;
		font-size: 1.4rem; background-color:#003F88; color: #FFD500;}
		header {text-align: center; background-color:#003F88; height: 200px;}
		header .logo {padding: 20px 0; color: #FFD500; font-size: 100px; font-family: 'Nasa', sans-serif; position: relative; top:30px;}
		header .logo img {height: 40px;}
		nav{padding: 25px; position: absolute;top: 0; right: 0;}
		nav li {display: inline-block; margin: 0 20px;}
		nav a {font-size: 1.4rem;color: #FFD500; font-size: 20px;}
		#logo_name{font-size: 1.4rem; color: #FFD500; font-size: 20px;}
		nav a:hover {text-decoration: underline;}
		.border{color: #FFD500; font-weight: 700; font-size: 20px; margin-top: 120px;}
		#team{position: relative; left: 500px;}
		#id{width: 350px;}
	</style>
	<script>
		$(function(){
			$(".on").click(function(){
				alert("파일을 첨부합니다.");
				e_frm.submit();
			});//.on
		});//제이쿼리 최신
	</script>
</head>
<header>
   	 <h1 class="logo"><a href="a_main.do">JJAGEUL</a></h1>
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
</head>
<body>
    <div class="board_wrap">
        <div class="board_title">
            <strong>게시글 수정</strong>
            <p>요청게시판 게시글을 수정합니다.</p>
        </div>
        <form name="e_frm" method="post" action="doB_edit.do" enctype="multipart/form-data">
        <div class="board_write_wrap">
            <div class="board_write">
               <div class="title">
              	<input type="hidden" name="page" value="${page}">
              	<input type="hidden" name="bsno" value="${sbdto.bsno}">
		     	<input type="hidden" name="id" value="${session_id}">
		    	<input type="hidden" name="oldfile" value="${sbdto.bfile}">
					<dl>
						<dt>제목</dt>
						<dd><input type="text"  name="btitle" id="btitle" value="${sbdto.btitle}"></dd>
					</dl>
				</div>
				<div class="info">
					<dl>
						<dt>글쓴이</dt>
						<dd><input type="text" name="id" id="id"  value="${session_id}" readonly></dd>
					</dl>
					<dl>
						<dt>첨부파일</dt>
						<dd><input type="file" name="bfile" id="bfile">${sbdto.bfile}<img src="upload/${sbdto.bfile}" style="width:50px; vertical-align: middle; margin-left:20px;"></dd>
					</dl>
				</div>
				<div class="cont">
					<textarea name="bcontent" id="bcontent">${sbdto.bcontent}</textarea>
				</div>
            </div>
            <div class="bt_wrap">
                <a class="on">작성글 수정</a>
                <a href="b_list.do">취소</a>수정
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