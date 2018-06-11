package multi.project.library;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class LibraryController {
	@Autowired
	MemService service;
	
	
	//첫페이지 - 현재 DB에 있는 도서관 목록 가져옴
	@RequestMapping(value = "/librarylist", method=RequestMethod.GET)
	public ModelAndView getorderForm(){
		
		List<LibraryVO> list = service.librarylist();
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("librarylist", list);
		mv.setViewName("librarylist");
		
		return mv;
	}
	
	//로그인 페이지
	@RequestMapping(value = "/login", method = RequestMethod.GET )
	public String loginform(){
		return "loginform";
	}
	
	//로그인 페이지
	@RequestMapping(value = "/logout", method = RequestMethod.GET )
	public String logout(HttpSession session){
		
		if(session.getAttribute("member_id") != null){
			System.out.println(session.getAttribute("member_id"));
			session.invalidate();
		}
	
		return "redirect:/librarylist";
	}
	
	
	//첫 페이지에서 선택한 도서관과 입력받은 ID, PW로 회원정보 조회
	@RequestMapping(value = "/login", method = RequestMethod.POST )
	public ModelAndView loginresult(String id, String pw, HttpSession session){

		Map<String, String> map = new HashMap<String, String>();
		map.put("map_l_id", Integer.toString((Integer)session.getAttribute("l_id")));	
		map.put("map_id", id);
		map.put("map_pw", pw);
		MemberVO vo = new MemberVO();
		vo = service.checkmember(map);

		ModelAndView mv = new ModelAndView();
		
		if(vo==null){
			//id 틀림
			mv.addObject("error", "해당 도서관에 가입 정보가 없습니다.");			
			mv.setViewName("loginform");
		}else{
			//로그인 성공
			mv.addObject("memberVO", vo);			
			mv.setViewName("/LibraryMain");
			session.setAttribute("member_id", id);
		}

		return mv;
	}
	

	//회원가입 페이지
	@RequestMapping(value = "/new", method=RequestMethod.GET)
	public ModelAndView getnewMember(){
	
		ModelAndView mv = new ModelAndView();
		mv.setViewName("newmember");
		
		return mv;
	}
	
	//회원가입 시 아이디 중복체크
	@RequestMapping(value = "/checkname" , method=RequestMethod.POST)
	@ResponseBody
	public String checkname(String id){
		String result = service.checkid(id);
		//System.out.println("id "+id);
		//System.out.println(result);
		
		return result;
	}
	
	//회원가입 버튼 누르면 저장하고/ 다시 첫페이지인 도서관 목록 보여줌
	@RequestMapping(value = "/librarylist", method=RequestMethod.POST)
	public ModelAndView insertMember(String id, String pw, String name, String phone, HttpSession session){
		
		List<LibraryVO> list = service.librarylist();

		MemberVO vo = new MemberVO((Integer) session.getAttribute("l_id"), id, pw, name, phone);
		
		service.insertmember(vo);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("librarylist", list);
		mv.setViewName("librarylist");
		
		return mv;
	}
	
	
	
}
