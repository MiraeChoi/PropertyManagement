<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>코리아주택관리</title>
		
		<style>
			*{margin:0; padding:0;}
			body{width:1100px; margin:0 auto; padding:0;}
			a{text-decoration:none; color:#767676;}
			form table{font-size:15px; font-family:dotum, verdana, arial;}
			form table .test{border-collapse:collapse;}
			.subtitle{margin-top:30px; margin-bottom:20px; text-align:center;
					  font:normal 900 normal 25px / normal "맑은 고딕"}
			.test{border:20px solid #ddd; border-collapse:collapse; background:#ddd;
			 	  font-size:11pt; width:1100px; margin:0px auto 30px;}
			.b_content{min-height:50px;}
			input[type="text"]{border:1px solid #999; border-raduis:0; outline-style:none; padding:.8em .5em;}
			input[type="password"]{border:1px solid #999; border-raduis:0; outline-style:none; padding:.8em .5em;}
			.test2{text-align:left; border-bottom:1px solid #DEDEDE; padding:10px;}
			.test3{text-align:left; border-bottom:1px solid #DEDEDE; padding:10px;
					font:15px dotum, verdana, arial;}
			.button_reg{font-size:12pt; font-weight:bold; background:#7c27c7; border:none; color:white;
						width:120px; height:60px; outline:none; text-align:center; margin:20px;}
			.button_cancel{font-size:12pt; font-weight:bold; background:#7c27c7; border:none; color:white;
						   width:120px; height:60px; outline:none; text-align:center; margin:20px;}
		</style>
		
		<script>
			function send_check(){
				var f = document.f; //f라는 이름의 form을 검색
				var subject = f.subject.value.trim();
				var name = f.name.value.trim();
				var content = f.content.value.trim();
				var pwd = f.pwd.value.trim();
				
				//유효성 체크
				if(subject == '') {
					alert("제목을 입력해 주세요.");
					f.subject.focus();
					return;
				}
				if(name == '') {
					alert("작성자를 입력해 주세요.");
					f.name.focus();
					return;
				}
				if(content == '') {
					alert("내용을 입력해 주세요.");
					f.content.focus();
					return;
				}
				if(pwd == '') {
					alert("비밀번호를 입력해 주세요.");
					f.pwd.focus();
					return;
				}
				
				f.action = "m_insert.do";
				f.submit();
			}
		</script>
	</head>
	<body>
		<jsp:include page="../main/manage_menu.jsp" />
		
		<form name="f" method="post">
			<input type="hidden" name="id" value="${manage_vo.id}">
			
			<table align="center" width="1100px" class="test">
				<caption class="subtitle">새 공지 등록</caption>
				<tr>
					<td rowspan="4" width="100"></td>
					<th width="80" height="25" class="test2 table_top">제목</th>
					<td class="test3 table_top"><input type="text" name="subject" size="82"></td>
				</tr>
				<tr>
					<th width="80" height="25" class="test2">작성자</th>
					<td class="test3"><input type="text" name="name" size="82"></td>
				</tr>
				<tr>
					<th width="80" height="25" class="test2">내용</th>
					<td class="test3"><textarea name="content" rows="10" cols="85"></textarea></td>
				</tr>
				<tr>
					<th width="80" height="25" class="test2 table_bottom">비밀번호</th>
					<td class="test3 table_bottom">
						<input type="password" name="pwd" size="82">
					</td>
				</tr>
				<tr>
					<td colspan="3" align="center" class="btns">
						<input type="button" class="button_reg" value="등록" onclick="send_check();">
						<input type="button" class="button_cancel" value="취소" onclick="location.href='m_login_main.do?id=${manage_vo.id}&page=${param.page}'">
						<%-- <img src="${pageContext.request.contextPath}/resources/img/btn_reg.gif" onclick="send_check();">
						<img src="${pageContext.request.contextPath}/resources/img/btn_back.gif" onclick="location.href='budongsanmain.do?page=${param.page}'"> --%>
					</td>
				</tr>
			</table>
		</form>
	</body>
	
	<footer>
		<jsp:include page="../common/real_footer.jsp" />
	</footer>
</html>