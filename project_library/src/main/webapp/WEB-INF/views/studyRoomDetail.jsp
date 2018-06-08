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
	<table>
		<tr><td>${studyRoomDetail.getSr_num() } ${studyRoomDetail.getSr_cate()} ${studyRoomDetail.getSr_title() }	${studyRoomDetail.getSr_date() }</td></tr>
		<tr><td>${studyRoomDetail.getM_name() }</td></tr>		
		<tr><td>${studyRoomDetail.getSr_content() }</td></tr>
	</table>
	
	댓글수  <span id="studyRoomCommentCntId">${studyRoomCommentCnt }</span>
	조회수 ${studyRoomDetail.getSr_view_num() }
	<!-- ===================================글 상세 내용 !!==================== -->
	
	
	
	
	<!-- ========================댓글 목록 ======================-->
	 	<ol id="sr_comment_add">
			<c:forEach items="${studyRoomComment }" var="list">
				<!-- ==================댓글 하나마다 리스트/table 로 !!!!============== -->
				<li>
					<table id="sr_recomment_add_list${list.getSr_comment_num() }">
						<tr>
							<td>${list.getSr_comment_id() }</td>
							<td>${list.getSr_comment_date()}</td>
						</tr>
						<tr>
							<td>${list.getSr_comment_content() }</td>
						</tr>																																<!-- (this.param)으로 값 불러오기 -->
						<c:if test="${list.getSr_recomment_flag() ne -1}"><tr id="sr_recomment_add${list.getSr_comment_num() }"><td><input type="button" id="sr_recomment_add${list.getSr_comment_num() }" onclick="return recommentAdd('${list.getSr_comment_num() }');" value="답글 보기"></td></tr></c:if>
						<c:if test="${list.getSr_recomment_flag() eq -1}"><tr id="sr_recomment_write${list.getSr_comment_num() }"><td><input type="button" id="sr_recomment_write${list.getSr_comment_num() }" onclick="return recommentWrite('${list.getSr_comment_num() }');" value="답글 쓰기" ></td></tr></c:if>
					</table>
				</li>
			</c:forEach>
		</ol>
	<!-- ========================댓글 목록 ======================-->




	<!-- ===============댓글 더보기 눌렀을 경우============================== -->
	<input type="button" id="sr_comment_add_btn" value="댓글 더보기<c:if test="${studyRoomCommentCnt < 5 }">(0)</c:if><c:if test="${studyRoomCommentCnt >= 5 }">(${studyRoomCommentCnt-5})</c:if>" ><br>
	<input type="hidden" id="sr_comment_add_num" value="6">
	<!-- ===============댓글 더보기 눌렀을 경우============================== -->
		
		
		
	<!-- ====================댓글 다는 양식!!!! ==================-->
	<span id="comment">
	<%=session.getAttribute("sessionid") %> <input type="text" class="sr_comment_content_class" id="sr_comment_content_id" name="sr_comment_content" placeholder="댓글을 입력해주세요">
	<input type="hidden" id="sr_num" name="sr_num" value="${studyRoomDetail.getSr_num() }">
	<input type="hidden" id="sr_comment_id" value=<%=session.getAttribute("sessionid") %>>
	<input type="button" id="sr_comment_btn" value="등록"><br>
	</span>
	<!-- ====================댓글 다는 양식!!!! ==================-->
	
	
	<a href="/library/studyRoomMyPage" id="studyRoomJoinBtn">신청하기</a>
	
</body>



<script>
	var imsi_comment_form = $('#comment').clone().find("input[id^=sr_comment_btn]").attr("id", "sr_comment_btn_recomment").end()
												 .find("input[id^=sr_comment_content_id]").attr("id", "sr_recomment_content_id").end();
	// 답글 보기 눌렀을 때
	function recommentAdd(comment_num){
		var sr_num = $('#sr_num').val();
		$.ajax({
			type: 'post',		// 글 번호, 보여줄 댓글 갯수, 대댓글일 경우 댓글 번호/아닐경우 -1, 댓글단 아이디, 댓글 내용
			data: {'sr_num':sr_num, 'add_num_start':-1, 'add_num_end':-1, 'sr_comment_num':comment_num},
			url: '/library/studyRoomRecommentAdd',
			dataType : 'json',
			success:function(data){	
				for(var i=0; i<data.length; i++){
					$('#sr_recomment_add_list' + comment_num).append("<tr><td> --> " + data[i].sr_comment_id + "</td><td>" + 
						data[i].sr_comment_date +"</td></tr><tr><td>     " + data[i].sr_comment_content +"</td></tr>");
				}
				$('#sr_recomment_add_list' + comment_num).prepend("<tr><td><input type=\"hidden\" id=\"recommentcnt" + comment_num +"\" value=\"" + data.length +"\"></td></tr>");
			}
		});
		$('#sr_recomment_add' + comment_num).hide();
		$('#sr_recomment_add_list' + comment_num).after(imsi_comment_form);
		$('#sr_recomment_add_list' + comment_num).append("<input type=\"hidden\" id=\"recommentCommentNum\" value=\""+ comment_num +"\">");
	}
	
	// 답글 쓰기 눌렀을 때
	function recommentWrite(comment_num){
		//alert(comment_num);
		$('#sr_recomment_write' + comment_num).hide();
		$('#sr_recomment_add_list' + comment_num).prepend("<tr><td><input type=\"hidden\" id=\"recommentcnt" + comment_num +"\" value=\"0\"></td></tr>");
		$('#sr_recomment_add_list' + comment_num).after(imsi_comment_form);
		$('#sr_recomment_add_list' + comment_num).append("<input type=\"hidden\" id=\"recommentCommentNum\" value=\""+ comment_num +"\">");
	}
	
	// 답글 쓰기에서 등록 버튼 눌렀을 때
	$("body").on('click', '#sr_comment_btn_recomment', 
		function(){
			var sr_comment_num = $('#recommentCommentNum').val();		// ---> sr_comment_num의 값임 !!
			var add_num_start = parseInt($('#recommentcnt' + sr_comment_num).val()) + parseInt(1);
			var add_num_end = parseInt($('#recommentcnt' + + sr_comment_num).val()) + parseInt(1);
			$('#recommentcnt').val(parseInt(add_num_end));
			var sr_num = $('#sr_num').val();
			var sr_comment_id = $('#sr_comment_id').val();
			var sr_comment_content = $('#sr_recomment_content_id').val();		
			
			alert(sr_num);
			alert(add_num_start);
			alert(add_num_end);
			alert(sr_comment_num);
			alert(sr_comment_id);
			alert(sr_comment_content);
			
			$.ajax({
				type: 'post',		// 글 번호, 보여줄 댓글 갯수, 대댓글일 경우 댓글 번호/아닐경우 -1, 댓글단 아이디, 댓글 내용
				data: {'sr_num':sr_num, 'add_num_start':add_num_start, 'add_num_end':add_num_end, 'sr_comment_num':sr_comment_num, 'sr_comment_id':sr_comment_id, 'sr_comment_content':sr_comment_content },
				url: '/library/studyRoomCommentWrite',
				dataType : 'json',
				success:function(data){	
					for(var i=0; i<data.length; i++){
						$('#sr_recomment_add_list' + sr_comment_num).append("<tr><td> --> " + data[i].sr_comment_id + "</td><td>" + 
								data[i].sr_comment_date +"</td></tr><tr><td>     " + data[i].sr_comment_content +"</td></tr>");
					}
					$('#sr_recomment_content_id').val("");
				}
			});
			
	});

	
	
	
	
	

	// sr_comment_num은 초기값 -1, 그냥 댓글일 경우에는 댓글 sequence/ 대댓글이면 댓글의 comment_num 따와서 recomment 테이블에 들어감
	/* (int sr_num, int sr_recomment_flag, String sr_comment_id, int sr_recomment_flag, String sr_comment_content){ */
	// 젤 밑에 댓글 등록 클릭 시 불러오는 json
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
			
			$.ajax({
				type: 'post',		// 글 번호, 보여줄 댓글 갯수, 대댓글일 경우 댓글 번호/아닐경우 -1, 댓글단 아이디, 댓글 내용
				data: {'sr_num':sr_num, 'add_num_start':add_num_start, 'add_num_end':add_num_end, 'sr_comment_num':-1, 'sr_comment_id':sr_comment_id, 'sr_comment_content':sr_comment_content },
				url: '/library/studyRoomCommentWrite',
				dataType : 'json',
				success:function(data){	
					for(var i=0; i<data.length; i++){
						if(data[i].sr_recomment_flag!=-1){
							var str= "<tr id=\"sr_recomment_add" + data[i].sr_comment_num + "\"><td><input type=\"button\" id=\"sr_recomment_add" + data[i].sr_comment_num +"\" onclick=\"return recommentAdd('"+ data[i].sr_comment_num + "');\" value=\"답글 보기\"></td></tr>";
						} else if(data[i].sr_recomment_flag!==1){
							var str = "<tr id=\"sr_recomment_write" + data[i].sr_comment_num + "\"><td><input type=\"button\" id=\"sr_recomment_write" + data[i].sr_comment_num +"\" onclick=\"return recommentWrite('"+ data[i].sr_comment_num + "');\" value=\"답글 쓰기\"></td></tr>";
						}
						$('#sr_comment_add').append("<li><table id=\"sr_recomment_add_list" + data[i].sr_comment_num + "\">"
								+ "<tr><td>"+ data[i].sr_comment_id + "</td><td>" + data[i].sr_comment_date +"</td></tr>" 
								+ "<tr><td>" + data[i].sr_comment_content +"</td></tr>"
								+ "<c:set var='flag' value='"+ data[i].sr_recomment_flag + "'/>"
								+ str + "</table></li>");
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
						if(data[i].sr_recomment_flag!=-1){
							var str= "<tr id=\"sr_recomment_add" + data[i].sr_comment_num + "\"><td><input type=\"button\" id=\"sr_recomment_add" + data[i].sr_comment_num +"\" onclick=\"return recommentAdd('"+ data[i].sr_comment_num + "');\" value=\"답글 보기\"></td></tr>";
						} else if(data[i].sr_recomment_flag!==1){
							var str = "<tr id=\"sr_recomment_write" + data[i].sr_comment_num + "\"><td><input type=\"button\" id=\"sr_recomment_write" + data[i].sr_comment_num +"\" onclick=\"return recommentWrite('"+ data[i].sr_comment_num + "');\" value=\"답글 쓰기\"></td></tr>";
						}
						$('#sr_comment_add').append("<li><table id=\"sr_recomment_add_list" + data[i].sr_comment_num + "\">"
								+ "<tr><td>"+ data[i].sr_comment_id + "</td><td>" + data[i].sr_comment_date +"</td></tr>" 
								+ "<tr><td>" + data[i].sr_comment_content +"</td></tr>"
								+ "<c:set var='flag' value='"+ data[i].sr_recomment_flag + "'/>"
								+ str + "</table></li>");
					}
				}
			});		// ajax 종료
	});			// function 종료

	
	$('#studyRoomJoinBtn').on('click', 
		function(){
			 
	
		}
	);
	
	
</script>

</html>