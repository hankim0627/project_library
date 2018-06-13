<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<style>
/* div.mainForm{
	width: 100%;
	font-size: 13px;
} */

table{
	width: 100%;
	border-collapse: collapse;
	font-size: 13px;
	position: relative;
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
div.myPageSelect{
	position: relative;
	width: 100%;
	text-align: center;
	padding-bottom: 20px;
}
a.myPageSelect{
	vertical-align: middle;
}

</style>
<script src="/library/resources/jquery-3.2.1.min.js"></script>
<meta charset=UTF-8>
<title>Insert title here</title>
</head>
<body>
	<h4 style="margin-bottom: 0">마이페이지</h4>
	<%-- <h5><a href="/library/studyRoomMain?l_id=<%=session.getAttribute("l_id")%>">◀스터디룸으로 돌아가기</a></h5> --%>
	
<div class="mainForm">
	<div class="myPageSelect">
		<span><a class="myPageSelect" href="#" onclick="showJoinStudyRoomWithId();">신청한 스터디룸 (${cntJoinStudyRoomWithId})</a></span>  |	  							<!-- toggle 기능 넣기 -->
		<span><a class="myPageSelect" href="#" onclick="showMakeStudyRoomWithId();">참여 중인 스터디룸(${cntMyJoinStudyRoonWithId})</a></span>
	</div>
	
	<div id="joinStudyRoomWithId" style="${joinDisplay}">
		<table id="joinStudyRoomConditionAdd">
			<tr class="menuHead"><td width="7%">글번호</td>
						<td width="13%">카테고리</td>
						<td width="32%">제목</td><td width="8%">작성자</td>
						<td width="16%">작성일</td>
						<td width="6%">조회수</td><td width="18%">신청 현황</td></tr>
						
			<c:forEach items="${listJoinStudyRoomWithId}" var="list">
				<tr id="joinStudyRoomConditionAdd${list.getSr_num() }">
					<td class="middleText" >${list.getSr_num() }</td>
					<td class="middleText">${list.getSr_cate() }</td>
					<td ><a href="/library/studyRoomDetail?sr_num=${list.getSr_num() }"> ${list.getSr_title() }</a></td>
					<td>${list.getM_name() }</td>
					<td class="middleText">${list.getSr_date() }</td>
					<td class="middleText">${list.getSr_view_num() }</td>
					<td class="middleText"><a href="#" onclick="joinStudyRoomCondition('${list.getSr_num() }');">보기</a></td>
				</tr>
			</c:forEach>
		</table> 
		<c:forEach var="page" begin="1" end="${joinTotalPage}">
				<a href="/library/studyRoomMyPage?JoinPage=${page }&JoinDisplay=1">${page }</a>
		</c:forEach>
	</div>

	<div id="makeStudyRoomWithId" style="${makeDisplay}">
		<p>개설한 스터디룸(${cntMakeStudyRoomWithId})</p>
		<table id="makeStudyRoomConditionAdd">
			<tr class="menuHead"><td width="7%">글번호</td>
						<td width="13%">카테고리</td>
						<td width="30%">제목</td><td width="8%">작성자</td>
						<td width="16%">작성일</td>
						<td width="6%">조회수</td><td width="10%">신청 현황</td><td width="10%">스터디 게시판</td></tr>
			<c:forEach items="${listMakeStudyRoomWithId}" var="list">
				<tr id="makeStudyRoomConditionAdd${list.getSr_num() }">
					<td class="middleText">${list.getSr_num() }</td>
					<td class="middleText">${list.getSr_cate() }</td>
					<td><a href="/library/studyRoomDetail?sr_num=${list.getSr_num() }"> ${list.getSr_title() }</a></td>
					<td>${list.getM_name() }</td>
					<td class="middleText">${list.getSr_date() }</td>
					<td class="middleText">${list.getSr_view_num() }</td>
					<td class="middleText"><a href="#" onclick="makeStudyRoomCondition('${list.getSr_num() }');">보기</a></td>
					<td class="middleText"><a href="#" onclick="goStudyRoomBoard('${list.getSr_num() }');">이동</a></td>
				</tr>
			</c:forEach>
		</table>
		<c:forEach var="page" begin="1" end="${makeTotalPage}">
			<a href="/library/studyRoomMyPage?MakePage=${page }&MakeDisplay=1">${page }</a>
		</c:forEach>

		<p>신청한 스터디룸(${cntEnterStudyRoomWithId})</p>								
	<%-- <div id="enterStudyRoomWithId" style="${makeDisplay}"> --%>
		<table>
			<tr class="menuHead"><td width="6%">글번호</td>
						<td width="11%">카테고리</td>
						<td width="35%">제목</td><td width="8%">작성자</td>
						<td width="16%">작성일</td>
						<td width="6%">조회수</td><td width="18%">스터디 게시판</td></tr>
			<c:forEach items="${listEnterStudyRoomWithId}" var="list">
				<tr>
					<td class="middleText">${list.getSr_num() }</td>
					<td class="middleText">${list.getSr_cate() }</td>
					<td><a href="/library/studyRoomDetail?sr_num=${list.getSr_num() }"> ${list.getSr_title() }</a></td>
					<td>${list.getM_name() }</td>
					<td class="middleText">${list.getSr_date() }</td>
					<td class="middleText">${list.getSr_view_num() }</td>
					<td class="middleText"><a href="#" onclick="goStudyRoomBoard('${list.getSr_num() }');">이동</a></td>
				</tr>
			</c:forEach>
		</table> 
		<c:forEach var="page" begin="1" end="${enterTotalPage}">
				<a href="/library/studyRoomMyPage?enterPage=${page }&enterDisplay=1">${page }</a>
		</c:forEach>
	</div>
</div>
</body>

<script>
	function showMakeStudyRoomWithId(){
		$('#makeStudyRoomWithId').show();
		$('#joinStudyRoomWithId').hide();
	}
	function showJoinStudyRoomWithId(){
		$('#joinStudyRoomWithId').show();
		$('#makeStudyRoomWithId').hide();
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
					$('#makeStudyRoomConditionAdd' + sr_num).after("<tr class=\"makeStudyRoomConditionMember\"><td class=\"middleText\" colspan=\"8\" >신청한 회원이 없습니다.</td></tr>");
				} else {
					for(var i=0; i<data.length; i++){
						if(data[i].sr_join_flag == 0){
							$('#makeStudyRoomConditionAdd' + sr_num).after("<tr class=\"makeStudyRoomConditionMember\">"
									+ "<td class=\"middleText\">└</td><td class=\"middleText\">"+ data[i].m_name + "</td><td colspan=\"4\">" + data[i].sr_join_content + "</td>"
									+ "<td><input type=\"button\" id=\"joinSubmitOK\" onclick=\"joinStudyRoomSubmit(1);\" value=\"수락\"><input type=\"button\" id=\"joinSubmitNO\" onclick=\"joinStudyRoomSubmit(2);\" value=\"거절\"></td><td></td>"
									+ "<td><input type=\"hidden\" id=\"joinSubmit_m_id\" value=\"" + data[i].m_id +"\">"
									+ "<input type=\"hidden\" id=\"joinSubmit_sr_num\" value=\"" + sr_num +"\"></td></tr>");
						} else if(data[i].sr_join_flag == 1){
							$('#makeStudyRoomConditionAdd' + sr_num).after("<tr class=\"makeStudyRoomConditionMember\">"
									+ "<td class=\"middleText\">└</td><td class=\"middleText\">"+ data[i].m_name + "</td><td colspan=\"4\">" + data[i].sr_join_content + "</td>"
									+ "<td class=\"middleText\">수락</td><td></td></tr>");
						} else if(data[i].sr_join_flag == 2){
							$('#makeStudyRoomConditionAdd' + sr_num).after("<tr class=\"makeStudyRoomConditionMember\">"
									+ "<td class=\"middleText\">└</td><td class=\"middleText\">"+ data[i].m_name + "</td><td colspan=\"4\">" + data[i].sr_join_content + "</td>"
									+ "<td class=\"middleText\">거절</td><td></td></tr>");
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
							$('#joinStudyRoomConditionAdd' + sr_num).after("<tr class=\"joinStudyRoomConditionMember\"><td class=\"middleText\">└</td><td class=\"middleText\">전송 메세지</td>"
									+ "<td colspan=\"4\">" + data[i].sr_join_content + "</td>"
									+ "<td class=\"middleText\">수락 대기중</td></tr>");
						} else if(data[i].sr_join_flag == 1){
							$('#joinStudyRoomConditionAdd' + sr_num).after("<tr class=\"joinStudyRoomConditionMember\">"
									+ "<td>"+ data[i].m_name + "</td><td>" + data[i].sr_join_content + "</td>"
									+ "<td>수락</td></tr>");
						} else if(data[i].sr_join_flag == 2){
							$('#joinStudyRoomConditionAdd' + sr_num).after("<tr class=\"joinStudyRoomConditionMember\">"
									+ "<td>"+ data[i].m_name + "</td><td>" + data[i].sr_join_content + "</td>"
									+ "<td>거절</td></tr>");
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