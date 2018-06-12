package multi.project.library;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class FreeServiceImpl implements FreeService{
	
    @Autowired
	FreeDAO dao;

	@Override
	public LibraryVO location(int libraryId) {//해당 도서관정보 보기
		// TODO Auto-generated method stub
		return dao.location(libraryId);
	}

	@Override
	public List<MemberVO> memberInfo(String memberId) {//해당 회원 정보
		// TODO Auto-generated method stub
		return dao.memberInfo(memberId);
	}

	@Override
	public List<FreeVO> freeList(Map<String, Object> map) {//자유게시판 내용 불러오기
		// TODO Auto-generated method stub
		return dao.freeList(map);
	}

	@Override
	public int freeCnt(int cnt) {//자유게시판 페이징 처리용
		// TODO Auto-generated method stub
		return dao.freeCnt(cnt);
	}

	@Override
	public FreeVO freeSelectList(int num) {//자유 게시판 글내용 보기
		// TODO Auto-generated method stub
		return dao.freeSelectList(num);
	}

	@Override
	public List<FreeVO> freeSearch(Map<String, Object> ma) {//자유게시판 검색 결과 보기
		// TODO Auto-generated method stub
		return dao.freeSearch(ma);
	}

	@Override
	public int freeSerchCnt(Map<String, Object> ma) {//검색결과 페이징 처리
		// TODO Auto-generated method stub
		return dao.freeSerchCnt(ma);
	}

	@Override
	public void FreeInsert(Map<String, Object> map) {//자유게시판 글입력
		// TODO Auto-generated method stub
		dao.FreeInsert(map); 
	}

	@Override
	public List<FreeReplyVO> freeReply(int num) {//해당 글의 리플 보기
		// TODO Auto-generated method stub
		return dao.freeReply(num);
	}

	@Override
	public void replyDelete(Map<String, String> map) {//댓글삭제
		// TODO Auto-generated method stub
		dao.replyDelete(map);
	}

	@Override
	public void insertReply(Map<String, Object> map) {//댓글쓰기
		// TODO Auto-generated method stub
		dao.insertReply(map);
	}

	@Override
	public void deleteContReply(String freeNumber) {//삭제할 글에 소속된 댓글 지우기
		// TODO Auto-generated method stub
		dao.deleteContReply(freeNumber);
		
	}

	@Override
	public void deleteCont(Map<String, Object> map) {//글 삭제하기
		// TODO Auto-generated method stub
		dao.deleteCont(map);
	}

	@Override
	public void changePic(Map<String, String> map) {//아바타 바꾸기
		// TODO Auto-generated method stub
		dao.changePic(map);
	}

	public int myfree(String myid){
		return dao.myfree(myid);
		//내가 작성한 자유게시판 글 수
	}

	
	public int myreply(String myid){
		return dao.myreply(myid);
		//내가 작성한 자유게시판 리플수
	}
	
}
