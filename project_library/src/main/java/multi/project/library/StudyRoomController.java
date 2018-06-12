package multi.project.library;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.reflection.SystemMetaObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class StudyRoomController {
	
	@Autowired
	StudyRoomService sr_Service;
	
	// ====================맨 처음 스터디룸 가기 클릭 했을 떄=============
	@RequestMapping(value="/studyRoomMain")
	public ModelAndView selectStudyRoomMain(@RequestParam(value="page", defaultValue="1") int page, int l_id){
		Map<String,Integer> inputMap = new HashMap<String, Integer>();
		inputMap.put("map_start_rownum", (page-1)*10+1);
		inputMap.put("map_end_rownum", (page)*10);
		inputMap.put("map_l_id", (l_id));
		System.out.println(l_id);
		
		Map <String, Object> selectMap = sr_Service.selectStudyRoomList(inputMap);
		
		int StudyRoomAllCnt = (Integer)selectMap.get("studyRoomAllCnt");
		int totalPage =0;
		if(StudyRoomAllCnt /10 == 0){
			totalPage = StudyRoomAllCnt/10;
		}else{
			totalPage = StudyRoomAllCnt/10+1;
		}
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("totalPage", totalPage);
		mv.addObject("studyRoomList", (List<StudyRoomVO>)selectMap.get("studyRoomList"));
		mv.setViewName("studyRoomMain");
		
		return mv;
	}

	// ===================== 스터디룸 목록에서 검색 할 떄 =========================== 
	@RequestMapping(value="/studyRoomSearch")
	public ModelAndView selectStudyRoomSearch(@RequestParam(value="page", defaultValue="1") int page, int l_id, int searchDate, String searchType, String searchWord){
		//System.out.println("page" + page + "\nl_id" + l_id + "\nsearchDate" + searchDate + "\nsearchType" + searchType + "\nsearchWord" + searchWord);
		Map<String, Object> inputMap = new HashMap<String, Object>();
		
		inputMap.put("map_start_rownum", (Integer)(page-1)*10+1);
		inputMap.put("map_end_rownum", (Integer)page*10);
		inputMap.put("map_l_id", (l_id));
		inputMap.put("map_sr_date", (Integer)searchDate);
		inputMap.put("map_sr_type", (String)searchType);
		inputMap.put("map_sr_word", (String)searchWord);
		
		Map<String, Object> selectMap = sr_Service.selectStudyRoomSearch(inputMap);
		
		int StudyRoomAllCnt = (Integer)selectMap.get("studyRoomSearchCnt");
		int totalPage =0;
		if(StudyRoomAllCnt /10 == 0){
			totalPage = StudyRoomAllCnt/10;
		}else{
			totalPage = StudyRoomAllCnt/10+1;
		}
		ModelAndView mv = new ModelAndView();
		mv.addObject("searchDate", searchDate);
		mv.addObject("searchType", searchType);
		mv.addObject("searchWord", searchWord);
		mv.addObject("totalPage", totalPage);
		mv.addObject("studyRoomList", (List<StudyRoomVO>)selectMap.get("studyRoomSearchList"));
		mv.addObject("l_id", l_id);
		mv.setViewName("studyRoomMain");
		return mv;
	}
	
	
	// ===================== 스터디룸 게시글 클릭했을 떄 =========================== 
	@RequestMapping(value="/studyRoomDetail")
	public ModelAndView selectStudyRoomDetail(HttpSession session, int sr_num){
		
		Map<String, Integer> inputMap = new HashMap<String, Integer>();
		inputMap.put("map_sr_num", sr_num);
		inputMap.put("map_start_rownum", 1);
		inputMap.put("map_end_rownum", 5);
		
		sr_Service.updateStudyRoomViewNum(inputMap);
		
		StudyRoomVO detail = sr_Service.selectStudyRoomDetail(inputMap);
		List<StudyRoomCommentVO> commentList = sr_Service.selectStudyRoomCommentList(inputMap);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("studyRoomDetail", detail);
		mv.addObject("studyRoomComment", commentList);
		mv.addObject("studyRoomCommentCnt", sr_Service.selectStudyRoomCommentCnt(inputMap));
		
		if(session.getAttribute("member_id").equals(detail.getM_id())){
			mv.addObject("studyRoomJoinRequestDisplay", "display: none;");
		} else {
			mv.addObject("studyRoomJoinRequestDisplay", "");
		}
		
		mv.setViewName("studyRoomDetail");
		return mv;
	}
	
	@RequestMapping(value="/studyRoomWrite")
	public void studyRoomWrite(){
	}
	
	// ===================== 글쓰기 등록 눌렀을 떄 =========================== 
	@RequestMapping(value="/studyRoomWriteSubmit", method = RequestMethod.POST)
	public ModelAndView insertStudyRoomWriteSubmit(int l_id, String sr_title, String m_id, String sr_cate, String sr_content, String sr_pw){
		StudyRoomVO vo = new StudyRoomVO(l_id, sr_title, m_id, sr_cate, sr_content, sr_pw);
		//System.out.println(vo);
		sr_Service.insertStudyRoomWrite(vo);
		return selectStudyRoomMain(1, l_id);
	}
	
	
	// ===================== 댓글 등록 클릭했을 떄 =========================== 
	@RequestMapping(value="/studyRoomCommentWrite")
	@ResponseBody
	public List<StudyRoomCommentVO> studyRoomCommentWrite(int sr_num, int add_num_start, int add_num_end, int sr_comment_num, String sr_comment_id, String sr_comment_content){
		StudyRoomCommentVO  vo = new StudyRoomCommentVO(sr_num, sr_comment_num, sr_comment_id, sr_comment_content);
		sr_Service.insertStudyRoomCommentWrite(vo);
		if(sr_comment_num==-1){							// 댓글 달 때
			return studyRoomCommentAdd(sr_num, add_num_start,add_num_end);
		} else{											// 댓글의 답글 달 떄
			return studyRoomRecommentAdd(sr_num, add_num_start, add_num_end, sr_comment_num);
		}
	}

	// ===================== 답글 클릭했을 떄 =========================== 
	@RequestMapping(value="/studyRoomRecommentAdd")
	@ResponseBody
	public List<StudyRoomCommentVO> studyRoomRecommentAdd(int sr_num, int add_num_start, int add_num_end, int sr_comment_num){
		Map<String, Integer> inputMap = new HashMap<String, Integer>();
		inputMap.put("map_sr_num", sr_num);
		inputMap.put("map_start_rownum", add_num_start);
		inputMap.put("map_end_rownum", add_num_end);
		inputMap.put("map_sr_comment_num", sr_comment_num);
		
		return sr_Service.selectStudyRoomRecommentList(inputMap);
	}
	
	// ===================== 댓글 더보기 클릭했을 떄 =========================== 
	@RequestMapping(value="/studyRoomCommentAdd")
	@ResponseBody
	public List<StudyRoomCommentVO> studyRoomCommentAdd(int sr_num, int add_num_start, int add_num_end){
		Map<String, Integer> inputMap = new HashMap<String, Integer>();
		inputMap.put("map_sr_num", sr_num);
		inputMap.put("map_start_rownum", add_num_start);
		inputMap.put("map_end_rownum", add_num_end); 
		return sr_Service.selectStudyRoomCommentList(inputMap);
	}
	
	
	
	// ===================== 마이페이지 가기 눌렀을 떄=========================
	@RequestMapping(value="/studyRoomMyPage")
	public ModelAndView studyRoomMyPage(HttpSession session, @RequestParam(value="MakePage", defaultValue="1") int MakePage, @RequestParam(value="MakeDisplay", defaultValue="0") int MakeDisplay, 
			@RequestParam(value="JoinPage", defaultValue="1") int JoinPage, @RequestParam(value="JoinDisplay", defaultValue="0") int JoinDisplay,
			@RequestParam(value="enterPage", defaultValue="1") int enterPage, @RequestParam(value="enterDisplay", defaultValue="0") int enterDisplay){
		
		Map<String, Object> inputMap = new HashMap<String, Object>();			// 목록 불러올 때 쓸 map
		inputMap.put("map_m_id", (String)session.getAttribute("member_id"));
		inputMap.put("map_l_id", session.getAttribute("l_id"));
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
		inputMap.put("map_m_id", (String)session.getAttribute("member_id"));
		inputMap.put("map_l_id", session.getAttribute("l_id"));
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
		inputMap.put("map_l_id", session.getAttribute("l_id"));
		inputMap.put("map_sr_num", sr_num);
		return sr_Service.selectmakeStudyRoomCondition(inputMap);
	}
	// 내가 개설한 스터디룸에 신청한 사람 수락 -->1로 / 거절-->2로
	@RequestMapping(value="/makeStudyRoomJoinSubmit")
	@ResponseBody
	public int makeStudyRoomJoinSubmit(HttpSession session, int sr_num, String m_id, int sr_join_flag){
		Map<String, Object> inputMap = new HashMap<String, Object>();
		inputMap.put("map_l_id", session.getAttribute("l_id"));
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
		inputMap.put("map_l_id", session.getAttribute("l_id"));
		inputMap.put("map_m_id", session.getAttribute("member_id"));
		inputMap.put("map_sr_num", sr_num);
		return sr_Service.selectJoinStudyRoomCondition(inputMap);
	}
	
	// 스터디룸마다의 게시판 열기
/*	@RequestMapping(value="/studyRoomEachBoard")
	public ModelAndView selectStudyRoomEachBoard(HttpSession session, @RequestParam(value="page", defaultValue="1") int page, int sr_num){
		Map<String,Object> inputMap = new HashMap<String, Object>();
		inputMap.put("map_start_rownum", (page-1)*10+1);
		inputMap.put("map_end_rownum", (page)*10);
		inputMap.put("map_l_id", session.getAttribute("sessionlibrary"));
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
		mv.setViewName("studyRoomEachBoard");
		
		return mv;
	}*/
}