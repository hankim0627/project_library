<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<html>
<head>
<meta charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
body
{background-color: rgb(217, 217, 217)}
</style>
<script src="/library/resources/jquery-3.2.1.min.js"></script>


<style type="text/css">
div
{background-color: pink;
padding: 10px;
border-style: double;}
</style>
</head>
<body>
<form action="/library/Insert/" method="post" >
<div>
<h1>게시물 작성</h1>
제목 : <input type="text" name="title" id="title"><br>
내용 : <br>
<textarea cols=50; rows=10; name="contents" id="contents">게시물 내용을 작성하세요</textarea><br>
암호<input type=text name="pw" id="pw" >
<input id='in' type='submit' value='작성하기'>
<br>
<br>
</div>
</form>
<script>
	  
	window.onunload = function () { 
	    window.opener.location.reload(); 
	       window.close()
	}
	
	
	
</script>
</body>
</html>