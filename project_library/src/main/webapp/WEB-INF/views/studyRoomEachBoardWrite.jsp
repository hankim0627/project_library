<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8>
<title>Insert title here</title>
<style>
h4{
	position: absolute;
	top: 10px;
	left:20px;
}
div.writeForm{
	position: absolute;
	width : 80%;
	top : 70px;
	left : 20px;
}
span.writeMenu{
	display:inline-block;
	width : 100px;
}
div.writeMenu{
	padding:4px;
	font-size: 13px;
	border: 2px;
}
div.writeMenuSubmit{
	position: absolute;
	left : 10%;
}

</style>
<script>
	function writeCheck(obj){
		if(!obj.sr_title.value){
			alert("제목을 입력해주세요");
			return false;
		} 
		if(!obj.sr_pw.value){
			alert("비밀번호를 입력해주세요");
			return false;
		}
		alert("게시물 작성이 완료되었습니다.");
		return true;
	}
</script>
</head>
<body>

<h4>${sr_num }번 스터디룸 게시글 작성</h4>
<div class="writeForm">
	<form action="<%=request.getContextPath() + "/studyRoomEachBoardWriteSubmit"%>" method="post" enctype="multipart/form-data" onsubmit="return writeCheck(this)">
		<div class="writeMenu">
		<span class="writeMenu">카테고리</span>
		 <select name="sr_cate" style="height: 25px">
				<option value="자료공유">자료공유</option>
				<option value="스터디진행상황">스터디진행상황</option>
				<option value="설문조사">설문조사</option>
				<option value="잡담">잡담</option>
		</select>
		</div>
		<div class="writeMenu"><span class="writeMenu">제목</span>	<input type="text" name="sr_title" placeholder="게시글 제목을 입력하세요" style="width: 31%; height: 20px"></div>
		<div class="writeMenu"><textarea name="sr_content" rows="30" cols="80" placeholder="내용을 입력하세요"></textarea></div>
		<div class="writeMenu"><span class="writeMenu">비밀번호 </span><input type="password" name="sr_pw" style="height: 20px"></div>
		
		<div class="writeMenu">파일은 3개까지 업로드 가능합니다.</div>
		<div class="writeMenu"><span class="writeMenu">파일1</span>  <input type="file" name="file1"></div>
		<div class="writeMenu"><span class="writeMenu">파일2</span>  <input type="file" name="file2"></div>
		<div class="writeMenu"><span class="writeMenu">파일3</span>  <input type="file" name="file3"></div>
		
		<input type="hidden" name="l_id" value="<%=session.getAttribute("l_id") %>">
		<input type="hidden" name="sr_num" value="${sr_num }">
		<div class="writeMenuSubmit"><input type="submit" value="확인">   <input type="button" onclick="history.back();" value="취소"></div>
	</form>
</div>
</body>
</html>