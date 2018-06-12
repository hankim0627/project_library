<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" 
href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css">

</head>

<body>
<h3>글쓰기</h3>

<form action="/library/writesuccess" method="POST">
<table>
<tr>
<td>글 제목</td>
<td><input type=text name="st_title"></td>
</tr>
<tr>
<td>작성자</td>
<td><input type=text name="st_m_id" value="${sessionScope.member_id}"></td>
</tr>
<tr>
<td>글 비밀번호</td>
<td><input type=text name="st_pw"></td>
</tr>
<tr>
<td>내용</td>
<td><textarea rows="8" cols="40" name="st_context"></textarea></td>
</tr>
<tr>
<td colspan="2" align="right"><input type="submit" value="글작성완료" id="ok"></td>
</tr>
</table>
</form>

</body>
</html>