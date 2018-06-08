<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>

<%
	session.setAttribute("sessionid", "yhg1yhg1");  
	session.setAttribute("sessionpw", "qwe123");
	session.setAttribute("sessionlibrary", 0);
%>
<!-- 아래꺼 a태그로 바꾸기 -->
<form action="studyRoomMain">

	<input type="hidden" value="0" name="l_id">
	<input type="submit" value="studeygogo">
	
</form>


</body>
</html>
