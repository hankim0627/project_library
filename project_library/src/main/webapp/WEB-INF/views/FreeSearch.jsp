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
.re1
{border: 0px;
/* background-color: lightgray; */}
.re2
{border: 0px;}
.ts
{background-color: gray;}
table
{border: ridge gray 6px;
 margin-bottom: 2px; 
 border-collapse: collapse;
 width: 530px; }
  .num
 {width: 75px;
 font-weight: bold;
 text-align: center;}
  .col
 {text-align: center;}
td
{border: solid black 2px; }
.tit
{ width: 300px;}
.title
{ width: 300px;}
#search
{display: inline-block;
border: gray solid 1px;
padding: 2px;}
#main
{margin: 20px;}

#userpic
{width: 30px;
height: 30px;}
#userinfo
{border: 0px;
 }
.u
{border: 0px;}
a 
{ text-decoration:none } 
/* body
{background-color: rgb(217, 217, 217)} */
.rounded-circle {
  border-radius: 50% !important;
}
a, a:hover,a:VISITED,a:ACTIVE,a:LINK
{ text-decoration:none;  
display: inline-block;
font-weight: bold;} 
</style>
</head>
<body>

<input type="hidden" id='userloginId' name=<%=session.getAttribute("member_id")%>>

<div id="main">
<h1>'${searchText}'</h1>

<div id="cont">
</div> 
<table>
<tr class='ts'><td class='col'>글번호</td><td class='col'>ID</td><td class='col'>제목</td><td class='col'>작성시간</td></tr>
<c:forEach items="${freelist2}" var="li">
<tr><td class='num'>${li.f_Num }</td>
<td id="id">${li.f_m_Id }</td>
<td class="title"  id="${li.f_Num }" ><a href="#">${li.f_Title }</a></td>
<td id="date">${li.f_Date }</td></tr></c:forEach>
</table>

<c:forEach begin='1' end='${totalpage2 }' var='page'>
<a href='/library/FreeSearch?pagenum=${page }&searchdate=${searchdate}&searchBy=${searchBy}&searchText=${searchText}'>${page }</a>
</c:forEach>

<br>

<form name="Ser" action="/library/FreeSearch/" method="post">
<div id="search" class="search" >
<div class="input-group">
<select class="form-control"name="searchdate" id="searchdate" style='width:160px'>
<option value="all">전체기간</option>
<option value="1d">최근하루</option>
<option value="1w">최근일주일</option>
<option value="1m">최근한달</option>
</select>
<select class="form-control"name="searchBy" id="searchBy" style='width:160px'>
<option value="0">제목+내용</option>
<option value="1">작성자</option>
<option value="2">제목</option>
</select>
      <input type="text" class="form-control" placeholder="Search" name="searchText" id="searchText" style='width:170px'>
      <button class="btn btn-default" type="submit"><i class="glyphicon glyphicon-search"></i></button>
    </div>
</div></form>
<form  action="/library/Freelist/">
 <input type="submit" value="자유게시판" id="fr"> 
 </form>
</div>
</body>



 <script>

 var userid=$("#userloginId").prop("name");//세션으로 받아온 유저 아이디값
 	$(".title").on("click",function(){
 		var result=""
		var num=$(this).prop("id");
 		$.ajax({//작성글 내용 보기
	    	url:'/library/FreeSelectlist',
	    	type:'post',
	    	data:{'num': num},
	    	success:function(server){
	    		if(server.f_m_Id==userid){
		    		 result= 
		    			"<table class='re'><tr class='ts'><td class='col'>글번호</td><td class='col'>ID</td><td class='col'>제목</td><td class='col'>작성시간</td></tr>"+
		    			"<tr><td class='num'>"+server.f_Num+"</td>"+
		  		        "<td>"+server.f_m_Id+"</td>"+
		  		        "<td class='tit'>"+server.f_Title+"</td>"+
		  		        "<td>"+server.f_Date+"</td></tr>"+
		  		        "<tr><td>내용<br><input type='button' value='댓글보기' id='"+server.f_Num+"' class='reply'></td>"+//댓글보기 버튼
		  		        "<td  colspan='2'>"+server.f_Content+"</td><td>"+
		  		        "<form action='/library/FreeContDelete2'>Pw : <input type='password' name='password' style='width:30px'><input type='submit' value='삭제'>"+
		  		        "<input type='hidden' name='freeNumber' value="+server.f_Num+"></form></td></tr></table>";
		  		      $("#cont").html(result);   	
		    		}else{
		    		result= 
		    			"<table class='re'><tr class='ts'><td class='col'>글번호</td><td class='col'>ID</td><td class='col'>제목</td><td class='col'>작성시간</td></tr>"+
		    			"<tr><td class='num'>"+server.f_Num+"</td>"+
		  		        "<td>"+server.f_m_Id+"</td>"+
		  		        "<td class='tit'>"+server.f_Title+"</td>"+
		  		        "<td>"+server.f_Date+"</td></tr>"+
		  		        "<tr><td>내용<br><input type='button' value='댓글보기' id='"+server.f_Num+"' class='reply'></td>"+//댓글보기 버튼
		  		        "<td  colspan='2'>"+server.f_Content+"</td><td></td>"+
		  		        "</tr></table>";
		  		      $("#cont").html(result);   
		    		}
 	            
	    	}//success
	    });//ajax 글 내용보기
 	});//function 글 내용보기
  	
 	$('#cont').on('click',(".reply"),function(){
		 // alert($('.reply').val())
		 var result2=""
		 var num2=$(this).prop("id");
		 $.ajax({//댓글 보기
	    	url:'/library/ReplyView',
	    	type:'post',
	    	data:{'num': num2},
	    	//dataType:'text',
	    	success:function(server2){
		if($('.reply').val()=="댓글보기"){
			$('.reply').val("댓글접기")
			var insertReply="<tr class='retr'><td class='re1'><input type='submit' value='댓글입력' id='"+num2 +"'class='insertReply'>"
              +"</td><td colspan='3' class='re2'>댓글 : <input type='text' id='replyCon' class='replyCon'>"
              +" pw : <input id='replyPw' class='replyPw' type='password' style='width:30px'></td></tr>";
	          $(".re").html($(".re").html() +  insertReply);
	for(var i=0;i<server2.length;i++){
				if(server2[i].fr_m_Id==userid){ 
				var deleteReply=server2[i].fr_Num
				
			result2 = 
				"<tr class='retr'><td class='re1'></td><td class='re2'>"
				+"<img alt='댓글' src='/library/resources/reply.jpg'></td><td class='re2'>"
				+"<form action='/library/ReplyDelete2' method='post'>"+server2[i].fr_Content
				+"<input class='deletebtn'name='deleteReply'type='image' value='"+deleteReply+"' src='/library/resources/xbutton.png' width='13' height='13'>"
				+"<input type='password' name='deletePw' style='width:30px'></form>"//댓글삭제
				+"</td><td class='re2'>"
				+"<img alt='이모티콘' class='rounded-circle' src='/library/resources/"+server2[i].m_Pic+"' width='17' height='17'>"
				+server2[i].fr_m_Id+"</td></tr>";
				
			$(".re").html($(".re").html() +  result2);
			
			}else{
			result2=
				"<tr class='retr'><td class='re1'></td><td class='re2'>"
				+"<img alt='댓글' src='/library/resources/reply.jpg'></td><td class='re2'>"
				+server2[i].fr_Content
				+"</td><td class='re2'>"
				+"<img alt='이모티콘' class='rounded-circle' src='/library/resources/"+server2[i].m_Pic+"' width='17' height='17'>"
				+server2[i].fr_m_Id+"</td></tr>";
				$(".re").html($(".re").html() +  result2);
       					
   	    			}
   	    		}//로그인한 아이디가 작성한 리플 판별
	    			//$(".re").append(result);
		}else if($('.reply').val()=="댓글접기"){
			//alert("ㅎㅇ")
			$('.retr').parent().remove()//새로 생성된 댓글 tr의 부모인 tbody부터 자식까지 삭제
			$('.reply').val("댓글보기")
		}
	    		         }//success         
		            });//ajax 해당글의 댓글보기          
		    })//function해당 글의 댓글보기

 	
		    $('#cont').on('click',(".insertReply"),function(){  
		 	   var replyCon=$('.replyCon').val()//리플 내용
		 	   var replyPw=$('.replyPw').val()//리플 비번
		 	   var num3=$(this).prop("id");//게시물 아이디
		 	   //$('#replyPw')
		        //alert("hihi")
		 	   //alert(userid+" "+$('.replyCon').val()+" "+$('.replyPw').val())
		 	   if(replyCon!=""&&replyPw!=""){
		 		  //alert("입력!")
		 		   
		 		   
		 		$('.retr').parent().remove()
		  		var result3=""
		 		//var num=$(this).prop("id");
		  		$.ajax({//작성글 내용 보기
		 	    	url:'/library/InsertReply',
		 	    	type:'post',
		 	    	data:{'num':num3,'userid':userid,'replyCon': replyCon,'replyPw' : replyPw},
		 	    	success:function(server3){
		 	    		//alert(num2+" "+ userid+" "+replyCon+" "+replyPw)
		 	    		var insertReply="<tr class='retr'><td class='re1'><input type='submit' value='댓글입력' class='insertReply'>"
		 		                +"</td><td colspan='3' class='re2'>댓글 : <input type='text' id='replyCon' class='replyCon'>"
		 		                +" pw : <input id='replyPw' class='replyPw' type='password' style='width:30px'></td></tr>";
		 			          $(".re").html($(".re").html() +  insertReply);
		 			for(var i=0;i<server3.length;i++){
		 	    				if(server3[i].fr_m_Id==userid){ 
		 	    				var deleteReply=server3[i].fr_Num
		 	    				
		 	    			result3 = 
		     					"<tr class='retr'><td class='re1'></td><td class='re2'>"
		     					+"<img alt='댓글' src='/library/resources/reply.jpg'></td><td class='re2'>"
		     					+"<form action='/library/ReplyDelete2' method='post'>"+server3[i].fr_Content
		     					+"<input class='deletebtn'name='deleteReply'type='image' value='"+deleteReply+"' src='/library/resources/xbutton.png' width='13' height='13'>"
		     					+"<input type='password' name='deletePw' style='width:30px'></form>"
		     					+"</td><td class='re2'>"
		     					+"<img alt='이모티콘' class='rounded-circle' src='/library/resources/"+server3[i].m_Pic+"' width='17' height='17'>"
		     					+server3[i].fr_m_Id+"</td></tr>";
		     					
		 	    			$(".re").html($(".re").html() +  result3);
		 	    			
		 	    			}else{
		 	    			result3=
		 	    				"<tr class='retr'><td class='re1'></td><td class='re2'>"
		     					+"<img alt='댓글' src='/library/resources/reply.jpg'></td><td class='re2'>"
		     					+server3[i].fr_Content
		     					+"</td><td class='re2'>"
		     					+"<img alt='이모티콘' class='rounded-circle' src='/library/resources/"+server3[i].m_Pic+"' width='17' height='17'>"
		     					+server3[i].fr_m_Id+"</td></tr>";
		     					$(".re").html($(".re").html() +  result3);
		     					
		 	    			}
		 	    		}
		 	  		}//success
		 	    });//ajax 댓글 입력
		  	
		 		   
		 	   }else{
		 		   alert("내용과 비밀번호를 입력하세요")
		 	   }
		 	})//function 댓글 입력 
 	
</script>
</html>