<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>코리아주택관리</title>
<style>
	*{margin:0; padding:0;}
	body{overflow:hidden;}
	a{text-decoration:none; color:#575757;}
	#container {overflow:hidden; width:70%; height:966px; position:relative; float:left; border-right:2px solid #D5D5D5;}
	#mapWrapper {width:100%;height:100%;z-index:1;}
	#rvWrapper {width:100%;height:50%;bottom:0;right:0;position:absolute;z-index:0;}
	#container.view_roadview #mapWrapper {height: 50%;}
	#roadviewControl {position:absolute;top:5px;left:5px;width:42px;height:42px;z-index: 1;cursor: pointer; background: url(https://t1.daumcdn.net/localimg/localimages/07/2018/pc/common/img_search.png) 0 -450px no-repeat;}
	#roadviewControl.active {background-position:0 -350px;}
	#close {position: absolute;padding: 4px;top: 5px;left: 5px;cursor: pointer;background: #fff;border-radius: 4px;border: 1px solid #c8c8c8;box-shadow: 0px 1px #888;}
	#close .img {display: block;background: url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/rv_close.png) no-repeat;width: 14px;height: 14px;}
	body #info{width:29%; padding-left:3px; height:966px; float:right; overflow:auto;}
	body #info table{ border-collapse:collapse; margin:0px 30px;}
	body #info table tr{ padding:15px 3px;}
	body #info table tr td.gun_img{padding-left:10px; padding-top:30px;}
	body #info table tr td img{ top:0px; width:120px; height:120px;}
	body #info table tr td{padding:3px 0; font-family:"고딕", sans-serif;}
	body #info table tr td.top{padding-top: 30px; padding-bottom:6px; font-size:18px;}
	body #info table tr td.weolse{color:#5587ED; font-size:20px; font-family:"맑은 고딕", sans-serif;}
	body #info table tr td.gujo{font-size:15px; padding:3px 0;}
	body #info table tr.btm{border-bottom:2px solid #D5D5D5;}
	body #info table tr td.btm{padding-bottom: 25px; color:#575757; font-size:13px;}
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
</script>
</head>
<body>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c6f60502df856e2caedea334a8d6a976"></script>
	<div id="container">
	    <div id="rvWrapper">
	        <div id="roadview" style="width:100%;height:100%;"></div> <!-- 로드뷰를 표시할 div 입니다 -->
	        <div id="close" title="로드뷰닫기" onclick="closeRoadview()"><span class="img"></span></div>
	    </div>
	    <div id="mapWrapper">
	        <div id="map" style="width:100%%;height:100%"></div> <!-- 지도를 표시할 div 입니다 -->
	        <div id="roadviewControl" onclick="setRoadviewRoad()"></div>
	    </div>
	</div>
	<div id="info">
		<form>
		<table>
			<c:forEach var="list" items="${list}">
			<tr>
				<td class="top">
					${list.dong}
				</td>
				<td>
				<td class="gun_img" rowspan="5" valign="top">
					<c:if test="${list.gun_img_s ne 'no_file'}">
						<a href="" onclick="detail(${list.idx});">
							<img src="${pageContext.request.contextPath}/resources/upload/${list.gun_img_s}">
						</a>
					</c:if>
				</td>
			</tr>
			<tr>
				<td><a href="" onclick="detail(${list.idx});"><b>${list.gun_name}</b></a></td>
			</tr>
			<tr>
				<td class="weolse">월세 
				<fmt:formatNumber value="${list.weolse div 10000}" pattern="#,###.#"/>만</td>
			</tr>
			<tr>
				<td>보증금
				<fmt:formatNumber value="${list.bojung div 10000}" pattern="#,###.#"/>만 / 
				수수료 
				<fmt:formatNumber value="${list.susuryo div 10000}" pattern="#,###.#"/>만
				</td>
			</tr>
			<tr>
				<td class="gujo">${list.gujo} ∙ ${list.square}m², ${list.floor}층<td>
			</tr>
			<tr class="btm">
				<td class="btm" colspan="2">${list.content}</td>
			</tr>
			</c:forEach>
		</table>
	</form>
	</div>
	<p id="result"></p>
	<script>
	var overlayOn = false, //지도 위에 로드뷰 오버레이가 추가된 상태를 가지고 있을 변수
    container = document.getElementById('container'), 	//지도와 로드뷰를 감싸고 있는 div입니다
    mapWrapper = document.getElementById('mapWrapper'), //지도를 감싸고 있는 div입니다
    mapContainer = document.getElementById('map'), 		//지도를 표시할 div입니다
    rvContainer = document.getElementById('roadview');  //로드뷰를 표시할 div입니다
	
	var mapCenter = new kakao.maps.LatLng(${center}),   //지도의 중심좌표
	    mapOption = { 
	        center: mapCenter, //지도의 중심좌표
	        level: 7 //지도의 확대 레벨  
	    };
	
    //지도를 표시할 div와 지도 옵션으로 지도를 생성
	var map = new kakao.maps.Map(mapContainer, mapOption);
	
	//로드뷰 객체를 생성합니다 
	var rv = new kakao.maps.Roadview(rvContainer); 
	
	//좌표로부터 로드뷰 파노라마 ID를 가져올 로드뷰 클라이언트 객체를 생성합니다 
	var rvClient = new kakao.maps.RoadviewClient();
	
	//로드뷰에 좌표가 바뀌었을 때 발생하는 이벤트를 등록합니다 
	kakao.maps.event.addListener(rv, 'position_changed', function() {

	    //현재 로드뷰의 위치 좌표를 얻어옵니다 
	    var rvPosition = rv.getPosition();

	    //지도의 중심을 현재 로드뷰의 위치로 설정합니다
	    map.setCenter(rvPosition);

	    //지도 위에 로드뷰 도로 오버레이가 추가된 상태면
	    if(overlayOn) {
	        //마커의 위치를 현재 로드뷰의 위치로 설정합니다
	        moveMarker.setPosition(rvPosition);
	    }
	});
	
	//일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
	var mapTypeControl = new kakao.maps.MapTypeControl();

	//지도에 컨트롤을 추가해야 지도위에 표시됩니다
	//kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
	map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

	//지도 확대 축소를 제어할 수 있는 줌 컨트롤을 생성합니다
	var zoomControl = new kakao.maps.ZoomControl();
	map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
	
	//다각형을 구성하는 좌표 배열입니다. 이 좌표들을 이어서 다각형을 표시합니다 
	var polygonPath = [
		${polygon}
	];
	
	//지도에 표시할 다각형을 생성합니다
	var polygon = new kakao.maps.Polygon({
	    path:polygonPath, // 그려질 다각형의 좌표 배열입니다
	    strokeWeight: 3, // 선의 두께입니다
	    strokeColor: '#39DE2A', // 선의 색깔입니다
	    strokeOpacity: 0.8, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
	    strokeStyle: 'solid', // 선의 스타일입니다
	});
	
	//지도에 다각형을 표시합니다
	polygon.setMap(map);
	
	//다각형에 마우스다운 이벤트를 등록합니다
	kakao.maps.event.addListener(polygon, 'mousedown', function() { 
	    console.log(event);
	    var resultDiv = document.getElementById('result');
	});
	
	//마커를 표시할 위치와 내용을 가지고 있는 객체 배열입니다
	var positions = [
		<c:forEach items="${list}" var="list">
		{
	        content: '<div>${list.gun_name}<br>월세 : <fmt:formatNumber value="${list.weolse}"/>원<br>호수 : ${list.bang_num}호<br></div>', 
	        latlng: new kakao.maps.LatLng(${list.addr_num})
	    },
		</c:forEach>
	];
	
	console.log(positions);
	
	for (var i = 0; i < positions.length; i ++) {
	    //마커를 생성합니다
	    var marker = new kakao.maps.Marker({
	        map: map, //마커를 표시할 지도
	        position: positions[i].latlng //마커의 위치
	    });

	    //마커에 표시할 인포윈도우를 생성합니다 
	    var infowindow = new kakao.maps.InfoWindow({
	        content: positions[i].content //인포윈도우에 표시할 내용
	    });

	    //마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
	    //이벤트 리스너로는 클로저를 만들어 등록합니다 
	    //for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
	    kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
	    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
	}
	
	//마커 이미지를 생성합니다
	var markImage = new kakao.maps.MarkerImage(
	    'https://t1.daumcdn.net/localimg/localimages/07/2018/pc/roadview_minimap_wk_2018.png',
	    new kakao.maps.Size(26, 46),
	    {
	        //스프라이트 이미지를 사용합니다.
	        //스프라이트 이미지 전체의 크기를 지정하고
	        spriteSize: new kakao.maps.Size(1666, 168),
	        //사용하고 싶은 영역의 좌상단 좌표를 입력합니다.
	        //background-position으로 지정하는 값이며 부호는 반대입니다.
	        spriteOrigin: new kakao.maps.Point(705, 114),
	        offset: new kakao.maps.Point(13, 46)
	    }
	);
	
	//드래그가 가능한 마커를 생성합니다
	var moveMarker = new kakao.maps.Marker({
	    image : markImage,
	    position: mapCenter,
	    draggable: true
	});

	//마커에 dragend 이벤트를 등록합니다
	kakao.maps.event.addListener(moveMarker, 'dragend', function(mouseEvent) {

	    //현재 마커가 놓인 자리의 좌표입니다 
	    var position = moveMarker.getPosition();

	    //마커가 놓인 위치를 기준으로 로드뷰를 설정합니다
	    toggleRoadview(position);
	});

	//지도에 클릭 이벤트를 등록합니다
	kakao.maps.event.addListener(map, 'click', function(mouseEvent){
	    
	    //지도 위에 로드뷰 도로 오버레이가 추가된 상태가 아니면 클릭 이벤트를 무시합니다 
	    if(!overlayOn) {
	        return;
	    }

	    //클릭한 위치의 좌표입니다 
	    var position = mouseEvent.latLng;

	    //마커를 클릭한 위치로 옮깁니다
	    moveMarker.setPosition(position);

	    //클락한 위치를 기준으로 로드뷰를 설정합니다
	    toggleRoadview(position);
	});
	
	//전달받은 좌표(position)에 가까운 로드뷰의 파노라마 ID를 추출하여 로드뷰를 설정하는 함수입니다
	function toggleRoadview(position){
	    rvClient.getNearestPanoId(position, 50, function(panoId) {
	        //파노라마 ID가 null이면 로드뷰를 숨깁니다
	        if (panoId === null) {
	            toggleMapWrapper(true, position);
	        } else {
	         toggleMapWrapper(false, position);
	            //panoId로 로드뷰를 설정합니다
	            rv.setPanoId(panoId, position);
	        }
	    });
	}
	
	//지도를 감싸고 있는 div의 크기를 조정하는 함수입니다
	function toggleMapWrapper(active, position) {
	    if(active) {
	        //지도를 감싸고 있는 div의 너비가 100%가 되도록 class를 변경합니다 
	        container.className = '';

	        //지도의 크기가 변경되었기 때문에 relayout 함수를 호출합니다
	        map.relayout();

	        //지도의 너비가 변경될 때 지도중심을 입력받은 위치(position)로 설정합니다
	        map.setCenter(position);
	    } else {
	        //지도만 보여지고 있는 상태이면 지도의 너비가 50%가 되도록
	        //class를 변경하여 로드뷰가 함께 표시되게 합니다
	        if(container.className.indexOf('view_roadview') === -1) {
	            container.className = 'view_roadview';

	            //지도의 크기가 변경되었기 때문에 relayout 함수를 호출합니다
	            map.relayout();

	            //지도의 너비가 변경될 때 지도중심을 입력받은 위치(position)로 설정합니다
	            map.setCenter(position);
	        }
	    }
	}
	
	// 지도 위의 로드뷰 도로 오버레이를 추가,제거하는 함수입니다
	function toggleOverlay(active) {
	    if(active) {
			overlayOn = true;

	        //지도 위에 로드뷰 도로 오버레이를 추가합니다
	        map.addOverlayMapTypeId(kakao.maps.MapTypeId.ROADVIEW);

	        //지도 위에 마커를 표시합니다
	        moveMarker.setMap(map);

	        //마커의 위치를 지도 중심으로 설정합니다 
	        moveMarker.setPosition(map.getCenter());

	        //로드뷰의 위치를 지도 중심으로 설정합니다
	        toggleRoadview(map.getCenter());
	    } else {
	        overlayOn = false;

	        //지도 위의 로드뷰 도로 오버레이(선들)를 제거합니다
	        map.removeOverlayMapTypeId(kakao.maps.MapTypeId.ROADVIEW);

	        //지도 위의 마커를 제거합니다
	        moveMarker.setMap(null);
	    }
	}

	//지도 위의 로드뷰 버튼을 눌렀을 때 호출되는 함수입니다
	function setRoadviewRoad() {
	    var control = document.getElementById('roadviewControl');

	    //버튼이 눌린 상태가 아니면
	    if (control.className.indexOf('active') === -1) {
	        control.className = 'active';

	        //로드뷰 도로 오버레이가 보이게 합니다
	        toggleOverlay(true);
	    } else {
	        control.className = '';

	        //로드뷰 도로 오버레이를 제거합니다
	        toggleOverlay(false);
	    }
	}

	//로드뷰에서 X버튼을 눌렀을 때 로드뷰를 지도 뒤로 숨기는 함수입니다
	function closeRoadview() {
	    var position = moveMarker.getPosition();
	    toggleMapWrapper(true, position);
	}
	
	//인포윈도우를 표시하는 클로저를 만드는 함수입니다 
	function makeOverListener(map, marker, infowindow) {
	    return function() {
	        infowindow.open(map, marker);
	    };
	}
	
	//인포윈도우를 닫는 클로저를 만드는 함수입니다 
	function makeOutListener(infowindow) {
	    return function() {
	        infowindow.close();
	    };
	}
	</script>
</body>
</html>