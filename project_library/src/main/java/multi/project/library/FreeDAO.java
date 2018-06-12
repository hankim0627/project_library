package multi.project.library;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
@Component
public class FreeDAO {
    @Autowired
	SqlSession se; 
    
    /*public List<FreeVO> freeli(int[] free){
    	//System.out.println("페이지찾기");
    	return se.selectList("lib.freePageAll",free);
    }*/
    
    public List<FreeVO> freeList(Map<String,Object> map){
    	//System.out.println("페이지찾기");
    	return se.selectList("Library.freePageAll",map);
    }//자우게시판 페이지 불러오기
    
    public int freeCnt(int cnt){
    	//System.out.println("카운팅");
    	return se.selectOne("Library.freeCnt",cnt);
    }//자유게시판 페이징 처리용 카운팅
    
    public FreeVO freeSelectList(int num){
    	//System.out.println("select");
    	return se.selectOne("Library.freeSelectList",num);
    }//글 상세 내용보기 ajax
    
    public List<FreeVO> freeSearch(Map<String,Object> map){
    	//System.out.println("ㅇㅇ");
    	return se.selectList("Library.freeSearch",map);
    }//글 검색
    public int freeSerchCnt(Map<String,Object> map){
    	
    	return se.selectOne("Library.freeSearchCnt",map);
    }//글검색 내용 페이징처리용 카운팅

	public void FreeInsert(Map<String,Object> map) {
		//System.out.println("입력");
		se.insert("Library.freeInsert",map);
	}//자유게시판 게시물 작성

	public List<FreeReplyVO> freeReply(int num) {
		
		return se.selectList("Library.freeReply",num);
	}//해당글 리플보기

    public List<MemberVO> freeReplyPic(int num) {
		
		return se.selectList("Library.freeReplyPic",num);
	}//해당글 리플보기
	public List<MemberVO> memberInfo(String id) {
		
		return se.selectList("Library.memberInfo",id);
	}//회원정보 찾기

	public void replyDelete(Map<String,String> map) {
		//System.out.println(map.get("number")+" : "+map.get("pw"));
		se.delete("Library.replyDelete",map);
	}//리플 삭제

	public void insertReply(Map<String,Object> map) {
		//System.out.println("입력"+map.get("num")+" "+map.get("userid")+" "+map.get("replyCon")+" "+map.get("replyPw"));
		se.insert("Library.insertReply",map);
	}

	public LibraryVO location(int l_Id) {
		//System.out.println("위치찾기! "+l_Id);
		return se.selectOne("Library.selectLocation",l_Id);
	}

	public void deleteCont(Map<String, Object> map) {
		
		se.delete("Library.deleteCont",map);
		
	}//게시 글 지우기

	public void deleteContReply(String freeNumber) {
		se.delete("Library.deleteContReply",freeNumber);
		
	}//해당 게시글 리플지우기

	public void changePic(Map<String, String> map) {
		
		se.update("Library.changePic",map);
		se.update("Library.changeReplyPic",map);
	}

	public List<MemberVO> myinfo(String myid) {//내정보 보기
		// TODO Auto-generated method stub
		return se.selectList("Library.");
	}
	
	public int myfree(String myid) {
		// TODO Auto-generated method stub
		return se.selectOne("Library.myfree",myid);
	}

	public int myreply(String myid) {
		// TODO Auto-generated method stub
		return se.selectOne("Library.myreply",myid);
	}
}
