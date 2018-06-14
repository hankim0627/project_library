package multi.project.library;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class StudyRoomEachBoardController {
	
	@Autowired
	StudyRoomEachBoardService sr_Service;

	public static String getUuid(){
		return UUID.randomUUID().toString().replaceAll("-", "");
	}
	
	@RequestMapping(value="/studyRoomEachBoardShow")
	public ModelAndView selectStudyRoomEachBoardShow(int sr_num){
		ModelAndView mv = new ModelAndView();
		mv.addObject("sr_num", sr_num);
		mv.setViewName("/studyRoomEachBoardShow");
		return mv;
	}
	
	// 스터디룸마다의 게시판 열기
	@RequestMapping(value="/studyRoomEachBoard")
	public ModelAndView selectStudyRoomEachBoard(HttpSession session, @RequestParam(value="page", defaultValue="1") int page, int sr_num, @RequestParam(value="fileUploadIsSuccess", defaultValue="1") int fileUploadIsSuccess){
		Map<String,Object> inputMap = new HashMap<String, Object>();
		inputMap.put("map_start_rownum", (page-1)*10+1);
		inputMap.put("map_end_rownum", (page)*10);
		inputMap.put("map_l_id", session.getAttribute("l_id"));
		inputMap.put("map_sr_num", sr_num);
		
		Map <String, Object> selectMap = sr_Service.selectStudyRoomEachBoard(inputMap);
		
		int StudyRoomAllCnt = (Integer)selectMap.get("studyRoomEachBoardListCnt");
		int totalPage =0;
		if(StudyRoomAllCnt /10 == 0){
			totalPage = StudyRoomAllCnt/10;
		}else{
			totalPage = StudyRoomAllCnt/10+1;
		}
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("totalPage", totalPage);
		mv.addObject("studyRoomEachBoardList", (List<StudyRoomVO>)selectMap.get("studyRoomEachBoardList"));
		mv.addObject("sr_num", sr_num);
		if(fileUploadIsSuccess==0){				// 파일 업로드 실패 시
			mv.addObject("fileUploadIsSuccess", 0);
		} else if(fileUploadIsSuccess==1){
			mv.addObject("fileUploadIsSuccess", 1);
		}
		System.out.println("이것으,ㄴ,,,"+fileUploadIsSuccess);
		mv.setViewName("studyRoomEachBoard");
		
		return mv;
	}
	
	// ===================== 스터디룸 목록에서 검색 할 떄 =========================== 
	@RequestMapping(value="/studyRoomEachBoardSearch")
	public ModelAndView selectStudyRoomEachBoardSearch(HttpSession session, int sr_num, @RequestParam(value="page", defaultValue="1") int page, int searchDate, String searchType, String searchWord){
		Map<String, Object> inputMap = new HashMap<String, Object>();
		
		inputMap.put("map_start_rownum", (Integer)(page-1)*10+1);
		inputMap.put("map_end_rownum", (Integer)page*10);
		inputMap.put("map_l_id", session.getAttribute("l_id"));
		inputMap.put("map_sr_date", (Integer)searchDate);
		inputMap.put("map_sr_type", (String)searchType);
		inputMap.put("map_sr_word", (String)searchWord);
		inputMap.put("map_sr_num", sr_num);
		
		Map<String, Object> selectMap = sr_Service.selectStudyRoomEachBoardSearch(inputMap);
		
		int StudyRoomBoardSearchCnt = (Integer)selectMap.get("studyRoomEachBoardSearchCnt");
		int totalPage =0;
		if(StudyRoomBoardSearchCnt /10 == 0){
			totalPage = StudyRoomBoardSearchCnt/10;
		}else{
			totalPage = StudyRoomBoardSearchCnt/10+1;
		}
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("searchDate", searchDate);
		mv.addObject("searchType", searchType);
		mv.addObject("searchWord", searchWord);
		mv.addObject("totalPage", totalPage);
		mv.addObject("sr_num", sr_num);
		mv.addObject("studyRoomEachBoardList", (List<StudyRoomVO>)selectMap.get("studyRoomEachBoardSearchList"));
		mv.setViewName("studyRoomEachBoard");
		return mv;
	}
	
	// 글쓰기 눌렀을 떄 
	@RequestMapping(value="/studyRoomEachBoardWrite")
	public ModelAndView studyRoomEachBoardWrite(int sr_num){
		ModelAndView mv = new ModelAndView();
		mv.addObject("sr_num", sr_num);
		mv.setViewName("studyRoomEachBoardWrite");
		return mv;
	}
	
	// ===================== 글쓰기 등록 눌렀을 떄 =========================== 
	@RequestMapping(value="/studyRoomEachBoardWriteSubmit", method = RequestMethod.POST)
	public ModelAndView insertStudyRoomEachBoardWriteSubmit(HttpSession session, int l_id, int sr_num, String sr_title, String sr_cate, String sr_content, String sr_pw, MultipartHttpServletRequest mRequest){
		StudyRoomEachBoardVO vo = new StudyRoomEachBoardVO(sr_num, sr_title, l_id, sr_content, (String)session.getAttribute("member_id"), sr_pw, sr_cate);
		/*System.out.println((String)session.getAttribute("member_pw"));*/
		
		Map<String, Object> map = sr_Service.fileUpload(mRequest, vo);
		
		if((Boolean)map.get("isSuccess")==false){
			return selectStudyRoomEachBoard(session, 1, sr_num, 0);
		}
		//sr_Service.insertStudyRoomEachBoardWrite((StudyRoomEachBoardVO)map.get("vo"));
		
		return selectStudyRoomEachBoard(session, 1, sr_num, 1);
	}

	
	
	// ===================== 스터디룸 게시글 클릭했을 떄 =========================== 
	@RequestMapping(value="/studyRoomEachBoardDetail")
	public ModelAndView selectStudyRoomEachBoardDetail(HttpSession session, int sr_eb_num, int sr_num){
		
		Map<String, Integer> inputMap = new HashMap<String, Integer>();
		inputMap.put("map_sr_eb_num", sr_eb_num);
		inputMap.put("map_sr_num", sr_num);
		inputMap.put("map_start_rownum", 1);
		inputMap.put("map_end_rownum", 5);
		
		sr_Service.updateStudyRoomEachBoardViewNum(inputMap);
		
		StudyRoomEachBoardVO detail = sr_Service.selectStudyRoomEachBoardDetail(inputMap);
		
		File path = new File("c:/upload/studyroom" + detail.getSr_num() + "/write" + detail.getSr_eb_num()+ "/");
		String [] fileList = path.list();
		
		for(int i=0; i<fileList.length; i++){
			System.out.println("파일 리스트" + fileList[i]);
		}
		
		List<StudyRoomCommentVO> commentList = sr_Service.selectStudyRoomEachBoardCommentList(inputMap);

		ModelAndView mv = new ModelAndView();
		mv.addObject("downloadFileList", fileList);
		mv.addObject("studyRoomDetail", detail);
		mv.addObject("studyRoomComment", commentList);
		mv.addObject("studyRoomCommentCnt", sr_Service.selectStudyRoomEachBoardCommentCnt(inputMap));
		mv.addObject("sr_eb_num", sr_eb_num);
		mv.addObject("sr_num", sr_num);
		if(session.getAttribute("member_id").equals(detail.getM_id())){
			mv.addObject("studyRoomEachBoardEdit", "");
		} else {
			mv.addObject("studyRoomEachBoardEdit", "display: none;");
		}
		
		mv.setViewName("studyRoomEachBoardDetail");
		return mv;
	}
	
	// 파일 다운로드	
	@RequestMapping(value="studyRoomEachBoardDetail.file")
	public void studyRoomEachBoardFileDownload(HttpServletResponse response, int sr_eb_num, int sr_num, String filename) throws IOException{
		File f = new File("c:/upload/studyroom" + sr_num + "/write" + sr_eb_num + "/", filename);
		response.setContentType("application/download");
		response.setContentLength((int)f.length());
		response.setHeader("Content-Disposition", "attachment;filename=\"" + filename+ "\"");
		
		OutputStream out = response.getOutputStream();
		FileInputStream fin = new FileInputStream(f);
		FileCopyUtils.copy(fin, out);
		fin.close();
		out.close();
	}
	
	
	
	
	
	// ===================== 댓글 등록 클릭했을 떄 =========================== 
	@RequestMapping(value="/studyRoomEachBoardCommentWrite")
	@ResponseBody
	public List<StudyRoomCommentVO> studyRoomEachBoardCommentWrite(int sr_eb_num, int sr_num, int add_num_start, int add_num_end, int sr_comment_num, String sr_comment_id, String sr_comment_content){
		StudyRoomCommentVO  vo = new StudyRoomCommentVO(sr_eb_num, sr_num, sr_comment_num, sr_comment_id, sr_comment_content);
		sr_Service.insertStudyRoomEachBoardCommentWrite(vo);
		if(sr_comment_num==-1){							// 댓글 달 때
			return studyRoomEachBoardCommentAdd(sr_eb_num, sr_num, add_num_start,add_num_end);
		} else{											// 댓글의 답글 달 떄
			return studyRoomEachBoardRecommentAdd(sr_eb_num, sr_num, add_num_start, add_num_end, sr_comment_num);
		}
	}

	// ===================== 답글 클릭했을 떄 =========================== 
	@RequestMapping(value="/studyRoomEachBoardRecommentAdd")
	@ResponseBody
	public List<StudyRoomCommentVO> studyRoomEachBoardRecommentAdd(int sr_eb_num, int sr_num, int add_num_start, int add_num_end, int sr_comment_num){
		Map<String, Integer> inputMap = new HashMap<String, Integer>();
		inputMap.put("map_sr_eb_num", sr_eb_num);
		inputMap.put("map_sr_num", sr_num);
		inputMap.put("map_start_rownum", add_num_start);
		inputMap.put("map_end_rownum", add_num_end);
		inputMap.put("map_sr_comment_num", sr_comment_num);
		
		return sr_Service.selectStudyRoomEachBoardRecommentList(inputMap);
	}
	
	// ===================== 댓글 더보기 클릭했을 떄 =========================== 
	@RequestMapping(value="/studyRoomEachBoardCommentAdd")
	@ResponseBody
	public List<StudyRoomCommentVO> studyRoomEachBoardCommentAdd(int sr_eb_num, int sr_num, int add_num_start, int add_num_end){
		Map<String, Integer> inputMap = new HashMap<String, Integer>();
		inputMap.put("map_sr_eb_num", sr_eb_num);
		inputMap.put("map_sr_num", sr_num);
		inputMap.put("map_start_rownum", add_num_start);
		inputMap.put("map_end_rownum", add_num_end); 
		return sr_Service.selectStudyRoomEachBoardCommentList(inputMap);
	}
	
	
	@RequestMapping(value="/studyRoomEachBoardDelete")
	public ModelAndView studyRoomEachBoardDelete(HttpSession session, int sr_eb_num, int sr_num){
		Map<String, Object> inputMap = new HashMap<String, Object>();
		inputMap.put("map_l_id", session.getAttribute("l_id"));
		inputMap.put("map_sr_eb_num", sr_eb_num);
		inputMap.put("map_sr_num", sr_num);

		sr_Service.deleteStudyRoomEachBoardWrite(inputMap);
		
		return selectStudyRoomEachBoard(session, 1, sr_num,1);
	}
	
}