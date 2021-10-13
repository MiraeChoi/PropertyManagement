<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${empty sessionScope.gongin_vo}">
	<script>
		alert("로그인 후 이용 가능합니다.");
		location.href = "login_select.do";
	</script>
</c:if>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>코리아주택관리</title>
</head>
<body>

</body>
</html>