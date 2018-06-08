package multi.project.library;

import java.util.List;
import java.util.Map;

public interface FreeService {

	LibraryVO location(int libraryId);//해당 도서관정보 보기

	List<MemberVO> memberInfo(String memberId);//해당 회원 정보

	List<FreeVO> freeList(Map<String, Object> map);//자유게시판 내용 불러오기

	int freeCnt(int cnt);//자유게시판 페이징 처리용

	FreeVO freeSelectList(int num);//자유 게시판 글내용 보기

	List<FreeVO> freeSearch(Map<String, Object> ma);//자유게시판 검색 결과 보기

	int freeSerchCnt(Map<String, Object> ma);//검색결과 페이징 처리

	void FreeInsert(Map<String, Object> map);//자유게시판 글입력

	List<FreeReplyVO> freeReply(int num);//해당 글의 리플 보기

	void replyDelete(Map<String, String> map);//댓글삭제

	void insertReply(Map<String, Object> map);//댓글쓰기

	void deleteContReply(String freeNumber);//삭제할 글에 소속된 댓글 지우기

	void deleteCont(Map<String, Object> map);//글 삭제하기

	void changePic(Map<String, String> map);//아바타 바꾸기

}
