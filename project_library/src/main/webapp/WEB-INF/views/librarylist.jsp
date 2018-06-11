<%@page import="multi.project.library.LibraryVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8">
<title>Insert title here</title>
<style>
h1 {
	color: #d0858a;
	font-family: times; /* 여러개 중에 앞에서부터 있는 거 사용 */
	font-size: 40px;
	font-weight: bold;
	text-align: center;
}

th{
width: 120px;

}
td{
padding-left: 20px;
}

section#choose{
 display: table-cell;
 padding: 15px;
 border-right: 5px solid #d0858a;
}

section#info{
 display: table-cell;
  padding: 25px; 
}

p{
 text-align: right;
}
</style>

</head>

<body>


<h1> Library Talk </h1>

<hr width = 100% color = #d0858a size = 5>

<section id = choose>

<h2>  도서관 선택</h2>

<form action="?">
<select name = library>
	<c:forEach items = "${librarylist }" var = "vo">
		<option> ${vo.l_name }
	</c:forEach>
</select>
<input type=submit value='정보 조회'>
</form>

</section>


<section id = info>
<h2>도서관 정보</h2>

<% 	List<LibraryVO> list = (List<LibraryVO>)request.getAttribute("librarylist");
	String s = "";
	if(request.getParameter("library")==null)
		s = "중구구립도서관"; 
	else
		s =  request.getParameter("library");
	//out.println(s);

	for(int i=0 ; i<list.size() ; i++){
	
			if(s.equals(list.get(i).getL_name())){
				session.setAttribute("l_id", list.get(i).getL_id());
				session.setAttribute("l_name", list.get(i).getL_name());
				out.println("<table>");
				out.println("<tr><th>도서관 이름 </th><td>"+list.get(i).getL_name()+"</td></tr>");
				out.println("<tr><th>주소 </th><td>"+list.get(i).getL_location()+"</td></tr>");
				out.println("<tr><th>휴관일 </th><td>"+list.get(i).getL_holiday()+"</td></tr>");
				out.println("<tr><th>운영 시간 </th><td>"+list.get(i).getL_time()+"</td></tr>");
				out.println("<tr><th>전화번호 </th><td>"+list.get(i).getL_phone()+"</td></tr>");
				out.println("<tr><th>홈페이지</th><td> <a href="+list.get(i).getL_website()+">"+list.get(i).getL_website()+"</a></td></tr>");
				out.println("</table>");

			}
	}
%>

</section>

<br><br><br>

<p>
<button type="button" onclick="location.href='/library/new'">회원가입</button>
<button type="button" onclick="location.href='/library/login'">로그인</button>
</p>



</body>


</html>