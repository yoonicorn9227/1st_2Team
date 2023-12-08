<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
    <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
	<script src="js/like-dislike.js"></script>
    <title>요청게시판-b_view.jps</title>
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
		
		.likebox {
		    font-size: 25px; font-weight:700;
		    background-size: cover;
		    width: 85px;
		    height: 85px;
		    transition: background-image 0.5s ease-in-out;
		    position: relative;
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    margin:0 auto;
		}
		
		.likebox .likeNo {
		    position: absolute;
		    top: 50%;
		    left: 50%;
		    transform: translate(-50%, -50%);
		    color: #003F88;
		}
		
		.likebox:hover {
		    background-image: url('./images/icon-heart_ani.gif');
		}
				
		
		.likebox:hover .likeNo {
		    top: 50%; /* Adjust as needed */
		    left: 50%; /* Adjust as needed */
		    transform: translate(-50%, -50%);
		}

       
		
	</style>
	
	<script>
		$(function(){
			$("#deleteBtn").click(function(){
				if(confirm("게시글을 삭제하시겠습니까?")){
					location.href="b_delete.do?page=${page}&bsno=${sbdto.bsno}";
					
				}
			});
		});//j
		
		
		
		$(function(){
			var bsno = "${sbdto.bsno}";
			var myLike = "${my_like_count}";
			var htmlData ="";
			
			$(".likebox").click(function(){
				if(myLike==0){
					
					var num=Number($(".likeNo").text())+1;
					myLike = 1;
					
					//a
					$.ajax({
						url:"MyLikeUpdate",
						type:"post",
						data:{"bsno":bsno,"like_status":1},
						dataType:"json",
						success:function(data){
							alert("좋아요 추가1 성공");
							alert("좋아요 총개수 :"+data.all_like_count);
							$(".likebox:hover").css("background-image","url('')");
							htmlData = '';
							htmlData += '<img src="./images/icon-heart_2.png"><span class="likeNo">'+num+' </span>';
							$(".likebox").html(htmlData);
						},
						error:function(){
							alert("실패");
						}
					});//a
					
					
				}else{
					var num=Number($(".likeNo").text())-1;
					myLike=0;
					//a
					$.ajax({
						url:"MyLikeUpdate",
						type:"post",
						data:{"bsno":bsno,"like_status":0},
						dataType:"json",
						success:function(data){
							alert("좋아요 취소 성공");
							$(".likebox:hover").css("background-image","");
							alert("좋아요 총개수 : "+data.all_like_count);
							htmlData ='';
							htmlData += '<img src="./images/icon-heart.png"><span class="likeNo"> '+num+' </span>';
							$(".likebox").html(htmlData);
						},
						error:function(){
							alert("실패");
						}
					});//a
					
					
				}
			});
	});//j
	
	
		
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
<body>
    <div class="board_wrap">
        <div class="board_title">
            <strong>공지사항</strong>
            <p>공지사항을 빠르고 정확하게 안내해드립니다.</p>
        </div>
        <div class="board_view_wrap">
            <div class="board_view">
                <div class="title">
                    ${sbdto.btitle}
                </div>
                <div class="info">
                    <dl>
                        <dt>번호</dt>
                        <dd>${sbdto.bsno}</dd>
                    </dl>
                    <dl>
                        <dt>글쓴이</dt>
                        <dd>${sbdto.id}</dd>
                    </dl>
                    <dl>
                        <dt>작성일</dt>
                        <dd><fmt:formatDate value="${sbdto.bdate}" pattern="yyyy-MM-dd"/></dd>
                    </dl>
                    <dl>
                        <dt>첨부파일</dt>
                        <dd><a href="upload/${sbdto.bfile}" target="_blank">${sbdto.bfile}</a></dd>
                    </dl>
                </div>
                <div class="cont">
                    ${sbdto.bcontent}
                </div>
                
                <!-- 다음글이전글 -->
                <div class="pn">
                	<dl>
                		<dt class="comment"><strong>다음글</strong> <span> ▲ </span>
                		<a href="b_view.do?page=${page}&bsno=${nextDto.bsno}&category=${category}&sword=${sword}">${nextDto.btitle}</a>
                		</dt>
                	</dl>
                	<dl>
                		<dt class="comment"><strong>이전글</strong> <span> ▼ </span>
                		<a href="b_view.do?page=${page}&bsno=${preDto.bsno}&category=${category}&sword=${sword}">${preDto.btitle}</a>
                		</dt>
                	</dl>
                </div>
                <!-- 다음글이전글 끝 -->
                
            
            <!-- 좋아요 -->
            <div class="likebox">
            		<c:if test="${my_like_count==1}">
            			
            			<img src="./images/icon-heart_2.png"><span class="likeNo">${all_like_count}</span>
            		</c:if>
            		<c:if test="${my_like_count!=1}">
            			<img src="./images/icon-heart.png"><span class="likeNo">${all_like_count}</span>
            		</c:if>
           	</div>
			<!-- 좋아요 끝-->
            
            </div>
            
			
			
            <div class="bt_wrap">
                <a href="b_reply.do?page=${page}&bsno=${sbdto.bsno}" class="on">답글달기</a>
                <a href="b_edit.do?page=${page}&bsno=${sbdto.bsno}" class="on">작성글 수정</a>
                <a id="deleteBtn" class="on">작성글 삭제</a>
                <a href="b_list.do" class="on">글목록</a>
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