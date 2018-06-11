package multi.project.library;

import java.util.List;
import java.util.Map;

public interface MemService {
	public MemberVO login(String id);
	public MemberVO checkmember(Map map);
	public List<LibraryVO> librarylist();
	public void insertmember(MemberVO vo);
	public String checkid(String id);
}
