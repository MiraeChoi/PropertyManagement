<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="check_login_g.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>코리아주택관리</title>
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&amp;subset=korean" rel="stylesheet">
<style>
	*{margin:0; padding:0;}
	li{list-style:none;}
	a{text-decoration:none; color:#767676;}
	
	#body{width:1100px;}
	#body table{border-collapse:collapse;
				border-color:#BDBDBD;
				font-size:17px;
				width:1000px; height:auto;
				margin:30px auto;}
	#body tr.tt{ margin:0; }
	#body tr td.tt{text-align:center; font-size:28px; margin:0; font-weight:bold;}
	#body tr.top{border-top:4px double #DA9BFF;}
	#body tr{border-bottom:1px solid #BDBDBD;}
	#body tr.b{border-bottom:0}
	#body th, td{padding:15px 20px; width:100px;}
	#body th{font-weight:bold;}
	#body td input{padding:8px 10px;}
	.button { background-color: blue; border: none; color: white; padding:30px 7px;
	  text-align: center; text-decoration: none; display: inline-block;
	  font-size: 20px; margin: 4px 2px; cursor: pointer; background:#BA90F6;
	  border-radius:10px 0 10px 0; transition: 1s;}
	.button:hover{ text-shadow: 0 0 .1em, 0 0 .3em; }
	.button[disabled],.disabled { opacity: 0.5; filter:alpha(opacity=50); cursor: not-allowed;}
</style>

<script>
	function detail(idx) {
		//팝업창 중앙 정렬
		var popW = 1200;
		var popH = 800;
		var popupX = (screen.availWidth - popW) / 2;
		var popupY = (screen.availHeight - popH) / 2;
		window.open("gm_view.do?idx=" + idx, "코리아주택관리", "width=" + popW + ",height=" + popH + ",left=" + popupX + ",top=" + popupY);
	}
	
	function cancelYeyak( gun_idx ){
		if(!confirm("예약을 취소하시겠습니까?")) {
			return;
		}
		location.href="gongin_cancel_yeyak.do?gun_idx="+ gun_idx + "&yeyak_gongin_idx=" + "${gongin_vo.idx}";
	}
	
	function gongGyeyak( gun_idx ){
		if(!confirm("계약하시겠습니까?")) {
			return;
		}
		location.href = "gongin_gyeyak_in_yeyak_list.do?gun_idx="+ gun_idx + "&yeyak_gongin_idx=" + "${gongin_vo.idx}"; 
	}
</script>
</head>

<body>
	<jsp:include page="../main/gongin_menu.jsp" />
	
	<div id="body">
		<table align="center">
			<tr class="tt">
				<td colspan="6" class="tt">예약 매물목록</td>
			</tr>
			<tr class="top">
				<td align="center">사진</td>
				<td colspan="3" align="center">건물명세서</td>
				<td align="center">예약취소</td>
				<td align="center">계약</td>
			</tr>
			
		<c:forEach var="list" items="${list}">
			<tr>
				<td rowspan="7" align="center" >
					<c:if test="${list.gun_img_s eq 'no_file'}">
						<a href="" onclick="detail(${list.idx});">
							<img src="${pageContext.request.contextPath}/resources/img/no_image.png" width="300" height="200">
						</a>
					</c:if>
					<c:if test="${list.gun_img_s ne 'no_file'}">
						<a href="" onclick="detail(${list.idx});">
							<img src="${pageContext.request.contextPath}/resources/img/${list.gun_img_s}" width="300" height="200">
						</a>
					</c:if>
				</td>
				<td>건물명</td>
				<td colspan="2" align="center">${list.gun_name}</td>
				
				<td rowspan="7" align="center">
				<input type="button" value="예약취소" class="button" onclick="cancelYeyak('${list.idx}');">
				</td>
				
				<td rowspan="7" align="center">
				<input type="button" value="계약" class="button" onclick="gongGyeyak('${list.idx}');">
				</td>
			</tr>
			<tr>
			<td>주소</td>
				<td colspan="2" align="center">${list.addr}</td>
			</tr>
			<tr>
				<td>호/실</td>
				<td colspan="2" align="center">${list.bang_num}</td>
			</tr>
			<tr>
				<td>형태</td>
				<td colspan="2" align="center">${list.gujo}</td>
				
			</tr>
			<tr>
				<td>보증금</td>
				<td colspan="2" align="center">
					<fmt:formatNumber value="${list.bojung div 10000}" pattern="#,###.#"/>만 원
				</td>
			</tr>
			<tr>
				<td>계약금</td>
				<td colspan="2" align="center">
					<fmt:formatNumber value="${list.weolse div 10000}" pattern="#,###.#"/>만 원
				</td>
			</tr>
			<tr>
				<td>수수료</td>
				<td colspan="2" align="center">
					<fmt:formatNumber value="${list.susuryo div 10000}" pattern="#,###.#"/>만 원
				</td>
			</tr>
		</c:forEach>
			
		</table>
	</div>
	
	<footer>
		<jsp:include page="../common/real_footer.jsp" />
	</footer>
</body>
</html>