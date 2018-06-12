<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8>
<title>Insert title here</title>

<script>
	function writeCheck(obj){
		if(!obj.sr_title.value){
			alert("제목을 입력해주세요");
			return false;
		} 
		alert("게시물 작성이 완료되었습니다.");
		return true;
	}
</script>
</head>
<body>

<form action="<%=request.getContextPath() + "/studyRoomEachBoardWriteSubmit"%>" method="post" enctype="multipart/form-data" onsubmit="return writeCheck(this)">

<!-- <form action="/library/studyRoomEachBoardWriteSubmit" method="post" onsubmit="return writeCheck(this)"> -->
	<div>
	카테고리
	 <select name="sr_cate">
			<option value="자료공유">자료공유</option>
			<option value="스터디진행상황">스터디진행상황</option>
			<option value="설문조사">설문조사</option>
			<option value="잡담">잡담</option>
	</select>
	</div>
	<div>제목	<input type="text" name="sr_title" placeholder="게시글 제목을 입력하세요" ></div>
	<div>내용	<input type="text" name="sr_content"></div>
	
	<div>
	파일은 3개까지 업로드 가능
	<p>파일1  <input type="file" name="file1"></p>
	<p>파일2  <input type="file" name="file2"></p>
	<p>파일3  <input type="file" name="file3"></p>
	</div>
	
	<input type="hidden" name="l_id" value="<%=session.getAttribute("l_id") %>">
	<input type="hidden" name="sr_num" value="${sr_num }">
	<input type="submit" value="확인">
</form>

</body>
</html>