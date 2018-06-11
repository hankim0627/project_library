package multi.project.library.studyRoom;

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
			return session.selectList("library.selectStudyRoomReCommentAddList", inputMap);
		}
	}
	
	public List<StudyRoomCommentVO> selectStudyRoomCommentList(Map<String, Integer> inputMap){
		return session.selectList("library.selectStudyRoomCommentList", inputMap);
	}
	public int selectStudyRoomCommentCnt(Map<String, Integer> inputMap){
		return session.selectOne("library.selectStudyRoomCommentCnt", inputMap);
	}
}
