package multi.project.library;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class StudyRoomEachBoardController {
	
	@Autowired
	StudyRoomEachBoardService sr_Service;

	public static String getUuid(){
		return UUID.randomUUID().toString().replaceAll("-", "");
	}
	
	// 스터디룸마다의 게시판 열기
	@RequestMapping(value="/studyRoomEachBoard")
	public ModelAndView selectStudyRoomEachBoard(HttpSession session, @RequestParam(value="page", defaultValue="1") int page, int sr_num){
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
	public ModelAndView insertStudyRoomEachBoardWriteSubmit(HttpSession session, int l_id, int sr_num, String sr_title, String sr_cate, String sr_content, MultipartHttpServletRequest mRequest){
		StudyRoomEachBoardVO vo = new StudyRoomEachBoardVO(sr_num, sr_title, l_id, sr_content, (String)session.getAttribute("member_id"), "임시", sr_cate);
		/*System.out.println((String)session.getAttribute("member_pw"));*/
		
		Map<String, Object> map = sr_Service.fileUpload(mRequest, vo);
		sr_Service.insertStudyRoomEachBoardWrite((StudyRoomEachBoardVO)map.get("vo"));
		
		return selectStudyRoomEachBoard(session, 1, sr_num);
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
		
		List<StudyRoomCommentVO> commentList = sr_Service.selectStudyRoomEachBoardCommentList(inputMap);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("studyRoomDetail", detail);
		mv.addObject("studyRoomComment", commentList);
		mv.addObject("studyRoomCommentCnt", sr_Service.selectStudyRoomEachBoardCommentCnt(inputMap));
				
		mv.setViewName("studyRoomEachBoardDetail");
		return mv;
	}
	
	
	
	
	
	
	
	// ===================== 댓글 등록 클릭했을 떄 =========================== 
	@RequestMapping(value="/studyRoomEachBoardCommentWrite")
	@ResponseBody
	public List<StudyRoomCommentVO> studyRoomEachBoardCommentWrite(int sr_num, int add_num_start, int add_num_end, int sr_comment_num, String sr_comment_id, String sr_comment_content){
		StudyRoomCommentVO  vo = new StudyRoomCommentVO(sr_num, sr_comment_num, sr_comment_id, sr_comment_content);
		sr_Service.insertStudyRoomEachBoardCommentWrite(vo);
		if(sr_comment_num==-1){							// 댓글 달 때
			return studyRoomEachBoardCommentAdd(sr_num, add_num_start,add_num_end);
		} else{											// 댓글의 답글 달 떄
			return studyRoomEachBoardRecommentAdd(sr_num, add_num_start, add_num_end, sr_comment_num);
		}
	}

	// ===================== 답글 클릭했을 떄 =========================== 
	@RequestMapping(value="/studyRoomEachBoardRecommentAdd")
	@ResponseBody
	public List<StudyRoomCommentVO> studyRoomEachBoardRecommentAdd(int sr_num, int add_num_start, int add_num_end, int sr_comment_num){
		Map<String, Integer> inputMap = new HashMap<String, Integer>();
		inputMap.put("map_sr_num", sr_num);
		inputMap.put("map_start_rownum", add_num_start);
		inputMap.put("map_end_rownum", add_num_end);
		inputMap.put("map_sr_comment_num", sr_comment_num);
		
		return sr_Service.selectStudyRoomEachBoardRecommentList(inputMap);
	}
	
	// ===================== 댓글 더보기 클릭했을 떄 =========================== 
	@RequestMapping(value="/studyRoomEachBoardCommentAdd")
	@ResponseBody
	public List<StudyRoomCommentVO> studyRoomEachBoardCommentAdd(int sr_num, int add_num_start, int add_num_end){
		Map<String, Integer> inputMap = new HashMap<String, Integer>();
		inputMap.put("map_sr_num", sr_num);
		inputMap.put("map_start_rownum", add_num_start);
		inputMap.put("map_end_rownum", add_num_end); 
		return sr_Service.selectStudyRoomEachBoardCommentList(inputMap);
	}
	
	
/*	
	// ===================== 마이페이지 가기 눌렀을 떄=========================
	@RequestMapping(value="/studyRoomMyPage")
	public ModelAndView studyRoomMyPage(HttpSession session, @RequestParam(value="MakePage", defaultValue="1") int MakePage, @RequestParam(value="MakeDisplay", defaultValue="0") int MakeDisplay, 
			@RequestParam(value="JoinPage", defaultValue="1") int JoinPage, @RequestParam(value="JoinDisplay", defaultValue="0") int JoinDisplay,
			@RequestParam(value="enterPage", defaultValue="1") int enterPage, @RequestParam(value="enterDisplay", defaultValue="0") int enterDisplay){
		
		Map<String, Object> inputMap = new HashMap<String, Object>();			// 목록 불러올 때 쓸 map
		inputMap.put("map_m_id", (String)session.getAttribute("sessionid"));
		inputMap.put("map_l_id", session.getAttribute("sessionlibrary"));
		inputMap.put("map_make_start_rownum", (MakePage-1)*10+1);
		inputMap.put("map_make_end_rownum", (MakePage)*10);
		inputMap.put("map_join_start_rownum", (JoinPage-1)*10+1);
		inputMap.put("map_join_end_rownum", (JoinPage)*10);
		inputMap.put("map_enter_start_rownum", (enterPage-1)*10+1);
		inputMap.put("map_enter_end_rownum", (enterPage)*10);
		
		Map <String, Object> selectMap = sr_Service.selectMakeStudyRoomWithId(inputMap);
		int cntMakeStudyRoomWithId = (Integer)selectMap.get("cntMakeStudyRoomWithId");
		int makeTotalPage =0;
		if(cntMakeStudyRoomWithId/10 == 0){
			makeTotalPage = cntMakeStudyRoomWithId/10;
		}else{
			makeTotalPage = cntMakeStudyRoomWithId/10+1;
		}
		
		Map<String, Object> selectJoinPage = sr_Service.selectJoinStudyRoomWithId(inputMap);
		int cntJoinStudyRoomWithId = (Integer)selectJoinPage.get("cntJoinStudyRoomWithId");
		int joinTotalPage =0;
		if(cntJoinStudyRoomWithId/10 == 0){
			joinTotalPage = cntJoinStudyRoomWithId/10;
		}else{
			joinTotalPage = cntJoinStudyRoomWithId/10+1;
		}
		
		Map<String, Object> selectEnterPage = sr_Service.selectEnterStudyRoomWithId(inputMap);
		int cntEnterStudyRoomWithId = (Integer)selectEnterPage.get("cntEnterStudyRoomWithId");
		int enterTotalPage =0;
		if(cntEnterStudyRoomWithId/10 == 0){
			enterTotalPage = cntEnterStudyRoomWithId/10;
		}else{
			enterTotalPage = cntEnterStudyRoomWithId/10+1;
		}
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("makeTotalPage", makeTotalPage);
		mv.addObject("cntMakeStudyRoomWithId", cntMakeStudyRoomWithId);
		mv.addObject("listMakeStudyRoomWithId", (List<StudyRoomVO>)selectMap.get("listMakeStudyRoomWithId"));
		
		mv.addObject("joinTotalPage", joinTotalPage);
		mv.addObject("cntJoinStudyRoomWithId", cntJoinStudyRoomWithId);
		mv.addObject("listJoinStudyRoomWithId", (List<StudyRoomVO>)selectJoinPage.get("listJoinStudyRoomWithId"));
		
		mv.addObject("enterTotalPage", enterTotalPage);
		mv.addObject("cntEnterStudyRoomWithId", cntEnterStudyRoomWithId);
		mv.addObject("listEnterStudyRoomWithId", (List<StudyRoomVO>)selectEnterPage.get("listEnterStudyRoomWithId"));
		
		mv.addObject("cntMyJoinStudyRoonWithId", cntMakeStudyRoomWithId+cntEnterStudyRoomWithId);
		
		if(MakeDisplay==1){						// 내가 개설한 방 갯수 클릭 시 display 설정
			mv.addObject("makeDisplay", "");
		} else if(MakeDisplay==0){
			mv.addObject("makeDisplay", "display: none;");
		}
		if(JoinDisplay==1){						// 내가 신청한 방 갯수 클릭 시 display 설정
			mv.addObject("joinDisplay", "");
		} else if(JoinDisplay==0){
			mv.addObject("joinDisplay", "display: none;");
		}
		if(enterDisplay==1){
			mv.addObject("enterDisplay", "");
		} else if(enterDisplay==0){
			mv.addObject("enterDisplay", "display: none;");
		}
		mv.setViewName("studyRoomMyPage");
		return mv;
	}
	
	
	// 스터디룸 신청하기
	@RequestMapping(value="/studyRoomJoinRequest")
	@ResponseBody
	public int studyRoomJoinRequest(HttpSession session, int sr_num, String sr_join_content){
		Map<String, Object> inputMap = new HashMap<String,Object>();
		inputMap.put("map_m_id", (String)session.getAttribute("sessionid"));
		inputMap.put("map_l_id", session.getAttribute("sessionlibrary"));
		inputMap.put("map_sr_num", sr_num);
		inputMap.put("map_sr_join_content", sr_join_content);
		System.out.println(sr_num);
		System.out.println(sr_join_content);

		return sr_Service.insertStudyRoomJoinRequest(inputMap);
	}
	
	
	// 스터디룸 신청하기 시 팝업
	@RequestMapping(value="/studyRoomJoinPopup")
	public ModelAndView studyRoomJoinPopup(int sr_num, String sr_m_name){
		ModelAndView mv = new ModelAndView();
		mv.addObject("sr_num", sr_num);
		mv.addObject("sr_m_name", sr_m_name);
		mv.setViewName("studyRoomJoinPopup");
		return mv;
	}
	
	
	// 내가 개설한 스터디룸 현황
	@RequestMapping(value="/makeStudyRoomCondition")
	@ResponseBody
	public List<StudyRoomJoinVO> makeStudyRoomCondition(HttpSession session, int sr_num){
		Map<String, Object> inputMap = new HashMap<String, Object>();
		inputMap.put("map_l_id", session.getAttribute("sessionlibrary"));
		inputMap.put("map_sr_num", sr_num);
		return sr_Service.selectmakeStudyRoomCondition(inputMap);
	}
	// 내가 개설한 스터디룸에 신청한 사람 수락 -->1로 / 거절-->2로
	@RequestMapping(value="/makeStudyRoomJoinSubmit")
	@ResponseBody
	public int makeStudyRoomJoinSubmit(HttpSession session, int sr_num, String m_id, int sr_join_flag){
		Map<String, Object> inputMap = new HashMap<String, Object>();
		inputMap.put("map_l_id", session.getAttribute("sessionlibrary"));
		inputMap.put("map_sr_num", sr_num);
		inputMap.put("map_m_id", m_id);
		inputMap.put("map_sr_join_flag", sr_join_flag);
		sr_Service.updateMakeStudyRoomJoinSubmit(inputMap);
		return sr_join_flag;
	}
	
	
	// 신청한 스터디룸 현황
	@RequestMapping(value="/joinStudyRoomCondition")
	@ResponseBody
	public List<StudyRoomJoinVO> joinStudyRoomCondition(HttpSession session, int sr_num){
		Map<String, Object> inputMap = new HashMap<String, Object>();
		inputMap.put("map_l_id", session.getAttribute("sessionlibrary"));
		inputMap.put("map_m_id", session.getAttribute("sessionid"));
		inputMap.put("map_sr_num", sr_num);
		return sr_Service.selectJoinStudyRoomCondition(inputMap);
	}
	*/
	
}