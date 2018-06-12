package multi.project.library;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class StudyRoomEachBoardDAO {
	@Autowired
	SqlSession session;
	
	public int selectStudyRoomEachBoardListCnt(){
		return session.selectOne("library.selectStudyRoomEachBoardListCnt");
	}
	public List<StudyRoomVO> selectStudyRoomEachBoardList(Map<String, Object> inputMap){
		return session.selectList("library.selectStudyRoomEachBoardList",inputMap);
	}
	
	
	public List<StudyRoomVO> selectStudyRoomEachBoardSearch(Map<String, Object> inputMap){
		return session.selectList("library.selectStudyRoomEachBoardSearch", inputMap);
	}
	public int selectStudyRoomEachBoardSearchCnt(Map<String, Object> inputMap){
		return session.selectOne("library.selectStudyRoomEachBoardSearchCnt", inputMap);
	}
	
	
	public void insertStudyRoomEachBoardWrite(StudyRoomEachBoardVO vo){
		session.insert("library.insertStudyRoomEachBoardWrite", vo);
	}
	
	
	public StudyRoomEachBoardVO selectStudyRoomEachBoardDetail(Map<String, Integer> inputMap){
		return session.selectOne("library.selectStudyRoomEachBoardDetail", inputMap);
	}
	public void updateStudyRoomEachBoardViewNum(Map<String, Integer> inputMap){
		session.update("library.updateStudyRoomEachBoardViewNum", inputMap);
	}
	
	
	
	
	
	
}
