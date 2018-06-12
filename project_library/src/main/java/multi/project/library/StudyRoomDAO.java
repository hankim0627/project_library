package multi.project.library;

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
	
	public int selectCntMakeStudyRoomWithId(Map<String, Object> inputMap){
		return session.selectOne("library.selectCntMakeStudyRoomWithId", inputMap);
	}			    		 
	public List<StudyRoomVO> selectListMakeStudyRoomWithId(Map<String, Object> inputMap){
		return session.selectList("library.selectListMakeStudyRoomWithId", inputMap);
	}
	public int selectCntJoinStudyRoomWithId(Map<String, Object> inputMap){
		return session.selectOne("library.selectCntJoinStudyRoomWithId", inputMap);
	}
	public List<StudyRoomVO> selectListJoinStudyRoomWithId(Map<String, Object> inputMap){
		return session.selectList("library.selectListJoinStudyRoomWithId", inputMap);
	}
	public int selectCntEnterStudyRoomWithId(Map<String, Object> inputMap){
		return session.selectOne("library.selectCntEnterStudyRoomWithId", inputMap);
	}
	public List<StudyRoomVO> selectListEnterStudyRoomWithId(Map<String, Object> inputMap){
		return session.selectList("library.selectListEnterStudyRoomWithId", inputMap);
	}
	
	public void insertStudyRoomJoinRequest(Map<String, Object> inputMap){		// 스터디룸에 신청했을 떄 테이블에 insert
		session.insert("library.insertStudyRoomJoinRequest", inputMap);
	}
	public int selectStudyRoomJoinCheck(Map<String, Object> inputMap){			// 스터디룸을 이미 신청햇는지 아닌지 확인, 신청 했을 경우  count(*) -> 1 반환
		return session.selectOne("library.selectStudyRoomJoinCheck", inputMap);
	}
}
