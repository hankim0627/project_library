package multi.project.library;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class StudyRoomJoinDAO {
	@Autowired
	SqlSession session;
	
	public List<StudyRoomJoinVO> selectmakeStudyRoomCondition(Map<String, Object> inputMap){
		return session.selectList("library.selectmakeStudyRoomCondition", inputMap);
	}
	public void updateMakeStudyRoomJoinSubmit(Map<String, Object> inputMap){
		session.selectOne("library.updateMakeStudyRoomJoinSubmit", inputMap);
	}
	public List<StudyRoomJoinVO> selectJoinStudyRoomCondition(Map<String, Object> inputMap){
		return session.selectList("library.selectJoinStudyRoomCondition", inputMap);
	}
}
