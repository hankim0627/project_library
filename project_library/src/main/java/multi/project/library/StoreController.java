package multi.project.library;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class StoreController {
	@Autowired
	StoreService service;
	
	//중고 게시판 리스트
	@RequestMapping(value="/store", method=RequestMethod.GET)
	public ModelAndView getStoreAllPage(
			@RequestParam(value="page", defaultValue="1") String page){
		ModelAndView mv = new ModelAndView();
		mv.setViewName("store");
		List<StoreVO> list = service.selectAllWithPage(Integer.parseInt(page));
		mv.addObject("storeList", list);	//store게시물
		
		int cntAll = service.selectAllCnt(); //모든 데이터 갯수
		int pageCnt = 1;
		if(cntAll/10 == 0){ //한번에 나누어 떨어지면
			pageCnt = cntAll/10; //한페이지에 10개씩 보여줄 때 
		}
		else{ //10의 배수 아닐경우 11, 12 ...
			pageCnt = cntAll/10 + 1;
		}
		mv.addObject("pageCnt", pageCnt); //member_store list
		
		List<MemberStoreVO> list2 = new ArrayList<MemberStoreVO>();
		//flag여부를 담을 리스트
		
		for(int i = 0; i < list.size(); i++){
			List<MemberStoreVO> list3 = service.selectMemStore(list.get(i).getSt_num());
			//해당 st_num에 거래신청한 사람 리스트
			
			MemberStoreVO vo = new MemberStoreVO();
			if(list3.size() == 0){ //검색결과X , 거래신청한사람 없음
				vo.setFlag(-1);
			}
			else{	 //결과O, 거래신청사람 있음		
				for(int j = 0; j < list3.size(); j++){
					if(list3.get(j).getFlag() == 1){
						//신청한 사람들 사이에서 하나라도 거래완료가 있다면
						vo.setFlag(1);
						break; //1로 만들고 종료
					}
					else{
						vo.setFlag(0);
					}
				}//for-j-end
			}//else-end
			list2.add(vo);
		}//list-for-end
		mv.addObject("memStoreList", list2);
		
		return mv;
	}
	
	//하나의 게시물 상세조회
	@ResponseBody
	@RequestMapping("/store.stnum")
	public StoreVO getStoreOneNum(String stnum, String writer, HttpSession session){
		System.out.println(stnum);
		session.setAttribute("curr_stnum", stnum);//상세조회하면 stnum을 session에 공유
		session.setAttribute("curr_writer", writer); //상세조회한 게시물의 writer를 session공유
		StoreVO storevo = service.selectOneWithStNum(stnum);
		System.out.println(storevo);
		return storevo;
	}
	
	//글쓰기
	@RequestMapping("/write")
	public void write(){}
	
	@RequestMapping(value="/writesuccess", method=RequestMethod.POST)
	public void writeSuccess(StoreVO vo, HttpSession session){
		int l_id = (Integer)session.getAttribute("l_id");
		vo.setL_id(l_id);
		service.insertStore(vo); //store DB에 저장
	}
	
	//댓글리스트
	@ResponseBody
	@RequestMapping(value="/comment", method=RequestMethod.POST)
	public List<CommentVO> getCommentList(String stnum){
		List<CommentVO> list = service.selectAllComment(stnum);
		System.out.println(list);
		return list;
	}
	
	//댓글달기
	@ResponseBody
	@RequestMapping(value="/writecomment")
	public List<CommentVO> insertComment(String c_content, HttpSession session){
		CommentVO vo = new CommentVO();
		
		String loginid = (String) session.getAttribute("member_id");
		String stnum = (String) session.getAttribute("curr_stnum"); 
									//상세조회 클릭때 얻어온 stnum을 사용
		vo.setC_content(c_content);
		vo.setC_st_num(stnum);
		vo.setC_m_id(loginid);
		//현재 로그인정보 없으므로 임시로 mimi로 변경
		
		service.insertComment(vo); //db에 저장
		
		List<CommentVO> list = service.selectAllComment(stnum); //저장된 후 comment
		return list;
	}
	
	//글삭제
	//거래정보 member-store에 업데이트
	@RequestMapping("/delete")
	public String updateMemStore(HttpSession session){
		String stnum = (String) session.getAttribute("curr_stnum");
		//상세조회 클릭시 얻어온 stnum
		service.deleteStoreVO(stnum);
		return "redirect:/store";
	}
	
	//거래신청
	@RequestMapping("/send.memstore")
	public String send(HttpSession session){
		String loginid = (String) session.getAttribute("member_id"); //로그인페이지에서 저장된 id
		String writer = (String)session.getAttribute("curr_writer");
		String stnum = (String)session.getAttribute("curr_stnum");
		
		//거래한 사람이 있거나 거래 완료된 상태인지
		if(service.isDone(stnum)!=null){
			//이미 완료된 거래인지 확인
			if(service.isDone(stnum).equals("1")){
				return "done";				
			}
			//이미 거래를 신청한 사람인지 확인
			Map<String, String> map = new HashMap<String, String>();
			map.put("stnum", stnum);
			map.put("sendid", loginid);
			if(service.isAlreadySend(map) != null){
				return "sendfail";
			}
		}		
		
		MemberStoreVO vo = new MemberStoreVO();
		vo.setMs_m_id(writer);
		vo.setMs_st_num(stnum);
		vo.setSend_id(loginid);
		
		service.insertMemStore(vo);
		
		return "redirect:/store";
	} 
	
	//마이 페이지 첫화면
	@RequestMapping("/mypage")
	public ModelAndView mypage(HttpSession session){
		String loginid = (String) session.getAttribute("member_id");
		int countStore = service.countStoreWithId(loginid);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("mypage");
		mv.addObject("countStore", countStore);
		
		List<MemberStoreVO> list = service.selectMySend(loginid);
		mv.addObject("mySendCount", list.size()); //요청한 거래 갯수
		return mv;
	}
	
	//내가 요청한 거래 리스트
	@ResponseBody
	@RequestMapping("/mySendList")
	public List<MemberStoreVO> mySendList(HttpSession session){
		String loginid = (String) session.getAttribute("member_id");
		return service.selectMySend(loginid);
	}
	
	@RequestMapping(value="/mypagelist")
	public ModelAndView mypageList(HttpSession session){
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/mypage");
		String loginid = (String) session.getAttribute("member_id");
		
		List<StoreVO> list = service.selectStoreWithId(loginid); //글쓴리스트
		List<String> memList = new ArrayList<String>(); //거래 신청 갯수
		List<String> tradeList = new ArrayList<String>(); //거래 완료 여부
		for(int i = 0; i < list.size(); i++){
			List<MemberStoreVO> memStoreList = 
					service.selectMemStore(list.get(i).getSt_num());
			//각 글번호의 거래현황 리스트
			memList.add(String.valueOf(memStoreList.size()));
			
			String temp = null;
			for(int j = 0; j < memStoreList.size(); j++){
				//거래신청한 사람들 중에 거래를 수락했는지
				int flag = memStoreList.get(j).getFlag();
				if(flag == 1){
					temp = "1";
					break;
				}
				else{
					temp = "0";
				}
			}//for-j-end
			tradeList.add(temp);
		}
		mv.addObject("list", list);
		mv.addObject("memList", memList); //거래신청현황
		mv.addObject("tradeList", tradeList); //거래완료현황
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("stnum", "글번호");
		map.put("title", "글제목");
		map.put("trade", "거래신청");
		map.put("isComplete", "완료여부");
		mv.addObject("columnMap", map);
		
		List<MemberStoreVO> list2 = service.selectMySend(loginid);
		mv.addObject("mySendCount", list2.size()); //요청한 거래 갯수
		
		int countStore = service.countStoreWithId(loginid);
		mv.addObject("countStore", countStore);
		return mv;
	}
	
	@ResponseBody
	@RequestMapping("/viewtrade")
	public Map<String, List> viewTrade(String stnum, HttpSession session){
		session.setAttribute("trade_stnum", stnum);
		List<CommentVO> commentList = service.selectAllComment(stnum);
		List<MemberStoreVO> memStoreList = service.selectMemStore(stnum);
		Map<String, List> map = new HashMap<String, List>();
		map.put("commentList", commentList);
		map.put("memStoreList", memStoreList);
		return map;
	}
	
	@RequestMapping("/update.flag")
	public String updateMemStoreFlag(String name, HttpSession session){
		String stnum = (String)session.getAttribute("trade_stnum");
		Map<String, String> map = new HashMap<String, String>();
		map.put("sendid", name);
		map.put("stnum", stnum);
		service.updateMemStoreFlag(map);
		return "redirect:/mypagelist";
	}
	
	//거래가 완료된 id찾기
	@ResponseBody
	@RequestMapping("/sendId")
	public String selectSendId(String stnum){
		String sendId = service.selectSendId(stnum);
		return sendId;
	}
		
	//검색기능
	@RequestMapping("/search")
	public ModelAndView searchStore(String op, String value,
			@RequestParam(defaultValue="1")String amount,
			HttpSession session){
		ModelAndView mv = new ModelAndView();
		mv.setViewName("searchResult");

		Map<String, String> map = new HashMap<String, String>();
		map.put("column", op);
		map.put("value", value);
		map.put("amount", "1");
		List<StoreVO> list = service.searchStoreVO(map); //검색결과 리스트
		mv.addObject("searchList", list);
		
		int countSearch = service.countSearch(map);
		mv.addObject("countSearch", countSearch);
		mv.addObject("searchWord", value);
		if(list.size()>=5){
			mv.addObject("amount", amount);			
		}else{
			mv.addObject("amount2", list.size());
		}		
		
		session.setAttribute("searchCondition", map); //검색조건
		
		return mv;
	}
	
	//더보기
	@ResponseBody
	@RequestMapping("/searchMore")
	public List<StoreVO> searchMore(HttpSession session, String currAmount){
		Map<String, String> map 
		= (Map<String, String>) session.getAttribute("searchCondition");//검색조건
		map.put("amount", currAmount); //amount 값을 변경
		
		List<StoreVO> list = service.searchStoreVO(map);
		
		return list;
	}
	
	//상세조회한 게시물이 완료되었는지 여부
	@ResponseBody
	@RequestMapping("/isComplete")
	public String isComplete(String stnum){
		List<MemberStoreVO> list = service.selectMemStore(stnum);
		if(list.size() == 0) return "wait";
		for(MemberStoreVO vo : list){
			if(vo.getFlag() == 1){ //하나라도 거래가 완료되었다면 1로 리턴
				return "complete";
			}
		}
		return "ing";
	}
}
