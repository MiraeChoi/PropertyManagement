<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>코리아주택관리</title>
	
	<style>
		.copyright{width:1100px; heigth:45px; margin:0 auto;}
		/* .logo > img{width:200px; height:200px;} */
		.info{text-align:center;}
		#footer {
		   border-top: 1px solid #e4e8eb;
		   background-color: #fafbfc;
		   font-size:9pt; color:#444;
		}
		#footer li{
			/* float:left; */ display:inline-block;
			padding:2px 10px;
		}
		#footer li a:hover{
			color:#444;
		}
	</style>
</head>
<body>
	<div id="footer">
		<div class="copyright">
			<ul class="fmenu" style="text-align:center; margin-top:20px;">
				<li><a href="#">회사소개</a></li>
				<li><a href="#">광고문의</a></li>
				<li><a href="#">이용약관</a></li>
				<li><a href="#">개인정보처리방침</a></li>
				<li><a href="#">저작권정책</a></li>
				<li><a href="#">여기는뭐넣지</a></li>
				<li><a href="#">고객센터</a></li>
				<li><a href="#">웹사이트이용안내</a></li>
			</ul>
			<br>
			<p class="logo" align="center">
				<%-- <img src="${path}/resources/image/logo.png"> --%>
				<img src="${pageContext.request.contextPath}/resources/img/city_illust.png">
			</p>
			<div class="info">
				<ul>
					<li style="margin-top:20px;">대표자 : 허건범</li>
					<li>이메일 : guntiger@korea.com</li>
					<li>사업자등록번호 : 111-22-12345</li><br>
					<li>주소 : 서울특별시 마포구 서강로 136 아이비타워 3층</li>
					<li>호스트서비스사업자 : ㈜코리아IT아카데미 4조</li>
				</ul>
			</div>
			<p style="text-align:center; padding:30px 0;">Copyright ㉿ 2020 Team Four. ALL RIGHT RESERVED</p>
		</div>
	</div>
</body>
</html>