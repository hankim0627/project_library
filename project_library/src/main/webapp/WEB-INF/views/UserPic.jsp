<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<html>
<head>
<meta charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style type="text/css">
.userpic
{width: 30px;
height: 30px;}
/* body
{background-color: rgb(217, 217, 217)} */
table
{ border-collapse: collapse; 
margin-bottom: 2px;}
td
{padding: 5px;}
.userpic {
  border-radius: 50% !important;
}
body
{background-color: rgb(109, 124, 163);}
</style>
</head>
<body>
<div class="container">
<form action="/library/UserPicSelect/" method="post">
<br>
<label class="radio-inline"><input name=userpic value=person1.jpg type="radio" ><img src='/library/resources/person1.jpg' class=userpic></label>
<label class="radio-inline"><input name=userpic value=person2.jpg type="radio" ><img src='/library/resources/person2.jpg' class=userpic></label>
<label class="radio-inline"><input name=userpic value=person3.jpg type="radio" ><img src='/library/resources/person3.jpg' class=userpic></label>
<label class="radio-inline"><input name=userpic value=person4.jpg type="radio" ><img src='/library/resources/person4.jpg' class=userpic></label>
<label class="radio-inline"><input name=userpic value=person5.jpg type="radio" ><img src='/library/resources/person5.jpg' class=userpic></label>
<br><br>
<label class="radio-inline"><input name=userpic value=person6.jpg type="radio" ><img src='/library/resources/person6.jpg' class=userpic></label>
<label class="radio-inline"><input name=userpic value=person7.jpg type="radio" ><img src='/library/resources/person7.jpg' class=userpic></label>
<label class="radio-inline"><input name=userpic value=person8.jpg type="radio" ><img src='/library/resources/person8.jpg' class=userpic></label>
<label class="radio-inline"><input name=userpic value=person9.jpg type="radio" ><img src='/library/resources/person9.jpg' class=userpic></label>
<label class="radio-inline"><input name=userpic value=person10.jpg type="radio" ><img src='/library/resources/person10.jpg' class=userpic></label>
<br><br>
<input type="submit" class="btn btn-info" value='변경'>

</form>
</div>
</body>
<script>
	  
	window.onunload = function () { 
	    window.opener.location.reload(); 
	       window.close()
	}
	
	
	
</script>
</html>