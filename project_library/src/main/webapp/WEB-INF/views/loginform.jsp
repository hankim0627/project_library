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
	color: #d0858a;
	font-family: times; /* 여러개 중에 앞에서부터 있는 거 사용 */
	font-size: 40px;
	font-weight: bold;
	text-align: center;
}
</style>

</head>

<body>
	<h1>로그인 페이지</h1>
	<hr width=100% color=#d0858a size=5>

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

	<br> ${error }

</body>
</html>