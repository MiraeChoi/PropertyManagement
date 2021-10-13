<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>코리아주택관리</title>
	
	<style media="screen">
		*{margin:0; padding:0;}
		a{text-decoration:none;}
		.main{margin:10px auto;}
		
		.gun_name_effect{text-align:left; padding-left:55px; padding-top:20px; font-size:20px; font-weight:bold;}
		.subtitle{font-weight:bold;}
		
		#slide{width:500px; height:350px; overflow:hidden; position:relative; margin:0 auto; vertical-align:top; padding:0;}
		/* #slide ul{width:3500px; position:absolute; top:0; left:0; font-size:0;} */
		#slide ul li{display:inline-block;}
		#prev{position:absolute; top:150px; left:0; cursor:pointer; z-index:1;}
		#daum{position:absolute; top:150px; right:0; cursor:pointer; z-index:1;}
		#info{margin:10px auto; vertical-align:top;}
		.tables{border:1px solid #aaa; border-collapse:collapse; align:center; margin:10px auto;}
		.right{width:550px;}
		.content{width:1100px;}
		th{padding:0 20px 0 10px;}
		td{padding:5px;}
		.btm{padding:10px 0 15px; color:#575757; font-family:"맑은 고딕"}
		.detail_close{font-size:12pt; font-weight:bold; background:#7c27c7; border:none; color:white;
					width:120px; height:60px; outline:none; text-align:center; margin-top:20px;}
    </style>
	
	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script>
		$(document).ready(function(){
			var imgs;
			var img_position = 1;

			imgs = $("#slide ul");
			img_count = imgs.children().length;

			//버튼을 클릭했을 때 함수 실행
			$('#prev').click(function() {prev();});
			$('#daum').click(function() {daum();});

			function prev() {
				if(img_position > 1){
					imgs.animate({
						left : '+=500px'
					});
					img_position--;	
				}
			}
			
			function daum() {
				if(img_position < img_count){
					imgs.animate({
						left : '-=500px'
					});
					img_position++;	
				}
			}
	    });
	</script>
</head>
<body>
	<p class="gun_name_effect"><font color="#7c27c7" size="3px">No. ${vo.idx}</font>　${vo.gun_name}</p>
	
	<table class="main" align="center">
		<tr>
			<td>
				<!-- 상세 사진을 업로드하지 않은 경우 -->
				<c:if test="${vo.gun_img_l eq 'no_file'}">
					<img src="${pageContext.request.contextPath}/resources/img/no_image_detail.png">
				</c:if>
				
				<c:if test="${vo.gun_img_l ne 'no_file'}">
					<!-- 상세 사진을 1개만 올린 경우 -->
					<c:if test="${vo.file_gaesu eq 1}">
						<img src="${pageContext.request.contextPath}/resources/upload/${vo.gun_img_arr[0]}"
						 style="width:500px; height:350px;">
					</c:if>
				
					<!-- 상세 사진 2개 이상 -->
					<c:if test="${vo.file_gaesu gt 1}">
						<div id="slide">
						<img id="prev" src="${pageContext.request.contextPath}/resources/img/left.png" alt="prev">
							<ul style="width:(500 * ${vo.file_gaesu})px; position:absolute; top:0; left:0; font-size:0;">
								<c:forEach var="list" items="${vo.gun_img_arr}">
									<li>
										<img src="${pageContext.request.contextPath}/resources/upload/${list}" id="gallery" width="500" height="350">
									</li>
								</c:forEach>
							</ul>
						<img id="daum" src="${pageContext.request.contextPath}/resources/img/right.png" alt="daum">
						</div>
					</c:if>
				</c:if>
			</td>
			<td width="20">
			</td>
			<td id="info">
				<p class="subtitle">
					<font color="#7540c7">♥</font> 매물정보
				</p>
				<table class="tables right">
					<tr>
						<th width="60" align="center">
							보증금 
						</th>
						<td width="200">
							<fmt:formatNumber value="${vo.bojung div 10000}" pattern="#,###.#"/>만 원
						</td>
						<th width="60" align="center">
							월세
						</th>
						<td width="200">
							<fmt:formatNumber value="${vo.weolse div 10000}" pattern="#,###.#"/>만 원
						</td>
					</tr>
					<tr>
						<th align="center">
							수수료
						</th>
						<td>
							<fmt:formatNumber value="${vo.susuryo div 10000}" pattern="#,###.#"/>만 원
						</td>
						<th align="center">
							건물명
						</th>
						<td>
							${vo.gun_name}
						</td>
					</tr>
					<tr>
						<th align="center">
							층
						</th>
						<td>
							<c:if test="${not empty vo.floor}">${vo.floor}층</c:if>
							<c:if test="${empty vo.floor}">-</c:if>
						</td>
						<th align="center">
							호
						</th>
						<td>
							<c:if test="${not empty vo.bang_num}">${vo.bang_num}호</c:if>
							<c:if test="${empty vo.bang_num}">-</c:if>
						</td>
					</tr>
					<tr>
						<th align="center">
							구조
						</th>
						<td>
							${vo.gujo}
						</td>
						<th align="center">
							주차
						</th>
						<td>
							${vo.gun_park}
						</td>
					</tr>
					<tr>
						<th align="center">
							주소
						</th>
						<td>
							${vo.addr}
						</td>
						<th align="center">
							면적
						</th>
						<td>
							<c:if test="${not empty vo.square}">${vo.square}m²</c:if>
							<c:if test="${empty vo.square}">-</c:if>
						</td>
					</tr>
				</table>
				
				<p class="subtitle" style="padding-top:10px;">
					<font color="#7540c7">♥</font> 옵션
				</p>
				<table class="tables right">
					<tr>
						<td colspan="4">
							<c:forEach var="n" begin="0" end="19" step="1">
								<c:if test="${vo.gun_op_arr[n] eq '에어컨'}">
									<img src="${pageContext.request.contextPath}/resources/img/option01_air_con.png">
								</c:if>
								<c:if test="${vo.gun_op_arr[n] eq '세탁기'}">
									<img src="${pageContext.request.contextPath}/resources/img/option02_washer.png">
								</c:if>
								<c:if test="${vo.gun_op_arr[n] eq '침대'}">
									<img src="${pageContext.request.contextPath}/resources/img/option03_bed.png">
								</c:if>
								<c:if test="${vo.gun_op_arr[n] eq '책상'}">
									<img src="${pageContext.request.contextPath}/resources/img/option04_desk.png">
								</c:if>
								<c:if test="${vo.gun_op_arr[n] eq '옷장'}">
									<img src="${pageContext.request.contextPath}/resources/img/option05_closet.png">
								</c:if>
								<c:if test="${vo.gun_op_arr[n] eq 'TV'}">
									<img src="${pageContext.request.contextPath}/resources/img/option06_TV.png">
								</c:if>
								<c:if test="${vo.gun_op_arr[n] eq '신발장'}">
									<img src="${pageContext.request.contextPath}/resources/img/option07_shoe_closet.png">
								</c:if>
								<c:if test="${vo.gun_op_arr[n] eq '냉장고'}">
									<img src="${pageContext.request.contextPath}/resources/img/option08_refrigerator.png">
								</c:if>
								<c:if test="${vo.gun_op_arr[n] eq '가스레인지'}">
									<img src="${pageContext.request.contextPath}/resources/img/option09_gas_stove.png">
								</c:if>
								<c:if test="${vo.gun_op_arr[n] eq '오븐'}">
									<img src="${pageContext.request.contextPath}/resources/img/option10_oven.png">
								</c:if>
								<c:if test="${vo.gun_op_arr[n] eq '인덕션'}">
									<img src="${pageContext.request.contextPath}/resources/img/option11_induction.png">
								</c:if>
								<c:if test="${vo.gun_op_arr[n] eq '전자레인지'}">
									<img src="${pageContext.request.contextPath}/resources/img/option12_microwave.png">
								</c:if>
								<c:if test="${vo.gun_op_arr[n] eq '식탁'}">
									<img src="${pageContext.request.contextPath}/resources/img/option13_table.png">
								</c:if>
								<c:if test="${vo.gun_op_arr[n] eq '싱크대'}">
									<img src="${pageContext.request.contextPath}/resources/img/option14_sink.png">
								</c:if>
								<c:if test="${vo.gun_op_arr[n] eq '비데'}">
									<img src="${pageContext.request.contextPath}/resources/img/option15_bidet.png">
								</c:if>
								<c:if test="${vo.gun_op_arr[n] eq '엘리베이터'}">
									<img src="${pageContext.request.contextPath}/resources/img/option16_elevator.png">
								</c:if>
								<c:if test="${vo.gun_op_arr[n] eq '도어락'}">
									<img src="${pageContext.request.contextPath}/resources/img/option17_door_lock.png">
								</c:if>
								<c:if test="${vo.gun_op_arr[n] eq 'CCTV'}">
									<img src="${pageContext.request.contextPath}/resources/img/option18_CCTV.png">
								</c:if>
								<c:if test="${vo.gun_op_arr[n] eq '무인택배함'}">
									<img src="${pageContext.request.contextPath}/resources/img/option19_delivery_box.png">
								</c:if>
								<c:if test="${vo.gun_op_arr[n] eq '인터폰'}">
									<img src="${pageContext.request.contextPath}/resources/img/option20_intercom.png">
								</c:if>
							</c:forEach>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	
	<p class="subtitle" style="padding-left:50px;">
		<font color="#7540c7">♥</font> 상세정보
	</p>
	<table class="tables content" align="center">
		<tr>
			<td>
				<c:if test="${not empty vo.content}"><pre class="btm">${vo.content}</pre></c:if>
				<c:if test="${empty vo.content}">등록된 내용이 없습니다.</c:if>
			</td>
		</tr>
	</table>
	
	<div align="center">
		<input type="button" class="detail_close" value="닫기" onclick="window.close();">
	</div>
</body>
</html>