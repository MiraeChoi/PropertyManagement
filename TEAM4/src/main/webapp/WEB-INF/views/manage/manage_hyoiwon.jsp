<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>코리아주택관리</title>
	
	<style>
		*{margin:0; padding:0;}
		body{width:1100px;}
		a{text-decoration:none; color:#767676;}
		table{border-collapse:collapse; border-color:white;}
		th, td{padding:7px 3px; font-size:15px;}
		th{background:#ccc; color:#575757;}
		.center_top h2{font-size:30px; text-align:center; padding-top:43px;}
		.center_top h2:after {
	        content: "";
	        display: block;
	        width: 60px;
	        border-bottom: 2px solid #D5D5D5;
	        margin: 30px auto 30px;
	    }
	    .center_top p{width:500px; margin:10px 28% 30px; font-size:13px;}
	    
	    .subtable{width:1100px; margin-bottom:30px; text-align:center;}
	    .yeoback{padding:0 6px;}
	    
	    .subtitle{margin-top:30px; margin-bottom:5px; text-align:left; color:#7411cb;
					font:normal 900 normal 20px / normal "맑은 고딕";
					padding-bottom:10px;
					table-layout:fixed; word-wrap:break-word;}
	    .t_name{width:10%;}
	    .t_tel{width:20%;}
	    .t_gong_name{width:20%;}
	    .t_gun_name{width:20%;}
	    .t_email{width:20%;}
	    .B_go{width:10%;}
	    
	    .btn_all{padding:2px; border:1px solid purple; position:relative;
				 background-color:white; color:purple; font-weight:bold;
				 border-top-right-radius:5px; border-bottom-right-radius:5px;
				 border-top-left-radius:5px; border-bottom-left-radius:5px;}
	</style>
	
	<script src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>
	<script>
		function update_g(idx, name, tel, gong_name, email){
			location.href = "manage_hyoiwon_gongin_sujung.do?idx=" + idx +"&name="+name
					+"&tel=" + tel + "&gong_name="+gong_name + "&email=" + email;
		}
		
		function delete_g(idx) {
			if(!confirm("정말 공인중개사 정보를 삭제하시겠습니까?\n삭제 후에는 복구가 불가능합니다.")) {
				return;
			}
			
			var url = "manage_hyoiwon_gongin_del.do";
			var param = "idx=" + idx;
			
			sendRequest(url, param, resultFn_g, "POST");
		}
		
		function resultFn_g() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				var data = xhr.responseText;
				
				if(data == 'no') {
					alert("삭제 실패");
					return;
				}
				
				alert("삭제되었습니다.");
				location.href = "manage_hyoiwon.do";
			}
		}
		
		function update_i(idx, name, tel, gun_name, email){
			location.href = "manage_hyoiwon_imdaein_sujung.do?idx=" + idx +"&name="+ name
				+"&tel=" + tel + "&gun_name="+gun_name + "&email=" + email;
		}
		
		function delete_i(idx) {
			if(!confirm("정말 임대인 정보를 삭제하시겠습니까?\n삭제 후에는 복구가 불가능합니다.")) {
				return;
			}

			var url = "manage_hyoiwon_imdaein_del.do";
			var param = "idx=" + idx;
			
			sendRequest(url, param, resultFn_i, "POST");
		}
		
		function resultFn_i() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				var data = xhr.responseText;
				
				if(data == 'no') {
					alert("삭제 실패");
					return;
				}
				
				alert("삭제되었습니다.");
				location.href = "manage_hyoiwon.do";
			}
		}
	</script>
</head>
<body>
	<jsp:include page="../main/manage_menu.jsp" />
	
	<div id="center">
		<div class="center_top">
		<h2>회원관리</h2>
		<p align="center">가입한 회원의 정보를 관리합니다.</p>
		</div>
	</div>
	
		<p class="subtitle">공인중개사</p>
		
		<form name="f_gongin">
			<table class="subtable" border="1">
				<tr>
					<th class="t_name">이름</th>
					<th class="t_tel">전화번호</th>
					<th class="t_gong_name">상호</th>
					<th class="t_email">이메일</th>
					<th class="B_go">비고</th>
				</tr>
				<c:forEach var="gong" items="${gongList}">
				<tr>
					<td>${gong.name}</td>
					<td>${gong.tel}</td>
					<td>${gong.gong_name}</td>
					<td>${gong.email}</td>
					<td>
						<input type="button" class="btn_all" value="수정"
							onclick="update_g('${gong.idx}', '${gong.name}', '${gong.tel}', '${gong.gong_name}', '${gong.email}');">
						<input type="button" class="btn_all" value="삭제" onclick="delete_g('${gong.idx}');">
					</td>
				</tr>
				</c:forEach>
			</table>
		</form>

		<p class="subtitle">임대인</p>
		
		<form name="f_imdae">
			<table class="subtable" border="1">
				<tr>
					<th class="t_name">이름</th>
					<th class="t_tel">전화번호</th>
					<th class="t_gun_name">건물명</th>
					<th class="t_email">이메일</th>
					<th class="B_go">비고</th>
				</tr>
				<c:forEach var="im" items="${imList}">
					<tr>
						<td>${im.name}</td>
						<td>${im.tel}</td>
						<td>${im.gun_name}</td>
						<td>${im.email}</td>
						<td>
							<input type="button" class="btn_all" value="수정"
								onclick="update_i('${im.idx}', '${im.name}', '${im.tel}', '${im.gun_name}', '${im.email}');">
							<input type="button" class="btn_all" value="삭제" onclick="delete_i('${im.idx}');">
						</td>
					</tr>
				</c:forEach>
			</table>
		</form>
</body>
	
<footer>
	<jsp:include page="../common/real_footer.jsp" />
</footer>
</html>