<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8">
<title>Insert title here</title>
<style>
h1 {
	color:  rgb(109, 124, 163);
	font-family: times; /* 여러개 중에 앞에서부터 있는 거 사용 */
	font-size: 40px;
	font-weight: bold;
	text-align: center;
}
body{background-color: rgb(217, 217, 217)}
p {
	color:  red;
	text-align: center;
}

</style>
</head>

<body>
	<h1>로그인 페이지</h1>
	<hr width=100% color=#6D7CA3 size=5>

	<br>



	<form action="/library/login" method="post">
		<table style="text-align: center; margin: auto;">
			<tr>
				<th>아이디</th>
				<td><input type="text" name="id"></td>
				<td rowspan="2"><input type="submit" value="로그인" style="width: 60px; height: 50px;"></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="pw"></td>
			</tr>
		</table>
	</form>
	
	<p><input type="button" onclick="location.href='/library/new'" value="회원가입"></p>
	<p><input type="button" onclick="location.href='/library/librarylist'" value="도서관 선택하기"></p>
	<p> ${error } </p>

</body>
</html>