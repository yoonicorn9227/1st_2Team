<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <title>답글달기 - b_reply.jsp</title>
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
				if($("#btitle").val()==""){
					alert("제목을 입력해야만 합니다. 제목을 확인해주세요.");
					$("#btitle").focus();
					return false;
				}
				r_frm.submit();
			})
		})
	</script>
</head>
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
</head>
<body>
    <div class="board_wrap">
        <div class="board_title">
            <strong>답글달기</strong>
            <p>요청하신 글에 대한 답급입니다.(링크를 누르시면 다운로드가 가능합니다.)</p>
        </div>
        <form name="r_frm" method="post" action="doB_reply.do" enctype="multipart/form-data">
        <div class="board_write_wrap">
            <div class="board_write">
               <div class="title">
              	<input type="hidden" name="page" value="${page}">
              	<input type="hidden" name="id" value="${session_id}">
              	<input type="hidden" name="bgroup" value="${sbdto.bgroup}">
      			<input type="hidden" name="bstep" value="${sbdto.bstep}">
      			<input type="hidden" name="bindent" value="${sbdto.bindent}">
					<dl>
						<dt>제목</dt>
						<dd><input type="text"  name="btitle" id="btitle" value="[답글] ${sbdto.btitle}"></dd>
					</dl>
				</div>
				<div class="info">
					<dl>
						<dt>글쓴이</dt>
						<dd><input type="text" name="id" id="id"  value="${session_id}" readonly></dd>
					</dl>
					<dl>
						<dt>첨부파일</dt>
						<dd><input type="file" name="bfile" id="bfile">${sbdto.bfile}</dd>
					</dl>
				</div>
				<div class="cont">
					<textarea name="bcontent" id="bcontent">

 - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 ${sbdto.bcontent}</textarea>
				</div>
            </div>
            <div class="bt_wrap">
                <a class="on">답글 저장</a>
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