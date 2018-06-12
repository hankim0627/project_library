<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<html>
<head>
<meta charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
table
{border: ridge gray 6px;
 margin-bottom: 2px; 
 border-collapse: collapse; 
 width: 500px;
 text-align: center;
 background-color: rgb(109, 124, 163);}
td
{border: solid black 2px; }
body
{background-color: rgb(217, 217, 217);}
.rounded-circle {
  border-radius: 50% !important;
}
.img-profile {
    max-width: 10rem;
    max-height: 10rem;
    border: 0.5rem solid rgba(255, 255, 255, 0.2);
}
</style>
</head>
<body>
<c:forEach items='${info}' var="myinfo">
<table><tr><td rowspan="3">
<img class="img-fluid img-profile rounded-circle mx-auto mb-2" name='<%=session.getAttribute("l_id")%>' id='userpic' alt='No Image' src='/library/resources/${myinfo.m_pic}'>  <br>
</td>
<td><h3><%=request.getAttribute("libraryName")%></h3></td><td>아이디<h3>${myinfo.m_id}</h3></td></tr>
<tr><td>이름<h3>${myinfo.m_name}</h3></td><td>전화번호<h3>${myinfo.m_phone}</h3></td></tr>
<tr><td>자유게시판 작성글수<h3><%=request.getAttribute("freecnt") %></h3></td><td>자유게시판 작성리플수<h3><%=request.getAttribute("freereplycnt") %></h3></td></tr>
</table>
</c:forEach>
</body>
</html>