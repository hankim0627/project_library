<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8>
<title>Insert title here</title>
</head>
<body>
<h2>마이페이지</h2>
<h5><a href="/library/studyRoomMain?l_id=<%=session.getAttribute("sessionlibrary")%>">◀스터디룸으로 돌아가기</a></h5>

내가 개설한 스터디룸 : <a href="">${cntMakeStudyRoomWithId}</a>
<h4>개설한 스터디룸</h4>
<table>
	<c:forEach items="${listMakeStudyRoomWithId}" var="list">
		<tr>
			<td>${list.getSr_num() }</td>
			<td>${list.getSr_cate() }</td>
			<td><a href="/library/"> ${list.getSr_title() }</a></td>
			<td>${list.getM_name() }</td>
			<td>${list.getSr_date() }</td>
			<td>${list.getSr_view_num() }</td>
		</tr>
	</c:forEach>
</table>
<c:forEach var="page" begin="1" end="${makeTotalPage}">
		<a href="/library/studyRoomMyPage?page=${page }">${page }</a>
</c:forEach>


<%-- 내가 신청한 스터디룸 : <a href="">${totalPage}</a>
<h4>신청한 스터디룸</h4>
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
 --%>

</body>
</html>