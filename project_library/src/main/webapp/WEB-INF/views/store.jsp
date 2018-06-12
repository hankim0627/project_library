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
table{text-align: center; border: solid 1px;}
td{border: solid 1px;}
#result_content{background-color: pink;}
</style>
<script src="http://code.jquery.com/jquery-3.2.1.min.js"></script>
<!-- <script src="/library/resources/jquery-3.2.1.min.js"></script> -->
<script>
$(document).ready(function(){
	var stnum; //글번호
	
	$('.selectTitle').on('click',function(event){
		event.preventDefault();
		$("#result_comment").attr('hidden',true);
		$("#write_comment").attr('hidden',true);
		//var stnum = $(this).html(); --> 제목
		stnum = $(this).closest("tr").children().eq(1).text(); //선택행의 stnum
		writer = $(this).closest("tr").children().eq(3).text(); //선택행의 글쓴이
		 $.ajax({
			type: 'POST',
			dataType : 'JSON',
			data: {"stnum" : stnum,
					"writer" : writer},
			url: '/library/store.stnum',
			success: function(server_result){
				$("#result").attr('hidden',false);
				$("#result").html(
				"<table id='result_content'>"+
				"<tr>"+
				"<td>제목</td>"+
				"<td>작성자</td>"+
				"<td>작성일</td>"+
				"</tr>"+
				"<tr>"+
				"<td>"+server_result.st_title+"</td>"+
				"<td>"+server_result.st_m_id+"</td>"+
				"<td>"+server_result.st_date+"</td>"+
				"</tr>"+
				"<tr>"+
				"<td>내용</td>"+
				"<td colspan='2'>"+
				server_result.st_context+"<br><a href='' id='cmt'>댓글보기</a>"+
				"<input type=button id='delete' value='글삭제'>"+
				"<input type=button id='send' value='거래신청'>"+
				"</td>"+
				"</tr>"+
				"</table>");
			}//success-end
			
			/* complete:function(){
				alert("통신완료");
			} */
			
		});//ajax-end
	})//.selectTitle-on-end
	
	$("#write").on('click', function(){
		popup("/library/write",480,380,'팝업1','scroll');
	})	
	
	//글쓰기 창
	function popup(url, w, h, name, option){
		var poxX, pozY;
		var sw = screen.availWidth; //screen width
		var sh = screen.availHeight; //screen height
		var scroll = 0;
		if(option == 'scroll'){
			scroll = 1;
		}
		pozX = (sw - w) / 2;
		pozY = (sh - h) / 2;
		window.open(url, name, "location=0,status=0,scrollbars=" + scroll + ",resizable=1,width=" + w + ",height=" + h + 
			    ",left=" + pozX + ",top=" + pozY);
	}
	
	//글삭제
	$("#result").on('click',"input[id='delete']", function(){
		var inputPw = prompt("작성시 비밀번호를 입력해주세요");
		$.ajax({
			type : 'POST',
			dataType : 'JSON',
			data : {"stnum" : stnum},
			url : '/library/store.stnum',
			success : function(result){
				var pw = result.st_pw;
				if(inputPw == pw){
					$(location).attr('href',"/library/delete");
				}
				else{
					//비밀번호가 틀림
					alert("비밀번호를 확인해주세요");
				}
			}
		})
	})
	
	//댓글달기
	$("#result").on('click',"a[id='cmt']", function(event){
		event.preventDefault();
		$.ajax({
			type: 'POST',
			dataType : 'JSON',
			data : {"stnum" : stnum},
			url: "/library/comment",
			success: function(result){
				$("#result_comment").attr('hidden',false);
				$("#write_comment").attr('hidden',false);
				$("#result_comment").html("<table id='result_content2'>");
				for(var i = 0; i < result.length; i++){
					$("#result_comment").append(
							"<tr>"+
							"<td>"+result[i].c_m_id+"</td>"+
							"<td width='250' align='right'>"+result[i].c_content+"</td>"+
							"</tr>");
				}
				$("#result_comment").append("</table>"); 
				/* 
				$("#result").append("<table>");
				for(var i = 0; i < result.length; i++){
					$("#result").append(
							"<tr>"+
							"<td>"+result[i].c_m_id+"</td>"+
							"<td width='100' align='right'>"+result[i].c_content+"</td>"+
							"</tr>");
				}
				$("#result").append("</table>");  */
			}//success-end	
		})//ajax-end
	})//on-click-end
	
	//거래신청
	$("#result").on('click', "input[id='send']", function(){
		$(location).attr('href',"/library/send.memstore");
	})
	
	$("#commentBtn").on('click', function(){
		var c_content = $("#c_content").val();
		$.ajax({
			data : {"c_content" : c_content},
			url : "/library/writecomment",
			success : function(result){
				$("#result_comment").attr('hidden',false);
				$("#write_comment").attr('hidden',false);
				$("#result_comment").html("<table id='result_content2'>");
				for(var i = 0; i < result.length; i++){
					$("#result_comment").append(
							"<tr>"+
							"<td>"+result[i].c_m_id+"</td>"+
							"<td width='250' align='right'>"+result[i].c_content+"</td>"+
							"</tr>");
				}
				$("#result_comment").append("</table>"); 
			}
		})//ajax-end
	})
	
})
</script>
</head>
<body>

<h2>중고장터</h2>
<a href="/library/mypage">마이페이지로 이동</a>

<table>
<tr>
<td>거래상태</td>
<td>글번호</td>
<td>제목</td>
<td>작성자</td>
<td>작성일</td>
</tr>

<c:forEach items="${storeList}" var="storeVO" varStatus="vs">
<tr>
<td>
<c:if test="${memStoreList.get(vs.index).flag == 1}">
<font color="blue" style="font-style: italic;">거래완료</font>
</c:if>
<c:if test="${memStoreList.get(vs.index).flag == 0}">
거래중
</c:if>
<c:if test="${memStoreList.get(vs.index).flag == -1}">
거래대기
</c:if>
</td>
<td class="num">${storeVO.st_num}</td>
<td><a class="selectTitle" href="">${storeVO.st_title}</a></td>
<td>${storeVO.st_m_id}</td>
<td>${storeVO.st_date}</td>
</tr>
</c:forEach>
</table>

<!-- 검색 -->
<div>
<form action="/library/search" method="get">
<select name="op">
<option value="제목">제목</option>
<option value="작성자">작성자</option>
<option value="제목+내용">제목+내용</option>
</select>
<input type=text id='search' name='value'>
<input type=submit value='검색'>
</form>
</div>

<!-- 페이징 -->
<c:forEach var="page" begin="1" end="${pageCnt}">
<a href="/library/store?page=${page}">${page}</a>
</c:forEach>
<input type="button" value="글쓰기" id="write">
<br><br><br>

<div id="result" hidden="true">
</div>
<br><br>
<div id="result_comment" hidden="true">
</div>

<div id="write_comment" hidden="true">
	<form action="/library/writecomment">
		<input type="text" id="c_content">
		<input type="button" id="commentBtn" value="댓글달기">
	</form>
</div>

</body>
</html>
