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
      #body p.maemul{ font-size:40px; margin:70px 0 0 0; font-weight:lighter;}
      #body p.maemul span{color:#9253EB;}
      #body div.search-box{ padding:10px; margin:50px 550px 50px 550px; width:430px;
      transform:translate(-50%, -50%); height: 30px;
      border:1px solid #ECADFF; }
      .search-txt{ padding:0; width:400px; border:none; outline: none;
      float:left; font-size:1rem; line-height:30px;}
      .search-btn{ text-decoration:none; display:flex; justify-content:center;
      align-items:center; width:30px; height:30px; border-radius:30px; color:#DA9BFF}
      #body p.tt{ width:320px; float:left; font-size:20px; color: #767676;
               margin:30px 0 10px 49px;}
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
   </script>
</head>

<body>
	<jsp:include page="../main/not_login_menu.jsp" />
      
      <div id="body">
         <p class="maemul" align="center"><span>어떤 동네, 어떤 방을</span><br> 찾으시나요?</p>
         <div class="search-box">
         <form name="f" action="mng_searchRegion.do">
            <input type="text" class="search-txt" name="searchRegion" placeholder="지역을 검색하세요.">
            <a href="javascript:document.f.submit();" class="search-btn" >
               <i class="fas fa-search"></i>
            </a>
         </form>
      </div>
      <p class="tt">전체 매물 목록</p>
      <table align="center">
         <tr class="top">
            <td align="center">사진</td>
            <td colspan="3" align="center">건물명세서</td>
         </tr>
         
         <c:forEach var="list" items="${list}">
         <tr>
            <td rowspan="7" align="center" >
                  <c:if test="${list.gun_img_s eq 'no_file'}">
                     <a href="" onclick="detail(${list.idx});">
                        <img src="${pageContext.request.contextPath}/resources/img/no_image.png" width="450" height="300">
                     </a>
                  </c:if>
                  <c:if test="${list.gun_img_s ne 'no_file'}">
                     <a href="" onclick="detail(${list.idx});">
                        <img src="${pageContext.request.contextPath}/resources/img/${list.gun_img_s}" width="450" height="300">
                     </a>
                  </c:if>
            </td>
            <td>건물명</td>
            <td colspan="2" align="center">
            	<a href="" onclick="detail(${list.idx});"><b><font color="#7308cd">${list.gun_name}</font></b></a>
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