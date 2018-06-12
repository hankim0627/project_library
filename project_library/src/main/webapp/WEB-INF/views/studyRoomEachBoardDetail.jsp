<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="multi.project.library.*"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<script src="/library/resources/jquery-3.2.1.min.js"></script>
<meta charset=UTF-8>
<title>Insert title here</title>
</head>
<body>

<a href="/library/studyRoomMyPage">마이페이지 가기</a>
	
	<!-- ===================================글 상세 내용 !!==================== -->
	<div>
		<table>
			<tr><td>${studyRoomDetail.getSr_num() } ${studyRoomDetail.getSr_cate()} ${studyRoomDetail.getSr_title() }	${studyRoomDetail.getSr_date() }</td></tr>
			<tr><td>${studyRoomDetail.getM_name() }</td></tr>		
			<tr><td>${studyRoomDetail.getSr_content() }</td></tr>
		</table>
		<p>댓글수  <span id="studyRoomCommentCntId">${studyRoomCommentCnt }</span></p>
		<p>조회수 ${studyRoomDetail.getSr_view_num() }</p>
	</div>
	<!-- ================================================================= -->

	
	
	<!-- ========================댓글 목록 ======================-->
	<!-- ==================댓글 하나마다 리스트/table 로 !!!!============== -->
	<div>
	 	<ol id="sr_comment_add">
			<c:forEach items="${studyRoomComment }" var="list">
				
				<li id="sr_recomment_add_list${list.getSr_comment_num() }">
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
	<div>
		<input type="button" id="sr_comment_add_btn" value="댓글 더보기<c:if test="${studyRoomCommentCnt < 5 }">(0)</c:if><c:if test="${studyRoomCommentCnt >= 5 }">(${studyRoomCommentCnt-5})</c:if>" ><br>
		<input type="hidden" id="sr_comment_add_num" value="<c:if test="${studyRoomCommentCnt < 5 }">${studyRoomCommentCnt }</c:if><c:if test="${studyRoomCommentCnt >= 5 }">6</c:if>">
	</div>
	<!-- ============================================================-->
		
		
		
	<!-- ====================댓글 다는 양식!!!! ==================-->
	<div id="comment">
		<p><%=session.getAttribute("sessionid") %> 
			<input type="text" class="sr_comment_content_class" id="sr_comment_content_id" name="sr_comment_content" placeholder="댓글을 입력해주세요">
			<input type="button" id="sr_comment_btn" value="등록">
		</p>
	</div>
	<input type="hidden" id="sr_num" name="sr_num" value="${studyRoomDetail.getSr_num() }">
	<input type="hidden" id="sr_comment_id" value=<%=session.getAttribute("sessionid") %>>
	<input type="hidden" id="sr_m_id" value="${studyRoomDetail.getM_id() }">
	<input type="hidden" id="sr_m_name" value="${studyRoomDetail.getM_name() }">
	<!-- ===================================================-->
	
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
							+ "<div><div><span>"+ data[i].sr_comment_id + "</span><span>" + data[i].sr_comment_date 
							+ "</span></div><p>" + data[i].sr_comment_content +"</p></div></li>");
				}
				$('#sr_recomment_add_list' + comment_num).prepend("<input type=\"hidden\" class=\"a_recomment\" id=\"recommentcnt" + comment_num +"\" value=\"" + data.length +"\">");
			}
		});
		
		$('#sr_recomment_add_list' + comment_num).after("<li class=\"a_recomment\">"
				+ "<div><p>" + $('#sr_comment_id').val() +"<input type=\"text\" class=\" \" id=\"sr_recomment_content_id\" placeholder=\"댓글을 입력해주세요\"><input type=\"button\" id=\"sr_comment_btn_recomment\" value=\"등록\"></p></div></li>");
		$('#sr_recomment_add_list' + comment_num).append("<input type=\"hidden\" class=\"a_recomment\" id=\"recommentCommentNum\" value=\""+ comment_num +"\">");
	}	
	
	
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
								+ "<div><div><span>"+ data[i].sr_comment_id + "</span><span>" + data[i].sr_comment_date 
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
						$('#sr_comment_add').append("<li id=\"sr_recomment_add_list" + data[i].sr_comment_num + "\">"
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
						$('#sr_comment_add').append("<li id=\"sr_recomment_add_list" + data[i].sr_comment_num + "\">"
								+ "<div><div><span>"+ data[i].sr_comment_id + "</span><span>" + data[i].sr_comment_date 
								+ "</span><span><a href=\"#\" onclick=\"recommentAdd('" + data[i].sr_comment_num +"');\">답글</a></span>" 
								+ "</div><p>" + data[i].sr_comment_content +"</p></div></li>");
					}
				}
			});		// ajax 종료
	});			// function 종료

	
</script>

</html>