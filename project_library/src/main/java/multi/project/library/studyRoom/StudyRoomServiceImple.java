package multi.project.library.studyRoom;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class StudyRoomServiceImple implements StudyRoomService{

	@Autowired
	StudyRoomDAO studyRoomDAO;
	
	@Autowired
	StudyRoomCommentDAO studyRoomCommentDAO;
	
	@Override
	public Map<String, Object> selectStudyRoomList(Map<String,Integer> inputMap) {
		int studyRoomAllCnt = studyRoomDAO.selectStudyRoomAllCnt();
		List<StudyRoomVO> studyRoomList = studyRoomDAO.selectStudyRoomList(inputMap);
		
		Map<String, Object> selectMap = new HashMap<String, Object>();
		selectMap.put("studyRoomAllCnt", studyRoomAllCnt);
		selectMap.put("studyRoomList", studyRoomList);
		
		return selectMap;
	}
	
	@Override
	public Map<String, Object> selectStudyRoomSearch(Map<String, Object> inputMap) {
		int studyRoomSearchCnt = studyRoomDAO.selectStudyRoomSearchCnt(inputMap);
		System.out.println("service에서 inputMap: " + inputMap.get("map_l_id"));
		List<StudyRoomVO> studyRoomSearchList = studyRoomDAO.selectStudyRoomSearch(inputMap);
		
		Map<String, Object> selectMap = new HashMap<String, Object>();
		selectMap.put("studyRoomSearchCnt", studyRoomSearchCnt);
		selectMap.put("studyRoomSearchList", studyRoomSearchList);
		
		return selectMap;
	}

	@Override
	public StudyRoomVO selectStudyRoomDetail(Map<String, Integer> inputMap) {
		StudyRoomVO studyRoomDetail = studyRoomDAO.selectStudyRoomDetail(inputMap); 
		return studyRoomDetail;
	}

	@Override
	public void insertStudyRoomWrite(StudyRoomVO vo) {
		studyRoomDAO.insertStudyRoomWrite(vo);
	}

	@Override
	public void insertStudyRoomCommentWrite(StudyRoomCommentVO vo) {
		studyRoomCommentDAO.insertStudyRoomCommentWrite(vo);
	}

	
	
	@Override
	public List<StudyRoomCommentVO> selectStudyRoomRecommentList(Map<String, Integer> inputMap) {
		return studyRoomCommentDAO.selectStudyRoomRecommentList(inputMap);
	}

	@Override
	public List<StudyRoomCommentVO> selectStudyRoomCommentList(Map<String, Integer> inputMap) {
		List<StudyRoomCommentVO> studyRoomCommentList = studyRoomCommentDAO.selectStudyRoomCommentList(inputMap);
		return studyRoomCommentList;
	}

	@Override
	public int selectStudyRoomCommentCnt(Map<String, Integer> inputMap) {
		return studyRoomCommentDAO.selectStudyRoomCommentCnt(inputMap);
	}

	@Override
	public void updateStudyRoomViewNum(Map<String, Integer> inputMap) {
		studyRoomDAO.updateStudyRoomViewNum(inputMap);
	}

	@Override
	public Map<String, Object> selectMakeStudyRoomWithId(Map<String, Object> inputMap) {
		Map<String, Object> selectMap = new HashMap<String, Object>();
		List<StudyRoomVO> list = studyRoomDAO.selectListMakeStudyRoomWithId(inputMap);
		selectMap.put("cntMakeStudyRoomWithId", studyRoomDAO.selectCntMakeStudyRoomWithId((String)inputMap.get("map_m_id")));
		selectMap.put("listMakeStudyRoomWithId", list);
		
		return selectMap;
	}	
	
	
	
}
