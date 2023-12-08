<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<c:if test="${session_id==null}">
		<script>
			alert("로그인을 해야만 접속이 가능합니다.");
			location.href="a_login.do";
		</script>
	</c:if>
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
		
		$(".mpg_1").click(function(){
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
				return false;
			}//if
			
			if($("#webURL").val().length<1) {
				alert("사이트 URL을 입력하세요!")
				return false;
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
					//alert("성공");
					console.log(data);
					//즐겨찾기 등록 태그
					var pageHtml='';
					pageHtml += '<a href='+webURL+' target="_blank" class="mpg" style="height:96px;">';
					pageHtml += '<img src="images/link3.png">';
					pageHtml += '<div class="loc3">'+webName+'</div>';
					pageHtml += '</a>';
					pageHtml += '<div class="M_delBtn" id="'+data.pno+'">';
					pageHtml += '<i class="fa fa-trash" aria-hidden="true"><strong style="font-family: fontYouandiModernTR;"></strong></i>';
					pageHtml += '</div>';
					//즐겨찾기 등록
					
					$(location1).removeClass("mpg_1");
					$(location1).html(pageHtml);
					location.reload(true); //자동새로고침
					
				},//success
				error:function(){alert("실패");}//error
			});//ajax(즐겨찾기 추가)
			//alert("즐겨찾기 주소를 추가합니다.");
		});//#addBtn
		
		$(".M_delBtn").click(function(){
			//alert("삭제 test");
			//alert($(this).attr("id"));
			var id ="${session_id}";
			var pno = $(this).attr("id");
			$.ajax({
				url:"MD_Delete",
				type:"post",
				data:{"id" : id, "pno" : pno},
				dataType : "json",
				success:function(data){
				console.log(data);
				//alert("성공");
				//즐겨찾기 Plus 등록 태그
					
				var DelHtml = '';
				DelHtml += '<a target="_blank" class="mpg Plus">';
				DelHtml += '<img src="images/plus.png">';
				DelHtml += '</a>';
				
				$(location1).html(DelHtml);
				location.reload(true);
				},//success
				error:function(){alert("실패");}//error
			
			});//ajax
			
		});//.B_delBtn(바로가기 삭제)
		
		//----------qr모달 시작------------
	    // qr 모달창 외부 클릭 시 닫기
	    $(document).on('click', function (event) {
	        if (!$(event.target).closest('#modal_qr, #qr_con').length) {
	            $('#modal_qr').removeClass('popOn2').addClass('popOff2');
	        }
	    });
	    // qr_con 버튼 클릭 시 미니 모달창 열기
	    $('#qr_con').click(function () {
	        $('#modal_qr').removeClass('popOff2').addClass('popOn2');
	    });
	  //----------qr모달 끝------------
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
		<!--미니 모달창 시작 QR  -->
		<div id="modal_qr" class="popOff2">
			<img src="images/qr_01.png" >
			
		</div>
		<!--미니 모달창 QR  끝 -->
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
				   <!--미니 버튼 시작 -->
					<div id="qr_con">
						<button class="qr_btn">
							<img alt="" src="images/qr.png" id="qr_png" >
						</button>
					</div>
					<!--미니 버튼 끝 -->
					<li id="menu_la">
						<a href="a_myPage.do"><img src="images/my.png" id="my_png"></a>
					</li>
					<li id="menu_la">
						<a href="b_list.do"><img src="images/list.png" id="list_png"></a>
					</li>
					<li id="menu_out">
						<a href="a_logout.do"><img src="images/logout.png" id="out_png"></a>
					</li>
				</ul>
			</div>
				<!-- 이미지링크 -->
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
										<li class="mpg1">
											<a target="_blank" class="mpg mpg_1"><img src="images/plus.png"></a>
										</li>
									</c:forEach>
								</c:if>
								<c:if test="${list!=null}">
								<!-- 8번반복 -->
									<c:forEach items="${list}" var="ldto" varStatus="vs">
											<c:if test="${ldto.purl!=null}">
												<c:if test="${vs.index<4 }">
													<li class="mpg1">
														<a href=${ldto.purl } target="_blank" class="mpg" style="height: 96px;"><img src="images/link3.png"><div class="loc3">${ldto.pname}</div></a>
														<div class="M_delBtn" id="${ldto.pno}"><i class="fa fa-trash" aria-hidden="true"><strong style="font-family: fontYouandiModernTR;"></strong></i></div>
													</li>
												</c:if>
												<c:if test="${vs.index>=4 }">
														<li class="mpg1">
															<a href=${ldto.purl } target="_blank" class="mpg" style="height: 96px;"><img src="images/link4.png"><div class="loc3">${ldto.pname}</div></a>
														<div class="M_delBtn" id="${ldto.pno}"><i class="fa fa-trash" aria-hidden="true"><strong style="font-family: fontYouandiModernTR;"></strong></i></div>	
														</li>
												</c:if>
											</c:if>
									</c:forEach>
								<c:forEach var="c" begin="${list_size+1}" end="8" step="1">
											<c:if test="${ldto.purl==null}">
												<li class="mpg1 mpg_1">
													<a target="_blank" class="mpg Plus"><img src="images/plus.png"></a>
												</li>
											</c:if>
								</c:forEach>
								</c:if>
					</ul>
				<h1 id="h1"><strong style=" color:#0038a8">JJA</strong>GEUL</h1>
				<h3>
					한국 직업전문학교 copyright © ★항공 JAVA 풀스택 개발자 양성과정 5기★ - 2팀( 최창윤 | 조민진 | 정보람 | 김승우 )
				</h3>
			</div>
		</div>
	</table>
	</body>
</html>