<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<html>
<head>
<meta charset=UTF-8">
<title><%=request.getAttribute("libraryName")%></title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> 

<style type="text/css">
#userIdTag
{background-color: rgb(109, 124, 163);
padding-left: 20px;}
#userpic
{width: 40px;
height: 40px;}
#userinfo
{border: 0px;
 }
.u
{border: 0px;}

.item2 { grid-area: menu; font-size: 30px; padding: 0px;}
.item3 { grid-area: main; padding: 0px;}
.item4 { grid-area: right; }
.item5 { grid-area: footer; font-size: 2px; margin: auto;}

.grid-container {
  display: grid;
  grid-template-areas:
    'menu main main'
    'footer footer footer';
  grid-gap: 10px;
  /* background-color: #2196F3; */
/*   padding: 10px; */
}
.grid-container>div {
  /*  background-color: rgba(255, 255, 255, 0.8);  */
  text-align: center;
  padding:20px 0;
    
}
.menu
{/* border: lightblue 3px solid; */
border-radius: 50px 20px;
font-size: 20px;
background-color: rgba(165, 141, 218, 0.8)}
a, a:hover,a:VISITED,a:ACTIVE,a:LINK
{ text-decoration:none;  
display: inline-block;
font-weight: bold;} 
#myinfo{color: black;}
/* body
{background-color: rgb(217, 217, 217)} */
.img-profile {
    max-width: 10rem;
    max-height: 10rem;
    border: 0.5rem solid rgba(255, 255, 255, 0.2);
}

.rounded-circle {
  border-radius: 50% !important;
}
.img-fluid {
  max-width: 100%;
  height: auto;
}
#menuback
{background-color: rgba(158, 168, 194,0.7);
padding:5px;
border-radius: 5%;}
</style>
</head>
<body>
<!-- <hr width=100% color=#A58DDA size=50> -->

<div id="userIdTag"><c:forEach items="${user}" var="userInfo">
<table id= "userinfo">
<tr><td class="u">
<a href="#" data-toggle="tooltip" data-placement="bottom" title="아바타 바꾸기!">
<span class="d-none d-lg-block">
<img class="img-fluid img-profile rounded-circle mx-auto mb-2" name='<%=session.getAttribute("l_id")%>' id='userpic' alt='No Image' src='/library/resources/${userInfo.m_pic}'>
</span>
</a>
</td>
<td class="u"><h2><a href='#' id='myinfo'>${userInfo.m_id}</a></h2></td></tr></table>
</c:forEach></div>
<hr>
<div class="grid-container">
 
 <br>
  <div class="item2">
  <div id='menuback'>Menu
  <br>
  <br>
  
     
  <div class='menu' id='lib'><a href='#'>도서관 정보</a></div><br>
  <div class='menu' id='free'><a href='#'>자유 게시판</a></div><br>
  <div class='menu' id='store'><a href='#'>중고 장터</a></div><br>
  <div class='menu' id='studyroom'><a href='#'>스터디 룸</a></div><br>
  <div class='menu' id='map'><a href='#'>Location</a></div><br>
  <div class='menu' id='mypage'><a href='#'>마이페이지</a></div><br>
  <div class='menu' id='logout'><a href='#'>로그아웃</a></div><br>
  
  </div>
  </div>     
  <div id='board' class="item3">
  
  <iframe src=<%=request.getAttribute("libraryWebsite") %> width=1050 height=900 ></iframe>
  </div>  
  
  <div class="item4"></div>
  
  <div class="item5"><table><tr>
  <td><a href="/library/LibraryMain"><img  src='/library/resources/LOGO2.jpg'></a></td>
  <td>서울특별시 강남구 언주로 508 10~17층(역삼동, 서울상록빌딩)홈페이지 관련 문의 : multi@Library.go.kr
  <br>Copyright ⓒ multiLibrary. All rights	reserved.전화문의 : 02-111-2222, 080-111-2222(수신자 부담)</td>
  </tr></table></div>
</div>
<!-- <iframe src="http://www.w3c.org" name="a" width=500 height=400></iframe> -->

<input type="hidden" value=<%=request.getAttribute("lat") %> id='maplat'><!-- 위도 -->
<input type="hidden" value=<%=request.getAttribute("lon") %> id='maplon'><!-- 경도 -->
</body>

<script type="text/javascript">
$("#map").on('click',function(){
		//alert($("#maplat").val()+" "+$("#maplon").val())
	var ww=510;    //띄울 창의 넓이
	var wh=400;    //띄울 창의 높이
	
	var top=(screen.availHeight-wh)/4;
	var left=(screen.availWidth-ww)/2;
   // alert("새글 작성")
		window.open("/library/LibraryLocation?lat="+$('#maplat').val()+"&lon="+$('#maplon').val()+"", "window", "width="+ww+", height="+wh+", top="+top+", left="+left+", location=no, toolbar=no, menubar=no, scrollbar=no, resizable=no");
	})//function 지도 띄우기
	
 $("#free>a").on('click',function(){	
	//alert('/library/Freelist');
	$('#board').html("<iframe src='/library/Freelist' width=1050 height=900 ></iframe>")
}) 

$("#store>a").on('click',function(){	
	//alert('/library/Freelist');
	$('#board').html("<iframe src='/library/show' width=1050 height=900 ></iframe>")
}) 


 $("#studyroom>a").on('click',function(){	
	//alert('/library/Freelist');
	$('#board').html("<iframe src='/library/studyRoomMain?page=1&l_id=<%=session.getAttribute("l_id")%>' width=1050 height=900 ></iframe>")
}) 
 $("#lib>a").on('click',function(){	
	//alert('/library/Freelist');
	$('#board').html("<iframe src='<%=request.getAttribute("libraryWebsite")%>' width=1050 height=900 ></iframe>")
})

 $("#mypage>a").on('click',function(){	
	//alert('/library/Freelist');
	$('#board').html("<iframe src='/library/studyRoomMyPage' width=1050 height=900 ></iframe>")
})

 $("#logout>a").on('click',function(){	
	location.href='/library/logout';
})

$('#userpic').on("click",function(){
	 //alert("그림변경")
	    var ww=355;    //띄울 창의 넓이
		var wh=160;    //띄울 창의 높이
		
		var top=(screen.availHeight-wh)/4;
		var left=(screen.availWidth-ww)/2;
	   // alert("새글 작성")
			window.open("/library/UserPicSelect", "window", "width="+ww+", height="+wh+", top="+top+", left="+left+", location=no, toolbar=no, menubar=no, scrollbar=no, resizable=no");
		}) //아바타 변경
$('[data-toggle="tooltip"]').tooltip();  //툴팁

$(".u>h2").on("click",function(){
	var ww=510;    //띄울 창의 넓이
	var wh=400;    //띄울 창의 높이
	
	var top=(screen.availHeight-wh)/4;
	var left=(screen.availWidth-ww)/2;
   
		window.open("/library/myinfo", "window", "width="+ww+", height="+wh+", top="+top+", left="+left+", location=no, toolbar=no, menubar=no, scrollbar=no, resizable=no");
	
})
</script>
</html>