package multi.project.library;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
@Controller
public class FreeController {
    
	  
    @Autowired
    FreeService fser;
    
	  @RequestMapping("/LibraryMain")
	  public ModelAndView libraryMain(HttpSession sessionId){
		 
		  sessionId.setAttribute("libraryId", 1);//임의로 도서관 아이디 세션 생성 
		  sessionId.setAttribute("userid", "Park");//임의로 세션아이디 생성
		  int libraryId=(Integer)sessionId.getAttribute("libraryId");
		  ModelAndView mv = new ModelAndView();
		  LibraryVO lib=fser.location(libraryId);//도서관 아이디 세션 넣을자리
		  List<MemberVO> mem= fser.memberInfo((String) sessionId.getAttribute("userid"));//회원아이디 세션 넣을 자리
		  mv.addObject("lat",lib.getL_latitude());//위도
	   	  mv.addObject("lon",lib.getL_longtitude());//경도
	   	  mv.addObject("libraryName",lib.getL_name());
	   	  mv.addObject("libraryId",lib.getL_id());//도서관 아이디
	   	  mv.addObject("user",mem);//회원정보
		  mv.setViewName("/LibraryMain");
		  
		  
		  
		  return mv;
	  }//도서관 메인페이지
    
	  @RequestMapping("/Freelist")
	  public ModelAndView freelist(@RequestParam(value="pagenum", defaultValue="1") String pagenum, HttpSession sessionId){
		  
		    int free= Integer.parseInt(pagenum);
		    //sessionId.setAttribute("libraryId", "1");//임의로 도서관 아이디 세션 생성 
			//sessionId.setAttribute("userid", "Lee");//임의로 세션아이디 생성
	    	Map<String,Object> map=new HashMap<String,Object>();
	    	map.put("l_Id", sessionId.getAttribute("libraryId"));//도서관 아이디세션 넣을자리
	    	map.put("num", free);
	    	List<FreeVO> list=fser.freeList(map);
	    	ModelAndView mv = new ModelAndView();
	    	List<MemberVO> mem= fser.memberInfo((String) sessionId.getAttribute("userid"));//회원아이디 세션 넣을 자리
	    	
	    	
	    	int cnt = (Integer)sessionId.getAttribute("libraryId");//도서관 아이디 세션 넣을 자리
	    	int count=fser.freeCnt(cnt);//도서관아이디로 해당 게시물 글 갯수 구함
	   		int totalPage=0;
	   		if(count%10==0){
	   			
	   			totalPage=count/10;
	   		}else{
	   			
	   			totalPage=count/10+1;
	   		}
	   		
	   		
	   		mv.addObject("totalpage",totalPage);
	   		mv.addObject("freelist",list);
	   		mv.addObject("user",mem);//세션으로 찾은 회원정보 
	   		mv.setViewName("/Free");
	   		return mv;
	}//자유게시판 전체 글 목록보기
	  
	  @RequestMapping("/FreeSelectlist")
	  @ResponseBody
	  public FreeVO freeSelectlist(int num ){
		
		  FreeVO result = fser.freeSelectList(num);
		 
		  return result;
	  }//free page 글내용 보기 ajax
	  
	  
	  @RequestMapping("/FreeSearch")
	  public ModelAndView freeserchlist
	  (@RequestParam(value="pagenum", defaultValue="1")
	  String pagenum,String searchdate, String searchBy,String searchText ,HttpSession sessionId){
		// System.out.println(pagenum+" "+searchdate+" "+searchBy+" "+searchText);
		  ModelAndView mv = new ModelAndView();
		  
		  int free= Integer.parseInt(pagenum);
		  Map<String,Object> ma = new  HashMap<String,Object>(); 
		  ma.put("l_Id", sessionId.getAttribute("libraryId"));//도서관세션 넣을자리
	      ma.put("num", free);
		  ma.put("searchdate",searchdate);
		  ma.put("searchBy",searchBy);
		  ma.put("searchText",searchText);
		  
		  List<FreeVO> list2=fser.freeSearch(ma);
		  List<MemberVO> mem= fser.memberInfo((String) sessionId.getAttribute("userid"));//회원아이디 세션 넣을 자리

		    int count=fser.freeSerchCnt(ma);
	    	int totalPage=0;
	   		if(count%10==0){
	   			totalPage=count/10;
	   		}else{
	   			totalPage=count/10+1;
	   		}
	   	  
	   	  mv.addObject("user",mem);//세션으로 찾은 회원정보
	   	  mv.addObject("searchdate",searchdate);
	   	  mv.addObject("searchBy",searchBy);
	      mv.addObject("searchText",searchText);
	   	  mv.addObject("totalpage2",totalPage);
		  mv.addObject("freelist2",list2);
		  mv.setViewName("/FreeSearch");
		  return mv;
	  }//search 페이징처리
	  
	  @RequestMapping(value="/Insert", method=RequestMethod.GET)
	  public String insertForm(){
		 // System.out.println("IN");
		  return "/FreeInsert";
	  }//자유게시판 입력 폼
	  
	  @RequestMapping(value="/Insert", method=RequestMethod.POST)
	  public void insertSuccess(String contents,String title, String pw,HttpSession sessionId){
		 //System.out.println(title+" "+contents+" "+pw);
		 Map<String,Object> map= new HashMap<String,Object>();
		 map.put("l_Id",  sessionId.getAttribute("libraryId"));//도서관 아이디 세션 넣을 자리
		 map.put("contents", contents);
		 map.put("title", title);
		 map.put("pw", pw);
		 map.put("m_Id", (String) sessionId.getAttribute("userid"));//회원 아이디 세션 넣을 자리
		 fser.FreeInsert(map); 
	}//자유게시판 입력
	  
	  @RequestMapping(value="/ReplyView", method=RequestMethod.POST)
	  @ResponseBody
	  public List<FreeReplyVO> freeReply(int num ){
		
		  List<FreeReplyVO> result = fser.freeReply(num);
		//  System.out.println(sessionId.getAttribute("userid"));
		  return result;
	  }//댓글 보기 ajax
	  
	  @RequestMapping(value="/ReplyDelete", method=RequestMethod.POST)
	  public String replyDelete(String deletePw,String deleteReply){
		  Map<String,String> map= new HashMap<String,String>();
		  //System.out.println(deleteReply+"번 삭제 비번 : "+deletePw);
		  map.put("number", deleteReply);//해당 댓글 번호
		  map.put("pw", deletePw);
		  fser.replyDelete(map);//댓글삭제
		 
		  return "redirect:/Freelist";
		  //"redirect:/Freelist";
	  }//리플삭제
	  @RequestMapping(value="/ReplyDelete2", method=RequestMethod.POST)
	  public String replyDelete2(String deletePw,String deleteReply){
		  Map<String,String> map= new HashMap<String,String>();
		 // System.out.println(deleteReply+"번 삭제 비번 : "+deletePw);
		  map.put("number", deleteReply);
		  map.put("pw", deletePw);
		  fser.replyDelete(map);//댓글삭제
		 
		  return "redirect://FreeSearch";
		  //"redirect:/Freelist";
	  }//Search 리플삭제
	  
	  /*@RequestMapping(value="/ReplyDelete", method=RequestMethod.POST)
	  @ResponseBody
	  public List<FreeReplyVO> replyDelete(int num, String deletePw,String deleteReply){
		  Map<String,String> map= new HashMap<String,String>();
		  System.out.println(deleteReply+"번 삭제 비번 : "+deletePw);
		  map.put("number", deleteReply);
		  map.put("pw", deletePw);
		  fser.replyDelete(map);//댓글삭제
		  List<FreeReplyVO> result = fser.freeReply(num);//댓글불러오기
		  return result;
		  //"redirect:/Freelist";
	  }//ajax 이용한 리플삭제
*/	  
	  @RequestMapping(value="/InsertReply", method=RequestMethod.POST)
      @ResponseBody
	  public List<FreeReplyVO> insertReply(int num, String userid, String replyCon ,String replyPw){
		  //System.out.println(userid+" "+replyCon+" "+replyPw);
		  Map<String,Object> map= new HashMap<String,Object>();
		  map.put("num", num);
		  map.put("userid", userid);
		  map.put("replyCon", replyCon);
		  map.put("replyPw", replyPw);
		  fser.insertReply(map);//댓글 삽입
		  List<FreeReplyVO> result = fser.freeReply(num);//댓글불러오기
		  return result;
	  }//리플 입력
	  
	  
	  @RequestMapping(value="/LibraryLocation", method=RequestMethod.GET)
	  public String location(String lat,String lon, HttpServletRequest re){
		 //System.out.println("좌표"+lat+" "+lon);
		  re.setAttribute("lat", lat);
		  re.setAttribute("lon", lon);
		  return "LibraryLocation";
	  }//도서관 위치보기
	  @RequestMapping("/FreeContDelete")
	  public String freeContDelete(String freeNumber,String password){
		 // System.out.println(password+ freeNumber);
		  Map<String,Object> map= new HashMap<String,Object>();
		  map.put("f_Num", freeNumber);//해당 글번호
		  map.put("f_Pw", password);
		  fser.deleteContReply(freeNumber);//해당글 리플 지우기
		  fser.deleteCont(map);//해당글 지우기
		  
			
		  return "redirect:/Freelist";
		  
		}//게시판 글 지우기
	  @RequestMapping(value="/UserPicSelect",method=RequestMethod.GET)
	  public String UserPicSelect(){
		 // ModelAndView mv= new ModelAndView();
		 //String userpic=fser.getpic();
		 // mv.add
		  
		  return "/UserPic";
		  
	  }
	  @RequestMapping(value="/UserPicSelect",method=RequestMethod.POST)
	  public void UserPicSelect(String userpic, HttpSession sessionId){
		  //System.out.println(userpic+" 로 그림변경");
		  Map<String,String> map= new HashMap<String,String>();
		  map.put("id", (String) sessionId.getAttribute("userid"));
		  map.put("pic", userpic);
		  fser.changePic(map);
		  
	  }//아바타 변경
	  
}
