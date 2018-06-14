<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8>
<script src="/library/resources/jquery-3.2.1.min.js"></script>
<title>Insert title here</title>
<style>
table{
	width: 100%;
	border-collapse: collapse;
	font-size: 13px;
}
tr.menuHead{
	font-weight: bold;
	text-align: center;
}
td{
	border-top: 1px solid #BDBDBD;
	border-bottom: 1px solid #BDBDBD;
	padding: 7px;
}
td.middleText{
	text-align: center;
}
a{
	text-decoration: none;
	font-size:13px;
	color: #003399;
}
a:hover{
	text-decoration: underline;
}
a:link,a:visited{
	color:#003399;
}
div.pageNumSt{
	position: absolute;
	width: 100%;
	text-align: center;
	padding: 20px;
}
a.pageNumSt{
	vertical-align: middle;
}
div.searchForm{
	padding: 10px;
}


</style>
</head>
<body>

<!-- <a href="/library/studyRoomMyPage">마이페이지 가기</a> -->

<h4>스터디룸 게시글</h4>
<table>
	<tr class="menuHead"><td width="9%">글번호</td>
						<td width="14%">카테고리</td>
						<td width="36%">제목</td><td width="11%">작성자</td>
						<td width="20%">작성일</td>
						<td width="10%">조회수</td></tr>
	<c:forEach items="${studyRoomList}" var="list">
		<tr>
			<td class="middleText" width="7%" >${list.getSr_num() }</td>
			<td class="middleText" width="14%">${list.getSr_cate() }</td>
			<td width="38%"><a href="/library/studyRoomDetail?sr_num=${list.getSr_num() }"> ${list.getSr_title() }</a></td>
			<td width="11%">${list.getM_name() }</td>
			<td class="middleText" width="20%">${list.getSr_date() }</td>
			<td class="middleText" width="10%">${list.getSr_view_num() }</td>
		</tr>
	</c:forEach>
</table>

<div class="pageNumSt">
	<div>
		<c:if test="${empty searchWord }">
			<c:forEach var="page" begin="1" end="${totalPage }">
				<a class="pageNumSt" href="/library/studyRoomMain?page=${page }&l_id=<%=session.getAttribute("l_id") %>">${page }</a>
			</c:forEach>
		</c:if>
		
		
		<c:if test="${not empty searchWord }">
			<c:forEach var="page" begin="1" end="${totalPage }">
				<a class="pageNumSt" href="/library/studyRoomSearch?page=${page }&l_id=<%=session.getAttribute("l_id") %>&searchDate=${searchDate}&searchType=${searchType}&searchWord=${searchWord}">${page }</a>
			</c:forEach>
		</c:if>
	</div>
	<div class="searchForm">
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
	</div>
</div>

</body>
</html>