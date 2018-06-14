<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<html>
<head>
<meta charset=UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


<style type="text/css">

/* body
{background-color: rgb(217, 217, 217)} */
div
{background-color: rgb(109, 124, 163);
padding: 10px;
border-style: double;}
</style>
</head>
<body>

<form action="/library/Insert/" method="post" >
<div class="form-group">
<h1>게시물 작성</h1>
제목 : <input type="text" name="title" id="title" style='width:200px'><br>
<label for="comment">내용 : </label>
<textarea class="form-control" cols=50; rows=10; name="contents" id="contents">게시물 내용을 작성하세요</textarea><br>
암호 : <input type=text name="pw" id="pw" style='width:160px'>
<input id='in' type='submit' class="btn btn-default"value='작성하기'>
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