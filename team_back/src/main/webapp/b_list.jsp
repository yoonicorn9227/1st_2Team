<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <title>요청게시판-b_list</title>
    <link rel="stylesheet" href="css/css.css">
     <link href="https://fonts.cdnfonts.com/css/nasa" rel="stylesheet">
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
		#info_m{width: 350px;}
		.wrapper {display: right; align-items: center; width: 1000px; height: 50px; margin-top: 10px; right: 10%;}
		#category{width:80px; height:40px; border:1px solid #003F88; padding:5px; font-size:14px; font-weight: 700; color: #003F88;}
		.stitle{width:400px; height:40px;  display: inline-block;}
		#sword{width:400px; height:38px; border:1px solid #003F88; font-size:14px; }
		#sbtn{width:40px; height:40px; background:#003F88; color: #FDC500;}
		.fas{font-weight: 900; color:white;}
	</style>
	<script>
		$(function(){
			$("#sbtn").click(function(){
				if($("#sword").val()==""){
					alert("검색어를 입력하셔야 합니다.");
					$("#sword").focus();
					return false;
				}//if
				searchFrm.submit();
			});//#sbtn
		});//제이쿼리 최신
	</script>
<body>
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
    <div class="board_wrap">
        <div class="board_title">
            <strong>요청 게시판</strong>
            <p>요청하신 사항 빠르게 업로드 합니다.</p>
        </div>
        <div class="board_list_wrap">
        
        	<div class="wrapper">
		      <form action="b_list.do" name="sFrm" method="post" style="float: right;">
		        <!-- 카테고리부분 -->
		        <select name="category" id="category">
		          <option value="all">전체</option>
		          <option value="btitle">제목</option>
		          <option value="bcontent">내용</option>
		        </select>
		        <!-- 검색어 부분 -->
		        <div class="stitle">
		          <input type="text" size="16" name="sword" id="sword">
		        </div>
		        <button type="button" id="sbtn" ><i class="fas fa-search"></i>검색</button>
		      </form>
		    </div>
		    
            <div class="board_list">
                <div class="top">
                    <div class="num">번호</div>
                    <div class="title">제목</div>
                    <div class="writer">글쓴이</div>
                    <div class="date">작성일</div>
                    <div class="count">조회</div>
                </div>
                 <!--  반복 시작  -->
                 <c:forEach items="${list}" var="sbdto">
                <div>
                    <div class="num">${sbdto.bsno}</div>
                    <div class="title">
                    <c:forEach var="c" begin="1" end="${sbdto.bindent}" step="1" >▶</c:forEach>
                    <a href="b_view.do?page=${page}&bsno=${sbdto.bsno}&category=${category}&sword=${sword}">${sbdto.btitle}</a></div>
                    <div class="writer">${sbdto.id}</div>
                    <div class="date"><fmt:formatDate value="${sbdto.bdate}" pattern="yyyy-MM-dd"/></div>
                    <div class="count">${sbdto.bhit}</div>
                </div>
                 </c:forEach>
                <!--  반복 끝  -->
            </div>
             <div class="board_page">
                <a href="b_list.do?page=1&category=${category}&sword=${sword}"><dl class="bt first"><<</dl></a>
                <c:if test="${page>1}">
               	 <a href="b_list.do?page=${page-1}&category=${category}&sword=${sword}"><dl class="bt prev"><</dl></a>
                </c:if>
                <c:if test="${page<=1}">
                	<a><dl class="bt prev"><</dl></a>
                </c:if>
                <c:forEach var="n" begin="${startPage}" end="${endPage}" step="1">
				    <c:if test="${page==n}">
					<a><dl class="on">${n}</dl></a>
				    </c:if>
				    <c:if test="${page!=n}">
				    <a href="b_list.do?page=${n}&category=${category}&sword=${sword}"><dl>${n}</dl></a>
				    </c:if>
			    </c:forEach>
			   
			    <c:if test="${page<maxPage}">
				<a href="b_list.do?page=${page+1}&category=${category}&sword=${sword}"><dl class="bt next">></dl></a>
			    </c:if>
			    <c:if test="${page>=maxpage}">
			    	<dl class="bt next"></dl>
			    </c:if>
                <a href="b_list.do?page=${maxPage}&category=${category}&sword=${sword}"><dl class="bt last">>></dl></a>
            </div>
            <div class="bt_wrap">
                <a href="b_write.do" class="on">작성글쓰기</a>
                <!--<a href="#">수정</a>-->
            </div>
        </div>
    </div>
    <footer>
		<div id="team">
			<h3>한국 직업전문학교 copyright © ★항공 JAVA 풀스택 개발자 양성과정 5기★ - 2팀( 최창윤 | 조민진 | 정보람 | 김승우 )</h3>
		</div>
	</footer>
</body>
</html>