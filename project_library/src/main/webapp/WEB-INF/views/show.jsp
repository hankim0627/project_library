<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8">
<title>Insert title here</title>
<style>
span{width: 400px; height: 500px;}
#iframe1{width: 800px; height: 800px;}
#iframe2{width: 300px; height: 800px;}
</style>
</head>
<body>

<span>
<iframe id="iframe1" src="/library/store">
</iframe>
</span>

<span>
<iframe id="iframe2" src="/library/chat">
</iframe>
</span>

</body>
</html>