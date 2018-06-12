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
body{background-color: rgb(217, 217, 217); text-align: center;}
</style>

<script src="http://code.jquery.com/jquery-3.2.1.min.js"></script>
<script>
$(document).ready(function(){
	websocket = new WebSocket("ws://localhost:9090/library/chatws");
	websocket.onopen = onOpen;
	websocket.onclose = onClose;
	websocket.onmessage = onMessage;
	
	function onOpen(){
		console.log("웹소켓 연결 성공"); //웹소켓 연결시 호출
	}

	function onClose(){
		console.log("연결해제");
	}

	function onMessage(evt){ //메세지 수신시
		var data = evt.data;
		$("#chatArea").append(data+"<br>");
	}
	
	$("#sendMsg").on('click', function(){
		var msg = $("#message").val();
		$("#message").val('');
		websocket.send(msg);
	})
})
</script>
</head>
<body>
<h2>채팅</h2>

<div id="chatArea">

</div>
<!-- <div style="position: absolute;bottom: 0;"> -->
<input type="text" id="message">
<input type="button" value="메세지 전송" id="sendMsg">
</div>


</body>
</html>