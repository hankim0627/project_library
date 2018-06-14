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

<script src="http://code.jquery.com/jquery-3.2.1.min.js"></script>
<style>
body{/* background-color: rgb(217, 217, 217); */ text-align: center;}
table{margin: 0px auto;}
td{background-color: pink;}
</style>
</head>
<body>
<h2>마이페이지</h2>
<h5><a href="/library/store">◀중고장터로 돌아가기</a></h5>

내가 쓴 글 갯수 : <a href="0" id="countStore">${countStore}</a>

<div id="storeList">
<table border="1">
<tr>
<td>${columnMap.stnum}</td>
<td>${columnMap.title}</td>
<td>${columnMap.trade}</td>
<td>${columnMap.isComplete}</td>
</tr>
<c:forEach var="vo" items="${list}" varStatus="vs">
<tr>
<td>${vo.st_num}</td>
<td>${vo.st_title}</td>
<td>
<c:if test="${memList.get(vs.index) != 0}">
<a href="" class="send">${memList.get(vs.index)}</a>
</c:if>
</td>
<td>
<c:if test="${tradeList.get(vs.index) == 1}">
<a href="" class="sendid">거래완료</a>
</c:if>
</td>
</tr>
</c:forEach>
</table>
</div>

<div id="tradeComment">
</div>
<br>
<div id="tradeSendId">
</div>

내가 신청한 거래 : <a href="" id="mySendCount">${mySendCount}</a>
<div id="mySendList">
</div>


<script>
$("#mySendCount").on('click', function(event){
	event.preventDefault();
	$.ajax({
		url:"/library/mySendList",
		success: function(result){
			$("#mySendList").html("<table id='sendList' border='1'>"
					+"<tr><td>글번호</td><td>상대ID</td><td>거래상태</td></tr>");
			for(var i = 0; i < result.length; i++){
				var temp;
				if(result[i].flag == "1"){
					temp = "거래완료";
				}
				else if(result[i].flag == "0"){
					temp = "수락대기";
				}
				
				$("#sendList").append(
				"<tr>"+
				"<td>"+result[i].ms_st_num+"</td>"+
				"<td>"+result[i].ms_m_id+"</td>"+
				"<td>"+temp+"</td>"+
				"</tr>");
			}
			$("#sendList").append("</table>");
		}
	})
})

$("#countStore").on('click', function(event){
	event.preventDefault();
	$("#listname").attr('hidden',false);
	var toggle = $("#countStore").attr("href"); //토글에 사용하는 변수
	$("#countStore").attr("href","1");
	$(location).attr('href',"/library/mypagelist");
})

$("#storeList").on('click', '.send', function(event){
	event.preventDefault();
	var stnum = $(this).closest("tr").children().eq(0).text();
	$.ajax({
		data : {"stnum" : stnum},
		url : "/library/viewtrade",
		success : function(result){
			$("#tradeComment").html('');
			$("#tradeSendId").html('');
			if(result.commentList.length!=0){
				$("#tradeComment").append("댓글리스트<br><table id='commentList'>");
			 for(var i = 0; i < result.commentList.length; i++){
				$("#commentList").append(
						"<tr><td>"+
						result.commentList[i].c_m_id+"</td><td>"+
						result.commentList[i].c_content+"</td></tr>");
			}
				$("#commentList").append("</table>");
			}
			if(result.memStoreList.length!=0){
				$("#tradeSendId").append("거래신청 리스트<br><table id='sendlist'>");
			for(var i = 0; i < result.memStoreList.length; i++){
				$("#sendlist").append(
						"<tr><td>"+
						result.memStoreList[i].send_id+"</td><td>"+
						"<input type='button' value='거래수락' id='ok'>"+
						"</td></tr>"); 
			}
				$("#sendlist").append("</table>");
			}
		}//success-end
	})
})//store-List-end

$("#tradeSendId").on('click', "input[id='ok']", function(){
	var name = $(this).closest("tr").children().eq(0).text();
	$.ajax({
		data : {"name" : name},
		url : "/library/update.flag",
		success : function(result){
			alert("거래완료");
		}
	})
})

$("#storeList").on('click', '.sendid', function(){
	var stnum = $(this).closest("tr").children().eq(0).text();
	$.ajax({
		data : {"stnum" : stnum},
		url : "/library/sendId",
		success : function(result){
			confirm(result);
		}
	})
})
</script>

</body>
</html>