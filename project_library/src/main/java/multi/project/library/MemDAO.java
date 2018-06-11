package multi.project.library;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class MemDAO {

	@Autowired
	SqlSession session;
	
	public MemberVO checkmember(Map map){
		return session.selectOne("checkmember",map);
	}

	public List<LibraryVO> librarylist() {
		
		return session.selectList("librarylist");
	}

	public void insertmember(MemberVO vo) {
		// TODO Auto-generated method stub
		session.insert("insertmember", vo);
	}

	public String checkid(String id) {
		// TODO Auto-generated method stub
		return session.selectOne("checkid",id);
	}
}
