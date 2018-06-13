package multi.project.library;

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
	
	@Autowired
	StudyRoomJoinDAO studyRoomJoinDAO;
	
	@Autowired
	StudyRoomEachBoardDAO studyRoomEachBoardDAO;
	
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
		//System.out.println("service에서 inputMap: " + inputMap.get("map_l_id"));
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
		selectMap.put("cntMakeStudyRoomWithId", studyRoomDAO.selectCntMakeStudyRoomWithId(inputMap));
		selectMap.put("listMakeStudyRoomWithId", list);
		
		return selectMap;
	}

	@Override
	public Map<String, Object> selectJoinStudyRoomWithId(Map<String, Object> inputMap) {
		Map<String, Object> selectJoinPage = new HashMap<String, Object>();
		List<StudyRoomVO> list = studyRoomDAO.selectListJoinStudyRoomWithId(inputMap);
		selectJoinPage.put("cntJoinStudyRoomWithId", studyRoomDAO.selectCntJoinStudyRoomWithId(inputMap));
		selectJoinPage.put("listJoinStudyRoomWithId", list);
		return selectJoinPage;
	}

	
	@Override
	public Map<String, Object> selectEnterStudyRoomWithId(Map<String, Object> inputMap) {
		Map<String, Object> selectEnterPage = new HashMap<String, Object>();
		List<StudyRoomVO> list = studyRoomDAO.selectListEnterStudyRoomWithId(inputMap);
		selectEnterPage.put("cntEnterStudyRoomWithId", studyRoomDAO.selectCntEnterStudyRoomWithId(inputMap));
		selectEnterPage.put("listEnterStudyRoomWithId", list);
		return selectEnterPage;
	}

	@Override
	public int insertStudyRoomJoinRequest(Map<String, Object> inputMap) {
		if(studyRoomDAO.selectStudyRoomJoinCheck(inputMap)==0){		// 0일 경우에는 테이블에 없을 경우, 테이블에 insert하고 스터디룸 신청 성공 문구 띄우기
			studyRoomDAO.insertStudyRoomJoinRequest(inputMap);
			return 0;
		} else if(studyRoomDAO.selectStudyRoomJoinCheck(inputMap)==1){	// 1일 경우 테이블에 존재, insert하지 않고 스터디룸 이미 신청했따는 문구
			return 1;
		} else {															// 그 외 에러임,, 이상한것,,
			return 2;
		}
	}

	@Override
	public List<StudyRoomJoinVO> selectmakeStudyRoomCondition(Map<String, Object> inputMap) {
		return studyRoomJoinDAO.selectmakeStudyRoomCondition(inputMap);
	}

	@Override
	public void updateMakeStudyRoomJoinSubmit(Map<String, Object> inputMap) {
		studyRoomJoinDAO.updateMakeStudyRoomJoinSubmit(inputMap);
	}

	@Override
	public List<StudyRoomJoinVO> selectJoinStudyRoomCondition(Map<String, Object> inputMap) {
		return studyRoomJoinDAO.selectJoinStudyRoomCondition(inputMap);
	}

	@Override
	public void deleteStudyRoomWrite(Map<String, Object> inputMap) {
		studyRoomDAO.deleteStudyRoomWrite(inputMap);
	}

	
	
	
	
	
}
