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

<form action="/library/studyRoomWriteSubmit" method="post" onsubmit="return writeCheck(this)">
	카테고리
	 <select name="sr_cate">
			<option value="중학생">중학생</option>
			<option value="고등학생">고등학생</option>
			<option value="대학생">대학생</option>
			<option value="취업준비생">취업준비생</option>
			<option value="직장인">직장인</option>
			<option value="기타">기타</option>
	</select><br>
	제목	<input type="text" name="sr_title" placeholder="게시글 제목을 입력하세요" ><br>
	내용	<input type="text" name="sr_content"><br>
	
	<input type="hidden" name="l_id" value="<%=session.getAttribute("l_id")%>">
	<input type="hidden" name="m_id" value="<%=session.getAttribute("member_id") %>">
	<input type="hidden" name="sr_pw" value="<%=session.getAttribute("member_pw") %>">
	<input type="submit" value="확인">
</form>

</body>
</html>