<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<link href="https://fonts.cdnfonts.com/css/nasa" rel="stylesheet">
	<title>main</title>
	<link rel="stylesheet" href="css/a_main.css">
	<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script>
	$(function(){
		var location1;
		$("#my_png").click(function(){
			alert("회원정보 보기 페이지로 이동합니다.");
		});//#my_png
		
		$("#list_png").click(function(){
			alert("요청게시판으로 이동합니다.");
		});//#list_png
		
		$(".mpg1").click(function(){
			console.log("현재 배열 개수 : "+$(".mpg1").length);
			console.log("현재 배열 클릭 위치 : "+$(".mpg1").index(this));
			location1 = $(this);
			console.log("현재 위치점 : "+$(this));
			$("#modal_box").removeClass("popOff");
			$("#modal_box").addClass("popOn");
			
		});//#button(모달창 띄우기)
		
		$("#delBtn").click(function(){
			$("#modal_box").removeClass("popOn");
			$("#modal_box").addClass("popOff");
		});//
		
		$("#addBtn").click(function(){
			alert("현재위치점 : "+location1);
			console.log(location1);
			if($("#webName").val().length<1) {
				alert("사이트 이름을 입력하세요!")
			}//if
			
			if($("#webURL").val().length<1) {
				alert("사이트 URL을 입력하세요!")
			}//if
		
			<!--모달창 ajax-->
			//입력내용 가져오기
			var id = "${session_id}";
			var webName = $("#webName").val();
			var webURL = $("#webURL").val();
			
			$.ajax({
				url : "MD_Insert",
				type:"post",
				data:{"id":id, "webName":webName,"webURL":webURL},
				dataType:"json",
				success:function(data){
					alert("성공");
					console.log(data);
					
					//즐겨찾기 등록 태그
					var pageHtml='';
					
					pageHtml += '<a href='+webURL+'target="_blank" class="mpg" id="modal">';
					pageHtml += '<img src="images/link3.png">';
					pageHtml += '<div class="loc3">'+webName+'</div>';
					pageHtml += '</a>';
					pageHtml += '</div>';
					
					//즐겨찾기 등록
					$(location1).html(pageHtml);
					
					
				},//success
				error:function(){
					alert("실패");
				}//error
			});//ajax
			alert("즐겨찾기 주소를 추가합니다.");
		});//#addBtn
		
	});//제이쿼리 구문 최신
	</script>
	<style>
	   .loc{position: relative; top:-50px; width:96px; text-align: center; font-size: 13px; padding-top: 3px;}
	   .loc3{position: relative; top:-50px; width:96px; text-align: center; font-size: 13px; padding-top: 3px;}
	   .loc4{position: relative; top: -50px; width:96px; text-align: center; font-size: 13px; padding-top: 3px;}
	   a{text-decoration: none; color: #fff;}
	</style>
	</head>
	<body>
	<!-- 모달창 즐겨찾기 -->
	<c:if test="${session_id!=null}">
	<div id="modal_box" class="popOff">
			<div id="modal_cont">
				<h1 id="f_title">즐겨찾기 추가</h1>
				<form name="ModalFrm" method="get" id="modalF">
					<div id ="desc">
						&nbsp<label><p>이&nbsp&nbsp름</p></label>
						<input type="text" name="webName" id="webName" value="${ldto.pname}" placeholder=" ☞ 사이트 이름 | ex)  네이버, 다음, Google"><br><br>
						&nbsp<label><p>U&nbspR&nbspL</p></label>
						<input type="text" name="webURL" id="webURL" value="${ldto.purl}" placeholder=" ☞ url주소를 입력하세요. | ex) https://www.naver.com/">
					</div>
					<button type="button" class="buttonM" id="delBtn">취소</button>
					<button type="button" class="buttonM" id="addBtn" >추가</button>
				</form>
			</div>
		</div>
	</c:if>
		<!-- 모달창 끝 -->
		<table>
		<div class="bg-video">
			<video class="bg-video_content" autoplay muted loop>
				<source src="images/main_background.mp4" type="video/mp4" />
			</video>
			<div class="bg-text">
			<!-- 검색창 넣기 -->
			<div class="f_search">
			<div class="sch_wrap">
				<form action="https://www.google.co.kr/search" method="get" target="_blank">
					<input type="text" class="txt" id="fn_txt_srch" placeholder="검색어를 입력해주세요" name="query" required>
					<button class="btn_srch" type="submit"></button>
					<a href="a_logout.do"><span><i class="fa fa-sign-out" aria-hidden="true"></i>Logout</span></a>
				</form>
				</div>
			</div>
			<!-- 게시판 -->
			<div id="center">
				<ul id="menu">
					<li id="menu_my">
					<a href="a_myPage.do"><img src="images/my_1.png" id="my_png"></a>
					</li>
					<li id="menu_list">
					<a href="b_list.do"><img src="images/list_1.png" id="list_png"></a>
					</li>
				</ul>
			</div>
				<!-- 이미지링크 -->
				<div>
					<ul>
						<li>
						<a href=https://github.com/ target="_blank" class="mpg"><img src="images/link1.png">
						<div class="loc">GITHUB</div>
						</a>
						</li>
						<li>
						<a href="https://www.mockaroo.com/" target="_blank" class="mpg"><img src="images/link1.png">
						<div class="loc">MOCKAROO</div>
						</a>
						</li>
						<li>
						<a href="https://www.data.go.kr/index.do" target="_blank" class="mpg"><img src="images/link1.png">
						<div class="loc">공공데이터</div>
						</a>
						</li>
						<li>
						<a href="http://json.parser.online.fr/" target="_blank" class="mpg"><img src="images/link1.png">
						<div class="loc">JSON</div>
						</a>
						</li>
						<li>
						<a href="https://cafe.naver.com/koreaitbigdata" target="_blank" class="mpg"><img src="images/link2.png">
						<div class="loc">JAVA Dev</div>
						</a>
						</li>
						<li>
						<a href="https://fonts.google.com/?subset=korean&noto.script=Kore" target="_blank" class="mpg"><img src="images/link2.png">
						<div class="loc">WEBFONT</div>
						</a>
						</li>
						<li>
						<a href="https://elmah.io/tools/xml-formatter/" target="_blank" class="mpg"><img src="images/link2.png">
						<div class="loc">XML</div>
						</a>
						</li>
						<li>
						<a href="https://us06web.zoom.us/j/5201428216?pwd=bk9hT0ppVithT2JKblJNQTIzbktNUT09" target="_blank" class="mpg"><img src="images/link2.png">
						<div class="loc">ZOOM</div>
						</a>
						</li>
					</ul>
					<ul id="ul2">
								<c:if test="${list==null}">
									<c:forEach begin="1" end="8" step="1" varStatus="vs">
										<li>
											<a target="_blank" class="mpg mpg1" id="modal"><img src="images/plus.png"></a>
										</li>
									</c:forEach>
								</c:if>
								<c:if test="${list!=null}">
								<!-- 8번반복 -->
									<c:forEach items="${list}" var="ldto" varStatus="vs">
											<c:if test="${ldto.purl!=null}">
												<c:if test="${vs.index<4 }">
													<li>
														<a href=${ldto.purl } target="_blank" class="mpg" id="modal"><img src="images/link3.png"><div class="loc3">${ldto.pname}</div></a>
													</li>
												</c:if>
												<c:if test="${vs.index>=4 }">
														<li>
															<a href=${ldto.purl } target="_blank" class="mpg" id="modal"><img src="images/link4.png"><div class="loc3">${ldto.pname}</div></a>
														</li>
												</c:if>
											</c:if>
									</c:forEach>
								<c:forEach var="c" begin="${list_size+1}" end="8" step="1">
											<c:if test="${ldto.purl==null}">
												<li>
													<a target="_blank" class="mpg mpg1" id="modal"><img src="images/plus.png"></a>
												</li>
											</c:if>
								</c:forEach>
								</c:if>
					</ul>
				</div>
				<h1 id="h1"><strong style=" color:#0038a8">JJA</strong>GEUL</h1>
				<h3>
					한국 직업전문학교 copyright © ★항공 JAVA 풀스택 개발자 양성과정 5기★ - 2팀( 최창윤 | 조민진 | 정보람 | 김승우 )
				</h3>
			</div>
		</div>
	</table>
	</body>
</html>