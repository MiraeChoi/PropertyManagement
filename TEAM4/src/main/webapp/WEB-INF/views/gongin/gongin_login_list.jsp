<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="check_login_g.jsp" %>
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
		#body{width:1100px;}
		#body p.maemul{ font-size:25px; margin:70px 0 0 0; font-size:40px; font-weight:lighter;}
		#body p.maemul span{color:#9253EB;}
		#body div.search-box{ padding:10px; margin:50px 550px 50px 550px; width:430px;
		transform:translate(-50%, -50%); height: 30px;
		border:1px solid #ECADFF; }
		.search-txt{ padding:0; width:400px; border:none; outline: none;
		float:left; font-size:1rem; line-height:30px;}
		.search-btn{ text-decoration:none; display:flex; justify-content:center;
		align-items:center; width:30px; height:30px; border-radius:30px; color:#DA9BFF}
		#body table{border-collapse:collapse;
					border-color:#BDBDBD;
					font-size:17px;
					width:1000px; height:auto;
					margin:100px auto;}
		#body tr.top{border-top:4px double #7540c7;}
		#body tr{border-bottom:1px solid #BDBDBD;}
		#body tr.b{border-bottom:0}
		#body th, td{padding:15px 20px; width:100px;}
		#body th{font-weight:bold;}
		#body td input{padding:8px 10px;}
		.button { background-color: blue; border: none; color: white; padding:30px 7px;
		  text-align: center; text-decoration: none; display: inline-block;
		  font-size: 20px; margin: 4px 2px; cursor: pointer; background:#BA90F6;
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
		
		function yeyakbutton(form) {
			if(!confirm("예약하시겠습니까?\n예약은 24시간 동안 유지됩니다.")) {
				return;
			}
			
			alert('10초 내로 계약 부탁드립니다. 10초 내로 미계약 시 예약이 취소됩니다.');
			
			var gun_idx = form.gun_idx.value;
			var gong_idx = form.gong_idx.value;
			
			var url = "gongin_yeyak.do";
			var param = "gun_idx=" + gun_idx +"&gong_idx=" + gong_idx;
			
			var button_joinus = document.getElementById(gun_idx);
			button_joinus.disabled = "disabled";
			
			sendRequest(url, param, resultFn, 'POST');
		}
		
		function resultFn() {
			if(xhr.readyState==4 && xhr.status==200) {
				var json = xhr.responseText;
				var data = eval(json);
				var d1 = data[0].result;
				if( d1 == 'yes'){
					location.href="/four/gongin_list.do";
				}
			}
		}
		
		//계약버튼
		function gyeyakbutton( gun_idx ){
			if(!confirm("계약하시겠습니까?")) {
				return;
			}
			location.href="/four/gong_gyeyak.do?gun_idx=" + gun_idx;
		}
	</script>
</head>

<body>
	<jsp:include page="../main/gongin_menu.jsp" />
	
	<div id="body">
		<p class="maemul" align="center"><span>어떤 동네, 어떤 방을</span><br> 찾으시나요?</p>
		<div class="search-box">
		<form name="f" action="gong_searchRegion.do">
			<input type="text" class="search-txt" name="searchRegion" placeholder="지역을 검색하시오">
			<a href="javascript:document.f.submit();" class="search-btn" >
				<i class="fas fa-search"></i>
			</a>
		</form>
	</div>
	
	<table align="center">
		<tr class="top">
			<td align="center" width="400px">사진</td>
			<td colspan="3" align="center">건물명세서</td>
			<td align="center">예약</td>
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
			<td colspan="2" align="center">
            	<a href="" onclick="detail(${list.idx});"><b><font color="#7308cd">${list.gun_name}</font></b></a>
            </td>
			
			<form name="form">
			<td rowspan="7" align="center">
				<input type="hidden" value="${list.idx}" name="gun_idx">
				<input type="hidden" value="${gongin_vo.idx}" name="gong_idx">
				<c:choose>
					<c:when test="${list.yeyak_gongin_idx eq 0}">
						<input type="button" id="${list.idx}" class="button" value="예약"
							onclick="yeyakbutton(this.form);"/>
					</c:when>
					
					<c:otherwise>
						<input type="button" id="${list.idx}" class="button" value="예약"
							onclick="yeyakbutton(this.form);" disabled="disabled"/>
					</c:otherwise>
						
				</c:choose>
			</td>
			</form>
			
			<td rowspan="7" align="center">
				<input type="button" value="계약" class="button" 
					onclick="gyeyakbutton('${list.idx}');"/>
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
				<fmt:formatNumber value="${list.bojung div 10000}" pattern="#,###.#"/>만 원
			</td>
		</tr>
		<tr>
			<td>월세</td>
			<td colspan="2" align="center">
               <fmt:formatNumber value="${list.weolse div 10000}" pattern="#,###.#" />만 원
            </td>
		</tr>
		<tr>
			<td>수수료</td>
			<td colspan="2" align="center">
            	<fmt:formatNumber value="${list.susuryo div 10000}" pattern="#,###.#" />만 원
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