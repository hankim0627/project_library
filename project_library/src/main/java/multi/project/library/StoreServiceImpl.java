package multi.project.library;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StoreServiceImpl implements StoreService{
	@Autowired
	StoreDAO storeDAO;

	public List<StoreVO> selectAllWithPage(int page) {
		return storeDAO.selectAllWithPage(page);
	}

	public int selectAllCnt() { //전체갯수 출력
		return storeDAO.selectAllCnt();
	}

	public StoreVO selectOneWithStNum(String stnum) {
		return storeDAO.selectOneWithStNum(stnum);
	}

	public void insertStore(StoreVO vo) {
		storeDAO.insertStore(vo);
	}

	public void insertMemStore(MemberStoreVO vo) {
		storeDAO.insertMemStore(vo);
	}

	public String selectStNum(Map<String, String> map) {
		return storeDAO.selectStNum(map);
	}

	public List<CommentVO> selectAllComment(String stnum) {
		return storeDAO.selectAllComment(stnum);
	}

	public void insertComment(CommentVO vo) {
		storeDAO.insertComment(vo);
	}

	public void updateMemStore(String stnum) {
		storeDAO.updateMemStore(stnum);
	}

	public List<MemberStoreVO> selectMemStore(String stnum) {
		return storeDAO.selectMemStore(stnum);
	}

	public List<StoreVO> selectStoreWithId(String id) {
		return storeDAO.selectStoreWithId(id);
	}

	public int countStoreWithId(String id) {
		return storeDAO.countStoreWithId(id);
	}

	public void updateMemStoreFlag(Map<String, String> map) {
		storeDAO.updateMemStoreFlag(map);
	}

	public String selectSendId(String stnum) {
		return storeDAO.selectSendId(stnum);
	}

	public void deleteStoreVO(String stnum) {
		storeDAO.deleteStoreVO(stnum);
	}

	public MemberStoreVO isAlreadySend(Map<String, String> map) {
		return storeDAO.isAlreadySend(map);
	}

	public String isDone(String stnum) {
		return storeDAO.isDone(stnum);
	}

	public List<StoreVO> searchStoreVO(Map<String, String> map) {
		return storeDAO.searchStoreVO(map);
	}

	public int countSearch(Map<String, String> map) {
		return storeDAO.countSearch(map);
	}

	public List<MemberStoreVO> selectMySend(String id) {
		return storeDAO.selectMySend(id);
	}

	
	public int commentCountById(String myid) {
		
		return storeDAO.commentCountById(myid);
	}
}
