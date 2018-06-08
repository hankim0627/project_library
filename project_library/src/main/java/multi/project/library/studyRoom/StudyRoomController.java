package multi.project.library;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

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
	
	@RequestMapping(value="/studyRoomMain")
	public ModelAndView selectStudyRoomMain(@RequestParam(value="page", defaultValue="1") int page, int l_id){
		//System.out.println("l_id::::"+ l_id);
		
		Map<String,Integer> inputMap = new HashMap<String, Integer>();
		inputMap.put("map_start_rownum", (page-1)*10+1);
		inputMap.put("map_end_rownum", (page)*10);
		inputMap.put("map_l_id", (l_id));
		
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

	@RequestMapping(value="/studyRoomSearch")
	public ModelAndView selectStudyRoomSearch(@RequestParam(value="page", defaultValue="1") int page, int l_id, int searchDate, String searchType, String searchWord){
		//System.out.println("page" + page + "\nl_id" + l_id + "\nsearchDate" + searchDate + "\nsearchType" + searchType + "\nsearchWord" + searchWord);
		Map<String, Object> inputMap = new HashMap<String, Object>();
		
		inputMap.put("map_start_rownum", (Integer)(page-1)*10+1);
		inputMap.put("map_end_rownum", (Integer)page*10);
		inputMap.put("map_l_id", (Integer)l_id);
		inputMap.put("map_sr_date", (Integer)searchDate);
		inputMap.put("map_sr_type", (String)searchType);
		inputMap.put("map_sr_word", (String)searchWord);
		
		//System.out.println(inputMap.get("map_l_id"));
		
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
		mv.setViewName("studyRoomMain");
/*		mv.addObject("studyRoomSearchList", (List<StudyRoomVO>)selectMap.get("studyRoomSearchList"));
		mv.setViewName("studyRoomSearch");*/
		return mv;
	}
	
	@RequestMapping(value="/studyRoomDetail")
	public ModelAndView selectStudyRoomDetail(int sr_num){
		
		Map<String, Integer> inputMap = new HashMap<String, Integer>();
		inputMap.put("map_sr_num", sr_num);
		inputMap.put("map_start_rownum", 1);
		inputMap.put("map_end_rownum", 5);
		//inputMap.put("map_sr_title", sr_title);
		
		sr_Service.updateStudyRoomViewNum(inputMap);
		
		StudyRoomVO detail = sr_Service.selectStudyRoomDetail(inputMap);
		List<StudyRoomCommentVO> commentList = sr_Service.selectStudyRoomCommentList(inputMap);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("studyRoomDetail", detail);
		mv.addObject("studyRoomComment", commentList);
		mv.addObject("studyRoomCommentCnt", sr_Service.selectStudyRoomCommentCnt(inputMap));
		mv.setViewName("studyRoomDetail");
		return mv;
	}
	
	@RequestMapping(value="/studyRoomWrite")
	public void studyRoomWrite(){
	}
	
	@RequestMapping(value="/studyRoomWriteSubmit", method = RequestMethod.POST)
	public ModelAndView insertStudyRoomWriteSubmit(int l_id, String sr_title, String m_id, String sr_cate, String sr_content, String sr_pw){
		StudyRoomVO vo = new StudyRoomVO(l_id, sr_title, m_id, sr_cate, sr_content, sr_pw);
		sr_Service.insertStudyRoomWrite(vo);
		
		return selectStudyRoomMain(1, l_id);
	}
	
	@RequestMapping(value="/studyRoomCommentWrite")
	@ResponseBody
	public List<StudyRoomCommentVO> studyRoomCommentWrite(int sr_num, int add_num_start, int add_num_end, int sr_comment_num, String sr_comment_id, String sr_comment_content){
		System.out.println("???요기,.,");
		StudyRoomCommentVO  vo = new StudyRoomCommentVO(sr_num, sr_comment_num, sr_comment_id, sr_comment_content);
		sr_Service.insertStudyRoomCommentWrite(vo);
		System.out.println("여깅?..");
		if(sr_comment_num==-1){
			return studyRoomCommentAdd(sr_num, add_num_start,add_num_end);
		} else{
			return studyRoomRecommentAdd(sr_num, add_num_start, add_num_end, sr_comment_num);
		}
		
	}
	
/*	@RequestMapping(value="/studyRoomRecommentAdd")
	@ResponseBody
	public List<StudyRoomCommentVO> studyRoomRecommentAdd(int sr_num, int sr_comment_num){
		Map<String, Integer> inputMap = new HashMap<String, Integer>();
		inputMap.put("map_sr_num", sr_num);
		inputMap.put("map_sr_comment_num", sr_comment_num);
		
		return sr_Service.selectStudyRoomRecommentList(inputMap);
	}*/

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
	
	@RequestMapping(value="/studyRoomCommentAdd")
	@ResponseBody
	public List<StudyRoomCommentVO> studyRoomCommentAdd(int sr_num, int add_num_start, int add_num_end){
		Map<String, Integer> inputMap = new HashMap<String, Integer>();
		inputMap.put("map_sr_num", sr_num);
		inputMap.put("map_start_rownum", add_num_start);
		inputMap.put("map_end_rownum", add_num_end); 
		//System.out.println(sr_num + ", " + add_num + ", " + add_num_5);
		return sr_Service.selectStudyRoomCommentList(inputMap);
	}
	
	@RequestMapping(value="/studyRoomMyPage")
	public ModelAndView studyRoomMyPage(HttpSession session, @RequestParam(value="page", defaultValue="1") int page){
		
		Map<String, Object> inputMap = new HashMap<String, Object>();
		inputMap.put("map_m_id", (String)session.getAttribute("sessionid"));
		inputMap.put("map_l_id", session.getAttribute("sessionlibrary"));
		inputMap.put("map_start_rownum", (page-1)*10+1);
		inputMap.put("map_end_rownum", (page)*10);
		
		Map <String, Object> selectMap = sr_Service.selectMakeStudyRoomWithId(inputMap);
		
		int cntMakeStudyRoomWithId = (Integer)selectMap.get("cntMakeStudyRoomWithId");
		int totalPage =0;
		if(cntMakeStudyRoomWithId/10 == 0){
			totalPage = cntMakeStudyRoomWithId/10;
		}else{
			totalPage = cntMakeStudyRoomWithId/10+1;
		}
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("makeTotalPage", totalPage);
		mv.addObject("cntMakeStudyRoomWithId", cntMakeStudyRoomWithId);
		mv.addObject("listMakeStudyRoomWithId", (List<StudyRoomVO>)selectMap.get("listMakeStudyRoomWithId"));
		mv.setViewName("studyRoomMyPage");
		
		return mv;
	}

	
}