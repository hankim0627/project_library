package multi.project.library;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemServiceImpl implements MemService{

	@Autowired
	MemDAO memDAO;
	
	@Override
	public MemberVO login(String id) {
		// TODO Auto-generated method stub
		return null;
	}
	
	public MemberVO checkmember(Map map){
		return memDAO.checkmember(map);
	}

	@Override
	public List<LibraryVO> librarylist() {
		
		return memDAO.librarylist();
	}

	@Override
	public void insertmember(MemberVO vo) {
		 memDAO.insertmember(vo);		
	}

	@Override
	public String checkid(String id) {
		// TODO Auto-generated method stub
		return memDAO.checkid(id);
	}

}
