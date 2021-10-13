<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>코리아주택관리</title>
		<style>
			.t1 {
			  font-family: Poppins-Medium;
			  font-size: 16px;
			  color: white;
			  line-height: 1.2;
			
			  display: -webkit-box;
			  display: -webkit-flex;
			  display: -moz-box;
			  display: -ms-flexbox;
			  display: flex;
			  justify-content: center;
			  align-items: center;
			  padding: 0 20px;
			  min-width: 120px;
			  height: 50px;
			  border-radius: 25px;
			
			  background: #9152f8;
			  background: -webkit-linear-gradient(bottom, #7579ff, #b224ef);
			  background: -o-linear-gradient(bottom, #7579ff, #b224ef);
			  background: -moz-linear-gradient(bottom, #7579ff, #b224ef);
			  background: linear-gradient(bottom, #7579ff, #b224ef);
			  position: relative;
			  z-index: 1;
			
			  -webkit-transition: all 0.4s;
			  -o-transition: all 0.4s;
			  -moz-transition: all 0.4s;
			  transition: all 0.4s;
			}
		</style>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<%@ include file="../common/header.jsp" %>
	</head>
	<body>
		<div class="limiter">
		<div class="container-login100" style="background-image: url('${pageContext.request.contextPath}/resources/images/bg-01.jpg');">
			<div class="wrap-login100">
				<form class="login100-form validate-form">
					<span class="login100-form-logo">
						<i class="zmdi zmdi-landscape"></i>
					</span>
					<span class="login100-form-title p-b-34 p-t-27">
						로그인할 항목을<br>선택하세요.
					</span>
					<div class="container-login100-form-btn">
						<input class="t1" type="button" value="관리사" class="login100-form-btn" onclick="location.href='manage.do'">
					</div>
					<br>
					<div class="container-login100-form-btn">
						<input class="t1" type="button" value="공인중개사" class="login100-form-btn" onclick="location.href='gongin.do'">
					</div>
					<br>
					<div class="container-login100-form-btn">
						<input class="t1" type="button" value="임대인" class="login100-form-btn" onclick="location.href='imdae.do'">
					</div>
					<br>
					<div class="text-center p-t-90">
						<a class="txt1" href='budongsanmain.do'>
							홈으로
						</a>
					</div>
				</form>
			</div>
		</div>
	</div>
	<div id="dropDownSelect1"></div>
	<%@ include file="../common/footer.jsp" %>
	</body>
</html>