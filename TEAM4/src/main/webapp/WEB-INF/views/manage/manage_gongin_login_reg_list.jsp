<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>코리아주택관리</title>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.1/css/all.css">
	<style>
		*{margin:0; padding:0; align:center;}
		li{list-style:none;}
		a{text-decoration:none; color:#767676;}
		#body{width:1100px; overflow:hidden;}
		#body .tt{ width:320px; float:left; font-size:20px; color: #767676; margin:30px 0 10px 49px;}
		#body table{border-collapse:collapse;
					border-color:#BDBDBD;
					font-size:17px;
					width:1000px; height:auto;
					margin:0px auto;}
		#body tr.top{border-top:4px double #7540c7;}
		#body tr{border-bottom:1px solid #BDBDBD;}
		#body tr.b{border-bottom:0}
		#body th, td{padding:15px 20px; width:100px;}
		#body th{font-weight:bold;}
		#body table tr.bottom{border-bottom:2px solid #BDBDBD;}
		#body td input{padding:8px 10px;}
		.button { background-color: blue; border: none; color: white; padding:30px 7px;
		  text-align: center; text-decoration: none; display: inline-block;
		  font-size: 15px; margin: 4px 2px; cursor: pointer; background:#BA90F6;
		  border-radius:10px 0 10px 0; transition: 1s;
		}
		.button:hover{ text-shadow: 0 0 .1em, 0 0 .3em; }
		.button[disabled],.disabled { opacity: 0.5; filter:alpha(opacity=50); cursor: not-allowed;}
	</style>
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>
	<script>
		function detail(idx) {
			//팝업창 중앙 정렬
			var popW = 1200;
			var popH = 800;
			var popupX = (screen.availWidth - popW) / 2;
			var popupY = (screen.availHeight - popH) / 2;
			window.open("gm_view.do?idx=" + idx, "코리아주택관리", "width=" + popW + ",height=" + popH + ",left=" + popupX + ",top=" + popupY);
		}
		
		function cancel( idx){
			if(!confirm("매물을 내리시겠습니까?")){
				return;
			}
			location.href = "cancelReg.do?idx=" + idx;
		}
	</script>
</head>

<body>
	<jsp:include page="../main/manage_menu.jsp" />
		
		<div id="body">
			
		<p class="tt">등록된 매물 목록</p>
		<table align="center">
			<tr class="top">
				<td align="center" width="400px">사진</td>
				<td colspan="3" align="center">건물명세서</td>
				<td align="center">매물 내리기</td>
			</tr>
			
			<c:forEach var="list" items="${list}">
			<tr>
				<td rowspan="7" align="center">
						<c:if test="${list.gun_img_s eq 'no_file'}">
							<a href="" onclick="detail(${list.idx});">
								<img src="${pageContext.request.contextPath}/resources/img/no_image.png" width="400" height="260">
							</a>
						</c:if>
						<c:if test="${list.gun_img_s ne 'no_file'}">
							<a href="" onclick="detail(${list.idx});">
								<img src="${pageContext.request.contextPath}/resources/img/${list.gun_img_s}" width="400" height="260">
							</a>
						</c:if>
				</td>
				<td>건물명</td>
				<td colspan="2" align="center">${list.gun_name}</td>
				
				<td rowspan="7" align="center">
				<input type="button" value="매물내리기" class="button" onclick="cancel('${list.idx}');">
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
				<td>구조</td>
				<td colspan="2" align="center">${list.gujo}</td>
			</tr>
			<tr>
				<td>보증금</td>
				<td colspan="2" align="center">
					<fmt:formatNumber value="${list.bojung div 10000}" pattern="#,###.#"/>만원
				</td>
			</tr>
			<tr>
				<td>월세</td>
				<td colspan="2" align="center">
					<fmt:formatNumber value="${list.weolse div 10000}" pattern="#,###.#" />만원
				</td>
			</tr>
			<tr class="bottom">
				<td>수수료</td>
				<td colspan="2" align="center">
				<fmt:formatNumber value="${list.susuryo div 10000}" pattern="#,###.#" />만원
				</td>
			</tr>
			</c:forEach>
		</table>
		</div>
	</body>
	
	<footer>
		<jsp:include page="../common/real_footer.jsp" />
	</footer>
</html>