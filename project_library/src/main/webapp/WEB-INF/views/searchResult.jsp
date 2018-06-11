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
				$("#detail").html(result.st_title);
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
<a href="more" id="${amount}">▼더보기(${countSearch-amount*5})</a>
</td></tr>
</table>

<div id="detail">
</div>

</body>
</html>