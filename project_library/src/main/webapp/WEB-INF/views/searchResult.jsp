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
<script>
$(document).ready(function(){
	$('td').on('click','a[href="more"]',function(event){
		event.preventDefault();		
		var currAmount = Number($(this).attr('id'))+1;

		var temp = $("#bottom").children(0).text().indexOf("(");
		var temp2 = $("#bottom").children(0).text().indexOf(")");
		var num = "";
		for(var i = temp+1; i < temp2; i++){
			num += $("#bottom").children(0).text().charAt(i);		
		}
		$.ajax({
			url:"/library/searchMore",
			data:{"currAmount":currAmount},
			success:function(result){
				num = num - result.length;
				if(num <= 0){
					$("a[href='more']").click('off'); //더 보여줄것이 없으면 이벤트종료
				}
				
				$("#bottom").children().eq(0).children().eq(0).html(
						"<a href='' id='${amount}'>▼더보기("+num+")</a>");
				$("#bottom").children().eq(0).children().eq(0).attr('id',currAmount);
				for(var i = 0; i < result.length; i++){
					$("#bottom").before(
					"<tr>"+
					"<td>"+result[i].st_num+"</td>"+
					"<td><a class='selectTitle' href=''>"+result[i].st_title+"</a></td>"+
					"<td>"+result[i].st_m_id+"</td>"+
					"<td>"+result[i].st_date+"</td>"+
					"</tr>");					
				}
			}
		})//ajax-end
	})
	
	$('table').on('click','.selectTitle',function(event){
		event.preventDefault();
		var stnum = $(this).closest("tr").children().eq(0).text();
		var writer = $(this).closest("tr").children().eq(2).text();
		$.ajax({
			url : "/library/store.stnum",
			data : {"stnum" : stnum,
					"writer" : writer},
			success : function(result){
				$("#detail").html(
						"<table border='1'>"+
						"<tr>"+
						"<td>제목</td>"+
						"<td>"+result.st_title+"</td>"+
						"</tr>"+
						"<tr>"+
						"<td>작성자</td>"+
						"<td>"+result.st_m_id+"</td>"+
						"</tr>"+
						"<tr>"+
						"<td>작성일</td>"+
						"<td>"+result.st_date+"</td>"+
						"</tr>"+
						"<tr id='content'>"+
						"<td>내용</td>"+
						"<td>"+
						result.st_context+
						"<br><a href='' id='cmt'>댓글보기</a><br>"+
						"<input type=button id='delete' value='글삭제'>"+
						"<input type=button id='send' value='거래신청'>"+
						"</td>"+
						"</tr>"+
						"</table>");
			}
		})
		$.ajax({
			url : "/library/isComplete",
			data : {"stnum" : stnum},
			success : function(result){
				if(result == "complete"){ //거래완료
					$("#content").before("<tr><td>거래상태</td><td>거래완료</td></tr>");
				}
				else if(result == "wait"){ //거래대기
					$("#content").before("<tr><td>거래상태</td><td>거래대기</td></tr>");
				}
				else if(result == "ing"){ //거래중
					$("#content").before("<tr><td>거래상태</td><td>거래중</td></tr>");
				}
			}
		})
	})
})
</script>
</head>
<body>
<h2><b>#${searchWord}</b> 검색결과</h2>
<h6>${countSearch}개의 검색결과</h6>
<table border="1">
<tr>
<td>글번호</td>
<td>제목</td>
<td>작성자</td>
<td>작성일</td>
</tr>

<c:forEach var="storeVO" items="${searchList}">
<tr>
<td>${storeVO.st_num}</td>
<td><a class="selectTitle" href="">${storeVO.st_title}</a></td>
<td>${storeVO.st_m_id}</td>
<td>${storeVO.st_date}</td>
</tr>
</c:forEach>

<tr id="bottom"><td colspan="4" style="text-align: center;">
<!-- 더보기 누를때마다 id가 증가 -->
<c:if test="${not empty amount}">
	<c:set var="listAmount" value="${amount}*5"/>
</c:if>
<c:if test="${not empty amount2}">
	<c:set var="listAmount" value="${amount2}"/>
</c:if>
<a href="more" id="${amount}">▼더보기(${countSearch-listAmount})</a>
</td></tr>
</table>
<br>

<div id="detail">
</div>

</body>
</html>