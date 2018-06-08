package multi.project.library;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class StoreDAO {
	@Autowired
	SqlSession session;
	
	public List<StoreVO> selectAllWithPage(int page){
		return session.selectList("store.allWithPage", page);
	}
	
	public int selectAllCnt(){
		return session.selectOne("store.allCount");
	}
	
	public StoreVO selectOneWithStNum(String stnum){
		return session.selectOne("store.selectStore", stnum);
	}
	
	public void insertStore(StoreVO vo){
		session.insert("store.insertStore", vo);
	}
	
	public void insertMemStore(MemberStoreVO vo){
		session.insert("store.insertMemStore", vo);
	}
	
	public String selectStNum(Map<String, String> map){
		return session.selectOne("store.selectStNum", map);
	}
	
	public List<CommentVO> selectAllComment(String stnum){
		return session.selectList("store.selectAllComment", stnum);
	}
	
	public void insertComment(CommentVO vo){
		session.insert("store.insertComment", vo);
	}
	
	public void updateMemStore(String stnum){
		session.update("store.updateMemStore", stnum);
	}
	
	public void updateMemStoreFlag(Map<String, String> map){
		session.update("store.updateMemStoreFlag", map);
	}
	
	public List<MemberStoreVO> selectMemStore(String stnum){
		return session.selectList("store.selectMemStore", stnum);
	}
	
	public List<StoreVO> selectStoreWithId(String id){
		return session.selectList("store.selectStoreWithId", id);
	}
	
	public int countStoreWithId(String id){
		return session.selectOne("store.countStoreWithId", id);
	}
	
	public String selectSendId(String stnum){
		return session.selectOne("store.selectSendId", stnum);
	}
	
	public void deleteStoreVO(String stnum){
		deleteMemStoreVO(stnum); 
		//db에서 delete on cascade설정을 안해놔서 자식데이터 먼저 제거 
		session.delete("store.deleteStoreVO", stnum);
	}
	
	public void deleteMemStoreVO(String stnum){
		session.delete("store.deleteMemStoreVO", stnum);
	}
	
	public MemberStoreVO isAlreadySend(Map<String, String> map){
		return session.selectOne("store.isAlreadySend", map);
	}
	
	public String isDone(String stnum){
		return session.selectOne("store.isDone", stnum);
	}
	
	public List<StoreVO> searchStoreVO(Map<String, String> map){
		return session.selectList("store.searchStore", map);
	}
	
	public int countSearch(Map<String, String> map){
		return session.selectOne("store.countSearch", map);
	}
}
