<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>코리아주택관리</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<style>
		body{background:url(resources/img/background.jpg) no-repeat center bottom; background-size:1100px;
			 min-height:1050px;}
		.center_top h2{font-size:30px; text-align:center;}
		a{text-decoration:none;}
		table{border:20px solid #ddd; border-collapse:collapse; background:#ddd;
			  font-size:11pt; width:1000px; margin:0px auto;}
		caption{text-align:right; font-size:11pt; color:#666; margin-bottom:5px;}
		th{text-align:left;}
		th, td{padding:10px;}
		input[type="text"]{border:1px solid #999; border-raduis:0; outline-style:none; padding:.8em .5em;}
		input[type="file"]{font-size:11pt;}
		.button_upd{font-size:12pt; font-weight:bold; background:#7c27c7; border:none; color:white;
					width:120px; height:60px; outline:none; text-align:center; margin:20px;}
		.button_cancel{font-size:12pt; font-weight:bold; background:#7c27c7; border:none; color:white;
					width:120px; height:60px; outline:none; text-align:center; margin:20px;}
		textarea{border:1px solid #999; border-raduis:0; outline-style:none; padding:.8em .5em;}
		div{margin:auto; padding:0;}
		#preview{background-image:url("${pageContext.request.contextPath}/resources/img/preview.png") no-repeat;
				 width:300px; height:150px; text-align:left;}
	</style>
	
	<script src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script>
		window.onload = function() {
			modify_list();
		};
		
		function modify_list() {
			var url = "gm_modify_info.do";
			//var param = "idx?=0";
			
			sendRequest(url, null, resultFn, "POST");
		}
		
		function resultFn() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				var data = xhr.responseText;
				//var json = eval(data);
				var json = JSON.parse(data);
				
				var gun_park = json['gun_park'];
				var gun_op_arr = json['gun_op_arr'];
				
				$("input:radio[name='gun_park']").each(function(){
					if(this.value == gun_park){
						$(this).attr("checked", true);
					}
				});
				
				$("input:checkbox[name='gun_option']").each(function(){
					for(var i = 0; i < gun_op_arr.length; i++) {
						if(this.value == gun_op_arr[i]){
							$(this).attr("checked", true);
						}
					}
				});
			}
		}
		
		$(function() {
            //모든 datepicker에 대한 공통 옵션 설정
            $.datepicker.setDefaults({
                dateFormat: 'yy-mm-dd' //Input Display Format 변경
                ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
                ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
                ,changeYear: true //콤보박스에서 년 선택 가능
                ,changeMonth: true //콤보박스에서 월 선택 가능                
                ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
                ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
                ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
                ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
                ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
                ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
                ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
                ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
                ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트                 
            });
 
            //input을 datepicker로 선언
            $("#datepicker_begin").datepicker();                    
            $("#datepicker_end").datepicker();
        });
		
		function update(f) {
			//유효성 체크 추가
			
			f.action = 'manage_gm_update.do';
			f.submit();
		}
	</script>
</head>
<body>
<jsp:include page="../main/manage_menu.jsp" />
		
	<div class="center_top">
		<h2>건물 수정</h2>
	</div>
	
	<form method="POST" enctype="multipart/form-data" name="f">
		<input type="hidden" name="idx" value="${vo.idx}">
	
		<table border="1" align="center">
		<caption>*은 필수 입력입니다.</caption>
			<tr>
				<th>건물명*</th>
				<td><input type="text" name="gun_name" value="${vo.gun_name}" size="50"></td>
			</tr>
			<tr>
				<th>건물 층수</th>
				<td><input type="text" name="floor" value="${vo.floor}" size="50" placeholder="(예 : 5)"> 층</td>
			</tr>
			<tr>
				<th>건물 호/실</th>
				<td><input type="text" name="bang_num" value="${vo.bang_num}" size="50" placeholder="(예 : 303)"> 호/실</td>
			</tr>
			<tr>
				<th>건물 구조*</th>
				<td><input type="text" name="gujo" value="${vo.gujo}" size="50" placeholder="(예 : 투룸)"></td>
			</tr>
			<tr>
				<th>임대인의 idx*</th>
				<td><input type="text" name="ref" value="${vo.ref}" size="50"></td>
			</tr>
			<tr>
				<th>건물의 경도 위도</th>
				<td><input type="text" name="addr_num" size="50" value="${vo.addr_num}" placeholder="(예 : 37.572079, 126.903811)"></td>
			</tr>
			<tr>
				<th>메인 이미지</th>
				<td>
					<input type="file" id='photo_s' name="photo_s"> <%-- ${vo.gun_img_s} --%>
					<p id='preview'>
						<c:if test="${vo.gun_img_s ne 'no_file'}">
							<img src="${pageContext.request.contextPath}/resources/upload/${vo.gun_img_s}" width="200" height="150">
						</c:if>
					</p>
				</td>
			</tr>
			<tr>
				<th>상세정보 이미지</th>
				<td><input multiple="multiple" type="file" name="photo_l"></td>
			</tr>
			<tr>
				<th>건물 주소*</th>
				<td><input type="text" name="addr" value="${vo.addr}" size="50" placeholder="OO시 OO구 OO동 + 상세정보"></td>
			</tr>
			<tr>
				<th>주차*</th>
				<td>
					<input type="radio" name="gun_park" value="가능" onclick="oneRadio(this)">가능
					<input type="radio" name="gun_park" value="불가능" onclick="oneRadio(this)">불가능
				</td>
			</tr>
			<tr>
				<th>건물 옵션</th>
				<td>
					<label><input type="checkbox" id="option" name="gun_option" value="에어컨">에어컨</label>
					<label><input type="checkbox" id="option" name="gun_option" value="세탁기">세탁기</label>
					<label><input type="checkbox" id="option" name="gun_option" value="침대">침대</label>
					<label><input type="checkbox" id="option" name="gun_option" value="책상">책상</label>
					<label><input type="checkbox" id="option" name="gun_option" value="옷장">옷장</label>
					<label><input type="checkbox" id="option" name="gun_option" value="TV">TV</label>
					<label><input type="checkbox" id="option" name="gun_option" value="신발장">신발장</label>
					<label><input type="checkbox" id="option" name="gun_option" value="냉장고">냉장고</label>
					<label><input type="checkbox" id="option" name="gun_option" value="가스레인지">가스레인지</label>
					<label><input type="checkbox" id="option" name="gun_option" value="오븐">오븐</label>
					<br>
					<label><input type="checkbox" id="option" name="gun_option" value="인덕션">인덕션</label>
					<label><input type="checkbox" id="option" name="gun_option" value="전자레인지">전자레인지</label>
					<label><input type="checkbox" id="option" name="gun_option" value="식탁">식탁</label>
					<label><input type="checkbox" id="option" name="gun_option" value="싱크대">싱크대</label>
					<label><input type="checkbox" id="option" name="gun_option" value="비데">비데</label>
					<label><input type="checkbox" id="option" name="gun_option" value="엘리베이터">엘리베이터</label>
					<label><input type="checkbox" id="option" name="gun_option" value="도어락">도어락</label>
					<label><input type="checkbox" id="option" name="gun_option" value="CCTV">CCTV</label>
					<label><input type="checkbox" id="option" name="gun_option" value="무인택배함">무인택배함</label>
					<label><input type="checkbox" id="option" name="gun_option" value="인터폰">인터폰</label>
				</td>
			</tr>
			<tr>
				<th>건물 상세정보</th>
				<td><textarea name="content" rows="15" cols="95">${vo.content}</textarea></td>
			</tr>
			<tr>
				<th>면적</th>
				<td><input type="text" name="square" value="${vo.square}" size="50" placeholder="실면적을 기입해 주세요."> m²</td>
			</tr>
			<tr>
				<th>보증금*</th>
				<td><input type="text" id="bojung" name="bojung" value="${vo.bojung}" size="50" onkeyup="inputNumberFormat(this)"> 원</td>
			</tr>
			<tr>
				<th>월세*</th>
				<td><input type="text" id="weolse" name="weolse" value="${vo.weolse}" size="50" onkeyup="inputNumberFormat(this)"> 원</td>
			</tr>
			<tr>
				<th>수수료*</th>
				<td><input type="text" id="susuryo" name="susuryo" value="${vo.susuryo}" size="50" onkeyup="inputNumberFormat(this)"> 원</td>
			</tr>
			<tr>
			<tr>
				<th>세입자 이름</th>
				<td><input type="text" name="seipja_name" value="${vo.seipja_name}" size="50" placeholder="세입자가 없는 경우, 이하 항목 모두 생략 가능"></td>
			</tr>
			<tr>
				<th>세입자 전화번호</th>
				<td><input type="text" name="seipja_tel" value="${vo.seipja_tel}" size="50"></td>
			</tr>
			<tr>
				<th>세입자 계약 기간</th>
				<td>
					계약일 <input type="text" id="datepicker_begin" name="seipja_date_begin" value="${vo.seipja_date_begin}"> ~ 
					만료일 <input type="text" id="datepicker_end" name="seipja_date_end" value="${vo.seipja_date_end}">
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="button" class="button_upd" value="수정" onclick="update(this.form);">
					<input type="button" class="button_cancel" value="취소" onclick="location.href='total_gunmul_manage.do'">
				</td>
			</tr>
		</table>
	</form>
</body>

<!-- 이미지 미리보기 -->
<script>
	var photo_s = document.querySelector('#photo_s');
	var preview = document.querySelector('#preview');
	
    photo_s.addEventListener('change', function(e) {
    	get_file = e.target.files;
        image = document.createElement('img');
 
        //FileReader 객체 생성
        var reader = new FileReader();
        //reader 시작 시 함수 구현
        reader.onload = (function(aImg) {
			console.log(1);
 
			return function (e) {
				console.log(3);
				//base64 인코딩 된 스트링 데이터
				aImg.src = e.target.result
				aImg.width = "200"
				aImg.height = "150"
				preview.style = "background:#ddd";
			}
		})(image)
 
        if(get_file){
            //get_file[0]을 읽으면 loadend이벤트가 트리거되고 onload에 설정했던 return으로 넘어간다.
            //이와 함께 base64 인코딩된 스트링 데이터가 result 속성에 담긴다.
            reader.readAsDataURL(get_file[0]);
            console.log(2);
		}
        
        preview.innerHTML = '';
		preview.appendChild(image);
    })
</script>

</html>