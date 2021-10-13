<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
   <head>
      <style>
         div{font-weight:bold;}
      </style>
      <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sweetalert2.css" /><!-- 알럿창 스타일 -->
      <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/sweetalert2.js"></script> <!-- 알럿창 플러그인 -->
      <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/es6-promise.js"></script> <!-- 알럿창 _IE작동 -->
      <script>
         function send(f) {
            var id = f.id.value.trim();
            var pwd = f.pwd.value.trim();
            var name = f.name.value.trim();
            
            if(id==''){
               return;
            }
            if(pwd==''){
               return;
            }
            if(name==''){
               return;
            }
            
            swal({
                title: "진짜 수정하시겠습니까?",
                text: "수정으로 인한 문제 발생 시 책임지지 않습니다.",
                type: "question",
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: '네, 괜찮습니다.',
                cancelButtonText: '취소'
              }).then((result)=>{
                 if(result) {
                	 f.action = 'manage_modify.do';
                	 f.method='post';
                     f.submit();
                 }
              });
         }
         function move_click(){
            swal({
              title: "진짜 이동하시겠습니까?",
              text: "작성한 모든 기록이 날아갈 수 있습니다!",
              type: "warning",
              showCancelButton: true,
              confirmButtonColor: '#3085d6',
              cancelButtonColor: '#d33',
              confirmButtonText: '네, 괜찮습니다.',
              cancelButtonText: '취소'
            }).then((result)=>{
               if(result) {
                  location.href = 'budongsanmain.do';
               }
            });
         }
         function modify_click(){
            swal({
                   title : "수정방법",
                   text : "수정하고자 하는 항목만 수정하세요!<br>아이디는 수정이 불가능합니다.",
                   type : "info"
               });
         }
      </script>
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <%@ include file="../common/header.jsp" %>
   </head>
   <body>
      <div class="limiter">
      <div class="container-login100" style="background-image: url('${pageContext.request.contextPath}/resources/images/bg-01.jpg');">
         <div class="wrap-login100">
            <form class="login100-form validate-form">
               <span class="login100-form-logo">
                  <i class="zmdi zmdi-landscape"></i>
               </span>
               <div class="text-center p-t-90">
                  <a class="txt1" href="#" onclick="modify_click();">
                     ※수정 방법※
                  </a>
               </div>
               <span class="login100-form-title p-b-34 p-t-27">
                  회원정보수정
               </span>
               <!-- 아이디 입력 -->
               <div class="wrap-input100 validate-input" data-validate = "아이디를 입력하세요">
                  <input class="input100" type="text" name="id" placeholder="Id" value="${ vo.id }" readOnly>
                  <span class="focus-input100" data-placeholder="&#xf191;"></span>
               </div>
               <!-- 비밀번호 입력 -->
               <div class="wrap-input100 validate-input" data-validate = "비밀번호를 입력하세요">
                  <input class="input100" type="password" name="pwd" placeholder="Password" value="${ vo.pwd }">
                  <span class="focus-input100" data-placeholder="&#xf191;"></span>
               </div>
               <!-- 이름 입력 -->
               <div class="wrap-input100 validate-input" data-validate = "이름을 입력하세요">
                  <input class="input100" type="text" name="name" placeholder="Username" value="${ vo.name }">
                  <span class="focus-input100" data-placeholder="&#xf207;"></span>
               </div>
               <div class="container-login100-form-btn">
                 <input type="button" class="login100-form-btn" value="수정" onclick="send(this.form);" style="color:white">
               </div>
               <div class="text-center p-t-90">
                  <a class="txt1" href="#" onclick="move_click();">
                     	홈으로
                  </a>
               </div>
            </form>
         </div>
      </div>
   </div>
   <div id="dropDownSelect1"></div>
   <%@ include file="../common/footer.jsp" %>
   </body>
</html>