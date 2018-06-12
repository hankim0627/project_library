package multi.project.library;

import java.util.List;
import java.util.Map;

public interface StudyRoomService {
	public Map<String, Object> selectStudyRoomList(Map<String,Integer> inputMap);
	public Map<String, Object> selectStudyRoomSearch(Map<String, Object> inputMap);
	public StudyRoomVO selectStudyRoomDetail(Map<String, Integer> inputMap);
	public void insertStudyRoomWrite(StudyRoomVO vo);
	public void insertStudyRoomCommentWrite(StudyRoomCommentVO vo);
	public List<StudyRoomCommentVO> selectStudyRoomRecommentList(Map<String, Integer> inputMap);
	public List<StudyRoomCommentVO> selectStudyRoomCommentList(Map<String, Integer> inputMap);
	public int selectStudyRoomCommentCnt(Map<String, Integer> inputMap);
	public void updateStudyRoomViewNum(Map<String, Integer> inputMap);
	
	public Map<String, Object> selectMakeStudyRoomWithId(Map<String, Object> inputMap);		// 내가 개설한 스터디룸 목록 가져오기
	public Map<String, Object> selectJoinStudyRoomWithId(Map<String,Object> inputMap);		// 내가 신청한 스터디룸 목록 가져오기
	public Map<String, Object> selectEnterStudyRoomWithId(Map<String,Object> inputMap);
	public int insertStudyRoomJoinRequest(Map<String, Object> inputMap);					// 개설된 스터디룸에 스터디룸 신청하기
	public List<StudyRoomJoinVO> selectmakeStudyRoomCondition(Map<String, Object> inputMap);	// 내가 개설한 스터디룸에 신청한 사람들 목록보기
	public void updateMakeStudyRoomJoinSubmit(Map<String, Object> inputMap);
	public List<StudyRoomJoinVO> selectJoinStudyRoomCondition(Map<String, Object> inputMap);
	
	//public Map<String, Object> selectStudyRoomEachBoard(Map<String, Object> inputMap);
	
}
