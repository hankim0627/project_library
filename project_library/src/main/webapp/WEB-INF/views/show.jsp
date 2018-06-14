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

<style type="text/css">
body{/* background-color: rgb(217, 217, 217); */ text-align: center;}
span{width: 400px; height: 500px;}
#iframe1{width: 720px; height: 800px;}
#iframe2{width: 300px; height: 800px;}
</style>
</head>
<body>

<span>
<iframe style='border: 0px;' id="iframe1" src="/library/store">
</iframe>
</span>

<span>
<iframe  id="iframe2" src="/library/chat">
</iframe>
</span>

</body>
</html>