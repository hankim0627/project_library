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
<h4 style="font-size: 15px; font-weight: bold; top: 15px; position: relative; left: 10px;">채팅</h4>

<div id="chatArea" style="top: 40px; position: relative; left: 10px; font-size: 13px;">

</div>

<div style="left: 10px; position: relative;">
<input type="text" id="message" style="height:20px; position: relative; top: 50px;">
<input type="button" value="메세지 전송" id="sendMsg" style="height:25px; font-size: 13px; position: relative; top: 50px;">
</div>

</body>
</html>