package multi.project.library;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

public interface StudyRoomEachBoardService {
	public Map<String, Object> selectStudyRoomEachBoard(Map<String, Object> inputMap);
	public Map<String, Object> selectStudyRoomEachBoardSearch(Map<String, Object> inputMap);
	public StudyRoomEachBoardVO selectStudyRoomEachBoardDetail(Map<String, Integer> inputMap);
	public void insertStudyRoomEachBoardWrite(StudyRoomEachBoardVO vo);
	public void insertStudyRoomEachBoardCommentWrite(StudyRoomCommentVO vo);
	public List<StudyRoomCommentVO> selectStudyRoomEachBoardRecommentList(Map<String, Integer> inputMap);
	public List<StudyRoomCommentVO> selectStudyRoomEachBoardCommentList(Map<String, Integer> inputMap);
	public int selectStudyRoomEachBoardCommentCnt(Map<String, Integer> inputMap);
	public void updateStudyRoomEachBoardViewNum(Map<String, Integer> inputMap);	
	
	
	public Map<String, Object>  fileUpload(MultipartHttpServletRequest mRequest, StudyRoomEachBoardVO vo);
	
	public void deleteStudyRoomEachBoardWrite(Map<String, Object> inputMap);
}
