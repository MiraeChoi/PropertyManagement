<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="check_login_i.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>코리아주택관리</title>
	
	<style>
		*{maring:0; padding:0;}
		a{text-decoration:none; color:#767676;}
		.center_top h2{font-size:30px; text-align:center; padding-top:43px;}
		.center_top h2:after {
	        content: "";
	        display: block;
	        width: 60px;
	        border-bottom: 2px solid #D5D5D5;
	        margin: 30px auto 30px;
	    }
	    .center_top p{width:500px; margin:10px 28% 45px; font-size:13px;}
		table{border-collapse:collapse;
			  font-size:17px; width:900px; margin:10px auto;}
		td{padding:15px 20px;}
		.gun_name_effect{text-align:left; padding-left:32px; padding-top:20px; font-size:20px;}
		.gubun{margin:10px 0; width:320px;}
		.btm{padding:10px 0 15px; color:#575757; font-size:13px; font-family:"돋움"}
		.m_btn{margin-top:10px; border:1px solid purple; position:relative; padding:5px;
				background-color:white; color:purple; font-weight:bold;
				border-top-right-radius:5px; border-bottom-right-radius:5px;
				border-top-left-radius:5px; border-bottom-left-radius:5px;}
	</style>
	
	<script src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>
	<script>
		function detail(idx) {
			//팝업창 중앙 정렬
			var popW = 1200;
			var popH = 800;
			var popupX = (screen.availWidth - popW) / 2;
			var popupY = (screen.availHeight - popH) / 2;
			window.open("gm_view.do?idx=" + idx, "코리아주택관리", "width=" + popW + ",height=" + popH + ",left=" + popupX + ",top=" + popupY);
		}
		
		function cancel(idx) {
			if(!confirm("매물 등록을 취소하시겠습니까?\n내 건물 관리에는 그대로 유지됩니다.")) {
				return;
			}
			
			var url = "gongin_cancel.do";
			var param = "idx=" + idx;
			
			sendRequest(url, param, resultFn_cancel, "POST");
		}
		
		function resultFn_cancel() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				if(!confirm("취소되었습니다.\n내 건물 관리 페이지로 이동하시겠습니까?")){
					return;
				}
				
				location.href = "my_gmlist.do";
			}
		}
		
		function resultFn() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				var data = xhr.responseText;
				
				if(data == 'no') {
					alert("삭제 실패");
					return;
				}
				
				alert("삭제되었습니다.");
				location.href = "gm_maemul_list.do";
			}
		}
	</script>
</head>
<body>
	<jsp:include page="../main/imdae_menu.jsp" />
	<div class="center_top">
		<h2>매물 리스트</h2>
		<p align="center">매물 리스트에 등록된 건물은 사이트에 노출됩니다.</p>
	</div>
	
	<form>
		<table align="center">
			<c:forEach var="vo" items="${list}">
				<tr>
					<th class="gun_name_effect"><font color="#7c27c7" size="3px">No. ${vo.idx}</font>　${vo.gun_name}</th>
				</tr>
				<input type="hidden" name="idx" value="${vo.idx}">
				<tr>
					<td align="center" width="330">
						<a href="" onclick="detail(${vo.idx});">
							<c:if test="${vo.gun_img_s eq 'no_file'}">
								<img src="${pageContext.request.contextPath}/resources/img/no_image.png" width="300" height="200">
							</c:if>
							<c:if test="${vo.gun_img_s ne 'no_file'}">
								<img src="${pageContext.request.contextPath}/resources/upload/${vo.gun_img_s}" width="300" height="200">
							</c:if>
						</a>
					</td>
					<td>
						${vo.addr}<br>
						
						<font color="#5587ED"><b>보증금 <fmt:formatNumber value="${vo.bojung div 10000}" pattern="#,###.#"/>만</b></font> | 
						<font color="#5587ED"><b>월세 <fmt:formatNumber value="${vo.weolse div 10000}" pattern="#,###.#"/>만</b></font> | 
						수수료 <fmt:formatNumber value="${vo.susuryo div 10000}" pattern="#,###.#"/>만
						<hr class="gubun">
						${vo.gujo} ∙ ${vo.square}m², ${vo.floor}층<br>
						<pre class="btm">${vo.content}</pre>
						<input type="button" class="m_btn" value="등록 취소" onclick="cancel(${vo.idx});">
						
					<%-- <b>${vo.gun_name}</b><br>
						보증금 : <fmt:formatNumber value="${vo.bojung}" type="number" />원<br>
						월세 : <fmt:formatNumber value="${vo.weolse}" type="number" />원<br>
						수수료 : <fmt:formatNumber value="${vo.susuryo}" type="number" />원<br>
						<input type="button" value="등록 취소" onclick="cancel(${vo.idx});"> --%>
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