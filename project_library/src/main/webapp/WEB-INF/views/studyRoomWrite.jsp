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
		if(!obj.sr_pw.value){
			alert("비밀번호를 입력해주세요");
			return false;
		}
		alert("게시물 작성이 완료되었습니다.");
		return true;
	}
</script>
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
	padding:2px;
}
div.writeMenuSubmit{
	position: absolute;
	left : 30%;
}
</style>
</head>
<body>
<h4>스터디룸 게시글 작성</h4>
<div class="writeForm">
	<form action="/library/studyRoomWriteSubmit" method="post" onsubmit="return writeCheck(this)">
	<div class="writeMenu">
		<span class="writeMenu">카테고리</span>
		 <span><select name="sr_cate" style="height: 25px">
				<option value="중학생">중학생</option>
				<option value="고등학생">고등학생</option>
				<option value="대학생">대학생</option>
				<option value="취업준비생">취업준비생</option>
				<option value="직장인">직장인</option>
				<option value="기타">기타</option>
		</select></span>
	</div>
	<div class="writeMenu"><span class="writeMenu">제목</span>	<span><input type="text" name="sr_title" placeholder="게시글 제목을 입력하세요" style="width: 50%; height: 20px"></span></div>
	<div class="writeMenu"><!-- <span class="writeMenu">글쓰기</span><br> -->	<span><textarea name="sr_content" rows="40" cols="80" placeholder="내용을 입력하세요"></textarea><!-- <input type="text" name="sr_content"> --></span></div>
	<div class="writeMenu"><span class="writeMenu">비밀번호</span> <span><input type="password" name="sr_pw" style="height: 20px"></span></div>	<br>
		
		<input type="hidden" name="l_id" value="<%=session.getAttribute("l_id")%>">
		<input type="hidden" name="m_id" value="<%=session.getAttribute("member_id") %>">
	<div class="writeMenuSubmit"><input type="submit" value="확인"><input type="button" onclick="history.back();" value="취소"></div>
	</form>
</div>
</body>
</html>