<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>코리아주택관리</title>
		<style>
			div{font-weight:bold;}
		</style>
		<link type="text/css" rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/sweetalert2.css" /><!-- 알럿창 스타일 -->
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/sweetalert2.js"></script> <!-- 알럿창 플러그인 -->
    	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/es6-promise.js"></script> <!-- 알럿창 _IE작동 -->
		<script src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>
		<script>
			function check(f){
				var id=f.id.value.trim();
				var pwd=f.pwd.value.trim();
				
				if(id==''){
					return;
				}
				if(pwd==''){
					return;
				}

				var url="manage_login.do";
				var param="id="+id+"&pwd="+pwd;
				sendRequest(url, param, resultFn, "POST");
			}
			
			function resultFn(){
				if(xhr.readyState==4 && xhr.status==200){
					var data=xhr.responseText;
					var json = eval(data);
					
					if(json[0].result=='no'){
						swal({
			                title : "Wrong id",
			                text : "아이디가 일치하지 않습니다!",
			                type : "error"
			            });
						return;
					} else if(json[1].result=='no'){
						swal({
			                title : "Wrong password",
			                text : "비밀번호가 일치하지 않습니다!",
			                type : "error"
			            });
						return;
					} 
					location.href="m_login_main.do?id=" + json[2].id;
				}
			}
			function forget(){
				swal({
	                title : "forgot password?",
	                text : "저런.. 힘을 내서 기억해 보도록 해요 ㅠㅠ",
	                type : "question"
	            });
			}
		</script>
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
						관리사 로그인
					</span>
					<!-- 아이디 입력 -->
					<div class="wrap-input100 validate-input" data-validate = "아이디를 입력하세요">
						<input class="input100" type="text" name="id" placeholder="Id">
						<span class="focus-input100" data-placeholder="&#xf191;"></span>
					</div>
					<!-- 비밀번호 입력 -->
					<div class="wrap-input100 validate-input" data-validate = "비밀번호를 입력하세요">
						<input class="input100" type="password" name="pwd" placeholder="Password">
						<span class="focus-input100" data-placeholder="&#xf191;"></span>
					</div>
					<div class="contact100-form-checkbox">
						<input class="input-checkbox100" id="ckb1" type="checkbox" name="remember-me">
						<!-- <label class="label-checkbox100" for="ckb1">
							아이디 기억하기
						</label> -->
					</div>
					<div class="container-login100-form-btn">
						<input type="button"  value="로그인" class="login100-form-btn" onclick="check(this.form);" style="color:white">
					</div>
					<div class="text-center p-t-90">
						<a class="txt1" href="#" onclick="forget();">
							비밀번호를 잊으셨나요?
						</a>
						<br>
						<a class="txt1" href="budongsanmain.do">
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