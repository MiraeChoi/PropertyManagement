<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>코리아주택관리</title>
		
		<style type="text/css">
			*{margin:0; padding:0;}
			a{text-decoration:none; color:#767676;}
			body{width:1100px; margin:0 auto; padding:0;}
			form table{font-size:15px; font-family:dotum, verdana, arial;}
			form table .test{border-collapse:collapse;}
			.subtitle{margin-top:30px; margin-bottom:5px; text-align:left; color:#7411cb;
					  font:normal 900 normal 20px / normal "맑은 고딕"}
			.table_top{border-top:1px solid #ababab;}
			.table_bottom{border-bottom:1px solid #ababab;}
			.b_content{min-height:50px;}
			input[type="password"]{border:1px solid #999; border-raduis:0; outline-style:none; padding:.3em .5em;}
			.test2{text-align:center; border-bottom:1px solid #DEDEDE; padding:10px;
					color:#767676; background-color:#eee;}
			.test3{text-align:left; border-bottom:1px solid #DEDEDE; padding:10px;
					font:15px dotum, verdana, arial;}
			.buttons_three{margin-top:20px; margin-bottom:30px; font-size:12pt; font-weight:bold; background:#7c27c7;
							border:none; width:120px; height:60px; color:white; outline:none;}
			.buttons_three:hover{color:#95e2f3;}
		</style>
		
		<script type="text/javascript" src="${ pageContext.request.contextPath }/resources/js/httpRequest.js"></script>
		
		<script type="text/javascript">
			function del(){
				if(confirm("게시글을 삭제하시겠습니까?")){
					var pwd = document.getElementById("c_pwd").value.trim();
					var url = "m_del.do?idx=${vo.idx}&pwd="+pwd;
					sendRequest(url, null, resultFn, "POST");
				}
			}
			
			function resultFn(){
				if(xhr.readyState == 4 && xhr.status == 200){
					var data = xhr.responseText;
					
					if(data == 'yes'){
						alert("삭제 성공");
						location.href="m_login_main.do?id=${manage_vo.id}&page=${param.page}";
						//location.href="budongsanmain.do?page=${param.page}";
					}else{
						alert("비밀번호 불일치");
						return;
					}
				}
			}
			
			function modify(){
				console.log("일단 버튼 눌림");
				location.href = "m_modify_form.do?id=${manage_vo.id}&idx=${vo.idx}&page=${param.page}";
			}
		</script>
	</head>
	<body>
		<jsp:include page="../main/manage_menu.jsp" />
			
		<form name="f" method="post">
			<table align="center" width="1100" class="test">
				<caption class="subtitle">공지 상세정보</caption>
				<tr>
					<th width="120" height="25" class="test2 table_top">제목</th>
					<th colspan="3" class="test3 table_top"><b>${vo.subject}</b></th>
				</tr>
				<tr>
					<th width="120" height="25" class="test2">작성자</th>
					<td colspan="3" class="test3">${vo.name}</td>
				</tr>
				<tr>
					<th width="120" height="25" class="test2">내용</th>
					<td colspan="3" class="test3"><pre>${vo.content}</pre></td>
				</tr>
				<tr>
					<th width="120" height="25" class="test2">작성일</th>
					<td class="test3 table_bottom">${vo.regdate}</td>
					<th width="120" height="25" class="test2 table_bottom">아이피</th>
					<td class="test3 table_bottom">${vo.ip}</td>
				</tr>
				<tr>
					<th width="120" height="25" class="test2 table_bottom">비밀번호</th>
					<td colspan="3" class="test3 table_bottom">
						<input type="password" id="c_pwd" size="50">
					</td>
				</tr>
			</table>
			
			<table width="1100" align="center">
				<tr><td height="5"></td></tr>
				<tr>
					<td align="center">
						<!-- 목록으로 돌아가기 -->
						<input type="button" class="buttons_three" value="목록으로" onclick="location.href='budongsanmain.do?page=${param.page}'">
						
						<!-- 수정 -->
						<input type="button" class="buttons_three" value="수정" onclick="modify();">
						
						<!-- 삭제 -->
						<input type="button" class="buttons_three" value="삭제" onclick="del();">
					</td>	
				</tr>
			</table>
		</form>
	</body>
		
	<footer>
		<jsp:include page="../common/real_footer.jsp" />
	</footer>
</html>