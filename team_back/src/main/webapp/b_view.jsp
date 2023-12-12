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
		.replyWrite{width:100%; margin:20px 0 20px 0; overflow:hidden;}
		.replyWrite ul li{float:left;}
		.replyWrite ul li.in{position:relative; width:88%; padding:25px 0 0 0;}
		.replyWrite ul li.in p.txt{position:absolute; left:0; top:4px; font-size:1.4rem; font-weight:600; color: black;}
		.replyWrite ul li.in p.password{position:absolute; right:-4px; top:0; line-height:20px; font-size: 1.4rem; font-weight:600;}
		.replyWrite ul li.btn{margin:1px 0 0 10px}
		.replyWrite p.ntic{clear:both; padding:5px 0; font-size: 1.4rem; text-align: center; color: #808080;}	 
		.replyType{width:100%; height:48px; border:2px #003F88 solid; font-size: 1.4rem; float:left; margin-right:10px;}
		.replyBtn{display:block; width:108px; height:74px; line-height:75px; color:#FFD500; font-size:20px; font-weight:600; background:#003F88; text-align:center; border:1px solid black;}
		.replyBtn:hover{color:#fff; text-decoration:none;}
		.replynum{width:120px; height:20px; line-height:20px; border:1px #003F88 solid; padding:0 0 0 5px;}
		.replyBox{width:100%; overflow:hidden;}
		.replyBox ul{position:relative; border-bottom:1px #003F88 solid; margin:15px 0 0 0; padding:0 20px 15px 20px;}
		.replyBox ul li.name{font-size:1.4rem; font-weight:600; color:black; padding:0 10px 10px 0; float:left}
		.replyBox ul li.date{font-size:1.4rem; color:black; font-weight:normal; padding: 0 0 10px 0;}
		.replyBox ul li.txt{width:100%; color:black; line-height:1.5; font-size:1.4rem; word-break:keep-all;}
		.replyBox ul li.btn{text-align:right; height:20px; padding:3px 0 0 0;}
		.replyBox ul li.btn .re_edit,.replyBox ul li.btn .e_save,.replyBox ul li.btn .e_cancel{display:inline-block; width:70px; height:25px; line-height:24px; color:#FFD500; font-weight:600; text-align:center; border:1px solid black; background:#003F88;}
		.replyBox ul li.btn .re_edit:hover{color:#fff; text-decoration:none;}
		.replyBox ul li.btn .re_del{display:inline-block; width:70px; height:25px; line-height:24px; color:#FFD500; font-weight:600; text-align:center; border:1px solid black; background:#003F88;}
		.replyBox ul li.btn .re_del:hover{color:#fff; text-decoration:none;}
		.edit{width: 100%;}
	</style>
	<script>
		$(function(){
			var id ="${sbdto.id}"
			var session_id = "${session_id}"
			var bsno = "${sbdto.bsno}";
			var myLike = "${my_like_count}";
			var htmlData ="";
			$("#deleteBtn").click(function(){
				if(session_id=="aaa" || session_id==id){
				if(confirm("게시글을 삭제하시겠습니까?")){
						location.href="b_delete.do?page=${page}&bsno=${sbdto.bsno}";
				}//if-confirm
				}else if(session_id!=id){
					alert("게시글 작성자 또는 관리자만 삭제가능합니다.")
				}//if - 삭제조건x
			});//#deleteBtn
	
			$(".likebox").click(function(){
				if(myLike==0){
					var num=Number($(".likeNo").text())+1;
					myLike = 1;
					//ajax
					$.ajax({
						url:"MyLikeUpdate",
						type:"post",
						data:{"bsno":bsno,"like_status":1},
						dataType:"json",
						success:function(data){
							$(".likebox:hover").css("background-image","url('')");
							htmlData = '';
							htmlData += '<img src="./images/icon-heart_2.png"><span class="likeNo">'+num+' </span>';
							$(".likebox").html(htmlData);
						},//success
						error:function(){alert("실패");}//error
					});//ajax
				}else{
					var num=Number($(".likeNo").text())-1;
					myLike=0;
					//ajax
					$.ajax({
						url:"MyLikeUpdate",
						type:"post",
						data:{"bsno":bsno,"like_status":0},
						dataType:"json",
						success:function(data){
							$(".likebox:hover").css("background-image","");
							htmlData ='';
							htmlData += '<img src="./images/icon-heart.png"><span class="likeNo"> '+num+' </span>';
							$(".likebox").html(htmlData);
						},//success
						error:function(){alert("실패");}//error
					});//ajax
				}//if-else
			});//.likebox
			
			
			$(".replyBtn").click(function(){
				//입력 내용 가져오기
				var bsno = "${sbdto.bsno}";
				var spw = $(".replynum").val();
				var scontent = $(".replyType").val();
				//댓글 등록
				$.ajax({
					url:"SInsert",
					type:"post",
					data:{"bsno":bsno, "spw":spw, "scontent":scontent},
					dataType:"json",
					success:function(data){
						var htmlData='';
						htmlData += '<ul id="'+data.sno+'">';
						htmlData += '<li class="name">'+data.id+' <span> ['+data.sdate+']</span></li>';
						htmlData += '<li class="txt">'+data.scontent+'</li>';
						htmlData += '<li class="btn">';
						htmlData += '<a class="rebtn">수정</a>&nbsp';
						htmlData += '<a class="rebtn">삭제</a>';
						htmlData += '</li>';
						htmlData += '</ul>';
					$(".replyBox").prepend(htmlData);
						alert("댓글을 등록합니다.");
						$(".replynum").val("");
						$(".replyType").val("");
						location.reload(true);
					},//success
					error:function(){alert("실패했습니다.")}//error
				});//ajax
			});//댓글 등록
			
			//댓글삭제
			$(".re_del").click(function(){
				if(confirm("댓글을 삭제하시겠습니까?")){
					$.ajax({
						url:"ReDelete",
						type:"post",
						data:{"sno":$(this).attr("dataDsno")},
						dataType:"json",
						success:function(data){
							if(data==1){
								$(this).remove();
								alert("성공하셨습니다.");
							}//if
							location.reload(true);
						},//success
						error:function(){alert("실패하셨습니다.");}//error
					});//ajax
				}//if
			});//댓글 삭제
		var sno=0; //전역변수
		var comm='';   //
		var commName='';   //
		var or_content='';   //
			
		//댓글 수정화면	
		$(".re_edit").click(function(){
			sno = $(this).attr("dataSno");
			comm = $("#"+sno);
			commName = comm.find(".name").text();
			var currentDate = new Date();
		    var year = currentDate.getFullYear();
		    var month = ('0' + (currentDate.getMonth() + 1)).slice(-2);
		    var day = ('0' + currentDate.getDate()).slice(-2);
		    var hours = ('0' + currentDate.getHours()).slice(-2);
		    var minutes = ('0' + currentDate.getMinutes()).slice(-2);
		    var seconds = ('0' + currentDate.getSeconds()).slice(-2);
		    var re_date = year + '-' + month + '-' + day + ' ' + hours + ':' + minutes + ':' + seconds;
			or_content = comm.find(".txt").text();
			var htmlData = "";
			htmlData +='<li class="name">'+commName+'</li>';
			htmlData +='<li class="date">'+re_date+'</li>';
			htmlData +='<li class="txt"><textarea type="text" class="edit" value="'+or_content+'"></textarea></li>';
			htmlData +='<li class="btn">';
			htmlData +='<a class="e_save" dataSno="${s_comment.sno}">저장</a>&nbsp';
			htmlData +='<a class="e_cancel" dataDsno="${s_comment.sno}">취소</a>';
			htmlData +='</li>';
			comm.html(htmlData);
			//수정완료 버튼 추가
		});//.re_edit
	    // 댓글 저장
		$(document).on("click",'.e_save',function(){
			var comm = $("#"+sno);
			var e_content = $(".edit").val();
			var currentDate = new Date();
		    var year = currentDate.getFullYear();
		    var month = ('0' + (currentDate.getMonth() + 1)).slice(-2);
		    var day = ('0' + currentDate.getDate()).slice(-2);
		    var hours = ('0' + currentDate.getHours()).slice(-2);
		    var minutes = ('0' + currentDate.getMinutes()).slice(-2);
		    var seconds = ('0' + currentDate.getSeconds()).slice(-2);
		    var re_date = year + '-' + month + '-' + day + ' ' + hours + ':' + minutes + ':' + seconds;
			var htmlData = "";
			
			htmlData += '<li class="name">'+commName+'</li>';
			htmlData += '<li class="date">'+re_date+'</li>';
			htmlData += '<li class="txt">'+e_content+'</li>';
			htmlData += '<li class="btn">';
			htmlData += '<a class="re_edit" dataSno="${s_comment.sno}">수정</a>&nbsp';
			htmlData += '<a class="re_del" dataDsno="${s_comment.sno}">삭제</a>';
			htmlData += '</li>';
			comm.html(htmlData);
			$.ajax({
				url:"ReEdit",
				type:"post",
				data:{"sno":sno, "e_content":e_content},
				dataType:"json",
				success:function(data){
					if(data.result==1){
						comm.find(".txt").text(e_content);
						alert("댓글이 수정되었습니다.");
					}//if
				},//success
				error:function(){alert("댓글 수정이 실패했습니다.")}//error
			});//ajax
		});//$(".re_edit").click
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
                    <dl class="line">
                        <dt>번호</dt>
                        <dd>${sbdto.bsno}</dd>
                    </dl>
                    <dl class="line">
                        <dt>글쓴이</dt>
                        <dd>${sbdto.id}</dd>
                    </dl>
                    <dl class="line">
                        <dt>작성일</dt>
                        <dd><fmt:formatDate value="${sbdto.bdate}" pattern="yyyy-MM-dd"/></dd>
                    </dl>
                    <dl>
                        <dt>첨부파일</dt>
                        <dd>
                        <a href="upload/${sbdto.bfile}" target="_blank">${sbdto.bfile}</a>
                        <c:if test="${sbdto.bfile!=null}">
                        <img src="upload/${sbdto.bfile}" style="width:50px; vertical-align: middle; margin-left:20px;">
                        </c:if>
                        <c:if test="${sbdto.bfile==null}">
                        <i>첨부파일 없음</i>
                        </c:if>
                        </dd>
                    </dl>
                </div>
                <div class="cont">
                    ${sbdto.bcontent}<br>
                     <img src="upload/${sbdto.bfile}" alt="" width="50%">
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

                <!-- 하단댓글 시작 -->
	            <div class="replyWrite">
					<ul>
						<li class="in">
							<p class="txt">총 <span class="orange">${ccount}</span> 개의 댓글이 있습니다.</p>
							<p class="password">비밀번호&nbsp;&nbsp;<input type="password" class="replynum" /></p>
							<textarea class="replyType"></textarea>
						</li>
						<li class="btn"><a style="cursor: pointer;" class="replyBtn">등록</a></li>
					</ul>
					<p class="ntic">*비밀글은 비밀번호를 입력해주세요.*</p>
				</div>
				<div class="replyBox">
					<c:forEach var="s_comment" items="${slist}">
						<ul id="${s_comment.sno}">
							<li class="name">${s_comment.id}</li>
							<li class="date"><span>[${s_comment.sdate}]</span></li>
							<li class="txt">${s_comment.scontent}</li>
							<li class="btn">
								<a class="re_edit" dataSno="${s_comment.sno}">수정</a>
								<a class="re_del" dataDsno="${s_comment.sno}">삭제</a>
							</li>
						</ul>
					</c:forEach>
				</div>
                <!-- 하단댓글 끝 -->
            
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