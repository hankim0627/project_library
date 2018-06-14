<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<style type="text/css">
/* body{background-color: rgb(217, 217, 217); text-align: center;} */
div{width: 1200px; height: 800px;} */
/* iframe.iframe1{
	width: 70%; 
	height: 800px; 
	border: 0px; 
	margin-right: 30px;
}

iframe.iframe2{
	width: 30%; 
	height: 800px;
	border: 1px solid #BDBDBD; 
	background-color: white;
} */
</style>
</head>
<body>

<div class="eachBoardShow">
<iframe class="iframe1" src="/library/studyRoomEachBoard?sr_num=${sr_num }" style="width:700px; height:800px; border:0px; margin-right: 30px;">
</iframe>

<iframe class="iframe2" src="/library/chat" style="width:400px; height:800px; border: 1px solid #BDBDBD; background-color: white;">
</iframe>
</div>

</body>
</html>