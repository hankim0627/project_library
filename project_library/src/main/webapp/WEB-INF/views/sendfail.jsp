<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8">
<title>Insert title here</title>
<script src="/library/resources/jquery-3.2.1.min.js"></script>
<script>
$(document).ready(function(){
	alert("이미 신청된 거래입니다");
	$(location).attr("href","/library/store");
})
</script>
</head>
<body>

</body>
</html>