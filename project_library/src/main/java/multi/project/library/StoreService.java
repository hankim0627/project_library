package multi.project.library;

import java.util.List;
import java.util.Map;

public interface StoreService {
	public List<StoreVO> selectAllWithPage(int page);
	public int selectAllCnt();
	public StoreVO selectOneWithStNum(String stnum);
	public void insertStore(StoreVO vo);
	public void insertMemStore(MemberStoreVO vo);
	public String selectStNum(Map<String, String> map);
	public List<CommentVO> selectAllComment(String stnum);
	public void insertComment(CommentVO vo);
	public void updateMemStore(String stnum);
	public void updateMemStoreFlag(Map<String, String> map);
	public List<MemberStoreVO> selectMemStore(String stnum);
	public List<StoreVO> selectStoreWithId(String id);
	public int countStoreWithId(String id);
	public String selectSendId(String stnum);
	public void deleteStoreVO(String stnum);
	public MemberStoreVO isAlreadySend(Map<String, String> map);
	public String isDone(String stnum);
	public List<StoreVO> searchStoreVO(Map<String, String> map);
	public int countSearch(Map<String, String> map);
	public List<MemberStoreVO> selectMySend(String id);
	public int commentCountById(String myid);
}
