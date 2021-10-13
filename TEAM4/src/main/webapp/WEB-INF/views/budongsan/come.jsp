<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>코리아주택관리</title>
	
	<style>
		*{maring:0; padding:0;}
		a{text-decoration:none; color:#767676;}
		#center .center_top h2{text-align:center; font-size:30px; padding-top:43px;}
		/* h2:after {
		  content: "";
		  display: block;
		  width: xxx;
		  border-bottom: xxx;
		} */
	    #center .center_top h2:after {
	        content: "";
	        display: block;
	        width: 60px;
	        border-bottom: 2px solid #D5D5D5;
	        margin: 30px auto 30px;
	    }
		#center .center_top p{width:500px; margin:10px 28% 45px; font-size:13px;}
		#center #map{margin:0 auto;}
		.contact_list{padding-bottom: 120px;max-width: 980px;margin: 0 auto;}
		.contact_list ul {margin-top:16px;}
		.contact_list ul li{overflow: hidden;padding: 50px 0;border-top: 1px solid #dbdbdb;}
		.contact_list ul li:first-child{border-top: 0;}
		.contact_list ul li .tit{float: left; width: 170px;font-size: 26px;line-height: 36px;color: #333333; letter-spacing: -0.6px;}
		.contact_list ul li .tit_{float: left; width: 170px;font-size: 20px;line-height: 36px;color: #333333; letter-spacing: -0.6px;}
		.contact_list ul li .desc{float: left;text-align: left;font-size: 14px;line-height: 22px;}
		.contact_list ul li .desc .item{overflow: hidden;padding-top: 40px;}
		.contact_list ul li .desc .item:first-child{padding-top: 0;}
		.contact_list ul li .desc .item .ico{float: left;padding-right: 15px;min-width: 45px;}
		.contact_list ul li .desc .item .text{float: left;line-height: 38px;overflow: hidden}
		.contact_list ul li .desc .item .text em{font-weight: 700;width: 120px;display: block;float: left}
		.contact_list ul li .desc .item.multiline{float: left;padding-right: 60px;padding-top: 0;}
		.contact_list ul li .desc .item.multiline .text{line-height: 20px;}
		.contact_list ul li .desc .item.multiline .text em{float: none;width: 100%;}
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
		
	<div id="center">
		<div class="center_top">
		<h2>오시는 길</h2>
		<p align="center">코리아 주택관리로 오시는 길을 소개합니다.</p>
		</div>
		<div id="map" style="width:70%;height:500px;"></div>
	</div>
	
	<div class="contact_list">
	<ul>
	    	<li>
	        <div class="tit_">주소 &amp; 연락처</div>
	        <div class="desc">
	            <div class="item multiline">
	                <div class="ico"><img src="${pageContext.request.contextPath}/resources/image/ico_juso.png" alt="주소"/></div>
	                <div class="text"><em>주소</em>서울특별시 마포구 노고산동 106-5 (우: 04100)</div>
	            </div>
	            <div class="item multiline">
	                <div class="ico"><img src="${pageContext.request.contextPath}/resources/image/ico_phone.png" alt="전화"/></div>
	                <div class="text"><em>전화</em>02.313.7300</div>
	            </div>
	            <div class="item multiline">
	                <div class="ico"><img src="${pageContext.request.contextPath}/resources/image/ico_fax.png" alt="팩스"/></div>
	                <div class="text"><em>팩스</em>02.313.0516</div>
	            </div>
	       	</div>
	    	</li>
			<li>
				<div class="tit">교통편</div>
				<div class="desc">
				    <div class="item">
				        <div class="ico"><img src="${pageContext.request.contextPath}/resources/image/ico_metro.png" alt=""/></div>
				        <div class="text"><em>지하철 이용시</em>신촌역(2호선)에서 하차, 6 또는 7번 출구에서 도보 1-2분 거리</div>
				    </div>
				    <div class="item">
				        <div class="ico"><img src="${pageContext.request.contextPath}/resources/image/ico_bus.png" alt=""/></div>
				        <div class="text"><em>버스 이용시</em>신촌로터리 정류소 하차</div>
				    </div>
				</div>
			</li>
		</ul>
	</div>
	
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c6f60502df856e2caedea334a8d6a976"></script>
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = { 
		        center: new kakao.maps.LatLng(37.554041, 126.935694), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };
		
		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		
		var imageSrc = '${pageContext.request.contextPath}/resources/image/budon_s.ico', // 마커이미지의 주소입니다    
		    imageSize = new kakao.maps.Size(48, 53), // 마커이미지의 크기입니다
		    imageOption = {offset: new kakao.maps.Point(17, 40)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
		
		    console.log(imageSrc);
		// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
		var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
		    markerPosition = new kakao.maps.LatLng(37.554041, 126.935694); // 마커가 표시될 위치입니다
		
		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
		    position: markerPosition, 
		    image: markerImage // 마커이미지 설정 
		});
		
		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);  
	</script>
	</body>
	
	<footer>
		<jsp:include page="../common/real_footer.jsp" />
	</footer>
</html>