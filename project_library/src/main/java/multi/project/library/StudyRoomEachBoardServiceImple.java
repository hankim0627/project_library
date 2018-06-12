package multi.project.library;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Component
public class StudyRoomEachBoardServiceImple implements StudyRoomEachBoardService{

	@Autowired
	StudyRoomEachBoardDAO studyRoomEachBoardDAO;
	
	@Autowired
	StudyRoomCommentDAO studyRoomCommentDAO;
	
	@Autowired
	StudyRoomJoinDAO studyRoomJoinDAO;
		
	@Override
	public Map<String, Object> selectStudyRoomEachBoard(Map<String, Object> inputMap) {
		int studyRoomEachBoardListCnt = studyRoomEachBoardDAO.selectStudyRoomEachBoardListCnt();
		List<StudyRoomVO> studyRoomEachBoardList = studyRoomEachBoardDAO.selectStudyRoomEachBoardList(inputMap);
		
		Map<String, Object> selectMap = new HashMap<String, Object>();
		selectMap.put("studyRoomEachBoardListCnt", studyRoomEachBoardListCnt);
		selectMap.put("studyRoomEachBoardList", studyRoomEachBoardList);
		
		return selectMap;
	}	
	

	@Override
	public Map<String, Object> selectStudyRoomEachBoardSearch(Map<String, Object> inputMap) {
		int studyRoomSearchCnt = studyRoomEachBoardDAO.selectStudyRoomEachBoardSearchCnt(inputMap);
		//System.out.println("service에서 inputMap: " + inputMap.get("map_l_id"));
		List<StudyRoomVO> studyRoomSearchList = studyRoomEachBoardDAO.selectStudyRoomEachBoardSearch(inputMap);
		
		Map<String, Object> selectMap = new HashMap<String, Object>();
		selectMap.put("studyRoomEachBoardSearchCnt", studyRoomSearchCnt);
		selectMap.put("studyRoomEachBoardSearchList", studyRoomSearchList);
		
		return selectMap;
	}
	

	@Override
	public StudyRoomEachBoardVO selectStudyRoomEachBoardDetail(Map<String, Integer> inputMap) {
		StudyRoomEachBoardVO studyRoomDetail = studyRoomEachBoardDAO.selectStudyRoomEachBoardDetail(inputMap); 
		return studyRoomDetail;
	}
	
	@Override
	public void updateStudyRoomEachBoardViewNum(Map<String, Integer> inputMap) {
		studyRoomEachBoardDAO.updateStudyRoomEachBoardViewNum(inputMap);
	}
	
	@Override
	public void insertStudyRoomEachBoardWrite(StudyRoomEachBoardVO vo) {
		studyRoomEachBoardDAO.insertStudyRoomEachBoardWrite(vo);
	}

	@Override
	public Map<String, Object> fileUpload(MultipartHttpServletRequest mRequest, StudyRoomEachBoardVO vo) {
		Map<String, Object> map = new HashMap<String, Object>();
		boolean isSuccess= false;
		
		String uploadPath = "c:/upload/";
		File dir = new File(uploadPath);
		if(!dir.isDirectory()){
			dir.mkdirs();
		}
		
		Iterator<String> iter = mRequest.getFileNames();

		int cnt =0;
		while(iter.hasNext()){
			cnt++;
			String uploadFileName = iter.next();
			MultipartFile mFile = mRequest.getFile(uploadFileName);
			String originalFileName = mFile.getOriginalFilename();
			String saveFileName = originalFileName;
			
			if(cnt==1){
				vo.setSr_file_name1(originalFileName);
			} else if(cnt==2){
				vo.setSr_file_name2(originalFileName);
			} else if(cnt==3){
				vo.setSr_file_name3(originalFileName);
			}
			
			if(saveFileName != null && !saveFileName.equals("")) {
				
				if(new File(uploadPath + saveFileName).exists()) {
					saveFileName = saveFileName + "_" + System.currentTimeMillis();
				}
				try {
					mFile.transferTo(new File(uploadPath + saveFileName));
					isSuccess = true;				
				} catch (IllegalStateException e) {
					e.printStackTrace();
					isSuccess = false;
				} catch (IOException e) {
					e.printStackTrace();
					isSuccess = false;
				}
			}
		}
		map.put("isSuccess", isSuccess);
		map.put("vo", vo);
		return map;
	}

	
	
	
	
	@Override
	public void insertStudyRoomEachBoardCommentWrite(StudyRoomCommentVO vo) {
		studyRoomCommentDAO.insertStudyRoomCommentWrite(vo);
	}

	
	
	@Override
	public List<StudyRoomCommentVO> selectStudyRoomEachBoardRecommentList(Map<String, Integer> inputMap) {
		return studyRoomCommentDAO.selectStudyRoomRecommentList(inputMap);
	}

	
	
	@Override
	public List<StudyRoomCommentVO> selectStudyRoomEachBoardCommentList(Map<String, Integer> inputMap) {
		List<StudyRoomCommentVO> studyRoomCommentList = studyRoomCommentDAO.selectStudyRoomEachBoardCommentList(inputMap);
		return studyRoomCommentList;
	}

	@Override
	public int selectStudyRoomEachBoardCommentCnt(Map<String, Integer> inputMap) {
		return studyRoomCommentDAO.selectStudyRoomEachBoardCommentCnt(inputMap);
	}

	

}
