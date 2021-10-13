<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>코리아주택관리</title>
		
		<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/style2.css">
		<script src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>
		<style>
			*{margin:0; padding:0;}
			.center_top h2{font-size:30px; text-align:center; padding-top:43px;}
			.center_top h2:after {
		        content: "";
		        display: block;
		        width: 60px;
		        border-bottom: 2px solid #D5D5D5;
		        margin: 30px auto 30px;
	    	}
	    	.center_top p{width:500px; margin:10px 28% 40px; font-size:13px;}
			.table_left{align:left; width:1100px; font-size:22px; font-family:"맑은 고딕";}
			.table_right{align:right; width:1100px; font-size:22px; font-family:"맑은 고딕";}
			.table_left td{padding:30px; margin:30px;}
			.table_right td{padding:30px; margin:30px; text-align:right;}
			.subtitle{font:normal normal bold 30px "맑은 고딕"; padding:30px 20px;}
			.gubun_line{margin:20px 0;}
			.small_title{color:#6f6dd2; margin-bottom:15px; font-weight:bold;}
		</style>
	</head>
	<body>
		<!-- 로그인하지 않았을 경우 -->
		<c:if test="${empty sessionScope.manage_vo and empty sessionScope.gongin_vo and empty sessionScope.imdaein_vo}">
			<jsp:include page="../main/not_login_menu.jsp" />
		</c:if>
		
		<!-- 관리사가 로그인한 경우 -->
		<c:if test="${not empty sessionScope.manage_vo and empty sessionScope.gongin_vo and empty sessionScope.imdaein_vo}">
			<jsp:include page="../main/manage_menu.jsp" />
		</c:if>
				
		<!-- 공인중개사가 로그인한 경우 -->
		<c:if test="${empty sessionScope.manage_vo and not empty sessionScope.gongin_vo and empty sessionScope.imdaein_vo}">
			<jsp:include page="../main/gongin_menu.jsp" />
		</c:if>
				
		<!-- 임대인이 로그인한 경우 -->
		<c:if test="${empty sessionScope.manage_vo and empty sessionScope.gongin_vo and not empty sessionScope.imdaein_vo}">
			<jsp:include page="../main/imdae_menu.jsp" />
		</c:if>
		
		<div class="center_top">
			<h2>홈페이지 이용 안내</h2>
			<p align="center">본인에게 맞는 항목으로 회원가입 후 로그인하시면<br>홈페이지를 더욱 편리하게 이용하실 수 있습니다.</p>
		</div>
		
		<img src="${pageContext.request.contextPath}/resources/img/use_info.jpg"
				onmouseover="this.src='${pageContext.request.contextPath}/resources/img/cover.png'"
				onmouseout="this.src='${pageContext.request.contextPath}/resources/img/use_info.jpg'">
		
		<table class="table_left">
			<caption class="subtitle" style="text-align:left;">관리사</caption>
			<tr>
				<td width="130">
					<img src="${pageContext.request.contextPath}/resources/img/icon01.png" width="110" height="110">
				</td>
				<td>
					<p class="small_title">공지사항 관리</p>
					<p class="small_content">최신 부동산 소식과 각종 전달 사항을<br>
					회원들에게 빠르게 전달합니다.</p>
				</td>
			</tr>
			<tr>
				<td width="130">
					<img src="${pageContext.request.contextPath}/resources/img/icon02.png" width="110" height="110">
				</td>
				<td>
					<p class="small_title">임대인 대행</p>
					<p class="small_content">관리사는 임대인에게 권한을 위임 받아<br>
					임대인의 모든 업무를 처리할 수 있습니다.</p>
				</td>
			</tr>
			<tr>
				<td width="130">
					<img src="${pageContext.request.contextPath}/resources/img/icon03n06.png" width="110" height="110">
				</td>
				<td>
					<p class="small_title">매물 관리</p>
					<p class="small_content">임대인의 소중한 자산을 든든하게 관리합니다.</p>
				</td>
			</tr>
		</table>
		
		<hr class="gubun_line" width="1100">
		
		<table class="table_right">
			<caption class="subtitle" style="text-align:right;">공인중개사</caption>
			<tr>
				<td>
					<p class="small_title">매물 리스트 확인</p>
					<p class="small_content">지도와 키워드 검색으로<br>
					원하는 매물을 쉽고 빠르게 확인합니다.</p>
				</td>
				<td width="130">
					<img src="${pageContext.request.contextPath}/resources/img/icon04.png" width="110" height="110">
				</td>
			</tr>
			<tr>
				<td>
					<p class="small_title">매물 예약</p>
					<p class="small_content">고객이 원하는 매물을 예약 버튼 하나로<br>
					24시간 동안 독점할 수 있습니다.</p>
				</td>
				<td width="130">
					<img src="${pageContext.request.contextPath}/resources/img/icon05.png" width="110" height="110">
				</td>
			</tr>
		</table>
		
		<hr class="gubun_line" width="1100">
		
		<table class="table_left" style="margin-bottom:50px;">
			<caption class="subtitle" style="text-align:left;">임대인</caption>
			<tr>
				<td width="130">
					<img src="${pageContext.request.contextPath}/resources/img/icon03n06.png" width="110" height="110">
				</td>
				<td>
					<p class="small_title">매물 등록</p>
					<p class="small_content">임대인이 보유한 건물을 공인중개사 및<br>
					홈페이지 이용자들이 볼 수 있도록 등록합니다.</p>
				</td>
			</tr>
			<tr>
				<td width="130">
					<img src="${pageContext.request.contextPath}/resources/img/icon07.png" width="110" height="110">
				</td>
				<td>
					<p class="small_title">내 건물 관리</p>
					<p class="small_content">자신의 매물 상태를 쉽고 간편하게<br>
					확인할 수 있습니다.</p>
				</td>
			</tr>
		</table>
	</body>
			
	<footer>
		<jsp:include page="../common/real_footer.jsp" />
	</footer>
</html>