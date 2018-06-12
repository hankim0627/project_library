<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="/library/resources/jquery-3.2.1.min.js"></script>
<meta charset=UTF-8>
<title>Insert title here</title>
</head>
<body>
	<h2>마이페이지</h2>
	<h5><a href="/library/studyRoomMain?l_id=<%=session.getAttribute("sessionlibrary")%>">◀스터디룸으로 돌아가기</a></h5>
	
	<div>
		<p>신청한 스터디룸 : <a href="#" onclick="showJoinStudyRoomWithId();">${cntJoinStudyRoomWithId}</a></p>								<!-- toggle 기능 넣기 -->
	</div>
	<div id="joinStudyRoomWithId" style="${joinDisplay}">
		<p>신청한 스터디룸 목록</p>
		<table id="joinStudyRoomConditionAdd">
			<c:forEach items="${listJoinStudyRoomWithId}" var="list">
				<tr id="joinStudyRoomConditionAdd${list.getSr_num() }">
					<td>${list.getSr_num() }</td>
					<td>${list.getSr_cate() }</td>
					<td><a href="/library/studyRoomDetail?sr_num=${list.getSr_num() }"> ${list.getSr_title() }</a></td>
					<td>${list.getM_name() }</td>
					<td>${list.getSr_date() }</td>
					<td>${list.getSr_view_num() }</td>
					<td><a href="#" onclick="joinStudyRoomCondition('${list.getSr_num() }');">스터디신청현황</a></td>
				</tr>
			</c:forEach>
		</table> 
		<c:forEach var="page" begin="1" end="${joinTotalPage}">
				<a href="/library/studyRoomMyPage?JoinPage=${page }&JoinDisplay=1">${page }</a>
		</c:forEach>
	</div>
	
	========================================================
	
	<div>
		<p>참여 중인 스터디룸: ${cntMyJoinStudyRoonWithId}</p>
	</div>
	<div>
		<p>개설한 스터디룸 : <a href="#" onclick="showMakeStudyRoomWithId();">${cntMakeStudyRoomWithId}</a></p>					<!-- toggle 기능 넣기 -->
	</div>
	<div id="makeStudyRoomWithId" style="${makeDisplay}">
		<p>개설한 스터디룸 목록</p>
		<table id="makeStudyRoomConditionAdd">
			<c:forEach items="${listMakeStudyRoomWithId}" var="list">
				<tr id="makeStudyRoomConditionAdd${list.getSr_num() }">
					<td>${list.getSr_num() }</td>
					<td>${list.getSr_cate() }</td>
					<td><a href="/library/studyRoomDetail?sr_num=${list.getSr_num() }"> ${list.getSr_title() }</a></td>
					<td>${list.getM_name() }</td>
					<td>${list.getSr_date() }</td>
					<td>${list.getSr_view_num() }</td>
					<td><a href="#" onclick="makeStudyRoomCondition('${list.getSr_num() }');">스터디신청현황</a></td>
					<td><a href="#" onclick="goStudyRoomBoard('${list.getSr_num() }');">스터디룸 가기</a></td>
				</tr>
			</c:forEach>
		</table>
		<c:forEach var="page" begin="1" end="${makeTotalPage}">
			<a href="/library/studyRoomMyPage?MakePage=${page }&MakeDisplay=1">${page }</a>
		</c:forEach>
	</div>

	<div>
		<p>신청한 스터디룸 : <a href="#" onclick="showEnterStudyRoomWithId();">${cntEnterStudyRoomWithId}</a></p>								<!-- toggle 기능 넣기 -->
	</div>
	<div id="enterStudyRoomWithId" style="${enterDisplay}">
		<p>신청한 스터디룸 목록</p>
		<table>
			<c:forEach items="${listEnterStudyRoomWithId}" var="list">
				<tr>
					<td>${list.getSr_num() }</td>
					<td>${list.getSr_cate() }</td>
					<td><a href="/library/studyRoomDetail?sr_num=${list.getSr_num() }"> ${list.getSr_title() }</a></td>
					<td>${list.getM_name() }</td>
					<td>${list.getSr_date() }</td>
					<td>${list.getSr_view_num() }</td>
					<td><a href="#" onclick="goStudyRoomBoard('${list.getSr_num() }');">스터디룸 가기</a></td>
				</tr>
			</c:forEach>
		</table> 
		<c:forEach var="page" begin="1" end="${enterTotalPage}">
				<a href="/library/studyRoomMyPage?enterPage=${page }&enterDisplay=1">${page }</a>
		</c:forEach>
	</div>
</body>

<script>
	function showMakeStudyRoomWithId(){
		$('#makeStudyRoomWithId').toggle();
	}
	function showJoinStudyRoomWithId(){
		$('#joinStudyRoomWithId').toggle();
	}
	function showEnterStudyRoomWithId(){
		$('#enterStudyRoomWithId').toggle();
	}
	function makeStudyRoomCondition(sr_num){
		$('.makeStudyRoomConditionMember').remove();
		$.ajax({
			type: 'post',		// 글 번호, 보여줄 댓글 갯수, 대댓글일 경우 댓글 번호/아닐경우 -1, 댓글단 아이디, 댓글 내용
			data: {'sr_num':sr_num},
			url: '/library/makeStudyRoomCondition',
			dataType : 'json',
			success:function(data){
				if(data.length==0){
					$('#makeStudyRoomConditionAdd' + sr_num).after("<tr class=\"makeStudyRoomConditionMember\"><td>신청한 회원이 없습니다.</td></tr>");
				} else {
					for(var i=0; i<data.length; i++){
						if(data[i].sr_join_flag == 0){
							$('#makeStudyRoomConditionAdd' + sr_num).after("<tr class=\"makeStudyRoomConditionMember\">"
									+ "<td>"+ data[i].m_name + "</td><td>" + data[i].sr_join_content + "</td>"
									+ "<td><input type=\"button\" id=\"joinSubmitOK\" onclick=\"joinStudyRoomSubmit(1);\" value=\"수락\"><input type=\"button\" id=\"joinSubmitNO\" onclick=\"joinStudyRoomSubmit(2);\" value=\"거절\"></td>"
									+ "<td><input type=\"hidden\" id=\"joinSubmit_m_id\" value=\"" + data[i].m_id +"\">"
									+ "<input type=\"hidden\" id=\"joinSubmit_sr_num\" value=\"" + sr_num +"\"></td></tr>");
						} else if(data[i].sr_join_flag == 1){
							$('#makeStudyRoomConditionAdd' + sr_num).after("<tr class=\"makeStudyRoomConditionMember\">"
									+ "<td>"+ data[i].m_name + "</td><td>" + data[i].sr_join_content + "</td>"
									+ "<td>수락함</td></tr>");
						} else if(data[i].sr_join_flag == 2){
							$('#makeStudyRoomConditionAdd' + sr_num).after("<tr class=\"makeStudyRoomConditionMember\">"
									+ "<td>"+ data[i].m_name + "</td><td>" + data[i].sr_join_content + "</td>"
									+ "<td>거절함</td></tr>");
						}
					}
				}
			}
		});
		
	}
	function joinStudyRoomCondition(sr_num){
		$('.joinStudyRoomConditionMember').remove();
		$.ajax({
			type: 'post',		// 글 번호, 보여줄 댓글 갯수, 대댓글일 경우 댓글 번호/아닐경우 -1, 댓글단 아이디, 댓글 내용
			data: {'sr_num':sr_num},
			url: '/library/joinStudyRoomCondition',
			dataType : 'json',
			success:function(data){
				if(data.length==0){
					$('#joinStudyRoomConditionAdd' + sr_num).after("<tr class=\"joinStudyRoomConditionMember\"><td>신청한 회원이 없습니다.</td></tr>");
				} else {
					for(var i=0; i<data.length; i++){
						if(data[i].sr_join_flag == 0){
							$('#joinStudyRoomConditionAdd' + sr_num).after("<tr class=\"joinStudyRoomConditionMember\">"
									+ "<td>"+ data[i].m_name + "</td><td>" + data[i].sr_join_content + "</td>"
									+ "<td>수락 대기중...</td></tr>");
						} else if(data[i].sr_join_flag == 1){
							$('#joinStudyRoomConditionAdd' + sr_num).after("<tr class=\"joinStudyRoomConditionMember\">"
									+ "<td>"+ data[i].m_name + "</td><td>" + data[i].sr_join_content + "</td>"
									+ "<td>수락함</td></tr>");
						} else if(data[i].sr_join_flag == 2){
							$('#joinStudyRoomConditionAdd' + sr_num).after("<tr class=\"joinStudyRoomConditionMember\">"
									+ "<td>"+ data[i].m_name + "</td><td>" + data[i].sr_join_content + "</td>"
									+ "<td>거절함</td></tr>");
						}
					}
				}
			}
		});
	}
	
	function joinStudyRoomSubmit(sr_join_flag){
		var sr_num = $('#joinSubmit_sr_num').val();
		var m_id = $('#joinSubmit_m_id').val();
		
		$.ajax({
			type: 'post',						// 수락일 경우 1, 거절일 경우 2
			data: {'sr_num':sr_num, 'm_id':m_id, 'sr_join_flag':sr_join_flag},
			url: '/library/makeStudyRoomJoinSubmit',
			dataType : 'json',
			success:function(data){
				 if(data==1){
					alert("스터디룸 신청을 수락했습니다.");
				} else if(data==2){
					alert("스터디룸 신청을 거절했습니다.");
				}
				location.reload();
			}
		});
	}
	
	function goStudyRoomBoard(sr_num){
		var newWindow = window.open("about:blank");
		newWindow.location.href = '/library/studyRoomEachBoard?sr_num=' + sr_num;
	}
	

</script>
</html>