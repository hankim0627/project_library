package multi.project.library.studyRoom;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class StudyRoomDAO {
	
	@Autowired
	SqlSession session;
	
	public List<StudyRoomVO> selectStudyRoomList(Map<String, Integer> inputMap){
		return session.selectList("library.selectStudyRoomList",  inputMap);
	}
	public int selectStudyRoomAllCnt(){
		return session.selectOne("library.selectStudyRoomAllCnt");
	}
	public List<StudyRoomVO> selectStudyRoomSearch(Map<String, Object> inputMap){
		return session.selectList("library.selectStudyRoomSearch", inputMap);
	}
	public int selectStudyRoomSearchCnt(Map<String, Object> inputMap){
		return session.selectOne("library.selectStudyRoomSearchCnt", inputMap);
	}
	public StudyRoomVO selectStudyRoomDetail(Map<String, Integer> inputMap){
		return session.selectOne("library.selectStudyRoomDetail", inputMap);
	}
	public void insertStudyRoomWrite(StudyRoomVO vo){
		session.insert("library.insertStudyRoomWrite", vo);
	}
	public void updateStudyRoomViewNum(Map<String, Integer> inputMap){
		session.update("library.updateStudyRoomViewNum", inputMap);
	}
	
	
	public int selectCntMakeStudyRoomWithId(String sessionId){
		return session.selectOne("library.selectCntMakeStudyRoomWithId", sessionId);
	}			    		 
	public List<StudyRoomVO> selectListMakeStudyRoomWithId(Map<String, Object> inputMap){
		return session.selectList("library.selectListMakeStudyRoomWithId", inputMap);
	}
}
