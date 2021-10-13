<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<style>
		*{margin:0; padding:0;}
		body{width:1100px;}
		a{text-decoration:none; color:#767676;}
		/* div{margin:auto; margin-top:20px; width:1060px; padding:0;} */
		.center_top h2{font-size:30px; text-align:center; padding-top:43px;}
		.center_top h2:after {
	        content: "";
	        display: block;
	        width: 60px;
	        border-bottom: 2px solid #D5D5D5;
	        margin: 30px auto 30px;
	    }
	    .center_top p{width:500px; margin:10px 28% 30px; font-size:13px;}
		table{border-collapse:collapse;
			  font-size:17px; width:900px; margin:10px auto;}
		.gun_reg_btn{font-size:12pt; font-weight:bold; background:#7c27c7; border:none; color:white;
					width:120px; height:60px; outline:none; text-align:center;}
		.gun_name_effect{text-align:left; padding-left:32px; padding-top:20px; font-size:20px;}
		/* .underline{border-bottom:1px solid #6A84B7;} */
		td{padding:15px 20px;}
		.gubun{margin:10px 0; width:320px;}
		
		.i_icon{width:15px; height:15px;}
		.m_btn{margin-top:10px; border:1px solid purple; position:relative; padding:5px;
				 background-color:white; color:purple; font-weight:bold;
				 border-top-right-radius:5px; border-bottom-right-radius:5px;
				 border-top-left-radius:5px; border-bottom-left-radius:5px;}
		.m_reg{background-color:#ddd;}
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
		
		function reg(idx) {
			function myFunction() {
				document.f.submit();
			}
			
			if(!confirm("공인중개사 페이지에 등록하시겠습니까?")) {
				return;
			}
			
			var url = "manage_gongin_reg.do";
			var param = "idx=" + idx;
			
			sendRequest(url, param, resultFn_reg, "POST");
		}
		
		function resultFn_reg() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				if(!confirm("등록되었습니다.\n등록된 매물 목록에서 확인하시겠습니까?")){
					return;
				}
				location.href = "manage_gongin_login_reg_list.do";
			}
		}
		
		function update(f, idx) {
			f.idx.value = idx;
			
			f.action = 'manager_gm_modify_form.do';
			f.method = "POST";
			f.submit();
		}
		
		function del(idx) {
			if(!confirm("정말 삭제하시겠습니까?")) {
				return;
			}
			
			var url = "manage_gm_delete.do";
			var param = "idx=" + idx;
			
			sendRequest(url, param, resultFn_del, "POST");
		}
		
		function resultFn_del() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				var data = xhr.responseText;
				
				if(data == 'no') {
					alert("삭제 실패");
					return;
				}
				
				/* var ref = document.f.ref.value; */
				
				alert("삭제되었습니다.");
				location.href = "total_gunmul_manage.do";
			}
		}
	</script>
</head>
<body>
<jsp:include page="../main/manage_menu.jsp" />
	
	<div class="center_top">
		<h2>건물 관리</h2>
		<p align="center">건물을 등록하고 건물 정보를 수정하거나 삭제할 수 있습니다.</p>
	</div>
	
	<form name="f">
	<input type="hidden" name="idx" value="${vo.idx}">
	<input type="hidden" name="gun_name" value="${vo.gun_name}">
	<input type="hidden" name="ref" value="${vo.ref}">

	<div align="center">
	<input type="button" class="gun_reg_btn" value="새 건물 추가" onclick="location.href='manage_gm_insert_form.do'">
	</div>
	
		<table align="center">
			<c:forEach var="vo" items="${list}">
				<tr>
					<th class="gun_name_effect"><font color="#7c27c7" size="3px">No. ${vo.idx}</font>　${vo.gun_name}</th>
				</tr>
				<tr class="underline">
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
						
						<c:if test="${not empty vo.seipja_name and not empty vo.seipja_tel and not empty vo.seipja_date_begin and not empty vo.seipja_date_end}">
							<img class="i_icon" src="${pageContext.request.contextPath}/resources/img/saram.jpg">　${vo.seipja_name}<br>
							<img class="i_icon" src="${pageContext.request.contextPath}/resources/img/phone.jpg">　${vo.seipja_tel}<br>
							<img class="i_icon" src="${pageContext.request.contextPath}/resources/img/calender.jpg">　${vo.seipja_date_begin} ~ ${vo.seipja_date_end}<br>
						</c:if>
						<c:if test="${empty vo.seipja_name}">
							즉시 입주 가능<br>
						</c:if>
						
						<c:if test="${vo.reg_gyeyak_info eq 1}">
							<input type="button" class="m_btn m_reg" value="등록됨" disabled="disabled">
						</c:if>
						<c:if test="${vo.reg_gyeyak_info ne 1}">
							<input type="button" class="m_btn" value="등록" onclick="reg(${vo.idx});">
						</c:if>
						<input type="button" class="m_btn" value="수정" onclick="update(this.form, ${vo.idx});">
						<input type="button" class="m_btn" value="삭제" onclick="del(${vo.idx}, ${vo.ref});">
					</td>
				</tr>
			</c:forEach>
		</table>
	</form>
</body>

	<footer>
		<jsp:include page="../common/real_footer.jsp" />
	</footer>
</body>
</html>