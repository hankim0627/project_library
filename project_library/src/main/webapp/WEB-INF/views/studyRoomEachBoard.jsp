<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<style>
table{
	width: 650px;			/* 원래 50% */
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
	width: 650px;
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
<meta charset=UTF-8>
<title>Insert title here</title>
</head>
<body>

<!-- <a href="/library/studyRoomMyPage">마이페이지 가기</a> -->
<c:if test="${fileUploadIsSuccess ==0 }">
	<% out.println("<script>alert(\"게시물 등록에 실패했습니다. 다시 시도해주세요.\"); </script>"); %>
</c:if>
<h4>${sr_num }번 스터디룸</h4>

<table>
	<tr class="menuHead"><td width="9%">글번호</td>
						<td width="14%">카테고리</td>
						<td width="36%">제목</td><td width="11%">작성자</td>
						<td width="20%">작성일</td>
						<td width="10%">조회수</td></tr>
	<c:forEach items="${studyRoomEachBoardList}" var="list">
		<tr >
			<td class="middleText">${list.getSr_eb_num() }</td>
			<td class="middleText">${list.getSr_cate() }</td>
			<td><a href="/library/studyRoomEachBoardDetail?sr_eb_num=${list.getSr_eb_num() }&sr_num=${list.getSr_num() }"> ${list.getSr_title() }</a></td>
			<td >${list.getM_name() }</td>
			<td class="middleText">${list.getSr_date() }</td>
			<td class="middleText">${list.getSr_view_num() }</td>
		</tr>
	</c:forEach>
</table>

<div class="pageNumSt">
	<c:if test="${empty searchWord }">
		<c:forEach var="page" begin="1" end="${totalPage }">
			<a class="pageNumSt" href="/library/studyRoomEachBoard?sr_num=${sr_num }&page=${page }">${page }</a>
		</c:forEach>
	</c:if>
	
	<c:if test="${not empty searchWord }">
		<c:forEach var="page" begin="1" end="${totalPage }">
			<a class="pageNumSt" href="/library/studyRoomEachBoardSearch?sr_num=${sr_num }&page=${page }&searchDate=${searchDate}&searchType=${searchType}&searchWord=${searchWord}">${page }</a>
		</c:forEach>
	</c:if>
	
	<div class="searchForm">
		<form action="/library/studyRoomEachBoardSearch" >
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
			<!-- <input type="hidden" value="0" name="l_id"> -->
			<input type="hidden" name="sr_num" value="${sr_num }">
			<input type="submit" value="검색">
			
			<input type="button" value="글쓰기" onclick="location.href='/library/studyRoomEachBoardWrite?sr_num=${sr_num }'">
			<input type="button" value="전체보기" onclick="location.href='/library/studyRoomEachBoard?sr_num=${sr_num}'">
		</form>
	</div>
	
	
</div>
</body>
</html>