<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8>
<script src="/library/resources/jquery-3.2.1.min.js"></script>
<title>Insert title here</title>
</head>
<body>

<a href="/library/studyRoomMyPage">마이페이지 가기</a>

<table>
	<c:forEach items="${studyRoomList}" var="list">
		<tr>
			<td>${list.getSr_num() }</td>
			<td>${list.getSr_cate() }</td>
			<td><a href="/library/studyRoomDetail?sr_num=${list.getSr_num() }"> ${list.getSr_title() }</a></td>
			<td>${list.getM_name() }</td>
			<td>${list.getSr_date() }</td>
			<td>${list.getSr_view_num() }</td>
		</tr>
	</c:forEach>
</table>

<c:if test="${empty searchWord }">
	<c:forEach var="page" begin="1" end="${totalPage }">
		<a href="/library/studyRoomMain?page=${page }&l_id=<%=session.getAttribute("l_id") %>">${page }</a>
	</c:forEach>
</c:if>


<c:if test="${not empty searchWord }">
	<c:forEach var="page" begin="1" end="${totalPage }">
		<a href="/library/studyRoomSearch?page=${page }&l_id=<%=session.getAttribute("l_id") %>&searchDate=${searchDate}&searchType=${searchType}&searchWord=${searchWord}">${page }</a>
	</c:forEach>
</c:if>


<form action="/library/studyRoomSearch" >
	<select name="searchDate" >
		<option value="1" <c:if test="${searchDate eq 1 }">selected</c:if>>1 일</option>
		<option value="7" <c:if test="${searchDate eq 7 }">selected</c:if>>1 주</option>
		<option value="30" <c:if test="${searchDate eq 30 }">selected</c:if>>1 개월</option>
		<option value="180" <c:if test="${searchDate eq 180 }">selected</c:if>>6 개월</option>
	</select>
	
	<select name="searchType">
		<option value="제목" <c:if test="${searchType eq '제목' }">selected</c:if>>제목</option>
		<option value="작성자" <c:if test="${searchType eq '작성자' }">selected</c:if>>작성자</option>
		<option value="카테고리" <c:if test="${searchType eq '카테고리' }">selected</c:if>>카테고리</option>
	</select>
	
	<input type="text" name="searchWord" <c:if test="${not empty searchWord}">value=${searchWord }</c:if>>
	<input type="hidden" value="<%=session.getAttribute("l_id") %>" name="l_id">
	<input type="submit" value="검색">
	
	<input type="button" value="글쓰기" onclick="location.href='/library/studyRoomWrite'">
	<input type="button" value="전체보기" onclick="location.href='/library/studyRoomMain?l_id=<%=session.getAttribute("l_id")%>'">
</form>


</body>
</html>