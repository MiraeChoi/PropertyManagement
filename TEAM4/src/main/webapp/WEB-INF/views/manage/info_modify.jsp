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
			form table.test{border-collapse:collapse;}
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
			.buttons_two{font-size:12pt; font-weight:bold; background:#7c27c7; border:none; color:white;
						width:120px; height:60px; outline:none; text-align:center; margin:20px;}
					  
	/* 		form .test tr, form .test td{ border-right:1px solid #6A84B7; }
			input{ border-style:none; }
			textarea {border-style:none;}
			form .test.td_1{color:#6A84B7;}
			form table .test2{border-bottom:1px solid #6A84B7; color:#6A84B7; background-color:#C7D3ED;}
			form table .test3{border-bottom:1px solid #6A84B7; border-right:3px solid #6A84B7;} */
		</style>
		
		<script type="text/javascript">
			function modify_check(){
				var f = document.f; //f라는 이름의 form을 검색
				var c_pwd = f.c_pwd.value.trim();
				var pwd = f.pwd.value.trim();
				
				if(pwd != c_pwd){
					alert("비밀번호가 일치하지 않습니다.");
					return;
				}
				
				f.submit();
			}
		</script>
	</head>
	<body>
		<jsp:include page="../main/manage_menu.jsp" />
	
		<form name="f" method="post" action="m_modify.do">
			<input type="hidden" name="idx" value="${vo.idx}">
			<input type="hidden" name="pwd" value="${vo.pwd}">
			<input type="hidden" name="id" value="${manage_vo.id}">
			<input type="hidden" name="page" value="${param.page}">
			
			<table align="center" width="1100px" class="test">
				<caption class="subtitle">공지 수정</caption>
				<tr>
					<td rowspan="4" width="100"></td>
					<th width="80" height="25" class="test2">제목</th>
					<td class="test3 table_top"><input type="text" name="subject" size="82" value="${vo.subject}"></td>
				</tr>
				
				<tr>
					<th width="80" height="25" class="test2">작성자</th>
					<td class="test3"><input type="text" name="name" size="82" value="${vo.name}"></td>
				</tr>
				
				<tr>
					<th width="80" height="25" class="test2">내용</th>
					<td class="test3">
						<textarea name="content" rows="10" cols="85">${vo.content}</textarea>
					</td>
				</tr>
				
				<tr>
					<th width="80" height="25" class="test2 table_bottom">비밀번호</th>
					<td class="test3 table_bottom">
						<input type="password" name="c_pwd" size="82">
					</td>
				</tr>
				<tr>
					<td colspan="3" align="center">
						<input type="button" class="buttons_two" value="수정" onclick="modify_check();">
						<input type="button" class="buttons_two" value="취소" onclick="location.href='m_login_main.do?id=${manage_vo.id}&page=${param.page}'">
					</td>
				</tr>
			</table>			
		</form>
	</body>
	
	<footer>
		<jsp:include page="../common/real_footer.jsp" />
	</footer>
</html>