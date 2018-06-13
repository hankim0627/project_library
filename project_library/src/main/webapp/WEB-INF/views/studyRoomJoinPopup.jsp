<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="/library/resources/jquery-3.2.1.min.js"></script>
<meta charset=UTF-8>
<title>스터디룸 참여 신청</title>
</head>
<body>
	<input type="hidden" id="sr_num" value=<%=request.getParameter("sr_num") %>>

	<div id="joinConfirm">
		<p>받는 사람: <%=request.getParameter("sr_m_name") %></p>
		<p><textarea id="joinContent" placeholder="내용을 입력해주세요"></textarea></p> 
		<p><input type="button" id="joinSubmit" value="신청">
			<input type="button" id="joinCancel" onclick="self.close();" value="취소"></p>
	</div>
</body>
<script>
	$('#joinSubmit').on('click', function(){
		var sr_num = $('#sr_num').val();
		var sr_join_content = $('#joinContent').val();
		
		$.ajax({
			type: 'post',
			data: {'sr_num':sr_num, 'sr_join_content':sr_join_content},
			url: '/library/studyRoomJoinRequest',
			dataType : 'text',
			success:function(data){	
				 if(data==0){
					alert("스터디룸 신청에 성공했습니다.");
				} else if(data==1){
					alert("이미 신청한 스터디룸입니다.");
				} else if(data==2){
					alert("스터디룸 신청에 문제가 발생했습니다.");
				} 
				//opener.parent.location.href='/library/studyRoomDetail?sr_num=' + sr_num;
				self.close(); 
			}
		});
	});
</script>
</html>