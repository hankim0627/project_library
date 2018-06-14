<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style type="text/css">
/* body
{background-color: rgb(217, 217, 217)} */
</style>
<script 
src="http://maps.google.com/maps/api/js?key=AIzaSyBuMhc367ia1i3QryuC2LLtWT5WnSSNwF8"></script> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script >
$(document).ready (
function(){
 var watchID = navigator.geolocation.watchPosition(success, error,
				{enableHighAccuracy:true, maximumAge:0});

   }
);
function success(p){
	//var lat = p.coords.latitude;
	//var lat = '37.497851';
	//var lon = p.coords.longitude;
	//var lon = '127.003702';
	//$('#result').html("나의 위도  : "+lat+" 나의 경도 : "+lon);
	//37.497851, 127.003702
	var lat=$("#lat").val()
	var lon=$("#lon").val()
	//alert(lat+" "+lon)
	var center =new google.maps.LatLng(lat,lon);
	map = new google.maps.Map(
	document.getElementById('map'),
	{mapTypeId:google.maps.MapTypeId.ROADMAP,
		zoom :16, center : center}		
	);
	
	marker = new google.maps.Marker({position:center, title:"국립 중앙 도서관",map:map});
	
}
function error(e){
	e('#result').html(e.code+" : "+e.message);
}




</script>
</head>
<body>
<input type="hidden" value='<%=request.getAttribute("lat") %>' id=lat>
<input type="hidden" value='<%=request.getAttribute("lon") %>' id=lon>
<div id="result" > </div>
<div id='map' style="width: 500px; height: 380px">
 맵 로딩 예정입니다. </div>
</body>
</html>