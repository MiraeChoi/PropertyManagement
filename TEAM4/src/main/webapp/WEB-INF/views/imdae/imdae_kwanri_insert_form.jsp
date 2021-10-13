<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="check_login_i.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>코리아주택관리</title>
    
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <style>
    	.center_top{margin:auto; padding:40px 0 20px;}
		.center_top h2{font-size:30px; text-align:center;}
		a{text-decoration:none;}
		table{border:20px solid #ddd; border-collapse:collapse; background:#ddd;
			  font-size:11pt; width:1000px; margin:0px auto;}
		caption{text-align:right; font-size:11pt; color:#666; margin-bottom:5px;}
		th{text-align:left;}
		th, td{padding:10px;}
		input[type="text"]{border:1px solid #999; border-raduis:0; outline-style:none; padding:.8em .5em;}
		input[type="file"]{font-size:11pt;}
		.button_reg{font-size:12pt; font-weight:bold; background:#7c27c7; border:none; color:white;
					width:120px; height:60px; outline:none; text-align:center; margin:20px;}
		.button_cancel{font-size:12pt; font-weight:bold; background:#7c27c7; border:none; color:white;
					width:120px; height:60px; outline:none; text-align:center; margin:20px;}
		textarea{border:1px solid #999; border-raduis:0; outline-style:none; padding:.8em .5em;}
		#preview{background-image:url("${pageContext.request.contextPath}/resources/img/preview.png") no-repeat;
				 width:300px; height:150px; text-align:left;}
	</style>
	
	<script>
		//경도 위도 새 창 열기
		function detail() {
			//팝업창 중앙 정렬
			var popW = 1200;
			var popH = 800;
			var popupX = (screen.availWidth - popW) / 2;
			var popupY = (screen.availHeight - popH) / 2;
			window.open("gm_view.do?idx=" + idx, "코리아주택관리", "width=" + popW + ",height=" + popH + ",left=" + popupX + ",top=" + popupY);
			
			location.href = "http://www.dawuljuso.com/";
		}
		
		//보증금, 월세, 수수료에 세 자리 콤마
		function inputNumberFormat(obj) {
			obj.value = comma(uncomma(obj.value));
		}
	
		function comma(str) {
			str = String(str);
			return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
		}
	
		function uncomma(str) {
			str = String(str);
			return str.replace(/[^\d]+/g, '');
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
		
		function send(f) {
			var gun_name = f.gun_name.value.trim();
			var floor = f.floor.value.trim();
			var gujo = f.gujo.value.trim();
			var addr = f.addr.value.trim();
			var gun_park = f.gun_park.value;
			
			var content = f.content.value.trim();
			var square = f.square.value.trim();
			
			//DB로 보내기 전에 보증금, 월세, 수수료 콤마 없애기
			var bojung = parseInt(f.bojung.value.trim().replace(/,/g,""));
			var weolse = parseInt(f.weolse.value.trim().replace(/,/g,""));
			var susuryo = parseInt(f.susuryo.value.trim().replace(/,/g,""));
			
			f.bojung.value = bojung;
			f.weolse.value = weolse;
			f.susuryo.value = susuryo;
			
			//숫자판별 정규식
			var num_pattern = /^[0-9]+$/;
			
			//필수 입력 사항 체크(건물명)
			if(gun_name == '') {
				alert("건물명은 필수 입력사항입니다.");
				f.gun_name.focus();
				return;
			}
			
			//필수 입력 사항 체크(건물 구조(ex:투룸))
			if(gujo == '') {
				alert("건물 구조는 필수 입력사항입니다.");
				f.gujo.focus();
				return;
			}
			
			//필수 입력 사항 체크(주차)
			if(gun_park != '가능' && gun_park != '불가능') {
				alert("주차는 필수 체크사항입니다.");
				f.gun_park.focus();
				return;
			}
			
			//필수 입력은 아니지만 숫자만 입력해야 하는 사항 체크(면적)
			if(!num_pattern.test(square) && square != '') {
				alert("면적은 숫자만 입력 가능합니다.");
				f.square.focus();
				return;
			}
			
			//필수 입력 & 숫자만 입력해야 하는 사항 체크(보증금)
			if(bojung == '') {
				alert("보증금은 필수 입력사항입니다.");
				f.bojung.focus();
				return;
			}
			if(!num_pattern.test(bojung)) {
				alert("보증금은 숫자만 입력 가능합니다.");
				f.bojung.focus();
				return;
			}
			
			//필수 입력 & 숫자만 입력해야 하는 사항 체크(월세)
			if(weolse == '') {
				alert("월세는 필수 입력사항입니다.");
				f.weolse.focus();
				return;
			}
			if(!num_pattern.test(weolse)) {
				alert("월세는 숫자만 입력 가능합니다.");
				f.weolse.focus();
				return;
			}
			
			//필수 입력 & 숫자만 입력해야 하는 사항 체크(수수료)
			if(susuryo == '') {
				alert("수수료는 필수 입력사항입니다.");
				f.susuryo.focus();
				return;
			}
			if(!num_pattern.test(susuryo)) {
				alert("수수료는 숫자만 입력 가능합니다.");
				f.susuryo.focus();
				return;
			}
			
			f.action = "gm_insert.do";
			f.submit();
		}
	</script>
</head>

<body>
	<jsp:include page="../main/imdae_menu.jsp" />
	
	<div class="center_top">
		<h2>새 건물 등록</h2>
	</div>
	
	<form method="POST" enctype="multipart/form-data" name="f">
		<input type="hidden" name="ref" value="${imdaein_vo.idx}">
		
		<table align="center">
		<caption>*은 필수 입력입니다.</caption>
			<tr>
				<th>건물명*</th>
				<td><input type="text" name="gun_name" size="50"></td>
			</tr>
			<tr>
				<th>건물 층수</th>
				<td><input type="text" name="floor" size="50" placeholder="(예 : 5)"> 층</td>
			</tr>
			<tr>
				<th>건물 호/실</th>
				<td><input type="text" name="bang_num" size="50" placeholder="(예 : 303)"> 호/실</td>
			</tr>
			<tr>
				<th>건물 구조*</th>
				<td><input type="text" name="gujo" size="50" placeholder="(예 : 투룸)"></td>
			</tr>
			<tr>
				<th>건물의 경도ㆍ위도</th>
				<td>
					<input type="text" name="addr_num" size="50" placeholder="(예 : 37.572079, 126.903811)">
					<a href="javascript:void(window.open('http://www.dawuljuso.com/', '코리아주택관리','width=1200, height=800'))">경도ㆍ위도 변환</a>
				</td>	
			</tr>
			<tr>
				<th>메인 이미지</th>
				<td>
					<input type='file' id='photo_s' name='photo_s'>
					<p id='preview'></p>
				</td>
			</tr>
			<tr>
				<th>상세정보 이미지</th>
				<td><input multiple="multiple" type="file" name="photo_l"></td>
			</tr>
			<tr>
				<th>건물 주소*</th>
				<td><input type="text" name="addr" size="50" placeholder="OO시 OO구 OO동 + 상세정보"></td>
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
					<label><input type="checkbox" id="option" name="gun_option" value="인덕션">인덕션</label>
					<br>
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
				<td><textarea name="content" rows="15" cols="95"></textarea></td>
			</tr>
			<tr>
				<th>면적</th>
				<td><input type="text" name="square" size="50" placeholder="실면적을 기입해 주세요."> m²</td>
			</tr>
			<tr>
				<th>보증금*</th>
				<td><input type="text" id="bojung" name="bojung" size="50" onkeyup="inputNumberFormat(this)"> 원</td>
			</tr>
			<tr>
				<th>월세*</th>
				<td><input type="text" id="weolse" name="weolse" size="50" onkeyup="inputNumberFormat(this)"> 원</td>
			</tr>
			<tr>
				<th>수수료*</th>
				<td><input type="text" id="susuryo" name="susuryo" size="50" onkeyup="inputNumberFormat(this)"> 원</td>
			</tr>
			<tr>
				<th>세입자 이름</th>
				<td><input type="text" name="seipja_name" size="50" placeholder="세입자가 없는 경우, 이하 항목 모두 생략 가능"></td>
			</tr>
			<tr>
				<th>세입자 전화번호</th>
				<td><input type="text" name="seipja_tel" size="50" placeholder="010-0000-0000"></td>
			</tr>
			<tr>
				<th>세입자 계약 기간</th>
				<td>
					계약일 <input type="text" id="datepicker_begin" name="seipja_date_begin"> ~ 
					만료일 <input type="text" id="datepicker_end" name="seipja_date_end">
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="button" class="button_reg" value="등록" onclick="send(this.form);">
					<input type="button" class="button_cancel" value="취소" onclick="location.href='my_gmlist.do'">
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
    	var get_file = e.target.files;
        image = document.createElement('img');
 
        /* FileReader 객체 생성 */
        var reader = new FileReader();
        /* reader 시작 시 함수 구현 */
        reader.onload = (function(aImg) {
			console.log(1);
 
			return function (e) {
				console.log(3);
				/* base64 인코딩 된 스트링 데이터 */
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