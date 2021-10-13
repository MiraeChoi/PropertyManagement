<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>코리아주택관리</title>
		
		<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/style2.css">
		<style>
			*{margin:0; padding:0;}
			body{width:1100px; margin:0 auto; padding:0;}
			.title{text-align:left; font-size:13pt; font-weight:bold; color:#767676; font-style:bold; margin:0; padding:0;}
			.subtitle{margin-top:30px; margin-bottom:5px; text-align:left; color:#7411cb;
					font:normal 900 normal 20px / normal "맑은 고딕"}
			#issue{position:relative;}
			.rank_issue{margin:6px 0; padding:0 10px; font-size:15px; text-align:left;}
			.rank_issue a{font-size:11px;}
			.rank_header{border-bottom: 1px solid #A4A4A4;}
			#issue div.section_rank{width:485px; height:248px; left:610px; top:0px; position:absolute;}
			.rank_body li p.txt{margin:17px 0; padding:0 10px;}
			.rank_body li p.txt a{font-size:13px;}
			.rank_body li p.txt span{font-size:13px;}
			.rank_body li p.txt span.count{position:absolute; right:20px;}
			.rank_body li p.txt .rank1_t{color:#7c27c7;}
			#gujido img.jido{width:700px; height:522px; margin:50px 300px 30px 220px;}
		</style>
		
		<script src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>
	</head>
	<body>
		<jsp:include page="../main/manage_menu.jsp" />
		
		<!-- 공지사항 -->
		<table width="600" height="300" align="left">
			<tr>
				<td>
					<table class="gongji_table" width="590">
					<caption class="subtitle">공지</caption>
						<tr>
							<td width="70" class="td_a">번호</td>
							<td width="5" class="td_b"><img src="${pageContext.request.contextPath}/resources/img/td_bg_01.gif"></td>
							
							<td width="400" class="td_b">제목</td>
							<td width="5" class="td_b"><img src="${pageContext.request.contextPath}/resources/img/td_bg_01.gif"></td>
							
							<td width="100" class="td_b">작성자</td>
							<td width="5" class="td_b"><img src="${pageContext.request.contextPath}/resources/img/td_bg_01.gif"></td>
							
							<td width="100" class="td_b">작성일</td>
							<td width="5" class="td_b"><img src="${pageContext.request.contextPath}/resources/img/td_bg_01.gif"></td>
							
							<td width="70" class="td_c">조회수</td>
						</tr>
						
						<c:forEach var="vo" items="${list}">
						<tr class="tr_a_1">
							<td align="center" class="td_a_1">${vo.idx}</td>
							<td class="td_b_1"><img src="${pageContext.request.contextPath}/resources/img/td_bg_02.gif"></td>
							<td class="td_b_1 left">
								<!-- 댓글 들여쓰기 작업 -->
								<c:forEach begin="1" end="${vo.depth}">
									&nbsp;
								</c:forEach>
							
								<!-- 댓글 기호 -->
								<c:if test="${vo.depth ne 0}">
									ㄴ
								</c:if>
							
								<c:if test="${vo.del_info ne -1}">
									<!-- 제목 -->
									<a href="m_view.do?idx=${vo.idx}&page=${empty param.page ? 1 : param.page}" class="num">${vo.subject}</a>
								</c:if>
							
								<!-- 삭제된 게시물은 클릭 불가 -->
								<c:if test="${ vo.del_info eq -1 }">
									<a href="#" style="color:#ccc">
										${vo.subject}
									</a>
								</c:if>
							</td>
								<td class="td_b_1"><img src="${pageContext.request.contextPath}/resources/img/td_bg_02.gif"></td>
								<td class="td_b_1" align="center">${vo.name}</td>
								<td class="td_b_1"><img src="${pageContext.request.contextPath}/resources/img/td_bg_02.gif"></td>
								<td class="td_b_1" align="center">${vo.regdate}</td>
								<td class="td_b_1"><img src="${pageContext.request.contextPath}/resources/img/td_bg_02.gif"></td>
								<td class="td_c_1" align="center">${vo.readhit}</td>
							</tr>
						</c:forEach>
						<!-- 게시판 리스트 끝 -->
						
						<c:if test="${empty list}">
							<tr>
								<td align="center" colspan="11" width="100%" height="185px"
									style="border:1px solid #ddd">
									등록된 글이 없습니다.
								</td>
							</tr>
						</c:if>
					</table>
				</td>
			</tr>
			
			<tr>
				<td height="8"></td>
			</tr>
			
			<tr>
				<td class="f11" align="center">
					${pageMenu}
				</td>
			</tr>
			<tr>
				<td>
					<img src="${ pageContext.request.contextPath }/resources/img/btn_reg.gif" onclick="location.href='m_insert_form.do?id=${id}'">
				</td>
			</tr>
		</table>
		<!-- 공지사항 -->
				
		<!-- 뉴스 -->
		<p class="subtitle news">　뉴스</p>
		
		<div id="issue">
			<div class="section_rank">
				<div class="rank_header">
					<h3 class="rank_issue">랭킹 이슈 5 | <a>조회수가 높은 이슈 랭킹</a></h3>
				</div>
				<div class="rank_body">
					<ol>
						<li class="rank1">
							<p class="txt">
								<a href="#" class="rank1_t"> 1. <strong>코로나19 이후 주택의 미래</strong></a>
								<!-- <span>관련기사 <strong>764</strong>건</span> -->
								<span class="count">조회수 982 | 2020-06-08</span>
							</p>
						</li>
						<li class="rank2">
							<p class="txt">
								<a href="#" class="rank2_t"> 2. <strong>뜨거운 서울 집값</strong></a>
								<!-- <span>관련기사 <strong>509</strong>건</span> -->
								<span class="count">조회수 743 | 2020-05-22</span>
						</li>
						<li class="rank3">
							<p class="txt">
								<a href="#" class="rank3_t"> 3. <strong>10년째 기다리는 지하철 개통</strong></a>
								<!-- <span>관련기사 <strong>396</strong>건</span> -->
								<span class="count">조회수 547 | 2020-04-30</span>
						</li>
						<li class="rank4">
							<p class="txt">
								<a href="#" class="rank4_t"> 4. <strong>2020 주거종합계획</strong></a>
								<!-- <span>관련기사 <strong>194</strong>건</span> -->
								<span class="count">조회수 325 | 2020-04-13</span>
						</li>
						<li class="rank5">
							<p class="txt">
								<a href="#" class="rank5_t"> 5. <strong>전남 보성 '귀농귀촌 공공주택'</strong></a>
								<!-- <span>관련기사 <strong>125</strong>건</span> -->
								<span class="count">조회수 127 | 2020-03-22</span>
							</p>
						</li>
					</ol>
				</div>
			</div>
		</div>
		<!-- 뉴스 -->
			
<!-- 지도 -->
      <div id="gujido">
      <img class="jido" src="${pageContext.request.contextPath}/resources/image/jido.PNG" usemap="#jido">
         <map name="jido" id="jido">
            <area class="sudaemoon" shape="rect" coords="238,217,309,243"
            href="map.do?location=서대문구">
            <area class="mapo" shape="rect" coords="214,261,270,289"
            href="map.do?location=마포구">
            <area class="eunpyeong" shape="rect" coords="243,146,297,173"
            href="map.do?location=은평구">
            <area class="jongro" shape="rect" coords="324,212,377,237"
            href="map.do?location=종로구">
            <area class="junggu" shape="rect" coords="345,254,383,277"
            href="map.do?location=중구">
            <area class="yongsan" shape="rect" coords="320,302,374,327"
            href="map.do?location=용산구">
            <area class="sungdong" shape="rect" coords="420,272,471,295"
            href="map.do?location=성동구">
            <area class="dongdaemoon" shape="rect" coords="428,216,496,240"
            href="map.do?location=동대문구">
            <area class="seongbook" shape="rect" coords="390,180,441,204"
            href="map.do?location=성북구">
            <area class="gangbook" shape="rect" coords="379,107,432,131"
            href="map.do?location=강북구">
            <area class="dobong" shape="rect" coords="406,61,464,87"
            href="map.do?location=도봉구">
            <area class="nowon" shape="rect" coords="481,115,537,141"
            href="map.do?location=노원구">
            <area class="jungrang" shape="rect" coords="503,185,558,210"
            href="map.do?location=중랑구">
            <area class="gwangjin" shape="rect" coords="494,278,545,302"
            href="map.do?location=광진구">
            <area class="gangdong" shape="rect" coords="580,271,636,296"
            href="map.do?location=강동구">
            <area class="songpa" shape="rect" coords="524,347,575,373"
            href="map.do?location=송파구">
            <area class="gangnam" shape="rect" coords="436,375,489,399"
            href="map.do?location=강남구">
            <area class="seocho" shape="rect" coords="364,394,417,418"
            href="map.do?location=서초구">
            <area class="dongjak" shape="rect" coords="264,356,317,382"
            href="map.do?location=동작구">
            <area class="gwanak" shape="rect" coords="262,427,315,453"
            href="map.do?location=관악구">
            <area class="gemchun" shape="rect" coords="179,416,229,438"
            href="map.do?location=금천구">
            <area class="youngdengpo" shape="rect" coords="190,331,258,355"
            href="map.do?location=영등포구">
            <area class="guro" shape="rect" coords="101,370,153,394"
            href="map.do?location=구로구">
            <area class="yangcheon" shape="rect" coords="115,319,170,343"
            href="map.do?location=양천구">
            <area class="gangseo" shape="rect" coords="80,245,135,269"
            href="map.do?location=강서구">
         </map>
      </div>
	</body>
	
	<footer>
		<jsp:include page="../common/real_footer.jsp" />
	</footer>
</html>