<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>코리아주택관리</title>
		
		<style>
			*{margin:0; padding:0;}
			body{width:1100px; margin:0 auto; padding:0; list-style:none;}
			#i_name{text-align:right; padding:0 10px;}
			.btn{left:10px; margin:10px 5px; padding:5px; border:1px solid purple; position:relative;
				 background-color:white; color:purple; font-weight:bold;
				 border-top-right-radius:5px; border-bottom-right-radius:5px;
				 border-top-left-radius:5px; border-bottom-left-radius:5px;}
			.btn:hover{background-color:#a4a8ea; color:white;}
			ul, li{margin:0; padding:0; list-style:none;}
			
			#nav{text-decoration:none; width:1086px; height:45px; padding:6px 7px; background:#7540c7; margin:0 auto;}
			#nav > li{text-decoration:none; float:left; position:relative; margin:3px 52px;}
			#nav li a{display:block; font-weight:bold; padding:10px 20px; color:white;}
			#nav li a:hover{text-decoration:none; color:#95e2f3;}
			
			#slider-wrap{width:1100px; height:250px; margin:0 auto; position:relative; overflow:hidden;}
			#slider-wrap ul#slider{height:100%; position:absolute; top:0; left:0;}
			#slider-wrap ul#slider li {width:600px; height:250px; float:left; position:relative;}
			#slider-wrap ul#slider li>div{position:absolute; top:20px; left:35px;}
			#slider-wrap ul#slider li img{width:100%; height:100%; display: block;}
	
			/*buttons*/
			.slider-btns{width:50px; height:60px; position:absolute; top:50%; margin-top:-25px; line-height:57px;
	    				 text-align:center; cursor:pointer; background:rgba(0, 0, 0, 0.1); z-index: 100;
	    				 -webkit-user-select:none; -moz-user-select:none; -khtml-user-select:none;
	    				 -ms-user-select:none; -webkit-transition:all 0.1s ease; -o-transition:all 0.1s ease;
	    				 transition: all 0.1s ease;}
			.slider-btns:hover{background: rgba(0, 0, 0, 0.3);}
			#next{right:-50px; border-radius:7px 0px 0px 7px; color:#eee;}
			#previous{left:-50px; border-radius:0px 7px 7px 7px; color:#eee;}
			#slider-wrap.active #next{right: 0px;}
			#slider-wrap.active #previous{left: 0px;}
	
			/*bar*/
			#slider-pagination-wrap{min-width:20px; height:15px; position:relative; text-align:center;
	    							margin-top:200px; margin-left:auto; margin-right:auto;}
			#slider-pagination-wrap ul li{width:5px; height:5px; position:relative; display:inline-block;
										  border-radius:50%; background:#fff; margin:0 4px; top:0; opacity:0.5;}
			#slider-pagination-wrap ul li.active{width:12px; height:12px; top:3px; opacity:1;
												 -webkit-box-shadow: rgba(0, 0, 0, 0.1) 1px 1px 0px;
												 box-shadow: rgba(0, 0, 0, 0.1) 1px 1px 0px;}
			/*animation*/
			#slider-wrap ul, #slider-pagination-wrap ul li {
				-webkit-transition: all 0.3s cubic-bezier(1, .01, .32, 1);
				-o-transition: all 0.3s cubic-bezier(1, .01, .32, 1);
				transition: all 0.3s cubic-bezier(1, .01, .32, 1);}
		</style>
		
		<script>
 			function myMaemul() {
				document.f.action = "gm_maemul_list_f.do";
				document.f.submit();
			}
 			
 			function myGunmul() {
 				document.f.action = "my_gmlist_f.do";
				document.f.submit();
			}
		</script>
	</head>
	
	<body>
		<form id="f" name="f" method="POST">
			<input type="hidden" id="ref" name="ref" value="${imdaein_vo.idx}" >
			
			<%-- 메인 --%>
			<p id="btn_group">
				<a href="budongsanmain.do"><img src="${pageContext.request.contextPath}/resources/img/khm_logo_s.png"></a>
				<p id="i_name">
					<b>${imdaein_vo.name}</b>님 환영합니다.
					<input type="button" class="btn" value="로그아웃" onclick="location.href='logout.do'">
					<input type="button" class="btn" value="회원정보수정" onclick="location.href='user_modify_imdae.do?id=${id}'">
				</p>
			</p>
			
			<%-- 메뉴 --%>
			<ul id="nav">
				<li><a href="budongsanmain.do">홈</a></li>
				<li><a href="use_info.do">이용안내</a></li>
				<li><a href="come.do">오시는 길</a></li>
				<li><a href="gm_maemul_list_f.do?ref=${imdaein_vo.idx}" onclick="myMaemul();">내 매물 목록</a></li>
				<li><a href="my_gmlist_f.do?ref=${imdaein_vo.idx}" onclick="myGunmul();">내 건물 관리</a></li>
			</ul>
		</form>
		
		<%-- 3단 자동 슬라이드 --%>
		<div id="slider-wrap">
		    <ul id="slider">
		        <li><img src="${pageContext.request.contextPath}/resources/img/slide1.png"></li>
				<li><img src="${pageContext.request.contextPath}/resources/img/slide2.png"></li>
		        <li><img src="${pageContext.request.contextPath}/resources/img/slide3_g.png"></li>
		    </ul>
		
		    <div class="slider-btns" id="next"><span>▶</span></div>
		    <div class="slider-btns" id="previous"><span>◀</span></div>
		
		    <div id="slider-pagination-wrap">
		        <ul></ul>
		    </div>
		</div>
		
		<script>
			//slide-wrap
			var slideWrapper = document.getElementById('slider-wrap');
			//current slideIndexition
			var slideIndex = 0;
			//items
			var slides = document.querySelectorAll('#slider-wrap ul li');
			//number of slides
			var totalSlides = slides.length;
			//get the slide width
			var sliderWidth = slideWrapper.clientWidth;
			//set width of items
			slides.forEach(function (element) {
			    element.style.width = sliderWidth + 'px';
			})
			//set width to be 'x' times the number of slides
			var slider = document.querySelector('#slider-wrap ul#slider');
			slider.style.width = sliderWidth * totalSlides + 'px';
		
			//next, prev
			var nextBtn = document.getElementById('next');
			var prevBtn = document.getElementById('previous');
			nextBtn.addEventListener('click', function () {
			    plusSlides(1);
			});
			prevBtn.addEventListener('click', function () {
			    plusSlides(-1);
			});
		
			//hover
			slideWrapper.addEventListener('mouseover', function () {
			    this.classList.add('active');
			    clearInterval(autoSlider);
			});
			slideWrapper.addEventListener('mouseleave', function () {
			    this.classList.remove('active');
			    autoSlider = setInterval(function () {
			        plusSlides(1);
			    }, 3000);
			});
		
			function plusSlides(n) {
			    showSlides(slideIndex += n);
			}
			function currentSlides(n) {
			    showSlides(slideIndex = n);
			}
			function showSlides(n) {
			    slideIndex = n;
			    if (slideIndex == -1) {
			        slideIndex = totalSlides - 1;
			    } else if (slideIndex === totalSlides) {
			        slideIndex = 0;
			    }
			    slider.style.left = -(sliderWidth * slideIndex) + 'px';
			    pagination();
			}
		
			//pagination
			slides.forEach(function () {
			    var li = document.createElement('li');
			    document.querySelector('#slider-pagination-wrap ul').appendChild(li);
			})
		
			function pagination() {
			    var dots = document.querySelectorAll('#slider-pagination-wrap ul li');
			    dots.forEach(function (element) {
			        element.classList.remove('active');
			    });
			    dots[slideIndex].classList.add('active');
			}
		
			pagination();
			var autoSlider = setInterval(function () {
			    plusSlides(1);
			}, 3000);
		</script>
	</body>
</html>