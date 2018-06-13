<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="multi.project.library.*"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<style>

table{
	width: 80%;
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
div.commentForm{
	vertical-align: middle;
}
div.goList{
	text-align: center;
}
ol.olForm{
	width: 80%;
	list-style: none;
	padding-left: 0px;
}
li.liForm{
	border-top: 1px solid #BDBDBD;
	border-bottom: 1px solid #BDBDBD;
	font-size: 13px;
}
li.a_recomment{
	border-top: 1px solid #BDBDBD;
	border-bottom: 1px solid #BDBDBD;
	font-size: 13px;
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
</style>
<script src="/library/resources/jquery-3.2.1.min.js"></script>
<meta charset=UTF-8>
<title>Insert title here</title>
</head>
<body>

<h4>스터디룸 게시글</h4>	
	<!-- ===================================글 상세 내용 !!==================== -->
	<div>
		<table>
			<tr><td class="middleText" width="7%">${studyRoomDetail.getSr_num() }</td><td class="middleText" width="16%">[${studyRoomDetail.getSr_cate()}]</td><td width="38%">${studyRoomDetail.getSr_title() }</td><td class="middleText" width="20%">${studyRoomDetail.getSr_date() }</td>
				<td class="middleText"><a href="#" onclick="editPwCheck('${studyRoomDetail.getSr_pw()}');" style="${studyRoomEdit}">수정</a></td><td class="middleText"><a href="#" onclick="delPwCheck('${studyRoomDetail.getSr_pw()}');" style="${studyRoomEdit}">삭제</a></td></tr>
			<tr><td style="font-weight: bold;">작성자</td><td colspan="5" >${studyRoomDetail.getM_name() }</td></tr>		
			<tr><td colspan="6" height="300px">${studyRoomDetail.getSr_content() }</td></tr>
			<tr><td colspan="4"></td><td>댓글  <span id="studyRoomCommentCntId">${studyRoomCommentCnt }</span></td><td>조회 ${studyRoomDetail.getSr_view_num() }</td></tr>
		</table>
	</div>
	<!-- ================================================================= -->

	
	
	<!-- ========================댓글 목록 ======================-->
	<!-- ==================댓글 하나마다 리스트/table 로 !!!!============== -->
	<div>
	 	<ol class="olForm" id="sr_comment_add">
			<c:forEach items="${studyRoomComment }" var="list">
				
				<li class="liForm" id="sr_recomment_add_list${list.getSr_comment_num() }">
					<div>
						<div>
							<span>${list.getSr_comment_id() }</span>
							<span>${list.getSr_comment_date()}</span>
							<span><a href="#" onclick="recommentAdd('${list.getSr_comment_num() }');">답글</a></span>		<!-- 답글 옆에 답글 갯수 띄우고 답글 누르면 답글 + 답글 쓰는 창 띄우기 !! -->
						</div>
						<p>${list.getSr_comment_content() }</p>
					</div>
				</li>		 		
			</c:forEach>
		</ol>
	</div>
		<!-- 답글 눌러서 생긴 li 는 class a_recomment로 만들기!! recomment remove, append로 답글 추가/삭제 하기 -->
	<!-- ======================================================-->



	<!-- ===============댓글 더보기 눌렀을 경우============================== -->
	<div style="padding: 10px; position:relative; left: 30px;">
		<input type="button" id="sr_comment_add_btn" value="댓글 더보기<c:if test="${studyRoomCommentCnt < 5 }">(0)</c:if><c:if test="${studyRoomCommentCnt >= 5 }">(${studyRoomCommentCnt-5})</c:if>" ><br>
		<input type="hidden" id="sr_comment_add_num" value="<c:if test="${studyRoomCommentCnt < 5 }">${studyRoomCommentCnt }</c:if><c:if test="${studyRoomCommentCnt >= 5 }">6</c:if>">
	</div>
	<!-- ============================================================-->
		
		
		
	<!-- ====================댓글 다는 양식!!!! ==================-->
	<div class="commentForm" id="comment" style="position:relative; left: 30px;">
		<%-- <span style="display: inline-block; position: relative; bottom: 60px;"><%=session.getAttribute("member_id") %></span> --%>
			<textarea class="sr_comment_content_class" id="sr_comment_content_id" name="sr_comment_content" placeholder="댓글을 입력해주세요" rows="5" cols="80" placeholder="내용을 입력하세요"></textarea>
			<!-- <input type="text" class="sr_comment_content_class" id="sr_comment_content_id" name="sr_comment_content" placeholder="댓글을 입력해주세요"> -->
			<input style="height: 80px; width:70px; position:relative; bottom: 35px;" type="button" id="sr_comment_btn" value="등록">
	</div>
	<input type="hidden" id="sr_num" name="sr_num" value="${studyRoomDetail.getSr_num() }">
	<input type="hidden" id="sr_comment_id" value=<%=session.getAttribute("member_id") %>>
	<input type="hidden" id="sr_m_id" value="${studyRoomDetail.getM_id() }">
	<input type="hidden" id="sr_m_name" value="${studyRoomDetail.getM_name() }">
	<!-- ===================================================-->
	
	
	<!-- 남이 올린 글만 신청 태그 보임-->
	<div class="goList"><a href="#" id="studyRoomJoin" style="${studyRoomJoinRequestDisplay}">스터디룸 신청하기</a>
	<input class="goList" type="button" onclick="history.back();" value="목록"></div>
</body>


<script>

	// 답글 버튼 클릭 시
	function recommentAdd(comment_num){
		var sr_num = $('#sr_num').val();
		$('.a_recomment').remove();
		$.ajax({
			type: 'post',		// 글 번호, 보여줄 댓글 갯수, 대댓글일 경우 댓글 번호/아닐경우 -1, 댓글단 아이디, 댓글 내용
			data: {'sr_num':sr_num, 'add_num_start':-1, 'add_num_end':-1, 'sr_comment_num':comment_num},
			url: '/library/studyRoomRecommentAdd',
			dataType : 'json',
			success:function(data){	
				for(var i=0; i<data.length; i++){
					$('#sr_recomment_add_list' +comment_num).after("<li class=\"a_recomment\">"
							+ "<div><div><span>└</span><span>   "+ data[i].sr_comment_id + "</span><span>" + data[i].sr_comment_date 
							+ "</span></div><p>   " + data[i].sr_comment_content +"</p></div></li>");
				}
				$('#sr_recomment_add_list' + comment_num).prepend("<input type=\"hidden\" class=\"a_recomment\" id=\"recommentcnt" + comment_num +"\" value=\"" + data.length +"\">");
			}
		});
		
		$('#sr_recomment_add_list' + comment_num).after("<li class=\"a_recomment\">"
				+ "<div><p><textarea id=\"sr_recomment_content_id\" placeholder=\"댓글을 입력해주세요\" rows=\"5\" cols=\"80\" placeholder=\"내용을 입력하세요\"></textarea>"
				+ "<input style=\"height: 80px; width:70px; position:relative; bottom: 35px;\" type=\"button\" id=\"sr_comment_btn_recomment\" value=\"등록\"></p></div></li>");
		$('#sr_recomment_add_list' + comment_num).append("<input type=\"hidden\" class=\"a_recomment\" id=\"recommentCommentNum\" value=\""+ comment_num +"\">");
	}	
	
	/* " + $('#sr_comment_id').val() +" */
	// 답글에서 등록 버튼 눌렀을 때
	$("body").on('click', '#sr_comment_btn_recomment', 
		function(){
			var sr_comment_num = $('#recommentCommentNum').val();		// ---> sr_comment_num의 값임 !!
			var add_num_start = parseInt($('#recommentcnt' + sr_comment_num).val()) + parseInt(1);
			var add_num_end = parseInt($('#recommentcnt' + + sr_comment_num).val()) + parseInt(1);
			$('#recommentcnt' + sr_comment_num).val(add_num_end);
			var sr_num = $('#sr_num').val();
			var sr_comment_id = $('#sr_comment_id').val();
			var sr_comment_content = $('#sr_recomment_content_id').val();		
			
			$.ajax({
				type: 'post',		// 글 번호, 보여줄 댓글 갯수, 대댓글일 경우 댓글 번호/아닐경우 -1, 댓글단 아이디, 댓글 내용
				data: {'sr_num':sr_num, 'add_num_start':add_num_start, 'add_num_end':add_num_end, 'sr_comment_num':sr_comment_num, 'sr_comment_id':sr_comment_id, 'sr_comment_content':sr_comment_content },
				url: '/library/studyRoomCommentWrite',
				dataType : 'json',
				success:function(data){	
					for(var i=0; i<data.length; i++){
						
						$('#sr_recomment_add_list' +sr_comment_num).after("<li class=\"a_recomment\">"
								+ "<div><div><span>└</span><span>   "+ data[i].sr_comment_id + "</span><span>" + data[i].sr_comment_date 
								+ "</span></div><p>" + data[i].sr_comment_content +"</p></div></li>");
					}
					
				}
			});
			$('#sr_recomment_content_id').val("");
			
	});
	
	
	
	

	// sr_comment_num은 초기값 -1, 그냥 댓글일 경우에는 댓글 sequence/ 대댓글이면 댓글의 comment_num 따와서 recomment 테이블에 들어감
	/* (int sr_num, int sr_recomment_flag, String sr_comment_id, int sr_recomment_flag, String sr_comment_content){ */
	// 젤 밑에 댓글 등록 클릭 시
	$("body").on('click', '#sr_comment_btn',
		function(){
			var add_num_start = $('#sr_comment_add_num').val();		// 다음 코멘트 시작 지점
			var add_num_end = parseInt($('#studyRoomCommentCntId').html())+parseInt(1);	// 맨 마지막 코멘트 시작 지점, 전체 댓글에 댓글 달면 전체 댈듯 보이도록 하기 위해서
			$('#studyRoomCommentCntId').html((parseInt(add_num_end)));		
			$('#sr_comment_add_num').val((parseInt(add_num_end) + parseInt(1)));
			$('#sr_comment_add_btn').val("댓글 더보기(0)");

			var sr_num = $('#sr_num').val();
			var sr_comment_id = $('#sr_comment_id').val();
			var sr_comment_content = $('#sr_comment_content_id').val();
			
			/* alert(add_num_start);
			alert(add_num_end); */
			
			$.ajax({
				type: 'post',		// 글 번호, 보여줄 댓글 갯수, 대댓글일 경우 댓글 번호/아닐경우 -1, 댓글단 아이디, 댓글 내용
				data: {'sr_num':sr_num, 'add_num_start':add_num_start, 'add_num_end':add_num_end, 'sr_comment_num':-1, 'sr_comment_id':sr_comment_id, 'sr_comment_content':sr_comment_content },
				url: '/library/studyRoomCommentWrite',
				dataType : 'json',
				success:function(data){	
					for(var i=0; i<data.length; i++){
						$('#sr_comment_add').append("<li class=\"liForm\" id=\"sr_recomment_add_list" + data[i].sr_comment_num + "\">"
								+ "<div><div><span>"+ data[i].sr_comment_id + "</span><span>" + data[i].sr_comment_date 
								+ "</span><span><a href=\"#\" onclick=\"recommentAdd('" + data[i].sr_comment_num +"');\">답글</a></span>" 
								+ "</div><p>" + data[i].sr_comment_content +"</p></div></li>");
					}
					$('#sr_comment_content_id').val("");
				}
			});
	});
	
	// 댓글 더보기 클릭 시 json
	$('#sr_comment_add_btn').on('click', 
		function(){
			var sr_num = $('#sr_num').val();					// 글번호 받아오기
			var add_num_start = $('#sr_comment_add_num').val();		/// 앞으로 추가할 댓글의 rownum 번호 받아오기
			var add_num_end = parseInt(add_num_start) + parseInt(4);
			var sr_comment_cnt = ${studyRoomCommentCnt };
			
			if(parseInt(sr_comment_cnt)-parseInt(add_num_start)<=5){
				//alert(parseInt(add_num_start)+parseInt(sr_comment_cnt)-parseInt(add_num_start)+parseInt(1));
				var sr_comment_add_btn_update = "댓글 더보기(0)";
				$('#sr_comment_add_num').val(parseInt(add_num_start)+parseInt(sr_comment_cnt)-parseInt(add_num_start)+parseInt(1));
			} else {
				var btn_update = parseInt(sr_comment_cnt)-parseInt(5)-parseInt(add_num_start)+parseInt(1);
				var sr_comment_add_btn_update = "댓글 더보기(" + btn_update + ")";
				$('#sr_comment_add_num').val((parseInt(add_num_start)+parseInt(5)));
			}
			$('#sr_comment_add_btn').val(sr_comment_add_btn_update);
			
			$.ajax({
				type: 'post',
				data: {'sr_num':sr_num, 'add_num_start':add_num_start, 'add_num_end':add_num_end},
				url: '/library/studyRoomCommentAdd',
				dataType : 'json',
				success:function(data){				
					for(var i=0; i<data.length; i++){
						$('#sr_comment_add').append("<li class=\"liForm\" id=\"sr_recomment_add_list" + data[i].sr_comment_num + "\">"
								+ "<div><div><span>"+ data[i].sr_comment_id + "</span><span>" + data[i].sr_comment_date 
								+ "</span><span><a href=\"#\" onclick=\"recommentAdd('" + data[i].sr_comment_num +"');\">답글</a></span>" 
								+ "</div><p>" + data[i].sr_comment_content +"</p></div></li>");
					}
				}
			});		// ajax 종료
	});			// function 종료
	

 	$('#studyRoomJoin').on('click', 
		function(){
			var url = "/library/studyRoomJoinPopup?sr_num=" + $('#sr_num').val() + "&sr_m_name=" +$('#sr_m_name').val();
			var windowObj = window.open(url,"studyRoomJoinPopup", "width=500, height=300, left=100, top=50");
			windowObj.focus();
		}
	); 
	
	function editPwCheck(sr_pw){
		var inputString = prompt("비밀번호를 입력하세요");
		if(inputString == sr_pw){		// 글 수정할 경우 
			//location.href = '/library/studyRoomEdit?sr_num=' + $('#sr_num').val();
		} else {
			alert("비밀번호가 틀렸습니다.");
		}
	}
	
	function delPwCheck(sr_pw){
		var inputString = prompt("비밀번호를 입력하세요");
		if(inputString == sr_pw){
			var result = confirm("정말로 삭제하시겠습니까?");
			if(result){		// 삭제할 경우
				location.href = '/library/studyRoomDelete?sr_num=' + $('#sr_num').val();
			}
		} else {
			alert("비밀번호가 틀렸습니다.");
		}
	}
	
</script>

</html>