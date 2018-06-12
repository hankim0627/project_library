package multi.project.library;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class StudyRoomCommentDAO {

	@Autowired
	SqlSession session;
	
	public void insertStudyRoomCommentWrite(StudyRoomCommentVO vo){
		if(vo.getSr_comment_num()==-1){
			session.insert("library.insertStudyRoomCommentWrite", vo);
		} else {
			System.out.println(vo);
			session.insert("library.insertStudyRoomReCommentWrite", vo);
		}
	}
	public List<StudyRoomCommentVO> selectStudyRoomRecommentList(Map<String, Integer> inputMap){
		if(inputMap.get("map_start_rownum")==-1 && inputMap.get("map_end_rownum")==-1){
			session.update("library.updateStudyRoomCommentRecommentFlag", inputMap);
			return session.selectList("library.selectStudyRoomRecommentList", inputMap);
		} else {

			System.out.println(inputMap.get("map_sr_num"));
			System.out.println(inputMap.get("map_start_rownum"));
			System.out.println(inputMap.get("map_end_rownum"));
			System.out.println(inputMap.get("map_sr_comment_num"));
			return session.selectList("library.selectStudyRoomReCommentAddList", inputMap);
		}
	}
	
	public List<StudyRoomCommentVO> selectStudyRoomCommentList(Map<String, Integer> inputMap){
		return session.selectList("library.selectStudyRoomCommentList", inputMap);
	}
	public int selectStudyRoomCommentCnt(Map<String, Integer> inputMap){
		return session.selectOne("library.selectStudyRoomCommentCnt", inputMap);
	}
	
	
	
	
	
	// ============== 참여한 스터디룸의 댓글 ====================
	public List<StudyRoomCommentVO> selectStudyRoomEachBoardCommentList(Map<String, Integer> inputMap){
		return session.selectList("library.selectStudyRoomEachBoardCommentList", inputMap);
	}
	public int selectStudyRoomEachBoardCommentCnt(Map<String, Integer> inputMap){
		return session.selectOne("library.selectStudyRoomEachBoardCommentCnt", inputMap);
	}
	
	
}
