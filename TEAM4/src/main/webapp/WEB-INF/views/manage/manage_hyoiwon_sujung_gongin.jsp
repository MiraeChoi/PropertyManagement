<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>코리아주택관리</title>
	<style>
		*{margin:0; padding:0;}
		li{list-style:none;}
		a{text-decoration:none; color:#767676;}
		.subtitle{margin-top:50px; margin-bottom:20px; text-align:center;
		  font:normal 900 normal 25px / normal "맑은 고딕"}
		#body table{border-collapse:collapse;
					border-color:#C7D3ED;
					font-size:17px;
					width:900px; height:auto;
					margin:50px auto 20px;}
		#body tr.top{border-top:4px double #8EA8DB;}
		#body tr{border-bottom:1px solid #C7D3ED;}
		#body tr.b{border-bottom:0}
		#body th, td{padding: 15px 20px; width:100px;}
		#body th{font-weight:bold;}
		#body td input{padding:8px 10px;}
		#bottom .link{margin:0px 30px;}
		.buttons_two{font-size:12pt; font-weight:bold; background:#7c27c7; border:none; color:white;
						width:120px; height:60px; outline:none; text-align:center; margin:20px 20px 50px 20px;}
	</style>
	
	<script src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>
	<script>
		function send(f){
			//유효성 검사
			var name = f.name.value.trim();
			var tel = f.tel.value.trim();
			var gong_name = f.gong_name.value.trim();
			var email = f.email.value.trim();
			
			if(name == '') {
				alert("이름을 입력해 주세요.");
				f.name.focus();
				return;
			}
			if(tel == '') {
				alert("전화번호를 입력해 주세요.");
				f.tel.focus();
				return;
			}
			if(gong_name == '') {
				alert("상호를 입력해 주세요.");
				f.gong_name.focus();
				return;
			}
			if(email == '') {
				alert("이메일을 입력해 주세요.");
				f.email.focus();
				return;
			}
			
			if(!confirm("수정 사항을 저장하시겠습니까?")){
				return;
			}
			
			f.method = "POST";
			f.action = "manage_hyoiwon_gongin_update.do";
			f.submit();
		}
	</script>
</head>
<body>
	<jsp:include page="../main/manage_menu.jsp" />
	
	<div id="body">
	<form name="f">
		<input type="hidden" name="idx" value="${param.idx}">
		
		<p class="subtitle">공인중개사 정보 수정</p>
		<table>
			<tr class="top">
				<th>이름</th>
				<td><input name="name" size="50" value="${param.name}"></td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td><input name="tel" size="50" value="${param.tel}"></td>
			</tr>
			<tr>
				<th>상호</th>
				<td><input name="gong_name" size="50" value="${param.gong_name}"></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><input name="email" size="50" value="${param.email}"></td>
			</tr>
		</table>
		
		<div id="bottom" align="center">
			<input type="button" class="buttons_two" value="수정" onclick="send(this.form);">
			<input type="button" class="buttons_two" value="취소" onclick="location.href='manage_hyoiwon.do'">
		</div>
	</form>
	</div>
</body>

<footer>
	<jsp:include page="../common/real_footer.jsp" />
</footer>
</html>