package multi.project.library.studyRoom;

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
	
	public Map<String, Object> selectMakeStudyRoomWithId(Map<String, Object> inputMap);
}
